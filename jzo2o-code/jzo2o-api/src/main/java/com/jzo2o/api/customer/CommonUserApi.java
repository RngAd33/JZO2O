package com.jzo2o.api.customer;

import com.jzo2o.api.customer.dto.response.CommonUserResDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 内部接口 - 普通用户相关接口
 *
 * @author itcast
 */
@FeignClient(contextId = "jzo2o-customer", value = "jzo2o-customer", path = "/customer/inner/common-user")
public interface CommonUserApi {

    @GetMapping("/{id}")
    CommonUserResDTO findById(@PathVariable("id") Long id);

}