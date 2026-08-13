package com.jzo2o.foundations.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.foundations.constants.RedisConstants;
import com.jzo2o.foundations.enums.FoundationStatusEnum;
import com.jzo2o.foundations.mapper.*;
import com.jzo2o.foundations.model.domain.*;
import com.jzo2o.foundations.model.dto.request.ServePageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.*;
import com.jzo2o.foundations.service.IServeService;
import com.jzo2o.mysql.utils.PageHelperUtils;
import com.jzo2o.mysql.utils.PageUtils;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.support.IndicesOptions;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.elasticsearch.xcontent.ToXContent;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 区域服务实现类
 */
@Service
public class ServeServiceImpl extends ServiceImpl<ServeMapper, Serve> implements IServeService {

    @Resource
    private RegionMapper regionMapper;

    @Resource
    private ServeMapper serveMapper;

    @Resource
    private ServeItemMapper serveItemMapper;

    @Resource
    private ServeSyncMapper serveSyncMapper;

    @Resource
    private ServeTypeMapper serveTypeMapper;

    @Resource
    private RestHighLevelClient client;

    @Override
    public PageResult<ServeResDTO> page(ServePageQueryReqDTO servePageQueryReqDTO) {
        return PageHelperUtils.selectPage(servePageQueryReqDTO,
                () -> baseMapper.queryListByRegionId(servePageQueryReqDTO.getRegionId()));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(List<ServeUpsertReqDTO> dtoList) {
        // 遍历列表，拿到每个地区的服务
        for (ServeUpsertReqDTO dto : dtoList) {
            // 服务项目必须是启用状态才能添加到区域
            Long serveItemId = dto.getServeItemId();
            Long regionId = dto.getRegionId();
            ServeItem serveItem = serveItemMapper.selectById(serveItemId);
            if (ObjUtil.isNull(serveItem) || serveItem.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
                throw new ForbiddenOperationException("服务项目状态有误！");
            }

            // 同一服务不能在同一区域重复添加
            int count = serveMapper.selectCount(Wrappers.<Serve>lambdaQuery()
                    .eq(Serve::getServeItemId, serveItemId)
                    .eq(Serve::getRegionId, regionId)
            );
            if (count > 0) {
                throw new ForbiddenOperationException("当前服务项目已经存在！");
            }

            // 保存数据
            Serve serve = BeanUtil.copyProperties(dto, Serve.class);
            Region region = regionMapper.selectById(regionId);
            if (ObjUtil.isNotNull(region)) {
                serve.setCityCode(region.getCityCode());
            }
            serveMapper.insert(serve);
            regionMapper.insert(region);
        }
    }

    @Override
    public void deleteById(Long id) {
        // 根据主键查询记录, 草稿状态方可删除
        Serve serve = baseMapper.selectById(id);
        if (ObjUtil.isNull(serve) || serve.getSaleStatus() != FoundationStatusEnum.INIT.getStatus()){
            throw new ForbiddenOperationException("删除失败, 当前区域服务不是草稿状态");
        }
        this.removeById(serve.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void onSale(Long id) {
        Serve serve = this.getById(id);
        if (serve.getSaleStatus() == FoundationStatusEnum.ENABLE.getStatus()) {
            throw new ForbiddenOperationException("当前区域服务已经启用，请勿重复操作！");
        }

        Long serveItemId = serve.getServeItemId();
        ServeItem serveItem = serveItemMapper.selectById(serveItemId);
        if (ObjUtil.isNull(serveItem) || serveItem.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            throw new ForbiddenOperationException("服务项目未启用！");
        }

        serve.setSaleStatus(FoundationStatusEnum.ENABLE.getStatus());
        this.updateById(serve);
        this.addServeSync(id);
    }

    @Override
    public void offSale(Long id) {
        // 状态校验
        Serve serve = this.getById(id);
        if (serve.getSaleStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            throw new ForbiddenOperationException("当前区域服务未启用！");
        }
        Long serveItemId = serve.getServeItemId();
        ServeItem serveItem = serveItemMapper.selectById(serveItemId);
        if (ObjUtil.isNull(serveItem) || serveItem.getActiveStatus() != FoundationStatusEnum.DISABLE.getStatus()) {
            throw new ForbiddenOperationException("服务项目未禁用！");
        }
        // 更新下架状态
        serve.setSaleStatus(FoundationStatusEnum.DISABLE.getStatus());
        this.updateById(serve);
        // 同步表删除
        serveSyncMapper.deleteById(id);
    }

    @Override
    @Caching(
            cacheable = {
                    // 缓存未命中，则缓存空值 30 分钟，这样可以避免缓存穿透
                    @Cacheable(value = RedisConstants.CacheName.SERVE_ICON, key = "#regionId" ,
                            unless = "#result.size() > 0", cacheManager = RedisConstants.CacheManager.THIRTY_MINUTES),
                    // 缓存命中，则永久缓存数据
                    @Cacheable(value = RedisConstants.CacheName.SERVE_ICON, key = "#regionId" ,
                            unless = "#result.size() == 0", cacheManager = RedisConstants.CacheManager.FOREVER)
            }
    )
    public List<ServeCategoryResDTO> firstPageServeList(Long regionId) {
        // 区域校验
        Region region = regionMapper.selectById(regionId);
        if (ObjUtil.isNull(region) || region.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            return Collections.emptyList();
        }

        // 查询指定区域下上架的服务分类及项目信息
        List<ServeCategoryResDTO> dtoList = serveMapper.findListByRegionId(regionId);
        if (CollUtil.isEmpty(dtoList)) {
            return Collections.emptyList();
        } else {
            return dtoList;
        }
    }

    @Override
    @Caching(cacheable = {
            @Cacheable(value = RedisConstants.CacheName.HOT_SERVE, key = "#regionId",
                    unless = "#result.size() > 0", cacheManager = RedisConstants.CacheManager.THIRTY_MINUTES),
            @Cacheable(value = RedisConstants.CacheName.HOT_SERVE, key = "#regionId",
                    unless = "#result.size() == 0", cacheManager = RedisConstants.CacheManager.FOREVER)
    })
    public List<ServeAggregationSimpleResDTO> hotServeList(Long regionId) {
        // 区域校验
        Region region = regionMapper.selectById(regionId);
        if (ObjUtil.isNull(region) || region.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            return Collections.emptyList();
        }
        // 查询指定区域下上架且热门的服务项目信息
        return serveMapper.findServeListByRegionId(regionId);
    }

    @Override
    public List<ServeAggregationTypeSimpleResDTO> serveTypeList(Long regionId) {
        // 区域校验
        Region region = regionMapper.selectById(regionId);
        if (ObjUtil.isNull(region) || region.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            return Collections.emptyList();
        }
        // 查询当前区域下上架服务对应的分类
        return serveMapper.findServeTypeListByRegionId(regionId);
    }

    @Override
    public List<ServeSimpleResDTO> search(String cityCode, String keyword, Long serveTypeId) {
        // 创建请求对象
        SearchRequest request = new SearchRequest("serve_aggregation");

        // 封装请求参数
        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery();
        boolQuery.must(QueryBuilders.termQuery("city_code", cityCode));
        if (StrUtil.isNotBlank(keyword)) {
            boolQuery.must(QueryBuilders.matchQuery("keyword", keyword));
        }
        if (ObjUtil.isNotNull(serveTypeId) || serveTypeId > 0) {
            boolQuery.must(QueryBuilders.termQuery("serve_type_id", serveTypeId));
        }

        // 执行搜索请求
        SearchResponse response = null;
        request.source().query(boolQuery);
        request.source().sort("serve_item_sort_num", SortOrder.ASC);
        try {
            response = client.search(request, RequestOptions.DEFAULT);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 返回搜索结果
        if (response.getHits().getTotalHits().value == 0) {
            return Collections.emptyList();
        } else {
            return Arrays.stream(response.getHits().getHits())
                    .map(e -> JSONUtil.toBean(e.getSourceAsString(), ServeSimpleResDTO.class))
                    .collect(Collectors.toList());
        }
    }

    /**
     * 新增服务同步数据
     *
     * @param serveId 服务id
     */
    private void addServeSync(Long serveId) {
        Serve serve = baseMapper.selectById(serveId);
        Region region = regionMapper.selectById(serve.getRegionId());
        ServeItem serveItem = serveItemMapper.selectById(serve.getServeItemId());
        ServeType serveType = serveTypeMapper.selectById(serveItem.getServeTypeId());

        ServeSync serveSync = new ServeSync();
        serveSync.setServeTypeId(serveType.getId());
        serveSync.setServeTypeName(serveType.getName());
        serveSync.setServeTypeIcon(serveType.getServeTypeIcon());
        serveSync.setServeTypeImg(serveType.getImg());
        serveSync.setServeTypeSortNum(serveType.getSortNum());

        serveSync.setServeItemId(serveItem.getId());
        serveSync.setServeItemIcon(serveItem.getServeItemIcon());
        serveSync.setServeItemName(serveItem.getName());
        serveSync.setServeItemImg(serveItem.getImg());
        serveSync.setServeItemSortNum(serveItem.getSortNum());
        serveSync.setUnit(serveItem.getUnit());
        serveSync.setDetailImg(serveItem.getDetailImg());
        serveSync.setPrice(serve.getPrice());

        serveSync.setCityCode(region.getCityCode());
        serveSync.setId(serve.getId());
        serveSync.setIsHot(serve.getIsHot());

        serveSyncMapper.insert(serveSync);
    }

}