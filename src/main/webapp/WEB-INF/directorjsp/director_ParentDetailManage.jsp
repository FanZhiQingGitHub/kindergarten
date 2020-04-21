<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>家长信息管理</title>
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
<input type="hidden" id="kindername" value="${kindername}">
<form class="layui-form" action="#" lay-filter="test1">
	<input type="text" name="parentId" id="parentId">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">家长名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="parentName" id="parentName" autocomplete="off" required lay-verify="required"
			       placeholder="请输入家长名称" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">宝宝名称：</label>
		<div class="layui-input-inline">
			<select name="studentname" id="studentname" lay-filter="mySelect">
				<option value="暂无" selected>暂无选择</option>
				<c:if test="${not empty tblStudentList}">
					<c:forEach items="${tblStudentList}" var="i" step="1">
						<option value="${i.studentname}">${i.studentname}</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">亲子关系：</label>
		<div class="layui-input-inline">
			<div class="layui-form">
				<select name="parentSon" id="parentSon" lay-filter="mySelect">
					<option value="暂无" selected>暂无选择</option>
					<option value="爸爸">爸爸</option>
					<option value="妈妈">妈妈</option>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">年龄：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="parentAge" placeholder="请输入年龄" id="parentAge"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">地址：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="parentAdd" placeholder="请输入地址" id="parentAdd"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">联系方式：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="parentPhone" placeholder="请输入联系方式" id="parentPhone"
				       autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">职业：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="parentJob" id="parentJob" placeholder="请输入职业"
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
			$("#parentName").on('blur', function () {
				var parentName = $("#parentName").val();
				var path = $("#path").val();
				$.ajax({
					url: path + "/director/selectParentName",
					async: true,
					type: "post",
					data: {"parentName": parentName},
					dataType: "text",
					success: function (msg) {
						if (msg === "success") {
							layer.msg("家长名称已存在，请更改！");
							$("#parentName").focus();
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