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
        interceptorRegistration.addPathPatterns("/main/**","/admin/**","/director/**","/healther/**","/parent/**","/security/**","/teacher/**");
        interceptorRegistration.excludePathPatterns(
                "/main/path/main",

                "/admin/toUrl/adminLogin",
                "/admin/checkLogin",
                "/admin/loginCode",
                "/admin/resetAdminPwd",
                "/admin/resetAdminPwd",

                "/director/toUrl/directorLogin",
                "/director/directorLogin",
                "/director/loginCode",
                "/director/selectresetRectorPwd",
                "/director/resetRectorPwd",
                "/director/toUrl/director_SchoolMessage",
                "/director/selectSchoolMessage",
                "/director/chatLogin",
                "/director/toUrl/chatlogin",
                "/director/mainpage",
                "/director/toUrl/chatmain",

//                "/healther/path/healtherLogin",
                "/healther/healtherLogin",
                "/healther/loginCode",
                "/healther/findExistHealtherName",
                "/healther/resetHealtherpwd",

//                "/parent/toUrl/parentLogin",
                "/parent/healtherLogin",
                "/parent/loginCode",
                "/parent/resetParentpwd",

//                "/security/path/securityLogin",
                "/security/securityLogin",
                "/security/loginCode",
                "/security/findExistSecurityName",
                "/security/resetSecuritypwd",

//                "/teacher/toUrl/teacherLogin",
                "/teacher/teacherLogin",
                "/teacher/loginCode",
                "/teacher/resetTeacherpwd"



//                "/commons/**",
//                "/homeWork/**",
//                "/image/**",
//                "/js/**",
//                "/layui/**",
//                "/loginres/**",
//                "/mainres/**",
//                "/photos/**",
//                "/resources/**",
//                "/workRelease/**"
        );
    }
}

