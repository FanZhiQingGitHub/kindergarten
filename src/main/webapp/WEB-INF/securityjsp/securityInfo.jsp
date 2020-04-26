<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-2
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-个人信息页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <link rel="stylesheet" type="text/css" href=<%=path+"/image/healtherimg/css/main.css"%>>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="header">
    <h1 class="logo">
        <a>
            <span>个人信息</span>
            <img src="${pageContext.request.contextPath}/image/healtherimg/img/logo.png">
        </a>
    </h1>
    <div class="nav">
        <a style="font-size: 18px">welcome to <span class="name"
                                                    style="color: darkorchid">&nbsp;${securityname}&nbsp;</span> home
            !!!</a>
    </div>
    <p class="welcome-text">
        <button class="layui-btn layui-btn-radius layui-btn-normal updateSecuritypwd" style="margin-top: 48%">
            修改密码
        </button>
    </p>
</div>

<div class="about-content">
    <div class="w1000">
        <div class="item info">
            <div class="title">
                <h3>我的介绍</h3>
            </div>
            <div class="cont">
                <img src="${pageContext.request.contextPath}/image/logo/head.jpg">
                <div class="per-info">
                    <ul style="font-size: 18px">
                        <c:if test="${not empty tblSecurityList}">
                            <c:forEach items="${tblSecurityList}" var="i" step="1">
                                <li>姓名：${i.securityname}</li>
                                <br/>
                                <li>性别：${i.securitysex}</li>
                                <br/>
                                <li>年龄：${i.securityage}</li>
                                <br/>
                                <li>地址：${i.securityadd}</li>
                                <br/>
                                <li>电话：${i.securityphone}</li>
                                <br/>
                            </c:forEach>
                        </c:if>
                    </ul>
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

<div id="type-content" style="display: none;">
    <div class="layui-form-item">
        <div class="layui-inline">
            <input type="password" id="oldSecuritypwd" placeholder="请输入6-12位旧密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <input type="password" id="securitypwd" placeholder="请输入6-12位密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <input type="password" id="confrimSecuritypwd" placeholder="请确认密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
</div>

<script>

    layui.use(['jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var path = $("#path").val();

        $("#oldSecuritypwd").blur(function () {
            var oldSecuritypwd = $("#oldSecuritypwd").val();
            if (oldSecuritypwd.length == 0) {
                layer.alert("请输入旧密码", {icon: 2});
            } else {
                $.ajax({
                    url: path + '/security/checkOldPwd',
                    async: true,
                    type: 'post',
                    data: {"oldSecuritypwd": oldSecuritypwd},
                    datatype: 'text',
                    success: function (data) {
                        if (data == "error") {
                            layer.msg("亲，密码与原密码不匹配", {icon: 2});
                        } else {
                            layer.msg("亲，密码与原密码匹配", {icon: 6});
                        }
                    }, error: function (data) {
                        layer.msg("网络繁忙！", {icon: 2});
                    }
                });
            }
        });


        $('body').on('click', '.updateSecuritypwd', function () {
            layer.open({
                type: 1,
                content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
                title: '个人密码修改',
                btn: ['确定', '取消'],
                offset: '130px',
                btnAlign: 'c',
                btn1: function (index) {
                    layer.confirm('您确定要修改吗?', {icon: 3, title:'提示'},function (index) {
                        var securitypwd = $("#securitypwd").val();
                        var confrimSecuritypwd = $("#confrimSecuritypwd").val();
                        var oldSecuritypwd = $("#oldSecuritypwd").val();
                        var pwd = /^[\S]{6,12}$/;
                        if (oldSecuritypwd.length == 0) {
                            layer.msg("请输入旧密码", {icon: 2});
                        } else if (!pwd.test(securitypwd)) {
                            layer.msg("您好，新密码必须6~12位，且不能出现空格！", {icon: 2});
                        } else if (!pwd.test(confrimSecuritypwd)) {
                            layer.msg("请确认密码，必须6~12位，且不能出现空格！", {icon: 2});
                        } else if (securitypwd != confrimSecuritypwd) {
                            layer.msg("密码输入不一致", {icon: 2});
                        } else {
                            $.ajax({
                                url: path + '/security/updateSecuritypwd',
                                async: true,
                                type: 'post',
                                data: {
                                    "securitypwd": securitypwd,
                                    "confrimSecuritypwd": confrimSecuritypwd
                                },
                                datatype: 'text',
                                success: function (data) {
                                    if (data == "error") {
                                        layer.msg("修改失败！", {icon: 2});
                                    } else {
                                        layer.alert("修改成功", {icon: 6},function (index) {
                                            window.location.reload();
                                        });
                                    }
                                }, error: function (data) {
                                    layer.msg("网络繁忙！", {icon: 2});
                                }
                            });
                        };
                    });
                },
            });
        });
    })
</script>
</body>
</html>
