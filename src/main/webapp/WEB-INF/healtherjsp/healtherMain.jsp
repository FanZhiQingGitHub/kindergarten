<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Stict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>

    <title>智慧幼儿园-保健员首页</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
        }
        .a1:hover{
            color: #f37d25;
        }
    </style>
    <!--加载meta IE兼容文件-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="kindername" value="${kindername}">
<!-- header -->
<div class="header_box">

    <ul class="layui-nav layui-layout-right" style="background-color: white;">
        <li class="layui-nav-item">
            <a href="javascript:;" style="color: black;font-size: 18px">
                <img src="${pageContext.request.contextPath}/image/logo/head.jpg" class="layui-nav-img">
                欢迎&nbsp;,${healthername}&nbsp;保健员
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:void(0);" id="a1">个人信息</a></dd>
                <dd><a href="javascript:void(0);"  class="schoolMessage">校园消息通知</a></dd>

            </dl>
        </li>
        <li class="layui-nav-item"><a href="javascript:void(0);" id="exit" style="color: black;font-size: 18px">注销</a>
        </li>
    </ul>


    <div class="header" style="max-width: 80%">
        <ul class="app-header">
            <li class="app-header-menuicon">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </li>
        </ul>
        <h1 class="logo">
            <img style="width: 100%;height: 90px" src="${pageContext.request.contextPath}/image/logo/logo.png">
        </h1>
        <h1 style="margin-left: 21%;font-size: 40px;color: coral">保健员首页</h1>

    </div>
</div>
<!-- end-header -->


<!-- content -->
<div class="content">
    <div class="title">
        <h3>好营养我们造,为孩子健康护航</h3>
        <h4>We make good nutrition, escort the health of children.</h4>
    </div>

    <div class="layui-carousel imgbox" id="test1">
        <div carousel-item class="imgH">
            <div><img style="width: 100%;" src="${pageContext.request.contextPath}/image/healtherimg/img/heather-1.jpeg">
            </div>
            <div><img style="width: 100%;" src="${pageContext.request.contextPath}/image/healtherimg/img/heather-2.jpeg">
            </div>
            <div><img style="width: 100%;" src="${pageContext.request.contextPath}/image/healtherimg/img/heather-3.jpg">
            </div>
            <div><img style="width: 100%;" src="${pageContext.request.contextPath}/image/healtherimg/img/heather-4.jpg">
            </div>
            <div><img style="width: 100%;" src="${pageContext.request.contextPath}/image/healtherimg/img/heather-5.jpg">
            </div>
        </div>
    </div>

    <div class="prod-show">
        <div class="img-txt" style="float: left">
            <h3>
                <button type="button" id="bu1" class="layui-btn layui-btn-lg"
                        style="width: 450px;height: 100%;font-size: 20px">体检管理
                </button>
            </h3>
        </div>

        <div class="img-txt" style="float: right">
            <h3>
                <button type="button" id="bu2" class="layui-btn layui-btn-lg layui-btn-normal"
                        style="width: 450px;height: 100%;font-size: 20px">膳食管理
                </button>
            </h3>
        </div>
    </div>


    <div class="prod-show">
        <div class="layui-fluid">
            <div class="row layui-col-space12 layui-clear">
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
                    <div class="img-txt">
                        <h3 style="text-align: left">园所动态News</h3>
                        <div style=" overflow:auto;">
                            <a><img style="width: 100%" src="${pageContext.request.contextPath}/image/healtherimg/img/news.jpg"></a>
                        </div>
                        <div style=" overflow:auto;" id="newsInfo">
                            <c:if test="${not empty tblCampuses}">
                                <c:forEach items="${tblCampuses}" var="i" step="1">
                                <p><a class="a1" href="javascript:void(0);" style="font-size: 15px;width: 200px">${i.campusinfoname}:${i.campusinfodetail}</a><span style="font-size: 15px;margin-left: 10%">发布时间：<fmt:formatDate value='${i.campustime}' pattern='yyyy-MM-dd hh:mm:ss' /></span><span></span></p>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
                    <div class="img-txt">
                        <h3 style="text-align: left">园所视频Videos</h3>
                        <div class="layui-carousel videobox" id="test2">
                            <div carousel-item class="videroH">
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/2019-nCoV.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/2019-nCoV.jpg"></a></div>
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/CrossTheRoadSafely.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/CrossTheRoadSafely.jpg"></a></div>
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/farmPropaganda.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/farmPropaganda.jpg"></a></div>
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/SafetyRollerSkate.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/SafetyRollerSkate.jpg"></a></div>
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/TakeTheElevatorSafely.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/TakeTheElevatorSafely.jpg"></a></div>
                                <div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/Traffic_safety.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/Traffic_safety.jpg"></a></div>
                            </div>
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

    layui.use(['carousel', 'jquery', 'element', 'layer'], function () {
        var carousel = layui.carousel, $ = layui.$;
        var element = layui.element;
        var layer = layui.layer;
        var path = $("#path").val();


        //首页轮播图
        carousel.render({
            elem: '#test1'
            , width: '100%' //设置容器宽度
            , arrow: 'always'
            , height: 'auto'
            //,anim: 'updown' //切换动画方式
        });
        //首页轮播视频
        carousel.render({
            elem: '#test2'
            , width: '100%' //设置容器宽度
            , arrow: 'always'
            , height: 'auto'
            //,anim: 'updown' //切换动画方式
        });

        $('.app-header-menuicon').on('click', function () {
            $('.header-down-nav').toggleClass('down-nav')
        })
        var imgH = $('.imgbox div.layui-this').outerHeight();
        $('.imgH').css('height', imgH + 'px');

        var videroH = $('.videobox div.layui-this').outerHeight();
        $('.videroH').css('height', videroH + 'px');

        window.onresize = function () {
            var imgH = $('.imgbox div.layui-this').outerHeight();
            $('.imgH').css('height', imgH + 'px');

            var videroH = $('.videobox div.layui-this').outerHeight();
            $('.videroH').css('height', videroH + 'px');
        };


        $(function () {
            $("#a1").click(function () { //修改密码
                layer.open({
                    type: 2,
                    area: ['95%', '80%'],
                    offset: ['10%', '3%'],
                    title: '智慧幼儿园-保健员个人信息页',
                    btn1: function (index, layero) {
                        //layer.getChildFrame("form", index)获取iframe的表单
                        //serializeArray jquery方法，将表单对象序列化为数组
                        layer.close(index);
                    },
                    content: path + '/healther/path/healtherInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                    }
                });
            }), $("#exit").click(function () {
                layer.confirm('您确定要退出到登录界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                    layer.close(index);
                    sessionStorage.clear();//清除session信息
                    location.href = path + "/healther/path/healtherLogin";
                });
            }), $("#bu1").click(function () { //体检管理
                layer.open({
                    type: 2,
                    area: ['95%', '80%'],
                    offset: ['10%', '3%'],
                    title: '智慧幼儿园-宝宝体检信息页',
                    btn1: function (index, layero) {
                        //layer.getChildFrame("form", index)获取iframe的表单
                        //serializeArray jquery方法，将表单对象序列化为数组
                        layer.close(index);
                    },
                    content: path + '/healther/path/examinationInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                    }
                });
            }), $("#bu2").click(function () { //膳食管理
                layer.open({
                    type: 2,
                    area: ['95%', '80%'],
                    offset: ['10%', '3%'],
                    title: '智慧幼儿园-宝宝膳食信息页',
                    btn1: function (index, layero) {
                        //layer.getChildFrame("form", index)获取iframe的表单
                        //serializeArray jquery方法，将表单对象序列化为数组
                        layer.close(index);
                    },
                    content: path + '/healther/path/mealInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                    }
                });
            }),$(".a1").click(function () { //点击查看园所新闻
                var name = $(this).text();
                var titleInfo = name.split(":")[0];
                var detailInfo = name.split(":")[1];
                var kindername = $("#kindername").val();
                //打开一个窗口播放视频
                layer.open({
                    //打开一个窗口播放视频
                    // area: ['40%', '50%'],
                    area: 'auto',
                    // offset:['26%','31%'],
                    offset:'auto',
                    title:titleInfo,
                    content: detailInfo+'------'+kindername,
                });
            });
        })
        //对应显示消息通知的内容
        $('.schoolMessage').on('click',function () {
            layer.open({
                type: 2,
                title: '校园消息通知',
                shade: 0.8//表示的是阴影的大小
                , area: ['55%', '65%'],
                moveType: 1,//拖拽模式，0或者1
                content: path + '/director/toUrl/director_SchoolMessage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    console.log(layero, index);
                }
            });
        });
        //点击查看园所视频
        $(".playVideos").click(function () {
            var videoUrl = $(this).attr('title');
            //打开一个窗口播放视频
            layer.open({
                //打开一个窗口播放视频
                type: 1,
                area: ['95%', '80%'],
                offset:['10%','3%'],
                title:'园所视频播放',
                content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
                    '<source src="'+videoUrl+'" type="video/mp4"></source></video>'
                //直接跳出一个标签播放视频
            });
        });
    });

</script>


</body>
</html>
