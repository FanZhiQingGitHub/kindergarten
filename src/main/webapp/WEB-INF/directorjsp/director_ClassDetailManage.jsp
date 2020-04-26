<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>班级信息管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
	* {
		margin: 0 auto;
	}
	html{
		margin-top: 10%;
		padding-top: 10%;
	}
	body {
		line-height: 50px;
	}
</style>
<body>

<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" name="classid" id="classid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">班级名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="classname" id="classname" autocomplete="off" required lay-verify="required"
			       placeholder="请输入班级名称" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">班主任：</label>
		<div class="layui-input-inline">
			<select name="teachername" id="teachername"  lay-filter="mySelect">
				<option value="暂无" selected>暂无选择</option>
				<c:if test="${not empty tblTeacherList}">
					<c:forEach items="${tblTeacherList}" var="i" step="1">
						<option value="${i.teachername}">${i.teachername}</option>
					</c:forEach>
				</c:if>
			</select>
			<span id="updatedemo"></span>

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
			//班级名字判断是不是重复
			$("#classname").on('blur', function () {
				var classname = $("#classname").val();
				var path = $("#path").val();
				$.ajax({
					url: path + "/director/selectClassName",
					async: true,
					type: "post",
					data: {"classname": classname},
					dataType: "text",
					success: function (msg) {
						if (msg === "success") {
							layer.msg("该班级名称已存在，请更改！");
							$("#classname").focus();
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