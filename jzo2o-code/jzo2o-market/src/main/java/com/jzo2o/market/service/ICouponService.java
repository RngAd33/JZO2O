package com.jzo2o.market.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jzo2o.common.model.PageResult;
import com.jzo2o.market.model.domain.Coupon;
import com.jzo2o.market.model.dto.request.CouponOperationPageQueryReqDTO;
import com.jzo2o.market.model.dto.request.SeizeCouponReqDTO;
import com.jzo2o.market.model.dto.response.CountResDTO;
import com.jzo2o.market.model.dto.response.CouponInfoResDTO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author itcast
 * @since 2023-09-16
 */
public interface ICouponService extends IService<Coupon> {

    /**
     * 根据优惠券活动id集合查询优惠券领取数量集合
     *
     * @param activityIdList 优惠券活动id集合
     * @return 优惠券领取数量集合
     */
    List<CountResDTO> countByActivityIdList(List<Long> activityIdList);

    /**
     * 根据活动id查询优惠券领取记录
     *
     * @param dto 活动id
     * @return 优惠券领取记录
     */
    PageResult<CouponInfoResDTO> findByPage(CouponOperationPageQueryReqDTO dto);

    /**
     * 已领取优惠券自动过期
     */
    void processExpireCoupon();

    /**
     * 抢券
     *
     * @param seizeCouponReqDTO 抢券参数
     */
    void seizeCoupon(SeizeCouponReqDTO seizeCouponReqDTO);

}