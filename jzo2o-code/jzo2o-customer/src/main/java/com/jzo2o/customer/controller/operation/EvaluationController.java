package com.jzo2o.customer.controller.operation;

import com.jzo2o.customer.model.dto.response.EvaluationTokenDto;
import com.jzo2o.customer.service.EvaluationService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 评价相关接口
 *
 * @author itcast
 * @create 2023/9/11 16:14
 **/
@RestController("operationEvaluationController")
@RequestMapping("/operation/evaluation")
@Api(tags = "运营端 - 评价相关接口")
public class EvaluationController {
    @Resource
    private EvaluationService evaluationService;


    @GetMapping("/token")
    @ApiOperation("获取评价系统token")
    public EvaluationTokenDto getToken() {
        return evaluationService.getEvaluationInfo();
    }
}
