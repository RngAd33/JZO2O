package com.jzo2o.customer.controller.consumer;

import com.jzo2o.api.customer.dto.response.AddressBookResDTO;
import com.jzo2o.customer.service.IAddressBookService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController("consumerAddressBookController")
@RequestMapping("/consumer/address-book")
@Api(tags = "用户端 - 用户地址相关接口")
public class AddressBookController {

    @Resource
    private IAddressBookService addressBookService;

    @GetMapping("/defaultAddress")
    @ApiOperation("查询用户默认地址值")
    public AddressBookResDTO findDefaultAddress(){
        return addressBookService.findDefaultAddress();
    }

}