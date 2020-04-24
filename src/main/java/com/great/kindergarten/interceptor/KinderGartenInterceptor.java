package com.great.kindergarten.interceptor;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

/**
 * 拦截器实现类具体拦截方法
 */
public class KinderGartenInterceptor implements HandlerInterceptor {
    /**
     * 该方法会在控制器方法前执行，其返回值表示是否中断后续操作。当其返回值为true时，表示继续向下执行；
     * 当其返回值为false时，会中断后续的所有操作（包括调用下一个拦截器和控制器类中的方法执行等）
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();//拿到拦截的页面
        System.out.println("uri=" + uri);

//        if (uri.equals("/kindergarten/main/path/main")) {
//            try {
//                //统一拦截（查询当前session是否存在user）(这里user会在每次登陆成功后，写入session)
//                String kindername = (String) request.getSession().getAttribute("kindername");
//                if (kindername != null) {
//                    return true;
//                }else {
//                    response.sendRedirect(request.getContextPath() + "/main/Login");
//                    return false;
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            return false;//如果设置为false时，被请求时，拦截器执行到此处将不会继续操作,如果设置为true时，请求将会继续执行后面的操作
//        } else {
//            if(uri.equals("/kindergarten/error")){
//                response.sendRedirect(request.getContextPath() + "/main/error");
//                return false;
//            }else {
//                return true;
//            }
//        }
        return true;
    }

    // 用户鉴权具体方法
    private boolean hasPermission() {
        return false;
    }

    /**
     * 该方法会在控制器方法调用之后，且解析视图之前执行。可以通过此方法对请求域中的模型和视图做出进一步的修改
     *
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * 该方法会在整个请求完成，即视图渲染结束之后执行。可以通过此方法实现一些资源清理、记录日志信息等工作
     *
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
