package com.jzo2o.foundations.controller.consumer;

import com.jzo2o.foundations.model.dto.response.ServeCategoryResDTO;
import com.jzo2o.foundations.service.IServeService;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 区域服务接口
 */
@RestController
@RequestMapping("/customer/serve")
public class ServeController {

    @Resource
    private IServeService serveService;

    @GetMapping("/firstPageServeList")
    @ApiOperation("首页服务分类及项目")
    public List<ServeCategoryResDTO> firstPageServeList(@RequestParam("regionId") Long regionId) {
        return serveService.firstPageServeList(regionId);
    }

}