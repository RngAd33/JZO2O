package com.jzo2o.foundations.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.foundations.enums.FoundationStatusEnum;
import com.jzo2o.foundations.mapper.RegionMapper;
import com.jzo2o.foundations.mapper.ServeItemMapper;
import com.jzo2o.foundations.mapper.ServeMapper;
import com.jzo2o.foundations.model.domain.Region;
import com.jzo2o.foundations.model.domain.Serve;
import com.jzo2o.foundations.model.domain.ServeItem;
import com.jzo2o.foundations.model.dto.request.ServePageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.RegionResDTO;
import com.jzo2o.foundations.model.dto.response.RegionSimpleResDTO;
import com.jzo2o.foundations.model.dto.response.ServeCategoryResDTO;
import com.jzo2o.foundations.model.dto.response.ServeResDTO;
import com.jzo2o.foundations.service.IServeService;
import com.jzo2o.mysql.utils.PageHelperUtils;
import com.jzo2o.mysql.utils.PageUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

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
    }

    @Override
    public void offSale(Long id) {
        Serve serve = this.getById(id);
        if (serve.getSaleStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            throw new ForbiddenOperationException("当前区域服务未启用！");
        }

        Long serveItemId = serve.getServeItemId();
        ServeItem serveItem = serveItemMapper.selectById(serveItemId);
        if (ObjUtil.isNull(serveItem) || serveItem.getActiveStatus() != FoundationStatusEnum.DISABLE.getStatus()) {
            throw new ForbiddenOperationException("服务项目未禁用！");
        }

        serve.setSaleStatus(FoundationStatusEnum.DISABLE.getStatus());
        this.updateById(serve);
    }

    @Override
    public List<ServeCategoryResDTO> firstPageServeList(Long regionId) {
        // 区域校验
        Region region = regionMapper.selectById(regionId);
        if (ObjUtil.isNull(region) || region.getActiveStatus() != FoundationStatusEnum.ENABLE.getStatus()) {
            return Collections.emptyList();
        }

        // 查询指定区域下上架的服务分类及项目信息
        List<ServeCategoryResDTO> dtoList = serveMapper.findListByRegionId(regionId);

        return List.of();
    }

}