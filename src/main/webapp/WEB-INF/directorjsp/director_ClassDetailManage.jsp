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

	body {
		line-height: 50px;
	}
</style>
<body>

<form class="layui-form" action="#" lay-filter="test1">
	<input type="text" name="classid" id="classid">
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
		// var classid = $("#classid").val();
		// var src = $("#path").val();
		// if ("" != classid || null != classid) {
		// 	console.log("对应修改" + classid);
		// 	$("#classname").on('blur', function () {
		// 		console.log("点击事件=" + classid);
		// 		$.ajax({
		// 			url: src + '/director/selectTeacherByCid',
		// 			type: 'post'
		// 			, data: {"classid": classid},
		// 			dataType: "text",
		// 			success: function (data) {
		// 				console.log("--" + data.toString());
		// 			}, error: function (err) {
		// 				console.log(err);
		// 			}
		// 		});
		// 	});
		// }
	});
	// function teacherchange() {
	// 	console.log("进入方法=");
	// }
</script>
</body>
</html>