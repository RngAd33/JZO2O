package com.jzo2o.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
public @interface NoWriteService {
    String value() default "";
}