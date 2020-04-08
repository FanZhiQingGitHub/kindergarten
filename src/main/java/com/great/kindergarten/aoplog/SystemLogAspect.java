package com.great.kindergarten.aoplog;

import com.great.kindergarten.admin.javabean.TblAdmin;
import com.great.kindergarten.admin.javabean.TblSysLog;
import com.great.kindergarten.admin.service.SystemLogService;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.UUID;

/**
 * @author
 * @desc 切点类 
 */

@Aspect
@Component
public class SystemLogAspect {

    //注入Service用于把日志保存数据库
    //这里我用resource注解

    @Resource
    private SystemLogService systemLogService;

  //这里的stdout要和log4j.properties里的配置一致，否则写不到文件中

	private static final Logger logger = Logger.getLogger("stdout");

    //Controller层切点

    @Pointcut("execution (* com.great.kindergarten.admin.controller..*.*(..))&&@annotation(com.great.kindergarten.aoplog.Log)")
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
        String ip = request.getRemoteAddr();
	    if("0:0:0:0:0:0:0:1".equals(ip)&&!ip.equals(null))
	    {
		    ip = "127.0.0.1";
	    }
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
                            operationType = method.getAnnotation(Log.class).operationType();
                            operationName = method.getAnnotation(Log.class).operationName();
                            break;
                        }
                    }
                }
            //*========数据库日志=========*//
            TblSysLog log = new TblSysLog();
            log.setUuid(UUID.randomUUID().toString());
            log.setOperatedetail(operationName);
            log.setOperatetype(operationType);
            log.setOperateip(ip);
            log.setOperateresult( null);
            if(tblAdmin != null)
            {
                log.setOperateor(tblAdmin.getAdminname());
            }else{
                log.setOperateor("无");
            }
            log.setOperatetime(new Date());
            //保存数据库
            systemLogService.addLog(log);
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
     public  void doAfterThrowing(JoinPoint joinPoint, Throwable e)
     {
         HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
         HttpSession session = request.getSession();
        //读取session中的用户
         TblAdmin tblAdmin = (TblAdmin) session.getAttribute("tblAdmin");
        //获取请求ip
         String ip = request.getRemoteAddr();
         if("0:0:0:0:0:0:0:1".equals(ip)&&!ip.equals(null))
         {
         	ip = "127.0.0.1";
         }
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
                              operationType = method.getAnnotation(Log.class).operationType();
                              operationName = method.getAnnotation(Log.class).operationName();
                              break;
                          }
                      }
                  }
            /*==========数据库日志=========*/
             TblSysLog log = new TblSysLog();
             log.setUuid(UUID.randomUUID().toString());
             log.setOperatedetail(operationName);
             log.setOperatetype(operationType);
             log.setOperateip(ip);
             log.setOperateresult( null);
             if(tblAdmin != null)
             {
                 log.setOperateor(tblAdmin.getAdminname());
             }else{
                 log.setOperateor("无");
             }
             log.setOperatetime(new Date());
            //保存数据库
            systemLogService.addLog(log);
            System.out.println("=====异常通知结束=====");
        }  catch (Exception ex) {
            //记录本地异常日志
            logger.error("==异常通知异常==");
            logger.error("异常信息:{}------"+ ex.getMessage());
        }
         /*==========记录本地异常日志==========*/
//        logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}-----"+joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params);
    }

}