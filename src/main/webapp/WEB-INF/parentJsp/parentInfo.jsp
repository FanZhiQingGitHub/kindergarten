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
        <button class="layui-btn layui-btn-radius layui-btn-normal updateParentPwd" style="margin-top: 48%">
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
                                <li >注册时间： <fmt:formatDate  value="${sessionScope.onlineParent.parentRegTime}" type="both" pattern="yyyy-MM-dd "/></li><br/>
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
            旧密码：
            <input type="password" id="oldParentPwd" placeholder="请输入6-12位旧密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            新密码：
            <input type="password" id="NewParentPwd" placeholder="请输入6-12位密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            二次输入新密码：
            <input type="password" id="confirmParentPwd" placeholder="请确认密码" value=""
                   autocomplete="off" class="layui-input" style="width: 300px">
        </div>
    </div>
</div>



<script>

    layui.use(['jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;

        $('body').on('click', '.updateParentPwd', function () {
            layer.open({
                type: 1,
                content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
                title: '个人密码修改',
                btn: ['确定', '取消'],
                offset: '130px',
                btnAlign: 'c',
                btn1: function (index) {
                    var oldParentPwd = $("#oldParentPwd").val();
                    var NewParentPwd = $("#NewParentPwd").val();
                    var confirmParentPwd = $("#confirmParentPwd").val();

                    if (oldParentPwd.length == 0 ) {
                        layer.alert("请输入旧密码", {icon: 2});
                    }else if (NewParentPwd.length < 6) {
                        layer.alert("新密码长度低于6位", {icon: 2});
                    } else if (NewParentPwd.length > 12) {
                        layer.alert("新密码长度大于12位", {icon: 2});
                    } else if (NewParentPwd.length == 0) {
                        layer.alert("新密码不能为空", {icon: 2});
                    } else if (confirmParentPwd.length == 0) {
                        layer.alert("请确认密码", {icon: 2});
                    } else if (NewParentPwd != confirmParentPwd) {
                        layer.alert("密码输入不一致", {icon: 2});
                    } else {
                        $.ajax({
                            url: path + '/parent/updateParentPwd',
                            async: true,
                            type: 'post',
                            data: {"parentOldPwd": oldParentPwd, "parentNewPwd": NewParentPwd},
                            datatype: 'json',
                            success: function (result) {

                                if (result.msg == "error") {
                                    layer.alert("修改失败！", {icon: 2});
                                } else if(result.msg == "oldPwdError") {
                                    layer.alert("旧密码输入错误", {icon: 2});
                                } else if (result.success) {
                                    layer.alert("修改成功，下次登陆将使用刚刚更改的密码", {icon: 6});

                                }else {
                                    layer.alert("遇到外星人攻击", {icon: 2});
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
