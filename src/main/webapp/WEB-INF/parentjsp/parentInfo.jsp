<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-2
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
    <title>智慧幼儿园-个人信息页面</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <link rel="stylesheet" type="text/css" href="${path}/image/healtherimg/css/main.css">

</head>
<body>
<div class="header">
    <h1 class="logo">
        <a>
            <span>个人信息</span>
            <img src="${pageContext.request.contextPath}/image/healtherimg/img/logo.png">
        </a>
    </h1>
    <div class="nav">
        <a style="font-size: 18px">welcome to <span class="name" style="color: darkorchid">&nbsp;${sessionScope.onlineParent.parentName}&nbsp;</span> home !!!</a>
    </div>
    <p class="welcome-text">
        <button class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal addUserScore" style="margin-top: 48%">
            修改密码
        </button>
    </p>
</div>

<div class="about-content">
    <div class="w1000">
        <div class="item info">
            <div class="title">
                <h3>个人资料</h3>
            </div>
            <div class="cont">
                <img src="${pageContext.request.contextPath}/image/logo/head.jpg">
                <div class="per-info">
                    <ul style="font-size: 18px">
                        <c:if test="${not empty sessionScope.onlineParent}">
                                <li >姓名：${sessionScope.onlineParent.parentName}</li><br/>
                                <li >性别：${sessionScope.onlineParent.parentSex}</li><br/>
                                <li >年龄：${sessionScope.onlineParent.parentAge}</li><br/>
                                <li >地址：${sessionScope.onlineParent.parentAdd}</li><br/>
                                <li >电话：${sessionScope.onlineParent.parentPhone}</li><br/>
                                <li >工作：${sessionScope.onlineParent.parentJob}</li><br/>
                                <li >注册时间：${sessionScope.onlineParent.parentRegTime}</li><br/>
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

<script>

    layui.use(['jquery','layer'], function () {
        var jquery = layui.jquery;
        var layer = layui.layer;

        $('body').on('click', '.addUserScore', function () {
            var userid = $("#userid").val();
            layer.open({
                type: 1,
                content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
                title: '请输入充值积分',
                btn: ['确定', '取消'],
                offset: '100px',
                btnAlign: 'c',
                btn1: function (index) {
                    var num = /^[0-9]+.?[0-9]*/;
                    var userscore = $("#userscore").val();
                    if(!num.test(userscore)){
                        layer.alert("请输入数字",{icon:2});
                    }else {
                        $.ajax({
                            url: path + '/user/addUserScore',
                            async: true,
                            type: 'post',
                            data: {"userid": userid,"userscore":userscore},
                            datatype: 'text',
                            success: function (data) {
                                if (data == "error") {
                                    layer.alert("充值失败！", {icon: 2});
                                } else {
                                    layer.close(index);
                                    layer.alert("充值成功", {icon: 6}, function (index) {
                                        $("#score").text("积分："+data);
                                        layer.close(index);
                                    });
                                }
                            }, error: function (data) {
                                layer.alert("网络繁忙！", {icon: 2});
                            }
                        });
                    }
                },
            });
        });
    })
</script>
</body>
</html>
