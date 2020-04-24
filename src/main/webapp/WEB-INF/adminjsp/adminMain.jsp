<%@ page import="com.great.kindergarten.commons.entity.TblAdmin" %><%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-7
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>智慧幼儿园-平台端</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<style>
		*{
			margin: 0;
			padding: 0;
		}
		body,html{
			height: 100%;
			overflow:hidden;
		}

		#header{
			width: 100%;
			height: 80px;
		}

		#scroll{
			width: 220px;

		}

		#index-commonmenu
		{
			top:80px;
		}

		#exit{
			background: #040404;
		}

		#title{
			padding: 5%;
			font-size: 22px;
			line-height: 120%;
		}
		.menu_div_item{
			font-size: 20px;
			color: #8f9199;
			padding: 5%;
			line-height: 180%;
		}
	</style>
</head>
<body class="layui-layout-body close-footer">
	<input type="hidden" id="kindername" value="${kindername}">
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-layout layui-layout-admin">

		<div class="layui-header" id="header">
			<div class="layui-logo" style="width: 300px;margin: 0.5% 0;font-size: 175%">智慧幼儿园平台端管理系统</div>
				<ul class="layui-nav layui-layout-right">
					<li class="layui-nav-item">
						<a href="javascript:;" style="margin: 2% -20%;font-size: 165%;">
							<img id="adminheadurl" class="layui-nav-img" style="width: 30px;height: 30px">
							<%
								String adminname = (String) request.getSession().getAttribute("adminname");
								String rolename = (String) request.getSession().getAttribute("rolename");
							%>欢迎你,<%=adminname%><%=rolename%>
						</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:void(0);" title="${pageContext.request.contextPath}/admin/toUrl/adminInfo"  onclick="changeSrc(this)">个人信息</a></dd>
							<dd><a href="javascript:void(0);" title="${pageContext.request.contextPath}/admin/toUrl/updateAdminPwd"  onclick="changeSrc(this)">修改密码</a></dd>
						</dl>
					</li>
					<button type="button" class="layui-btn layui-btn-normal" style="background-color: transparent" id="exit" lay-submit lay-filter="logout">
						<span style="font-size: 165%;">退出</span>
					</button>
				</ul>
		</div>

		<div id="index-commonmenu" class="layui-side layui-bg-black">
			<div class="layui-side-scroll" id="scroll">
				<c:if test="${not empty menuMap}">
					<c:forEach items="${menuMap}" var="i">
						<div onclick="showOrHide(this)" id="title">
								${i.key}
						</div>
						<ul class="menu_ul" style="display: none">
							<c:forEach items="${i.value}" var="j">
								<li>
									<a href="javascript:void(0)" title="${pageContext.request.contextPath}/${j.menuurl}" onclick="changeSrc(this)" class="menu_div_item">${j.menuname}</a>
								</li>
							</c:forEach>
						</ul>
					</c:forEach>
				</c:if>
			</div>
		</div>

		<div class="layui-body" id="body">
			<iframe id="iframeMain" name="iframeMain" src="" style="width: 100%" height="100%" ></iframe>
		</div>
	</div>

	<script>
		layui.use(['element', 'layer', 'jquery'], function(){
			var $ = layui.jquery,
				element = layui.element,
				path = $("#path").val(),
				layer = layui.layer;
			$(function () {
				$("#exit").click(function () {
					layer.confirm("您确定要退出？",{icon:3,title: '温馨提示'},function (index) {
						layer.close(index);
						sessionStorage.clear();//清除session信息
						location.href = path+"/admin/logout";
					})
				});
				$("#perInfo").click(function () {
					parent.location.href = path+"/admin/toUrl/adminInfo";
				});
			});

			$.ajax({
				url: path + "/admin/selectAdminInfo",
				type: 'post',
				datatype: 'json',
				success: function (data) {
					var adminInfo = eval(data);
					for (i in adminInfo) {
						$("#adminheadurl").attr("src", path+"/"+adminInfo[i].adminheadurl);
					}
				}, error: function (data) {
					layer.alert("网络繁忙！", {icon: 2});
				}
			});
		});

		var src;
		function changeSrc(node)
		{
			var iframeNode = document.getElementById('iframeMain');
			iframeNode.src = node.title;
		}
		function showOrHide(node)
		{
			var menuNodes = $(".menu_ul");
			for(var i = 0; i< menuNodes.length;i++)
			{
				$(menuNodes[i].style.display = "none");
			}
			$(node).next().slideToggle("slow");
		}
	</script>
</body>
</html>
