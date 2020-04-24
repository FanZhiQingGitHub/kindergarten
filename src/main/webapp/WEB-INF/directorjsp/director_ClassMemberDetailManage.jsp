<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>班级成员信息管理</title>
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
	<input type="hidden" name="studentid" id="studentid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">学生名称：</label>
		<div class="layui-input-inline">
			<select name="studentname" id="studentname"  lay-filter="mySelect">
				<option value="暂无" selected>暂无选择</option>
				<c:if test="${not empty tblStudentList}">
					<c:forEach items="${tblStudentList}" var="i" step="1">
						<option value="${i.studentname}">${i.studentname}</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">班级名称：</label>
		<div class="layui-input-inline">
			<select name="classname" id="classname"  lay-filter="mySelect">
				<option value="暂无" selected>暂无选择</option>
				<c:if test="${not empty tblClassList}">
					<c:forEach items="${tblClassList}" var="i" step="1">
						<option value="${i.classname}">${i.classname}</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
	</div>
</form>

<script>
	//Demo
	layui.use(['form', 'jquery', 'layer'], function () {
		var form = layui.form;
		$ = layui.$;
		var layer = layui.layer;
		//对应的班级ID的删除-正则表达式的判断
	});
</script>
</body>
</html>