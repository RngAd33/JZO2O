package com.jzo2o.customer;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@SpringBootApplication
@MapperScan("com.jzo2o.customer.mapper")
@EnableCaching
@EnableAspectJAutoProxy
public class CustomerApplication {

    public static void main(String[] args) {
        new SpringApplicationBuilder(CustomerApplication.class)
                .build(args)
                .run(args);
        System.out.println("家政服务-客户中心已启动 >>>");
    }
}
