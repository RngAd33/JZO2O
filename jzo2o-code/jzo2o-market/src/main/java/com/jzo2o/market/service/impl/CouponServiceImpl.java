package com.jzo2o.market.service.impl;

import cn.hutool.core.util.ObjUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.api.market.dto.request.CouponUseReqDTO;
import com.jzo2o.api.market.dto.response.CouponUseResDTO;
import com.jzo2o.common.expcetions.CommonException;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.common.utils.BeanUtils;
import com.jzo2o.common.utils.DateUtils;
import com.jzo2o.common.utils.NumberUtils;
import com.jzo2o.market.enums.CouponStatusEnum;
import com.jzo2o.market.mapper.CouponMapper;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.market.model.domain.CouponWriteOff;
import com.jzo2o.market.model.dto.request.CouponOperationPageQueryReqDTO;
import com.jzo2o.market.model.dto.request.SeizeCouponReqDTO;
import com.jzo2o.market.model.dto.response.ActivityInfoResDTO;
import com.jzo2o.market.model.dto.response.CountResDTO;
import com.jzo2o.market.model.dto.response.CouponInfoResDTO;
import com.jzo2o.market.service.IActivityService;
import com.jzo2o.market.service.ICouponService;
import com.jzo2o.market.service.ICouponUseBackService;
import com.jzo2o.market.service.ICouponWriteOffService;
import com.jzo2o.market.utils.CouponUtils;
import com.jzo2o.mvc.utils.UserContext;
import com.jzo2o.mysql.utils.PageUtils;
import com.jzo2o.redis.utils.RedisSyncQueueUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import static com.jzo2o.common.constants.ErrorInfo.Code.SEIZE_COUPON_FAILD;
import static com.jzo2o.market.constants.RedisConstants.RedisKey.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author itcast
 * @since 2023-09-16
 */
@Service
@Slf4j
public class CouponServiceImpl extends ServiceImpl<CouponMapper, Coupon> implements ICouponService {

    @Resource
    private IActivityService activityService;

    @Resource
    private ICouponUseBackService couponUseBackService;

    @Resource
    private ICouponWriteOffService couponWriteOffService;

    @Resource
    private CouponMapper couponMapper;

    @Resource
    private DefaultRedisScript<String> seizeCouponScript;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public List<CountResDTO> countByActivityIdList(List<Long> activityIdList) {
        return couponMapper.countByActivityIdList(activityIdList);
    }

    @Override
    public PageResult<CouponInfoResDTO> findByPage(CouponOperationPageQueryReqDTO dto) {
        if (dto.getActivityId() == null) {
            throw new ForbiddenOperationException("请指定活动id");
        }
        // 设置分页条件
        Page<Coupon> page = PageUtils.parsePageQuery(dto, Coupon.class);
        // 设置业务条件
        LambdaQueryWrapper<Coupon> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Coupon::getActivityId, dto.getActivityId());
        // 执行分页
        page = this.page(page, wrapper);
        // 组装返回结果
        return PageUtils.toPage(page, CouponInfoResDTO.class);
    }

    @Override
    public void processExpireCoupon() {
        this.lambdaUpdate()
                .eq(Coupon::getStatus, CouponStatusEnum.NO_USE.getStatus())
                .le(Coupon::getValidityTime, DateUtils.now())
                .set(Coupon::getStatus, CouponStatusEnum.INVALID.getStatus())
                .update();
    }

    @Override
    public void seizeCoupon(SeizeCouponReqDTO seizeCouponReqDTO) {
        // 校验当前时间是否在活动期间
        ActivityInfoResDTO activity = activityService.getActivityInfoByIdFromCache(seizeCouponReqDTO.getId());
        if (activity == null || activity.getDistributeStartTime().isAfter(LocalDateTime.now())) {
            throw new CommonException(SEIZE_COUPON_FAILD, "活动不存在或者未开始");
        }
        if (activity.getDistributeEndTime().isBefore(LocalDateTime.now())) {
            throw new CommonException(SEIZE_COUPON_FAILD, "活动不存在或者已结束");
        }
        // 抢券
        // - 准备参数
        int index = (int) (seizeCouponReqDTO.getId() % 10);
        String couponSeizeSyncRedisKey = RedisSyncQueueUtils.getQueueRedisKey(COUPON_SEIZE_SYNC_QUEUE_NAME, index);   // 同步队列 redisKey
        String resourceStockRedisKey = String.format(COUPON_RESOURCE_STOCK, index);   // 资源库存 redisKey
        String couponSeizeListRedisKey = String.format(COUPON_SEIZE_LIST, activity.getId(), index);   // 抢券列表
        log.debug("seize coupon keys -> couponSeizeListRedisKey -> {}, resourceStockRedisKey -> {}, couponSeizeListRedisKey -> {}, seizeCouponReqDTO.getId() -> {}, UserContext.currentUserId() -> {}",
                couponSeizeListRedisKey, resourceStockRedisKey, couponSeizeListRedisKey, seizeCouponReqDTO.getId(), UserContext.currentUserId());
        // - 执行抢券脚本
        Object executeResult = redisTemplate.execute(
                seizeCouponScript,   // 脚本
                Arrays.asList(couponSeizeSyncRedisKey, resourceStockRedisKey, couponSeizeListRedisKey),   // 键
                seizeCouponReqDTO.getId(), UserContext.currentUserId()   // 参数
        );

        // 返回结果
        if (executeResult == null) {
            throw new CommonException(SEIZE_COUPON_FAILD, "抢券失败");
        }
        int result = NumberUtils.parseInt(executeResult.toString());
        if (result > 0) return;
        // - 异常处理
        switch (result) {
            case -1:
                throw new CommonException(SEIZE_COUPON_FAILD, "限领一张");
            case -2:
            case -4:
                throw new CommonException(SEIZE_COUPON_FAILD, "已抢光!");
            default:
                throw new CommonException(SEIZE_COUPON_FAILD, "抢券失败");
        }
    }

    @Override
    public List<CouponInfoResDTO> queryForList(Long lastId, Long userId, Integer status) {
        List<Coupon> list = this.lambdaQuery()
                .eq(Coupon::getStatus, status)
                .eq(Coupon::getUserId, userId)
                .lt(lastId != null, Coupon::getId, lastId)
                .orderByDesc(Coupon::getCreateTime)
                .last("limit 10")
                .list();
        return BeanUtils.copyToList(list, CouponInfoResDTO.class);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public CouponUseResDTO use(CouponUseReqDTO couponUseReqDTO) {
        //1. 校验优惠券信息: 只有订单金额大于等于满减金额，并且优惠券在有效状态方可使用
        Coupon coupon = this.lambdaQuery()
                .eq(Coupon::getUserId, UserContext.currentUserId())//- 所属用户：当前登录用户
                .eq(Coupon::getStatus, CouponStatusEnum.NO_USE.getStatus())//- 状态：未使用
                .ge(Coupon::getValidityTime, LocalDateTime.now())//- 在有效使用期限内
                .le(Coupon::getAmountCondition, couponUseReqDTO.getTotalAmount())//- 满减金额：小于等于订单总额
                .eq(Coupon::getId, couponUseReqDTO.getId())//优惠券id
                .one();
        if (ObjUtil.isNull(coupon)) {
            throw new ForbiddenOperationException("优惠券核销失败");
        }

        //2. 修改优惠券表中该优惠券的使用状态（已使用）、使用时间（当前时间）、订单id（订单微服务传入）
        coupon.setStatus(CouponStatusEnum.USED.getStatus());//使用状态（已使用）
        coupon.setUseTime(LocalDateTime.now());//使用时间（当前时间）
        coupon.setOrdersId(couponUseReqDTO.getOrdersId().toString());//订单id（订单微服务传入）
        this.updateById(coupon);

        //3. 向优惠券核销表添加一条记录
        CouponWriteOff couponWriteOff = new CouponWriteOff();
        couponWriteOff.setCouponId(couponUseReqDTO.getId());
        couponWriteOff.setUserId(UserContext.currentUserId());
        couponWriteOff.setOrdersId(couponUseReqDTO.getOrdersId());
        couponWriteOff.setActivityId(coupon.getActivityId());
        couponWriteOff.setWriteOffTime(LocalDateTime.now());
        couponWriteOff.setWriteOffManPhone(coupon.getUserPhone());
        couponWriteOff.setWriteOffManName(coupon.getUserName());
        couponWriteOffService.save(couponWriteOff);

        //4. 核销成功返回最终优惠的金额
        BigDecimal discountAmount = CouponUtils.calDiscountAmount(coupon, couponUseReqDTO.getTotalAmount());
        CouponUseResDTO couponUseResDTO = new CouponUseResDTO();
        couponUseResDTO.setDiscountAmount(discountAmount);
        return couponUseResDTO;
    }

}