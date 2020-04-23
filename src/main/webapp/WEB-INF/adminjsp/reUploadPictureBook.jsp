<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-13
  Time: 7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-重新上床绘本</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			overflow: hidden;
		}
		h3 {
			text-align: center;
		}

		.layui-table-cell {
			height: 40px;
			line-height: 40px;
		}
	</style>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
	<table id="read" lay-filter="test" class="layui-table-cell"></table>
	<div class="layui-main readInfo">
		<form id="reUploads" class="layui-form" action="" onsubmit="return false;">
			<div class="layui-form-item">
				<label class="layui-form-label" style="">绘本名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="readMagName" id="readMagName" value="" placeholder="" style="width: 22%;margin-top: 1%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">绘本图片：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">页数：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
				</div>
			</div>

		</form>
	</div>
</body>
</html>
