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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>--%>
    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具"/>
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图"/>

    <!--引用百度地图API-->
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=bOF9gGWXz76q065otbYtWN4A"></script>


    <title>智慧幼儿园-首页</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

    <style type="text/css">
        html, body {
            margin: 0;
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
<input type="hidden" id="path" value="<%=path%>">
<!-- header -->
<div class="header_box">
    <div class="header" style="max-width: 80%">
        <ul class="app-header">
            <li class="app-header-menuicon">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </li>
        </ul>
        <h1 class="logo">
            <img style="width: 100%;height: 90px;" src="${pageContext.request.contextPath}/image/logo/logo.png">
        </h1>
        <div class="nav" style="visibility: visible">

            <a href="${pageContext.request.contextPath}/main/path/main" id="addStuTime" class="active" style="font-size: 18px">首页</a>
            <a href="${pageContext.request.contextPath}/main/parent" class="active" style="font-size: 18px">家长端</a>
            <a href="${pageContext.request.contextPath}/main/teacher" class="active" style="font-size: 18px">教师端</a>
            <a href="${pageContext.request.contextPath}/main/healther" class="active" style="font-size: 18px">保健员端</a>
            <a href="${pageContext.request.contextPath}/main/security" class="active" style="font-size: 18px">安防员端</a>
            <a href="${pageContext.request.contextPath}/main/director" class="active" style="font-size: 18px">园长端</a>
            <a href="${pageContext.request.contextPath}/main/admin" class="active" style="font-size: 18px">平台端</a>
            <a href="${pageContext.request.contextPath}/main/path/about" class="active" style="font-size: 18px">关于</a>
            <a href="javascript:void(0); " class="active" style="font-size: 18px" id="exit">注销</a>
        </div>
    </div>
</div>
<!-- end-header -->

<!-- content -->
<div class="content">
    <div class="title">
        <%--        <h5>欢迎您的到来</h5>--%>
        <h3>用心呵护孩子的点点滴滴</h3>
        <h4>Take care of your kids.</h4>
    </div>
    <div class="layui-carousel imgbox" id="test1">
        <div carousel-item class="imgH">
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-1.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-2.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-3.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-4.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-5.jpg"></div>
        </div>
    </div>

    <div class="prod-show">
        <div class="layui-fluid">
            <div class="row layui-col-space12 layui-clear">
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-1.jpg"
                             alt="">
                        <h3>温馨的学习空间</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
                             alt="">
                        <h3>培养动手能力</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-3.jpg"
                             alt="">
                        <h3>记录孩子成长</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-4.png"
                             alt="">
                        <h3>爱心呵护孩子</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="prod-descr">
        <div class="layui-fluid">
            <div class="layui-row">
                <div class="item layui-clear">
                    <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
                        <img src="${pageContext.request.contextPath}/image/advertising/ad-1.png" class="left-img">
                    </div>
                    <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
                        <div class="text">
                            <h3>专为幼儿园量身定做</h3>
                            <p>"智慧幼儿园"帮助园长更方便的管理园所日常工作，帮助老师更快捷的进行幼儿教学工作；同时方便家长及时查看孩子在校情况，操作方便，无需专业培训就可轻松使用。</p>
                            <a href="${pageContext.request.contextPath}/main/path/details">查看更多 ></a>
                        </div>
                    </div>
                    <div class="layui-col-xs12 layui-col-sm12 layui-col-md8 bot-img-box" style="width: 55%">
                        <div class="bot-img">
                            <img src="${pageContext.request.contextPath}/image/advertising/ad-2.png">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- end-content -->
<div class="service-contact">
    <div class="service-contact-box">
        <div class="layui-fluid">
            <div class="layui-row">
                <div class="layui-col-xs12 layui-col-sm6 layui-col-md7">
                    <div style="width:697px;height:400px;border:#ccc solid 1px;" id="dituContent"></div>
                </div>
                <div class="layui-col-xs12 layui-col-sm5  layui-col-md4 fr">
                    <div class="cantact-info">
                        <h3>联系我们</h3>
                        <div class="item">
                            <p><i class="layui-icon layui-icon-location"></i>地址:<span>福建省厦门市思明区软件园二期</span></p>
                            <p><i class="layui-icon layui-icon-dialogue"></i>电话:<span>400-000-888</span></p>
                            <p><i class="layui-icon layui-icon-layouts"></i>邮箱:<span>kindergarten@qq.com</span></p>
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
        var carousel = layui.carousel, $ = layui.jquery, layer = layui.layer;
        var path = $("#path").val();
        //建造实例
        carousel.render({
            elem: '#test1'
            , width: '100%' //设置容器宽度
            , arrow: 'always'
            , height: 'auto'
            //,anim: 'updown' //切换动画方式
        });
        $('.app-header-menuicon').on('click', function () {
            $('.header-down-nav').toggleClass('down-nav')
        })
        var imgH = $('.imgbox div.layui-this').outerHeight();
        $('.imgH').css('height', imgH + 'px')
        window.onresize = function () {
            var imgH = $('.imgbox div.layui-this').outerHeight();
            $('.imgH').css('height', imgH + 'px')
        };

        $(function () {
           $("#exit").click(function () {
               layer.confirm('您确定要退出到登录界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                   layer.close(index);
                   sessionStorage.clear();//清除session信息
                   location.href = path + "/main/path/Login";
               });
           });
        });
    });

    //创建和初始化地图函数：
    function initMap() {
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }

    //创建地图函数：
    function createMap() {
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(118.1930, 24.4885);//定义一个中心点坐标
        map.centerAndZoom(point, 11);//设定地图的中心点和坐标并将地图显示在地图容器中
        map.addControl(new BMap.MapTypeControl()); //添加地图类型控件
        map.addOverlay(new BMap.Marker(point))
        window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1});
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT});
        map.addControl(ctrl_sca);
    }

    initMap();//创建和初始化地图
</script>


</body>
</html>
