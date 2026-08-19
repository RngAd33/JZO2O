package com.jzo2o.market.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.common.utils.BeanUtils;
import com.jzo2o.common.utils.DateUtils;
import com.jzo2o.common.utils.JsonUtils;
import com.jzo2o.market.constants.RedisConstants;
import com.jzo2o.market.enums.ActivityStatusEnum;
import com.jzo2o.market.enums.CouponStatusEnum;
import com.jzo2o.market.mapper.ActivityMapper;
import com.jzo2o.market.model.domain.Activity;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.market.model.domain.CouponWriteOff;
import com.jzo2o.market.model.dto.request.ActivityQueryForPageReqDTO;
import com.jzo2o.market.model.dto.request.ActivitySaveReqDTO;
import com.jzo2o.market.model.dto.response.ActivityInfoResDTO;
import com.jzo2o.market.model.dto.response.CountResDTO;
import com.jzo2o.market.model.dto.response.SeizeCouponInfoResDTO;
import com.jzo2o.market.service.IActivityService;
import com.jzo2o.market.service.ICouponService;
import com.jzo2o.market.service.ICouponWriteOffService;
import com.jzo2o.mysql.utils.PageUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.jzo2o.market.constants.RedisConstants.RedisKey.ACTIVITY_CACHE_LIST;
import static com.jzo2o.market.constants.RedisConstants.RedisKey.COUPON_RESOURCE_STOCK;
import static com.jzo2o.market.enums.ActivityStatusEnum.DISTRIBUTING;
import static com.jzo2o.market.enums.ActivityStatusEnum.NO_DISTRIBUTE;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author itcast
 * @since 2023-09-16
 */
@Service
public class ActivityServiceImpl extends ServiceImpl<ActivityMapper, Activity> implements IActivityService {

    @Resource
    private ICouponService couponService;

    @Resource
    private ICouponWriteOffService couponWriteOffService;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    private static final int MILLION = 1000000;

    @Override
    public void saveOrUpdateActivity(ActivitySaveReqDTO dto) {
        dto.check();
        Activity activity = BeanUtil.copyProperties(dto, Activity.class);
        activity.setStatus(NO_DISTRIBUTE.getStatus());   // 待生效
        activity.setStockNum(activity.getTotalNum());   // 库存，一开始等于发放总数量
        this.save(activity);
    }

    @Override
    public PageResult<ActivityInfoResDTO> findByPage(ActivityQueryForPageReqDTO dto) {
        // 设置分页条件
        Page<Activity> page = PageUtils.parsePageQuery(dto, Activity.class);
        // 执行分页查询
        LambdaQueryWrapper<Activity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(dto.getId() != null, Activity::getId, dto.getId())
                .like(StrUtil.isNotBlank(dto.getName()), Activity::getName, dto.getName())
                .eq(dto.getType() != null, Activity::getType, dto.getType())
                .eq(dto.getStatus() != null, Activity::getStatus, dto.getStatus());
        page = this.page(page, wrapper);
        if (CollUtil.isEmpty(page.getRecords())) {
            return new PageResult<>(page.getPages(), page.getTotal(), List.of());
        }
        // 提前查询本页所有活动id对应的优惠券领取数量, 封装到一个 Map<活动id, 优惠券领取数量> 集合中备用
        List<Long> activityIdList = page.getRecords()
                .stream()
                .map(Activity::getId)
                .collect(Collectors.toList());
        // 根据优惠券活动id集合查询优惠券领取数量集合
        List<CountResDTO> countResDTOList = couponService.countByActivityIdList(activityIdList);
        // 将上述集合转换为 map 备用
        Map<Long, Integer> receiveNumMap = countResDTOList.stream()
                .collect(Collectors.toMap(CountResDTO::getActivityId, CountResDTO::getNum));
        // 组装返回结果
        List<ActivityInfoResDTO> list = page.getRecords()
                .stream()
                .map(e -> {
                    ActivityInfoResDTO activityInfoResDTO = BeanUtil.copyProperties(e, ActivityInfoResDTO.class);
                    // - 优惠券领取数量 select count(*) from coupon where activity_id = 活动id
                    int count1 = couponService.lambdaQuery().eq(Coupon::getActivityId, e.getId()).count();
                    activityInfoResDTO.setReceiveNum(count1);
                    // - 优惠券核销数量 select count(*) from coupon_write_off where activity_id = 活动id
                    int count2 = couponWriteOffService.lambdaQuery().eq(CouponWriteOff::getActivityId, e.getId()).count();
                    activityInfoResDTO.setWriteOffNum(count2);
                    return activityInfoResDTO;
        }).collect(Collectors.toList());
        return new PageResult<>(page.getPages(), page.getTotal(), list);
    }

    @Override
    public ActivityInfoResDTO findById(Long id) {
        Activity activity = this.getById(id);
        if (ObjUtil.isNull(activity)){
            throw new ForbiddenOperationException("当前优惠券活动不存在");
        }
        ActivityInfoResDTO activityInfoResDTO = BeanUtil.copyProperties(activity, ActivityInfoResDTO.class);
        // 根据活动id查询coupon统计当前活动的领取数量
        int count1 = couponService.lambdaQuery().eq(Coupon::getActivityId, id).count();
        activityInfoResDTO.setReceiveNum(count1);

        // 根据活动id查询coupon_write_off统计当前活动的核销数量
        int count2 = couponWriteOffService.lambdaQuery().eq(CouponWriteOff::getActivityId, id).count();
        activityInfoResDTO.setWriteOffNum(count2);
        return activityInfoResDTO;
    }

    @Override
    public void revoke(Long id) {
        Activity activity = this.getById(id);
        if (ObjUtil.isNull(activity)) {
            throw new ForbiddenOperationException("当前活动不存在");
        }
        if (activity.getStatus() != NO_DISTRIBUTE.getStatus()
                && activity.getStatus() != DISTRIBUTING.getStatus()) {
            throw new ForbiddenOperationException("当前活动状态不允许撤销");
        }
        // 修改活动的状态  待生效或者进行中 ---> 作废
        // update activity set status = 4 where id = 活动id and status in(1,2)
        boolean flag = this.lambdaUpdate()
                .eq(Activity::getId, id)
                .in(Activity::getStatus, Arrays.asList(NO_DISTRIBUTE.getStatus(), DISTRIBUTING.getStatus()))
                .set(Activity::getStatus, ActivityStatusEnum.VOIDED.getStatus())
                .update();
        // 修改优惠券的状态 未使用  --> 已作废
        // update coupon set status = 4 where activity_id = 活动id and status = 1
        if (flag) {
            couponService.lambdaUpdate()
                    .eq(Coupon::getActivityId,id)
                    .eq(Coupon::getStatus, CouponStatusEnum.NO_USE.getStatus())
                    .set(Coupon::getStatus, CouponStatusEnum.VOIDED.getStatus())
                    .update();
        }
    }

    @Override
    public void updateStatus() {
        // 对于待生效的活动到达发放开始时间状态改为进行中
        // update activity set status = 2 where  status = 1 and  distribute_start_time <= 当前时间 and distribute_end_time > 当前时间
        this.lambdaUpdate()
                .eq(Activity::getStatus, NO_DISTRIBUTE.getStatus())
                .le(Activity::getDistributeStartTime,LocalDateTime.now())
                .gt(Activity::getDistributeEndTime,LocalDateTime.now())
                .set(Activity::getStatus, DISTRIBUTING.getStatus())
                .update();
        // 对于待生效及进行中的活动到达发放结束时间状态改为已失效
        // update activity set status = 3 where status in (1,2) and  distribute_end_time < 当前时间
        this.lambdaUpdate()
                .in(Activity::getStatus, Arrays.asList(NO_DISTRIBUTE.getStatus(), DISTRIBUTING.getStatus()))
                .lt(Activity::getDistributeEndTime,LocalDateTime.now())
                .set(Activity::getStatus, ActivityStatusEnum.LOSE_EFFICACY.getStatus())
                .update();
    }

    @Override
    public void preHeat() {
        // 查询状态是待开始或者进行中，并且发放开始时间距离现在不足 1 个月的活动，按照开始时间升序排列
        // select * from activity where status in (1,2) and distribute_start_time < 当前时间+1个月 order by distribute_start_time asc
        List<Activity> list = this.lambdaQuery()
                .in(Activity::getStatus, Arrays.asList(NO_DISTRIBUTE.getStatus(), DISTRIBUTING.getStatus()))
                .lt(Activity::getDistributeStartTime, LocalDateTime.now().plusMonths(1))
                .orderByAsc(Activity::getDistributeStartTime)
                .list();
        if (CollUtil.isEmpty(list)){
            list = new ArrayList<>();   // - 缓存空值，防止缓存穿透
        }
        // 将查询到的数据封装到 List<SeizeCouponInfoResDTO>，再序列化
        List<SeizeCouponInfoResDTO> seizeCouponInfoResDTOS = BeanUtils.copyToList(list, SeizeCouponInfoResDTO.class);
        String jsonStr = JsonUtils.toJsonStr(seizeCouponInfoResDTOS);

        // 将 JSON 字符串存入 Redis
        redisTemplate.opsForValue().set(ACTIVITY_CACHE_LIST, jsonStr);

        // 将优惠券活动的库存从 MySQL 同步到 Redis
        // - 对于待生效的活动，更新库存
        list.stream().filter(e ->
                getStatus(e.getDistributeStartTime(), e.getDistributeEndTime(), e.getStatus()) == NO_DISTRIBUTE.getStatus()
        ).forEach(e ->
                redisTemplate.opsForHash()
                        .put(String.format(COUPON_RESOURCE_STOCK, e.getId() % 10), e.getId(), e.getStockNum())
        );
        // - 对于已生效的活动，如果库存已经同步则不再同步
        list.stream().filter(e ->
                getStatus(e.getDistributeStartTime(), e.getDistributeEndTime(), e.getStatus()) == DISTRIBUTING.getStatus()
        ).forEach(e ->
                // - 只有在库存不存在的情况下, 才进行保存操作
                redisTemplate.opsForHash()
                        .putIfAbsent(String.format(COUPON_RESOURCE_STOCK, e.getId() % 10), e.getId(), e.getStockNum())
        );
    }

    @Override
    public List<SeizeCouponInfoResDTO> queryForListFromCache(Integer tabType) {
        // 从Redis中查询优惠券活动的数据
        String jsonStr = (String) redisTemplate.opsForValue().get(ACTIVITY_CACHE_LIST);
        if (StrUtil.isBlank(jsonStr)) {
            return List.of();
        }
        // 反序列化
        List<SeizeCouponInfoResDTO> seizeCouponInfoResDTOS = JSON.parseArray(jsonStr, SeizeCouponInfoResDTO.class);
        if (CollUtil.isEmpty(seizeCouponInfoResDTOS)) {
            return List.of();
        }
        return seizeCouponInfoResDTOS.stream().filter(e -> {
            int status = getStatus(e.getDistributeStartTime(), e.getDistributeEndTime(), e.getStatus());
            if (tabType == 1) {
                // - 筛选疯抢中的
                return status == DISTRIBUTING.getStatus();
            } else {
                // - 筛选即将开始的
                return status == ActivityStatusEnum.NO_DISTRIBUTE.getStatus();
            }
        }).peek(e -> e.setRemainNum(e.getStockNum())).collect(Collectors.toList());
//        .map(e -> {
//            e.setRemainNum(e.getStockNum());
//            return e;
//        }).collect(Collectors.toList());
    }

    @Override
    public ActivityInfoResDTO getActivityInfoByIdFromCache(Long id) {
        // 从缓存中获取活动信息
        String jsonString = (String) redisTemplate.opsForValue().get(ACTIVITY_CACHE_LIST);
        if (StrUtil.isBlank(jsonString)) {
            return null;
        }
        // 反序列化
        List<ActivityInfoResDTO> activityInfoResDTOList = JSON.parseArray(jsonString, ActivityInfoResDTO.class);
        if (CollUtil.isEmpty(activityInfoResDTOList)) {
            return null;
        }
        // 过滤出指定 id 的活动
        return activityInfoResDTOList.stream()
                .filter(e -> e.getId().equals(id))
                .findFirst().orElse(null);
    }

    /**
     * 根据活动的目前状态、开始、结束时间 对比当前时间来获取到活动的真实状态
     * 1. 状态在待生效, 但是 活动开始时间 <=当前时间 < 活动结束时间  真实状态应该是 进行中
     * 2. 状态在待生效, 但是 活动结束时间 < 当前时间               真实状态应该是 已结束
     * 3. 状态在进行中, 但是 活动结束时间 < 当前时间               真实状态应该是 已结束
     * 4. 其它情况, 当前状态就是真实状态
     *
     * @param distributeStartTime 活动开始时间
     * @param distributeEndTime   活动结束时间
     * @param status              当前状态
     * @return 活动的真实状态
     */
    private int getStatus(LocalDateTime distributeStartTime, LocalDateTime distributeEndTime, Integer status) {
        if (NO_DISTRIBUTE.getStatus() == status && distributeStartTime.isBefore(DateUtils.now()) && distributeEndTime.isAfter(LocalDateTime.now())) {
            // 状态在待生效, 但是 活动开始时间<=当前时间<活动结束时间  真实状态应该是 进行中
            return DISTRIBUTING.getStatus();
        } else if (NO_DISTRIBUTE.getStatus() == status && distributeEndTime.isBefore(LocalDateTime.now())) {
            // 状态在待生效, 但是 活动结束时间 < 当前时间   真实状态应该是 已结束
            return ActivityStatusEnum.LOSE_EFFICACY.getStatus();
        } else if (DISTRIBUTING.getStatus() == status && distributeEndTime.isBefore(LocalDateTime.now())) {
            // 状态在进行中, 但是 活动结束时间 < 当前时间   真实状态应该是 已结束
            return ActivityStatusEnum.LOSE_EFFICACY.getStatus();
        }
        return status;
    }

}