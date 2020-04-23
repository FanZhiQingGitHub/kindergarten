package com.great.kindergarten.parent.annotation;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.net.InetAddress;

/**
 * 切点类
 */
@Aspect
@Component
public class ParentSystemLogAspect {
//注入Service用于把日志保存数据库

//    @Resource  //这里我用resource注解
//    private UserService userService;


    //这里的zxtest要和log4j.properties里的配置一致，否则写不到文件中
    private static Logger logger = Logger.getLogger("zxtest");

    //Controller层切点
    //匹配当前包下所有类中所有方法（不包括子包）&& 只匹配带PmLog注解的方法
    @Pointcut("within(com.great.kindergarten.parent.controller.*) && @annotation(com.great.kindergarten.parent.annotation.ParentSystemLog)")
    public void controllerAspect() {

    }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) {
        System.out.println("==========执行controller前置通知===============");

        if (logger.isInfoEnabled()) {
            logger.info("before " + joinPoint);
        }
    }

    //配置controller环绕通知,使用在方法aspect()上注册的切入点
    @Around("controllerAspect()")
    public void around(JoinPoint joinPoint) {
        System.out.println("==========开始执行controller环绕通知===============");
        long start = System.currentTimeMillis();
        //(signature是信号,标识的意思):获取被增强的方法相关信息.其后续方法有两个
        //getDeclaringTypeName: 返回方法所在的包名和类名
        //getname(): 返回方法名
        String methodName = joinPoint.getSignature().getName();

        try {
            //ProceedingJoinPoint 执行proceed方法的作用是让目标方法执行
            ((ProceedingJoinPoint) joinPoint).proceed();
            long end = System.currentTimeMillis();
            if (logger.isInfoEnabled()) {
                logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms!");
            }
            System.out.println("==========结束执行controller环绕通知===============");
        } catch (Throwable e) {
            System.out.println("环绕通知中的异常--------------------------------" + methodName + "-------" + e.getMessage());
            long end = System.currentTimeMillis();
            if (logger.isInfoEnabled()) {
                logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms with exception : " + e.getMessage());
            }
        }
    }

    /**
     * 后置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
    @After("controllerAspect()")
    public void after(JoinPoint joinPoint) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();

        //读取session中的用户
        String username = (String) session.getAttribute("onlineParent");
        //请求的IP
        InetAddress addr = InetAddress.getLocalHost();
        String ip = addr.getHostAddress();

        try {

            String targetName = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            Object[] arguments = joinPoint.getArgs();
            Class targetClass = Class.forName(targetName);
            Method[] methods = targetClass.getMethods();
            String operationType = "";
            String operationName = "";
            for (Method method : methods) {
                if (method.getName().equals(methodName)) {
                    Class[] clazzs = method.getParameterTypes();
                    if (clazzs.length == arguments.length) {
                        operationType = method.getAnnotation(ParentSystemLog.class).operationType();
                        operationName = method.getAnnotation(ParentSystemLog.class).operationName();
                        break;
                    }
                }
            }
            //*========控制台输出=========*//
            System.out.println("=====controller后置通知开始=====");
            System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()") + "." + operationType);
            System.out.println("方法描述:" + operationName);
            System.out.println("请求人:" + username);
            System.out.println("请求IP:" + ip);
            //*========数据库日志=========*//
//            LogTable logTable = new LogTable();
//            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//            String logtime = df.format(new Date());//获取当前时间
//
//            logTable.setOperateor(username);
//            logTable.setOperatetype(operationType);
//            logTable.setOperatedetail(operationName);
//            logTable.setOperatedate(logtime);
//            logTable.setOperateresult("正常");
//            logTable.setOperateip(ip);
//            List<LogTable> logTableList = new ArrayList<>();
//            logTableList.add(logTable);
//
//            //保存数据库
//            Boolean flag = userService.addSysLogInfo(logTableList);
//            if(flag){
//                System.out.println(logTable);
//                System.out.println("=====controller后置通知结束=====");
//            }
        } catch (Exception e) {
            //记录本地异常日志
            logger.error("==后置通知异常==");
            logger.error("异常信息:{}------" + e.getMessage());


            throw e;
        }
    }

    //配置后置返回通知,使用在方法aspect()上注册的切入点
//      @AfterReturning("controllerAspect()")
//      public void afterReturn(JoinPoint joinPoint){
//          System.out.println("=====执行controller后置返回通知=====----");
//              if(logger.isInfoEnabled()){
//                  logger.info("afterReturn " + joinPoint);
//              }
//      }

    /**
     * 异常通知 用于拦截记录异常日志
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) throws Throwable {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        //读取session中的用户
        String username = (String) session.getAttribute("username");
        //请求的IP
        String ip = request.getRemoteAddr();

        if(ip.equals("0:0:0:0:0:0:0:1")){
            ip = "127.0.0.1";
        }

        System.out.println("异常通知开始------------------------------------------");



        String params = "";
        if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
            for (int i = 0; i < joinPoint.getArgs().length; i++) {
//                params += JsonUtil.getJsonStr(joinPoint.getArgs()[i]) + ";";
                params += joinPoint.getArgs()[i] + ";";
            }
        }
        try {

            String targetName = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            Object[] arguments = joinPoint.getArgs();
            Class targetClass = Class.forName(targetName);
            Method[] methods = targetClass.getMethods();
            String operationType = "";
            String operationName = "";
            for (Method method : methods) {
                if (method.getName().equals(methodName)) {
                    Class[] clazzs = method.getParameterTypes();
                    if (clazzs.length == arguments.length) {
                        operationType = method.getAnnotation(ParentSystemLog.class).operationType();
                        operationName = method.getAnnotation(ParentSystemLog.class).operationName();
                        break;
                    }
                }
            }

            //*========控制台输出=========*//
            System.out.println("=====controller后置通知开始=====");
            System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()") + "." + operationType);
            System.out.println("方法描述:" + operationName);
            System.out.println("请求人:" + username);
            System.out.println("请求IP:" + ip);
            //*========数据库日志=========*//
//            LogTable logTable = new LogTable();
//            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//            String logtime = df.format(new Date());//获取当前时间
//
//            logTable.setOperateor(username);
//            logTable.setOperatetype(operationType);
//            logTable.setOperatedetail(operationName);
//            logTable.setOperatedate(logtime);
//            logTable.setOperateresult("异常");
//            logTable.setOperateip(ip);
//            List<LogTable> logTableList = new ArrayList<>();
//            logTableList.add(logTable);
//            //保存数据库
//            Boolean flag = userService.addSysLogInfo(logTableList);
//            if(flag){
//                System.out.println(logTable);
//                System.out.println("=====异常通知结束=====");
//            }
        } catch (Exception ex) {
            //记录本地异常日志
            logger.error("==异常通知异常==");
            logger.error("异常信息:{}------" + ex.getMessage());
        }
        /*==========记录本地异常日志==========*/
//        logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}-----"+joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params);

    }

}
