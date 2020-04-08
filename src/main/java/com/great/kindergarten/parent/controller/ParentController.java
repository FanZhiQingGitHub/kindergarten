package com.great.kindergarten.parent.controller;

import com.great.kindergarten.commons.entity.Parent;
import com.great.kindergarten.commons.entity.Result;
import com.great.kindergarten.parent.service.ParentService;
import com.great.kindergarten.util.MD5Utils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/parent")
public class ParentController {

    @Resource
    private ParentService parentService;

    @RequestMapping("/main")
    public String showMainView() {
        return "mainjsp/main";
    }

    @RequestMapping("/toUrl/{url}")
    public String toUrl(@PathVariable  String url) {
        return "parentjsp/"+url;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        //移除当前在线的家长
        request.getSession().removeAttribute("onlineParent");
        return "parentjsp/parentLogin";
    }

    @RequestMapping("/Login")
    @ResponseBody
    public Result parentLogin(HttpServletRequest request, String parentName , String parentPwd,String code) {

        Result loginResult = new Result();

        //判断验证码是否正确
        if (code.equalsIgnoreCase((String) request.getSession().getAttribute("vcode"))){
            //判断是否登陆成功

            if (parentName!=null&&parentPwd!=null){
                String loginPwd = MD5Utils.md5(parentPwd);
                Parent loginParent = parentService.parentLogin(parentName, loginPwd);
                if (loginParent!=null){
                    //返回ajax数据跳转到家长端首页
                    loginResult.setData("/parent/toUrl/parentMain");
                    //设置结果为成功 前台用来判断
                    loginResult.setSuccess(true);
                    //session中存储家长信息
                    request.getSession().setAttribute("onlineParent",loginParent);
                    //返回信息给ajax
                    return loginResult;
                }else {
                    //返回告知账号或者密码错误
                    loginResult.setMsg("loginFailed");
                }
            }else {
                //返回告知账号或者密码错误
                loginResult.setMsg("loginFailed");
            }

        }else {
            //返回告知验证码错误
            loginResult.setMsg("codeError");
        }
        return loginResult;
    }


}
