package com.great.kindergarten.security.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义系统日志注解
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface SecuritySystemLog {
    /**
     * 要执行的操作类型 比如：登录
     * @return
     */
    public String operationType() default "";

    /**
     * 要执行的具体操作 比如：用户登录
     * @return
     */
    public String operationName() default "";
}
