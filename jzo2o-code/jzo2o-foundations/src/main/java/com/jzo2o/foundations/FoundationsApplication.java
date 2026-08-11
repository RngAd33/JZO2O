package com.jzo2o.foundations;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

/**
 * @author itcast
 */
@SpringBootApplication
@MapperScan("com.jzo2o.foundations.mapper")
@EnableCaching
@EnableAspectJAutoProxy
public class FoundationsApplication {
    public static void main(String[] args) {
        SpringApplication.run(FoundationsApplication.class, args);
        System.out.println("家政服务-运营基础服务已启动 >>>");
    }
}