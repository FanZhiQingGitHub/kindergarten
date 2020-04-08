<%--
  Created by IntelliJ IDEA.
  User: junlong
  Date: 2019-11-13
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>修改密码</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
	* {
		margin: 0 auto;
	}
	body {
		line-height: 50px;
	}
</style>
<body>
<%--<input type="hidden" name="rectorid" id="rectorid" value="${logintblRector.rectorid}">--%>
<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">旧密码</label>
		<div class="layui-input-inline">
			<input type="password" name="oldpwd" id="oldpwd" autocomplete="off" required lay-verify="required|phone|number"
			       placeholder="请输入旧密码" autocomplete="on" class="layui-input">
		</div>
		<div class="layui-form-mid layui-word-aux" id="divoldpassword"></div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">新密码</label>
		<div class="layui-input-inline">
			<input type="password" name="password" id="password" autocomplete="off" required lay-verify="required"
			       placeholder="请输入密码" class="layui-input"/>
		</div>
		<div class="layui-form-mid layui-word-aux" id="divcheckpassword"></div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">确认密码</label>
		<div class="layui-input-inline">
			<input type="password" name="repassword" id="repassword" autocomplete="off" required lay-verify="required"
			       placeholder="请再次输入内容" class="layui-input"/>
		</div>
		<div class="layui-form-mid layui-word-aux" id="divcheckrepassword"></div>
	</div>
</form>

<script>
	//Demo
	layui.use(['form', 'jquery', 'layer'], function () {
		var form = layui.form;
		$ = layui.$;
		var layer = layui.layer;
		var src = $("#path").val();
		$("#oldpwd").on('blur', function () {
			var oldpwd = $("#oldpwd").val();
			console.log("按钮点击");
			//1.获取密码的值
			var div = document.getElementById("divoldpassword");
			div.innerHTML = "";
			//2.定义正则表达式
			var regPwd = /^[a-zA-Z0-9]{6,12}$/;
			//3.判断值是否符合正则的规则
			if (!regPwd.test(oldpwd)) {
				div.innerHTML = "请输入密码长度6-12位";
				$("#oldpwd").select();
				return false;
			}
			$.ajax({
				url: src + "/director/oldpassword",
				async: true,
				type: "post",
				data: {"oldpwd": oldpwd},
				dataType: "text",
				success: function (msg) {
					if (msg === "success") {
						div.innerHTML = "旧密码正确！";
					} else {
						layer.msg("密码错误！");
						$("#oldpwd").focus();
					}
				},
				error: function () {
					layer.alert("网络繁忙");
				}
			});
		});
		//2、密码的正则表达式的判断
		$("#password").on('blur', function () {
			var div = document.getElementById("divcheckpassword");
			div.innerHTML = "";
			//1.获取密码的值
			var password = $("#password").val();
			//2.定义正则表达式
			var regPwd = /^[a-zA-Z0-9]{6,12}$/;
			//3.判断值是否符合正则的规则
			if (!regPwd.test(password)) {
				div.innerHTML = "请输入密码长度6-12位";
				$("#password").select();
				return false;
			}
			console.log("输出的值是:密码");
			return true;
		});
	});
</script>
</body>
</html>