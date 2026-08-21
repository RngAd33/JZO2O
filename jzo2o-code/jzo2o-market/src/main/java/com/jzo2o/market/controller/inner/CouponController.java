package com.jzo2o.market.controller.inner;

import com.jzo2o.api.market.dto.request.CouponUseReqDTO;
import com.jzo2o.api.market.dto.response.CouponUseResDTO;
import com.jzo2o.market.service.ICouponService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController("innerCouponController")
@RequestMapping("/inner/coupon")
@Api(tags = "端-优惠券相关接口")
public class CouponController {

    @Resource
    private ICouponService couponService;

    @ApiOperation("使用优惠券，并返回优惠金额")
    @PostMapping("/use")
    public CouponUseResDTO use(@RequestBody CouponUseReqDTO couponUseReqDTO) {
        return couponService.use(couponUseReqDTO);
    }

}