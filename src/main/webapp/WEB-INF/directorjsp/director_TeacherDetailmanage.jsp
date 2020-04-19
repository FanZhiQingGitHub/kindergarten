<%--
  Created by IntelliJ IDEA.
  User: junlong
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>教师信息修改</title>
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
					<option value="暂无" selected>暂无选择</option>
					<option value="班主任">班主任</option>
					<option value="保健员">保健员</option>
					<option value="安防员">安防员</option>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">性别：</label>
		<div class="layui-input-inline">
			<div class="layui-form">
				<select name="teachersex" id="teachersex" lay-filter="mySelect">
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
				<input type="text" class="layui-input" name="teacherage" placeholder="请输入20-60岁年龄" id="teacherage"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">地址：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="teacheradd" placeholder="请输入地址" id="teacheradd"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">联系方式：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="teacherphone" placeholder="请输入11位联系方式" id="teacherphone"
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
			$("#teachername").on('blur', function () {
				var teachername = $("#teachername").val();
				var path = $("#path").val();
				$.ajax({
					url: path + "/director/selectTeacherName",
					async: true,
					type: "post",
					data: {"teachername": teachername},
					dataType: "text",
					success: function (msg) {
						if (msg === "success") {
							layer.msg("教师名称已存在，请更改！");
							$("#teachername").focus();
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