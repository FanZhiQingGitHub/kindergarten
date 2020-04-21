<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/18
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>宝宝信息</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
	<link rel="stylesheet" type="text/css" href=<%=path+"/image/healtherimg/css/main.css"%>>
	<style type="text/css">
		* {
			margin: 0;
			padding: 0;
		}

		html {
			width: 100%;
			height: 100%;
		}
		body {
			width: 100%;
			height: 100%;
		}
		#hh1 {
			color: black;
			font-weight: bold;
			font-size: 30px;
			margin-left: 16%;
			margin-top: 3%;
			font-family: 楷体;
		}
	</style>

</head>
<body>
<div id="alldiv">
	<div class="container">
		<h1 id="hh1">宝宝信息</h1>
		<hr style="color: white">
		<img src="${pageContext.request.contextPath}/image/healtherimg/img/logo.png">
		<div class="layui-form-item">
			<label class="layui-form-label">宝宝姓名：</label>
			<div class="layui-input-inline">
				<input type="text" name="studentName" id="studentName" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">出生年月：</label>
			<div class="layui-input-inline">
				<input type="text" name="studentBrith" id="studentBrith" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别：</label>
			<div class="layui-input-inline">
				<input type="text" name="studentSex" id="studentSex" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">户口地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="studentAdd" id="studentAdd" class="layui-input" readonly style="width:400px">
			</div>
		</div>
	</div>


	<div class="container">
		<h1 id="hh2">家长信息</h1>
		<hr style="color: white">
		<img src="${pageContext.request.contextPath}/image/healtherimg/img/logo.png">
		<div class="layui-form-item">
			<label class="layui-form-label">家长姓名：</label>
			<div class="layui-input-inline">
				<input type="text" name="parentName" id="parentName" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">亲子关系：</label>
			<div class="layui-input-inline">
				<input type="text" name="parentSon" id="parentSon" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号码：</label>
			<div class="layui-input-inline">
				<input type="text" name="parentPhone" id="parentPhone" class="layui-input" readonly width="100px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">家庭地址：</label>
			<div class="layui-input-inline">
				<input type="text" name="parentAdd" id="parentAdd" class="layui-input" readonly style="width:400px">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">职业：</label>
			<div class="layui-input-inline">
				<input type="text" name="parentJob" id="parentJob" class="layui-input" readonly width="200px">
			</div>
		</div>
	</div>
</div>

</body>
</html>
