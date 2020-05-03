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
		.bu:hover {
			color: white;
		}

		.bu {
			background-color: transparent;
			border: none;
			color: #D9D9D9;
			font-size: 18px;
			text-align: center;
		}
		.layui-nav {
			font-size: 18px;
		}
		.a1{
			font-size: 18px;
		}
		.a2{
			font-size: 16px;
		}
	</style>
</head>
<body class="layui-layout-body close-footer">
<input type="hidden" id="kindername" value="${kindername}">
<input type="hidden" id="path" value="<%=path%>">
<div class="layui-layout layui-layout-admin">

	<div class="layui-header" style="height: 100px">
		<div class="layui-logo" style="width:500px;font-size: 36px;margin-left: 10px;text-align: left;top:15px">
			智慧幼儿园平台端管理系统
		</div>
		<ul class="layui-nav layui-layout-right" style="top: 18px">
			<li class="layui-nav-item" style="width: 70%">
				<a href="javascript:;" style="margin: 2% -20%;font-size: 20px;">
					<img class="layui-nav-img" style="width: 30px;height: 30px" src="${pageContext.request.contextPath}/image/logo/head.jpg">
					<%
						String adminname = (String) request.getSession().getAttribute("adminname");
						String rolename = (String) request.getSession().getAttribute("rolename");
					%>欢迎你,<%=adminname%><%=rolename%>
				</a>
				<dl class="layui-nav-child">
					<dd><a href="javascript:void(0);" title="${pageContext.request.contextPath}/admin/toUrl/adminInfo" onclick="changeSrc(this)" style="font-size: 20px;">个人信息</a></dd>
					<dd><a href="javascript:void(0);" title="${pageContext.request.contextPath}/admin/toUrl/updateAdminPwd" onclick="changeSrc(this)" style="font-size: 20px;">修改密码</a></dd>
				</dl>
			</li>

			<li class="layui-nav-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="bu" id="exit">注销
			</button>
			</li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black" style="top: 100px">
		<div class="layui-side-scroll">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree" lay-filter="test">

				<c:if test="${not empty menuMap}">
					<c:forEach items="${menuMap}" var="i" step="1">
						<li class="layui-nav-item">
							<a class="a1" onclick="showOrHide(this)">${i.key}</a>
							<dl class="layui-nav-child">
								<c:forEach items="${i.value}" var="j">
									<dd><a class="a2" href="javascript:void(0);"
										   title="<%=request.getContextPath()%>/${j.menuurl}"
										   onclick="changeSrc(this)">${j.menuname}</a></dd>
								</c:forEach>
							</dl>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>


	<div class="layui-body" id="body" style="top: 100px">
		<iframe id="iframeMain" name="iframeMain" src="" frameborder="0" width="100%" height="100%" ></iframe>
	</div>

	<div class="layui-footer" style="font-size: 16px;">
		@2020 最后#的小组 版权所有©&nbsp;&nbsp;&nbsp;E-MAIL:kindergarten@outlook.com&nbsp;&nbsp;&nbsp;TEL:400-888-888
		<span style="font-size: 16px;margin-left: 38%" id="time"></span>
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
					// sessionStorage.clear();//清除session信息
					// location.href = path+"/admin/toUrl/adminLogin";
					$.ajax({
						url: path + "/admin/logout",
						type: 'post',
						datatype: 'text',
						success: function (data) {
							location.href=path+'/admin/toUrl/'+data;

						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});

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

	function timeTimer() {
		var d = new Date();//实例化日期对象
		var a = d.toLocaleTimeString();//获取日期
		var b = d.toLocaleDateString();//获取时间
		document.getElementById("time").innerHTML = "当前时间："+b+"&nbsp"+"&nbsp"+"&nbsp"+a;//.innerHTML是dom里面的方法（获取对象的内容  或  向对象插入内容，可以直接在网页上显示）
	}
	setInterval(function() {timeTimer()},1000);//这个方法可以这样写吗 。。。
</script>
</body>
</html>
