package com.jzo2o.orders.manager;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author itcast
 */
@SpringBootApplication
@EnableAspectJAutoProxy
@EnableTransactionManagement
@EnableScheduling
public class OrdersManagerApplication {
    public static void main(String[] args) {
        new SpringApplicationBuilder(OrdersManagerApplication.class)
                .build(args)
                .run(args);
        System.out.println("家政服务-订单管理微服务启动");
    }
}
