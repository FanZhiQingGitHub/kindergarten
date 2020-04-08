<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Stict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <title>智慧幼儿园-园长端主界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            margin: 0 auto;
        }
        .contentimg{
            width: 33%;
            padding: 0 50px;
        }
        .nav_btn{
            padding: 30px 0;
            max-width: 80%;
            margin: 0 auto;
        }
        .getbtn{
            height: 240px;
            /*width: 75px;*/
            width: 8%;
            font-weight: bold;
            font-size: 18px;
            background: #FF5722;
        }
        .footer{
            margin: 0 auto;
            width: 80%;
            padding: 0;
        }

    </style>
    <!--加载meta IE兼容文件-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>

<!-- header -->
<div class="header_box">
    <ul class="layui-nav layui-layout-right" style="background-color: white;">
        <li class="layui-nav-item" >
            <a href="javascript:;" style="color: black;font-size: 18px">
                <img src="${pageContext.request.contextPath}/image/logo/headDirector.jpg" class="layui-nav-img">
                欢迎&nbsp;&nbsp;&nbsp;${logintblRector.rectorname}&nbsp;,&nbsp;园长
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:void(0);"  class="personMsg">个人信息</a></dd>
                <dd><a href="javascript:void(0);"  class="updatePwd">修改密码</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a  href="javascript:void(0); "  id="exit" style="color: black;font-size: 18px">注销</a></li>
    </ul>

    <div class="header" style="max-width: 80%">
        <ul class="app-header">
            <li class="app-header-menuicon">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </li>
        </ul>
        <h1 style="margin-left: 38%;font-size: 40px;color: coral">园长首页</h1>
    </div>
</div>
<!-- end-header -->

<!-- content -->
<div class="content">
    <div class="layui-carousel imgbox" id="test1" style="margin: 0 auto">
        <div carousel-item class="imgH">
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-1.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-2.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-3.jpeg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-4.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-5.jpg"></div>
        </div>
    </div>

    <div class="prod-show" style="padding: 50px 0;">
        <div class="layui-fluid">
            <div class="row layui-col-space12 layui-clear">
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-1.jpg"
                             alt="">
                        <h3>资格审批</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
                             alt="">
                        <h3>班级中心</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-3.jpg"
                             alt="">
                        <h3>消息中心</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="nav_btn">
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="approvalGarden">园<br/>所<br/>审<br/>批</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="teachersManagement">教<br/>师<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="teachersExamAffection">教<br/>师<br/>考<br/>勤</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">幼<br/>儿<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">家<br/>长<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">班<br/>级<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">班<br/>级<br/>成<br/>员<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">课<br/>程<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">消<br/>息<br/>通<br/>知</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">校<br/>园<br/>公<br/>告</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn">联<br/>系<br/>老<br/>师</button>
    </div>
    <div class="prod-show" style="max-width: 80%;">
        <div class="layui-fluid">
            <div class="row layui-col-space12 layui-clear">
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
                    <div class="img-txt">
                        <h3 style="text-align: left">园所动态News</h3>
                        <div  style=" overflow:auto;" >
                            <a href="javascript:;">新闻一</a><br>
                            <a href="javascript:;">新闻二</a><br>
                            <a href="javascript:;">新闻三</a><br>
                            <a href="javascript:;">新闻四</a><br>
                            <a href="javascript:;">新闻五</a>
                        </div>

                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
                    <div class="img-txt">
                        <h3 style="text-align: left">园所视频Videos</h3>
                        <div style=" overflow:auto;">
                            <a href="javascript:;">视频一</a><br>
                            <a href="javascript:;">视频二</a><br>
                            <a href="javascript:;">视频三</a><br>
                            <a href="javascript:;">视频四</a><br>
                            <a href="javascript:;">视频五</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- footer -->
<div class="footer">
    <div class="line"></div>
    <p class="copyright">
        @2020 最后#的小组 版权所有©<br/>
        E-MAIL:kindergarten@outlook.com<br/>
        TEL:400-888-888
    </p>
    <div class="icon_box">
        <a href="#"><i class="layui-icon layui-icon-login-wechat weixin-icon"></i></a>
        <a href="#"><i class="layui-icon layui-icon-login-weibo weibo-icon"></i></a>
    </div>
</div>
<!-- end-footer -->
<script>
    layui.use(['carousel', 'jquery' ,'layer', 'element'], function () {
        var carousel = layui.carousel, $ = layui.$;
        var layer = layui.layer;
	    var src = $("#path").val();
        //建造实例
        carousel.render({
            elem: '#test1'
            , width: '80%' //设置容器宽度
            , arrow: 'always'
            , height: 'auto'

            //,anim: 'updown' //切换动画方式
        });
        $('.app-header-menuicon').on('click', function () {
            $('.header-down-nav').toggleClass('down-nav')
        });
        var imgH = $('.imgbox div.layui-this').outerHeight();
        $('.imgH').css('height', imgH + 'px')
        window.onresize = function () {
            var imgH = $('.imgbox div.layui-this').outerHeight();
            $('.imgH').css('height', imgH + 'px')
        };

        //个人信息的显示
        $('.personMsg').on('click',function () {
            layer.open({
                type: 2,
                title: '园长个人信息',
                area: ['500px', '400px'],
                moveType: 1,//拖拽模式，0或者1
                content: src + '/director/toUrl/personMsg' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
		            console.log(layero, index);
	            }
            });
        });
        //修改密码
        $('.updatePwd').on('click',function () {
            layer.open({
                type: 2,
                // offset: '100px',
                title: '修改密码',
                moveType: 1,//拖拽模式，0或者1
                area: ['500px', '400px'],
                btn: ['确认', '取消'],
                btn1: function (index, layero) {
                    // var src = $("#srcAddress").val();
                    //layer.getChildFrame("form", index)获取iframe的表单
                    //serializeArray jquery方法，将表单对象序列化为数组
                    var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

                    console.log("修改密码："+formData.password);
                    if (formData.oldpwd.length == 0 ) {
                        layer.alert("请输入旧密码", {icon: 2});
                    }else if (formData.password.length == 0) {
                        layer.alert("新密码不能为空", {icon: 2});
                    } else if (formData.repassword.length == 0) {
                        layer.alert("请确认密码", {icon: 2});
                    } else if (formData.password != formData.repassword) {
                        layer.alert("确认密码输入不一致", {icon: 2});
                    }else{
                        $.ajax({
                            url: src + '/director/updatePwd',
                            type: 'post',
                            data: formData,
                            success: function (data) {
                                layer.alert(data);
                                layer.close(index);
                                // window.location.href = src + "/servlet/pback/userManage";
                            }, error: function (err) {
                                console.log(err);
                            }
                        });
                    }
                },
                content: src + '/director/toUrl/updatePwd' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    console.log(layero, index);
                }
            });
        });

        //退出到首页
	    $("#exit").on('click',function () {
		    layer.confirm('您确定退出到园长端登录界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
			    layer.close(index);
			    window.location.href = src+"/director/exit";
                return true;
		    });
		    return false;
	    });

        //将表单转为js对象数据
        function serializeObject($, array) {
            var obj = new Object();
            $.each(array, function (index, param) {
                if (!(param.name in obj)) {
                    obj[param.name] = param.value;
                }
            });
            return obj;
        }

        //园所界面的跳转
        $("#approvalGarden").on('click',function () {
            layer.confirm('您确定要进入到园长审批界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/directorReg";
                return true;
            });
            return false;
        });
    });
</script>


</body>
</html>
