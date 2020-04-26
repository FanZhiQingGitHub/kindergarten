package com.great.kindergarten.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        //request.getSchema()可以返回当前页面使用的协议，就是上面例子中的“http”
        //request.getServerName()可以返回当前页面所在的服务器的名字，就是上面例子中的“localhost"
        //request.getServerPort()可以返回当前页面所在的服务器使用的端口，
        //request.getContextPath()可以返回当前页面所在的应用的名字
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        System.out.println("basePath="+basePath);
//        String main = "/kindergarten/main/path/main";
//        String admin = "/kindergarten/admin/toUrl/adminMain";
//        String director = "/kindergarten/director/toUrl/directorMain";
//        String healther = "/kindergarten/healther/path/healtherMain";
//        String parent = "/kindergarten/parent/toUrl/parentMain";
//        String security = "/kindergarten/security/path/securityMain";
//        String teacher = "/kindergarten/teacher/toUrl/teacherMain";


        if (uri.endsWith("Login")||uri.endsWith("logout")){
            //如果是访问登陆或者退出可以直接访问
            return true;
        }

        if (uri.contains("main")){
            //判断要访问的是主页的方法

        }

        if (uri.contains("admin")){
            //判断管理员是否登录
            if (request.getSession().getAttribute("rolename") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/admin/toUrl/adminLogin");
                //重定向之后放行
                return true;
            }

        }
        if (uri.contains("director")){

            //判断园长是否登录
            if (request.getSession().getAttribute("rectorname") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/director/toUrl/directorLogin");
                //重定向之后放行
                return true;
            }

        }
        if (uri.contains("healther")){
            //判断保健员是否登录
            if (request.getSession().getAttribute("healthername") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/healther/path/healtherLogin");
                //重定向之后放行
                return true;
            }
        }

        if (uri.contains("parent")){

            //判断家长是否登录
            if (request.getSession().getAttribute("onlineParent") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/parent/toUrl/parentLogin");
                //重定向之后放行
                return true;
            }


        }

        if (uri.contains("security")){
            //判断安防员是否登录
            if (request.getSession().getAttribute("securityname") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/security/path/securityLogin");
                //重定向之后放行
                return true;
            }

        }
        if (uri.contains("teacher")){
            //判断班主任是否登录
            if (request.getSession().getAttribute("teachername") != null) {
                return true;
            }else {
                response.sendRedirect(basePath + "/teacher/toUrl/teacherLogin");
                //重定向之后放行
                return true;
            }

        }


        //判断幼儿园是否登录
        if (request.getSession().getAttribute("kindername") != null) {
            return true;
        }




        System.out.println("返回幼儿园登录界面");
        response.sendRedirect(basePath + "/main/path/Login");
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
