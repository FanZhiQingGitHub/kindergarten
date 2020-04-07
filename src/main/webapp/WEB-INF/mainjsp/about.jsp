<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>智慧幼儿园-关于</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <script src=<%=path + "/layui/layui.js"%>></script>

    <!--加载meta IE兼容文件-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<!-- header -->
<div class="header_box">
    <div class="header" style="max-width: 80%">
        <ul class="app-header">
            <li class="app-header-menuicon">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </li>
        </ul>
        <h1 class="logo">
            <p style="font-size: 28px">关于我们</p>
        </h1>
        <div class="nav" style="visibility: visible">
            <a href="${pageContext.request.contextPath}/main/main" class="active" style="font-size: 18px">首页</a>
        </div>
    </div>
</div>
<!-- end-header -->


<!-- about-content -->
<div class="about-content">
    <div class="about-big-img">
        <div class="text_box">
            <div class="text">
                <h3>我们的信念</h3>
                <p>最后#的小组，创建于公元2020-4-3，我们始终秉承以用户体验为主的理念，用户大于一切，一切为用户服务！</p>
                <p>希望我们的产品能让你满意！</p>
            </div>
        </div>
    </div>
    <div class="about-info">
        <div class="img-texts">
            <div class="item">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-col-xs12 layui-col-sm12 layui-col-md6 img-center">
                            <img src="${pageContext.request.contextPath}/image/photos/gy_img1.jpg">
                        </div>
                        <div class="layui-col-xs12 layui-col-sm12 layui-col-md6">
                            <div class="text">
                                <h5>About us</h5>
                                <h4>关于我们</h4>
                                <p>如果眼下还是一团零星之火，那运筹帷幄之后，迎面东风，就是一场烈焰燎原吧，那必定会是一番尽情的燃烧。待，秋风萧瑟时，散作满天星辰，你看那四季轮回，正是 我们
                                    不灭的执念。如果眼下还是一团零星之火，那运筹帷幄之后，迎面东风，就是一场烈焰燎原吧，那必定会是一番尽情的燃烧。待，秋风萧瑟时，散作满天星辰，你看那四季轮回，正是 我们
                                    不灭的执念。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="coreTeam_box">
            <div class="writebg"></div>
            <div class="coreTeam">
                <div class="layui-fluid">
                    <h3>核心团队</h3>
                    <h4>有了向心力，才有可能凝聚</h4>
                    <div class="layui-row layui-col-space15">
                        <div class="layui-col-xs12 layui-col-sm4 layui-col-md4">
                            <div class="imgTxt">
                                <img src="${pageContext.request.contextPath}/image/photos/gy_img2.jpg" alt="">
                                <h6>开发大咖</h6>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-sm4 layui-col-md4">
                            <div class="imgTxt">
                                <img src="${pageContext.request.contextPath}/image/photos/gy_img3.jpg" alt="">
                                <h6>设计大咖</h6>
                            </div>
                        </div>
                        <div class="layui-col-xs12 layui-col-sm4 layui-col-md4">
                            <div class="imgTxt">
                                <img src="${pageContext.request.contextPath}/image/photos/gy_img4.jpg" alt="">
                                <h6>制作大咖</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
<!-- about-content -->


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

<script type="text/javascript">
    layui.use('jquery', function () {
        var $ = layui.$;
        //建造实例
        $('.app-header-menuicon').on('click', function () {
            $('.header-down-nav').toggleClass('down-nav')
        })
    });
</script>
</body>
</html>
