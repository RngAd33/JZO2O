package com.jzo2o.foundations.handler;

import com.jzo2o.api.foundations.dto.response.RegionSimpleResDTO;
import com.jzo2o.foundations.constants.RedisConstants;
import com.jzo2o.foundations.service.IRegionService;
import com.jzo2o.foundations.service.IServeService;
import com.xxl.job.core.handler.annotation.XxlJob;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * 定时更新缓存
 */
@Component
@Slf4j
public class SpringCacheSyncHandler {

    @Resource
    private IRegionService regionService;

    @Resource
    private IServeService serveService;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 更新缓存---开通区域 & 首页服务
     */
    @XxlJob("activeRegionCacheSync")
    public void activeRegionCacheSync() {
        log.info("============= 1. 开始更新开通区域列表缓存 ============");
        // 使用 redisTemplate 删除当前缓存中开通区域列表
        String redisKey1 = RedisConstants.CacheName.JZ_CACHE + "::" + RedisConstants.CacheKey.ACTIVE_REGIONS;
        redisTemplate.delete(redisKey1);
        // 重新将开通区域列表添加到缓存
        List<RegionSimpleResDTO> regionSimpleResDTOList = regionService.queryActiveRegionListCache();

        log.info("============= 2. 开始更新首页服务列表缓存 ============");
        // 查询、遍历所有开通区域
        for (RegionSimpleResDTO dto : regionSimpleResDTOList) {
            Long regionId = dto.getId();
            String redisKey2 = RedisConstants.CacheName.SERVE_ICON + "::" + regionId;
            String redisKey3 = RedisConstants.CacheName.HOT_SERVE + "::" + regionId;
            // 根据区域 id 删除缓存数据
            redisTemplate.delete(redisKey2);
            redisTemplate.delete(redisKey3);
            // 重新查询,放入缓存
            serveService.firstPageServeList(regionId);
            serveService.hotServeList(regionId);
        }
//        log.info("============= 3. 开始更新热门服务列表缓存============");
//        for (RegionSimpleResDTO dto : regionSimpleResDTOList) {
//            Long regionId = dto.getId();
//            String redisKey3 = RedisConstants.CacheName.HOT_SERVE + "::" + regionId;
//            // 根据区域 id 删除缓存数据
//            redisTemplate.delete(redisKey3);
//            // 重新查询,放入缓存
//            serveService.hotServeList(regionId);
//        }
    }

}