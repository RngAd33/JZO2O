package com.jzo2o.market.controller.consumer;

import com.jzo2o.market.model.dto.response.SeizeCouponInfoResDTO;
import com.jzo2o.market.service.IActivityService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController("consumerActivityController")
@RequestMapping("/consumer/activity")
@Api(tags = "用户端-活动相关接口")
public class ActivityController {

    @Resource
    private IActivityService activityService;

    @ApiOperation("用户端抢券列表分页查询活动信息")
    @GetMapping("/list")
    public List<SeizeCouponInfoResDTO> queryForPage(Integer tabType) {
        return activityService.queryForListFromCache(tabType);
    }
}