package com.jzo2o.market.handler;

import cn.hutool.core.util.ObjUtil;
import com.jzo2o.api.customer.CommonUserApi;
import com.jzo2o.api.customer.dto.response.CommonUserResDTO;
import com.jzo2o.common.expcetions.CommonException;
import com.jzo2o.common.utils.NumberUtils;
import com.jzo2o.market.enums.ActivityStatusEnum;
import com.jzo2o.market.mapper.ActivityMapper;
import com.jzo2o.market.mapper.CouponMapper;
import com.jzo2o.market.model.domain.Activity;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.redis.handler.SyncProcessHandler;
import com.jzo2o.redis.model.SyncMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

import static com.jzo2o.market.constants.RedisConstants.RedisKey.COUPON_SEIZE_SYNC_QUEUE_NAME;

/**
 * 抢券同步处理类
 */
@Component(COUPON_SEIZE_SYNC_QUEUE_NAME)
@Slf4j
public class SeizeCouponSyncProcessHandler implements SyncProcessHandler<Object> {
    
    @Resource
    private CouponMapper couponMapper;

    @Resource
    private ActivityMapper activityMapper;

    @Resource
    private CommonUserApi commonUserApi;

    @Override
    public void batchProcess(List<SyncMessage<Object>> multiData) {
        throw new RuntimeException("暂不支持批量处理");
    }

    @Override
    public void singleProcess(SyncMessage<Object> singleData) {
        log.info("获取要同步抢券结果数据： {}", singleData);
        long userId = NumberUtils.parseLong(singleData.getKey());//用户id
        long activityId = NumberUtils.parseLong(singleData.getValue().toString());//活动id
        log.info("userId = {}, activity = {}", userId, activityId);

        // 根据优惠券id查询对象
        Activity activity = activityMapper.selectById(activityId);
        if (ObjUtil.isNull(activity)) return;

        // 根据userId查询信息
        CommonUserResDTO userResDTO = commonUserApi.findById(userId);
        if (ObjUtil.isNull(userResDTO)) return;

        // 向优惠券表插入数据
        Coupon coupon = new Coupon();
        coupon.setName(activity.getName());   //优惠券名称使用活动名称
        coupon.setUserId(userId);
        coupon.setUserName(userResDTO.getNickname());
        coupon.setUserPhone(userResDTO.getPhone());
        coupon.setActivityId(activityId);
        coupon.setType(activity.getType());
        coupon.setDiscountRate(activity.getDiscountRate());
        coupon.setDiscountAmount(activity.getDiscountAmount());
        coupon.setAmountCondition(activity.getAmountCondition());
        coupon.setValidityTime(LocalDateTime.now().plusDays(activity.getValidityDays()));//有效期
        coupon.setStatus(ActivityStatusEnum.NO_DISTRIBUTE.getStatus());
        couponMapper.insert(coupon);

        //4. 扣减数据库表中的库存
        //update activity set stock_num = stock_num - 1 where id = 活动id and stock_num > 0
        int i = activityMapper.deductStock(activityId);
        if (i <= 0) throw new CommonException("同步失败");
    }

}