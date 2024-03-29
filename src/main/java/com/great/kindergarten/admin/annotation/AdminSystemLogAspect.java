package com.great.kindergarten.admin.annotation;

import com.great.kindergarten.admin.service.SystemLogService;
import com.great.kindergarten.commons.entity.TblAdmin;
import com.great.kindergarten.commons.entity.TblSyslog;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.util.Date;

/**
 * @author
 * @desc 切点类 
 */

@Aspect
@Component
public class AdminSystemLogAspect {

    //注入Service用于把日志保存数据库
    //这里我用resource注解

    @Resource
    private SystemLogService systemLogService;

  //这里的stdout要和log4j.properties里的配置一致，否则写不到文件中

	private static final Logger logger = Logger.getLogger("stdout");

    //Controller层切点

    @Pointcut("execution (* com.great.kindergarten.admin.controller..*.*(..)) && @annotation(com.great.kindergarten.admin.annotation.AdminSystemLog)")
    public  void controllerAspect() {
    }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) {
        if(logger.isInfoEnabled()){
            logger.info("before " + joinPoint);
        }
    }

    //配置controller环绕通知,使用在方法aspect()上注册的切入点
      @Around("controllerAspect()")
      public void around(JoinPoint joinPoint){
          long start = System.currentTimeMillis();
          String methodName = joinPoint.getSignature().getName();
          try {
              ((ProceedingJoinPoint) joinPoint).proceed();
              long end = System.currentTimeMillis();
              if(logger.isInfoEnabled()){
                  logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms!");
              }
          } catch (Throwable e) {
              long end = System.currentTimeMillis();
              if(logger.isInfoEnabled()){
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
    public  void after(JoinPoint joinPoint) throws Throwable{

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        //读取session中的用户
        TblAdmin tblAdmin = (TblAdmin) session.getAttribute("tblAdmin");
        //请求的IP
        InetAddress addr = InetAddress.getLocalHost();
        String ip = addr.getHostAddress();
	    try {
	    	    String methodName = joinPoint.getSignature().getName();
                String targetName = joinPoint.getTarget().getClass().getName();
                Object[] arguments = joinPoint.getArgs();
                Class targetClass = Class.forName(targetName);
                Method[] methods = targetClass.getMethods();
                String operationName = "";
                String operationType = "";
                for (Method method : methods)
                {
                    if (method.getName().equals(methodName))
                    {
                        Class[] clazzs = method.getParameterTypes();
                        if (clazzs.length == arguments.length)
                        {
                            operationType = method.getAnnotation(AdminSystemLog.class).operationType();
                            operationName = method.getAnnotation(AdminSystemLog.class).operationName();
                            break;
                        }
                    }
                }
            //*========数据库日志=========*//
            TblSyslog log = new TblSyslog();
            log.setOperatedetail(operationName);
            log.setOperatetype(operationType);
            log.setOperateip(ip);
            log.setOperateresult("正常");
            if(tblAdmin != null)
            {
                log.setOperateor(tblAdmin.getAdminname());
                log.setOperatetime(new Date());
                //保存数据库
                int num = systemLogService.addLog(log);
                if (num > 0) {
                    System.out.println(log);
                    System.out.println("=====controller后置通知结束=====");
                } else {
                    System.out.println(log);
                    System.out.println("=====controller后置通知异常=====");
                }

            }else{
                System.out.println("日志记录失败");
            }

        }  catch (Exception e) {
            //记录本地异常日志
            logger.error("==后置通知异常==");
            logger.error("异常信息:{}------"+ e.getMessage());
            throw e;
        }
    }

    /**
     * 异常通知 用于拦截记录异常日志
     *
     * @param joinPoint
     * @param e
     */

     @AfterThrowing(pointcut = "controllerAspect()", throwing="e")
     public  void doAfterThrowing(JoinPoint joinPoint, Throwable e) throws Exception {
         HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
         HttpSession session = request.getSession();
        //读取session中的用户
         TblAdmin tblAdmin = (TblAdmin) session.getAttribute("tblAdmin");
        //获取请求ip
         InetAddress addr = InetAddress.getLocalHost();
         String ip = addr.getHostAddress();

        //获取用户请求方法的参数并序列化为JSON格式字符串
         System.out.println("异常通知开始------------------------------------------");
         String params = "";
         if (joinPoint.getArgs() !=  null && joinPoint.getArgs().length > 0)
         {
             for ( int i = 0; i < joinPoint.getArgs().length; i++)
             {
            	 params += joinPoint.getArgs()[i] + ";";
             }
         }
         try {
                 String targetName = joinPoint.getTarget().getClass().getName();
                 String methodName = joinPoint.getSignature().getName();
                 Object[] arguments = joinPoint.getArgs();
                 Class targetClass = Class.forName(targetName);
                 String operationType = "";
                 Method[] methods = targetClass.getMethods();
                 String operationName = "";
                  for (Method method : methods)
                  {
                      if (method.getName().equals(methodName))
                      {
                         Class[] clazzs = method.getParameterTypes();
                          if (clazzs.length == arguments.length)
                          {
                              operationType = method.getAnnotation(AdminSystemLog.class).operationType();
                              operationName = method.getAnnotation(AdminSystemLog.class).operationName();
                              break;
                          }
                      }
                  }
            /*==========数据库日志=========*/
             TblSyslog log = new TblSyslog();
             log.setOperatedetail(operationName);
             log.setOperatetype(operationType);
             log.setOperateip(ip);
             log.setOperateresult("异常");
             if(tblAdmin != null)
             {
                 log.setOperateor(tblAdmin.getAdminname());
                 System.out.println("日志记录时间" + new Date());
                 log.setOperatetime(new Date());
                 //保存数据库
                 int num = systemLogService.addLog(log);
                 if (num > 0) {
                     System.out.println(log);
                     System.out.println("=====controller后置通知结束=====");
                 } else {
                     System.out.println(log);
                     System.out.println("=====controller后置通知异常=====");
                 }
             }else{
                 System.out.println("日志记录失败");
             }

        }  catch (Exception ex) {
            //记录本地异常日志
            logger.error("==异常通知异常==");
            logger.error("异常信息:{}------"+ ex.getMessage());
        }
         /*==========记录本地异常日志==========*/
//        logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}-----"+joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params);
    }

}