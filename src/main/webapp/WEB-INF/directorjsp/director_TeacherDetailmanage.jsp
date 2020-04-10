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
	<title>信息修改</title>
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
	<input type="hidden" name="teacherid" id="teacherid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">教师名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="teachername" id="teachername" autocomplete="off" required lay-verify="required"
			       placeholder="请输入教师名称" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">角色：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<select name="teacherjob" id="teacherjob" lay-filter="mySelect">
					<option value="暂无">暂无选择</option>
					<option value="班主任" selected>班主任</option>
					<option value="保健员">保健员</option>
					<option value="安防员">安防员</option>
				</select>
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
	});
</script>
</body>
</html>