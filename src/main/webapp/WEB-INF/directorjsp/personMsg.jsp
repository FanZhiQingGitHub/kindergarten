<%--
  Created by IntelliJ IDEA.
  User: junlong
  Date: 2019-11-13
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta charset="utf-8">
	<title>个人信息</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<%--	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">--%>
</head>
<style>
	* {
		margin: 0 auto;
	}
	body {
		line-height: 50px;
	}
	.nav {
		display: inline-block;
	}
	.cont img {
		width: 100px;
		height: 100px;
		float: left;
		margin: 50px;
	}
	.per-info {
		float: left;
	}
	.welcome-text {
		float: right;
		margin-right: 20px;
		margin-top: 10px;
	}

</style>
<body>
<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
<div class="header">
	<div class="nav">
		<a style="font-size: 18px;margin-left: 30px;">welcome to <span class="name"
		                                                               style="color: darkorchid">&nbsp;${logintblRector.rectorname}&nbsp;</span>
			home
			!!!</a>
	</div>
</div>
<div class="cont">
	<img src="${pageContext.request.contextPath}/image/logo/headDirector.jpg">
	<div class="per-info">
		<ul style="font-size: 18px">
			<c:if test="${not empty logintblRector}">
				<li>姓名：${logintblRector.rectorname}</li>
				<li>性别：${logintblRector.rectorsex}</li>
				<li>年龄：${logintblRector.rectorage}</li>
				<li>地址：${logintblRector.rectoradd}</li>
				<li>电话：${logintblRector.rectorphone}</li>
			</c:if>
		</ul>
	</div>
</div>

</body>
</html>