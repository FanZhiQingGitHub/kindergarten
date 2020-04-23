package com.great.kindergarten.interceptor;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 拦截器实现类（配置那些不被拦截）
 */
@Configuration
public class KinderGartenConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        InterceptorRegistration interceptorRegistration = registry.addInterceptor(new KinderGartenInterceptor());
        interceptorRegistration.addPathPatterns("/**");
        interceptorRegistration.excludePathPatterns(
                "/commons/**",
                "/homeWork/**",
                "/image/**",
                "/js/**",
                "/layui/**",
                "/loginres/**",
                "/mainres/**",
                "/photos/**",
                "/resources/**",
                "/workRelease/**"
        );
    }
}

