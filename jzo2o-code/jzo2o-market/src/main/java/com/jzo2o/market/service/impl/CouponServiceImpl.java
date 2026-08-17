package com.jzo2o.market.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.common.utils.DateUtils;
import com.jzo2o.market.enums.CouponStatusEnum;
import com.jzo2o.market.mapper.CouponMapper;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.market.model.dto.request.CouponOperationPageQueryReqDTO;
import com.jzo2o.market.model.dto.response.CountResDTO;
import com.jzo2o.market.model.dto.response.CouponInfoResDTO;
import com.jzo2o.market.service.IActivityService;
import com.jzo2o.market.service.ICouponService;
import com.jzo2o.market.service.ICouponUseBackService;
import com.jzo2o.market.service.ICouponWriteOffService;
import com.jzo2o.mysql.utils.PageUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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
    private DefaultRedisScript<String> seizeCouponScript;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private IActivityService activityService;

    @Resource
    private ICouponUseBackService couponUseBackService;

    @Resource
    private ICouponWriteOffService couponWriteOffService;

    @Resource
    private CouponMapper couponMapper;

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

}