<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>校园公告信息管理</title>
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
	<input type="text" name="campusinfoid" id="campusinfoid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">标题：</label>
		<div class="layui-input-inline">
			<input type="text" name="campusinfoname" id="campusinfoname" autocomplete="off" required lay-verify="required"
			       placeholder="请输入标题" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">内容：</label>
		<div class="layui-input-inline">
			<textarea name="campusinfodetail" id="campusinfodetail" placeholder="请输入内容" class="layui-textarea"></textarea>
		</div>
	</div>
</form>

<script>
	//Demo
	layui.use(['form', 'jquery', 'layer'], function () {
		var form = layui.form;
		$ = layui.$;
		var layer = layui.layer;
	});
</script>
</body>
</html>