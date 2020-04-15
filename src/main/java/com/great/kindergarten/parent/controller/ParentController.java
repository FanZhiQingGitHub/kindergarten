package com.great.kindergarten.parent.controller;

import com.great.kindergarten.commons.entity.*;
import com.great.kindergarten.parent.service.ParentService;
import com.great.kindergarten.util.FaceRecognitionUtils;
import com.great.kindergarten.util.MD5Utils;
import javafx.scene.Parent;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Administrator
 */
@Controller
@RequestMapping("/parent")
public class ParentController {

    @Resource
    private ParentService parentService;

    @RequestMapping("/toUrl/{url}")
    public String toUrl(@PathVariable  String url) {
        return "parentJsp/"+url;
    }



    @RequestMapping("/parentFaceRecognition")
    @ResponseBody
    public Result parentFaceRecognition(String face)
    {
        //人脸识别调用 (可根据id单张图片比较)
        Result result = new Result();

        FaceRecognitionUtils.identify(face,null);

        return result;
    }







    @RequestMapping("/kidHomeWorkList")
    @ResponseBody
    public TableDate kidHomeWorkList(HttpServletRequest request,SearchCondition searchCondition){
//    查询家长的孩子的作业列表方法
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

//        Integer cid = Integer.valueOf(request.getParameter("cid"));
        //设置查找人id
        searchCondition.setParentId(3);
        //返回查找的结果
        return parentService.kidHomeWorkList(searchCondition,1);
    }

    @RequestMapping("/getKids")
    @ResponseBody
    public Result getKids(HttpServletRequest request){
//    查询家长id 查询孩子列表
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");

        //返回查找的结果
        return parentService.getKids(3);
    }




    @RequestMapping("/recordScore")
    @ResponseBody
    public Result recordScore(HttpServletRequest request){



        Result result = new Result();
        //获取信息
       TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
       Integer videoId = Integer.valueOf(request.getParameter("videoId"));
        Integer score = Integer.valueOf(request.getParameter("score"));
//        调用插入数据信息
        if (parent!=null){
            if (parentService.recordScore(parent.getParentId(),videoId,score)){
                //成功返回状态
                result.setSuccess(true);
            }
        }
        return result;
    }


    @RequestMapping("/parentSafetyTestList")
    @ResponseBody
    public TableDate parentSafetyTestList(HttpServletRequest request,SearchCondition searchCondition){
//    查询家长安全视频列表方法
        //取得是谁要执行查询操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        //设置查找人id
        searchCondition.setParentId(parent.getParentId());
        //返回查找的结果
        return parentService.parentSafetyTestList(searchCondition);
    }

    @RequestMapping("/SafetyTestQuestion")
    public String playVideo(HttpServletRequest request){
//        获取要做哪套题
        Integer safetyVideoId =  Integer.valueOf(request.getParameter("safetyVideoId"));

        //查询出对应的题目列表
        List<TblSafetyvtq> subject= parentService.findSafetyTestQuestionList(safetyVideoId);
        //给请求加上题目
        request.setAttribute("subject",subject);
        //转发
	    return "parentJsp/SafetyTestQuestion";
    }


    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        //移除当前在线的家长
        request.getSession().removeAttribute("onlineParent");
        return "parentJsp/parentLogin";
    }

    @RequestMapping("/updateParentPwd")
    @ResponseBody
    public Result updateParentPwd(HttpServletRequest request) {
        //取得是谁要执行修改密码操作
        TblParent parent = (TblParent) request.getSession().getAttribute("onlineParent");
        //数据的获取与转化
        String md5oldPwd= MD5Utils.md5( request.getParameter("parentOldPwd"));
        String md5newPwd=  MD5Utils.md5( request.getParameter("parentNewPwd"));
        //调用service处理数据返回
        return parentService.updateParentPwd(parent.getParentId(),md5oldPwd, md5newPwd);
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
                TblParent loginParent = parentService.parentLogin(parentName, loginPwd);
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
