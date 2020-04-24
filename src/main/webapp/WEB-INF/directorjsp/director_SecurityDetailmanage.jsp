<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>安防员信息修改</title>
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

<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" name="securityid" id="securityid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">安防员名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="securityname" id="securityname" autocomplete="off" required lay-verify="required"
			       placeholder="请输入安防员名称" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">性别：</label>
		<div class="layui-input-inline">
			<div class="layui-form">
				<select name="securitysex" id="securitysex" lay-filter="mySelect">
					<option value="暂无" selected>暂无选择</option>
					<option value="男">男</option>
					<option value="女">女</option>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">年龄：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="securityage" placeholder="请输入20-60岁年龄" id="securityage"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">地址：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="securityadd" placeholder="请输入地址" id="securityadd"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">联系方式：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="securityphone" placeholder="请输入11位联系方式" id="securityphone"
				       autocomplete="off">
			</div>
		</div>
	</div>
</form>

<script>
	//Demo
	layui.use(['form', 'jquery', 'layer'], function () {
		var form = layui.form;
		$ = layui.$;
		var layer = layui.layer;
		$(function () {
			//教师名字判断是不是重复
			$("#securityname").on('blur', function () {
				var securityname = $("#securityname").val();
				var path = $("#path").val();
				$.ajax({
					url: path + "/director/selectSecurityName",
					async: true,
					type: "post",
					data: {"securityname": securityname},
					dataType: "text",
					success: function (msg) {
						if (msg === "success") {
							layer.msg("安防员名称已存在，请更改！");
							$("#securityname").focus();
						}
					},
					error: function () {
						layer.alert("网络繁忙");
					}
				});
			});
		})
	});
</script>
</body>
</html>