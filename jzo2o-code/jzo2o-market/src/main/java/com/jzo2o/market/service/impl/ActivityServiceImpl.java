package com.jzo2o.market.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.market.enums.ActivityStatusEnum;
import com.jzo2o.market.enums.CouponStatusEnum;
import com.jzo2o.market.mapper.ActivityMapper;
import com.jzo2o.market.mapper.CouponMapper;
import com.jzo2o.market.model.domain.Activity;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.market.model.domain.CouponWriteOff;
import com.jzo2o.market.model.dto.request.ActivityQueryForPageReqDTO;
import com.jzo2o.market.model.dto.request.ActivitySaveReqDTO;
import com.jzo2o.market.model.dto.response.ActivityInfoResDTO;
import com.jzo2o.market.model.dto.response.CountResDTO;
import com.jzo2o.market.service.IActivityService;
import com.jzo2o.market.service.ICouponService;
import com.jzo2o.market.service.ICouponWriteOffService;
import com.jzo2o.mysql.utils.PageUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
                && activity.getStatus() != ActivityStatusEnum.DISTRIBUTING.getStatus()) {
            throw new ForbiddenOperationException("当前活动状态不允许撤销");
        }
        // 修改活动的状态  待生效或者进行中 ---> 作废
        // update activity set status = 4 where id = 活动id and status in(1,2)
        boolean flag = this.lambdaUpdate()
                .eq(Activity::getId, id)//id = 活动id
                .in(Activity::getStatus, NO_DISTRIBUTE.getStatus(), ActivityStatusEnum.DISTRIBUTING.getStatus())//status in(1,2)
                .set(Activity::getStatus, ActivityStatusEnum.VOIDED.getStatus())//set status = 4
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
                .set(Activity::getStatus, ActivityStatusEnum.DISTRIBUTING.getStatus())
                .update();
        // 对于待生效及进行中的活动到达发放结束时间状态改为已失效
        // update activity set status = 3 where status in (1,2) and  distribute_end_time < 当前时间
        this.lambdaUpdate()
                .in(Activity::getStatus, NO_DISTRIBUTE.getStatus(), ActivityStatusEnum.DISTRIBUTING.getStatus())
                .lt(Activity::getDistributeEndTime,LocalDateTime.now())
                .set(Activity::getStatus, ActivityStatusEnum.LOSE_EFFICACY.getStatus())
                .update();
    }

}