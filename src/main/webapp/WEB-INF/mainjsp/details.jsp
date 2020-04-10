<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>智慧幼儿园-查看更多</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
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
            <img style="width: 100%;" src="${pageContext.request.contextPath}/image/logo/logo.png">
        </h1>
        <div class="nav" style="visibility: visible">
            <a href="${pageContext.request.contextPath}/main/path/main" class="active" style="font-size: 18px">首页</a>
        </div>
    </div>
</div>
<!-- end-header -->


<!-- details-content -->
<div class="details-content">
    <div class="title">
        <h3>智慧幼儿园</h3>
        <h4><span class="child-title">数字化幼儿园一站式解决方案</span> / <span class="time">2020</span></h4>
    </div>
    <div class="img-box">
        <img src="${pageContext.request.contextPath}/image/advertising/ad-3.png">
    </div>
</div>
<!-- details-content -->


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
    layui.use('jquery',function(){
        var $ = layui.$;
        //建造实例
        $('.app-header-menuicon').on('click',function(){
            $('.header-down-nav').toggleClass('down-nav')
        })
    });
</script>
</body>
</html>
