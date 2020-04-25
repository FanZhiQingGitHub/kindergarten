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
			font-size: 140%;
		}

		.layui-input{
			width:180%;
			margin: auto;
		}

		h3 {
			text-align: center;
		}
		.layui-table-cell {
			height: 70px;
			line-height: 70px;
			white-space:normal;
			font-size: 140%;
		}

		.sp{
			font-size: 140%;
			height: 40px;
			line-height: 40px;
		}
		body .demo-class .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}

		body .demo .layui-layer-btn{
			margin-top: -5%;
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}
		body .demo .layui-layer-content{
			font-Size:18px
		}
	</style>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
	<table id="read" lay-filter="test" class="layui-table-cell"></table>
	<div class="layui-main readInfo">
		<form id="reUploads" class="layui-form" action="" onsubmit="return false;">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 24%">绘本名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="readMagName" id="readMagName" value="" placeholder="" style="width: 180%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 24%">绘本图片：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 24%">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label" style="width: 24%">页数：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
				</div>
			</div>

		</form>
	</div>
</body>
</html>
