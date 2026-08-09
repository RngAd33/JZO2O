package com.jzo2o.foundations.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.api.foundations.dto.response.RegionSimpleResDTO;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.foundations.enums.FoundationStatusEnum;
import com.jzo2o.foundations.mapper.CityDirectoryMapper;
import com.jzo2o.foundations.mapper.RegionMapper;
import com.jzo2o.foundations.mapper.ServeItemMapper;
import com.jzo2o.foundations.mapper.ServeMapper;
import com.jzo2o.foundations.model.domain.CityDirectory;
import com.jzo2o.foundations.model.domain.Region;
import com.jzo2o.foundations.model.domain.Serve;
import com.jzo2o.foundations.model.domain.ServeItem;
import com.jzo2o.foundations.model.dto.request.RegionPageQueryReqDTO;
import com.jzo2o.foundations.model.dto.request.RegionUpsertReqDTO;
import com.jzo2o.foundations.model.dto.request.ServeUpsertReqDTO;
import com.jzo2o.foundations.model.dto.response.RegionResDTO;
import com.jzo2o.foundations.service.IConfigRegionService;
import com.jzo2o.foundations.service.IRegionService;
import com.jzo2o.mysql.utils.PageUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * 区域管理
 *
 * @author itcast
 * @create 2023/7/17 16:50
 **/
@Service
public class RegionServiceImpl extends ServiceImpl<RegionMapper, Region> implements IRegionService {

    @Resource
    private IConfigRegionService configRegionService;

    @Resource
    private CityDirectoryMapper cityDirectoryMapper;

    @Resource
    private ServeItemMapper serveItemMapper;

    @Resource
    private ServeMapper serveMapper;

    /**
     * 区域新增
     *
     * @param regionUpsertReqDTO 插入更新区域
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(RegionUpsertReqDTO regionUpsertReqDTO) {
        // 1.校验城市编码是否重复
        LambdaQueryWrapper<Region> queryWrapper = Wrappers.<Region>lambdaQuery().eq(Region::getCityCode, regionUpsertReqDTO.getCityCode());
        Integer count = baseMapper.selectCount(queryWrapper);
        if (count > 0) {
            throw new ForbiddenOperationException("城市提交重复");
        }

        // 查询城市
        CityDirectory cityDirectory = cityDirectoryMapper.selectById(regionUpsertReqDTO.getCityCode());
        // 查询城市的排序位
        int sotNum = cityDirectory.getSortNum();

        // 2.新增区域
        Region region = BeanUtil.toBean(regionUpsertReqDTO, Region.class);
        region.setSortNum(sotNum);
        baseMapper.insert(region);

        // 3.初始化区域配置
        configRegionService.init(region.getId(), region.getCityCode());
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
            Region region = this.getById(regionId);
            if (ObjUtil.isNotNull(region)) {
                serve.setCityCode(region.getCityCode());
            }
            serveMapper.insert(serve);
            baseMapper.insert(region);
        }
    }

    /**
     * 区域修改
     *
     * @param id           区域id
     * @param managerName  负责人姓名
     * @param managerPhone 负责人电话
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(Long id, String managerName, String managerPhone, BigDecimal price) {
        if (!ObjUtil.isAllEmpty(id, managerName, managerPhone)) {
            Region region = new Region();
            region.setId(id);
            region.setManagerName(managerName);
            region.setManagerPhone(managerPhone);
            this.updateById(region);
        }
        if (ObjUtil.isNotEmpty(price)) {
            Serve serve = new Serve();
            serve.setRegionId(id);
            serve.setPrice(price);
            serveMapper.update(serve, Wrappers.<Serve>lambdaUpdate().eq(Serve::getRegionId, id));
        }
    }

    /**
     * 区域删除
     *
     * @param id 区域id
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteById(Long id) {
        // 区域信息
        Region region = baseMapper.selectById(id);
        // 启用状态
        Integer activeStatus = region.getActiveStatus();
        // 草稿状态方可删除
        if (!(FoundationStatusEnum.INIT.getStatus() == activeStatus)) {
            throw new ForbiddenOperationException("草稿状态方可删除！");
        }
        // 删除
        this.removeById(id);
    }

    /**
     * 分页查询
     *
     * @param regionPageQueryReqDTO 查询条件
     * @return 分页结果
     */
    @Override
    public PageResult<RegionResDTO> page(RegionPageQueryReqDTO regionPageQueryReqDTO) {
        Page<Region> page = PageUtils.parsePageQuery(regionPageQueryReqDTO, Region.class);
        Page<Region> serveTypePage = baseMapper.selectPage(page, new QueryWrapper<>());
        return PageUtils.toPage(serveTypePage, RegionResDTO.class);
    }

    /**
     * 已开通服务区域列表
     *
     * @return 区域列表
     */
    @Override
    public List<RegionSimpleResDTO> queryActiveRegionList() {
        LambdaQueryWrapper<Region> queryWrapper = Wrappers.<Region>lambdaQuery()
                .eq(Region::getActiveStatus, FoundationStatusEnum.ENABLE.getStatus())
                .orderByAsc(Region::getSortNum);
        List<Region> regionList = baseMapper.selectList(queryWrapper);
        return BeanUtil.copyToList(regionList, RegionSimpleResDTO.class);
    }

    /**
     * 区域启用
     *
     * @param id 区域id
     */
    @Override
    public void active(Long id) {
        // 区域信息
        Region region = baseMapper.selectById(id);
        // 启用状态
        Integer activeStatus = region.getActiveStatus();
        // 草稿或禁用状态方可启用
        if (!(FoundationStatusEnum.INIT.getStatus() == activeStatus || FoundationStatusEnum.DISABLE.getStatus() == activeStatus)) {
            throw new ForbiddenOperationException("草稿或禁用状态方可启用");
        }
        // todo 如果需要启用区域，需要校验该区域下是否有上架的服务


        // 更新启用状态
        LambdaUpdateWrapper<Region> updateWrapper = Wrappers.<Region>lambdaUpdate()
                .eq(Region::getId, id)
                .set(Region::getActiveStatus, FoundationStatusEnum.ENABLE.getStatus());
        update(updateWrapper);

        // todo 3.如果是启用操作，刷新缓存：启用区域列表、首页图标、热门服务、服务类型

    }

    /**
     * 区域禁用
     *
     * @param id 区域id
     */
    @Override
    public void deactivate(Long id) {
        // 区域信息
        Region region = baseMapper.selectById(id);
        // 启用状态
        Integer activeStatus = region.getActiveStatus();
        //启用状态方可禁用
        if (!(FoundationStatusEnum.ENABLE.getStatus() == activeStatus)) {
            throw new ForbiddenOperationException("启用状态方可禁用");
        }

        // todo 如果禁用区域下有上架的服务则无法禁用

        //更新禁用状态
        LambdaUpdateWrapper<Region> updateWrapper = Wrappers.<Region>lambdaUpdate()
                .eq(Region::getId, id)
                .set(Region::getActiveStatus, FoundationStatusEnum.DISABLE.getStatus());
        update(updateWrapper);
    }

    /**
     * 已开通服务区域列表
     *
     * @return 区域简略列表
     */
    @Override
    public List<RegionSimpleResDTO> queryActiveRegionListCache() {
        return queryActiveRegionList();
    }

}
