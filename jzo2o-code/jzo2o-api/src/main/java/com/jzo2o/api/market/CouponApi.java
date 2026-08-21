package com.jzo2o.api.market;

import com.jzo2o.api.market.dto.request.CouponUseBackReqDTO;
import com.jzo2o.api.market.dto.request.CouponUseReqDTO;
import com.jzo2o.api.market.dto.response.CouponUseResDTO;
import io.swagger.annotations.ApiOperation;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(contextId = "jzo2o-market", value = "jzo2o-market", path = "/market/inner/coupon")
public interface CouponApi {

    /**
     * 使用优惠券，并返回优惠金额
     *
     * @param couponUseReqDTO 优惠券信息对象
     * @return 优惠金额
     */
    @PostMapping("/use")
    CouponUseResDTO use(@RequestBody CouponUseReqDTO couponUseReqDTO);

    /**
     * 退回优惠券
     *
     * @param couponUseBackReqDTO 优惠券对象
     */
    @PostMapping("/useBack")
    @ApiOperation("退回优惠券")
    void useBack(@RequestBody CouponUseBackReqDTO couponUseBackReqDTO);

}