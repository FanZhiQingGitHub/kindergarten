<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-2
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>智慧幼儿园-个人信息页面</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
	<link rel="stylesheet" type="text/css" href=<%=path+"/image/healtherimg/css/main.css"%>>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="header">
	<h1 class="logo">
		<a>
			<span>个人信息</span>
			<img src="${pageContext.request.contextPath}/image/healtherimg/img/logo.png">
		</a>
	</h1>
	<div class="nav">
		<a style="font-size: 18px">welcome to <span class="name" style="color: darkorchid">&nbsp;${healthername}&nbsp;</span> home !!!</a>
	</div>
	<p class="welcome-text">
		<button class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal updateTeacherPwd" style="margin-top: 48%">
			修改密码
		</button>
	</p>
</div>

<div class="about-content">
	<div class="w1000">
		<div class="item info">
			<div class="title">
				<h3>我的介绍</h3>
			</div>
			<div class="cont">
				<img src="${pageContext.request.contextPath}/image/logo/head.jpg">
				<div class="per-info">
					<ul style="font-size: 18px">
						<c:if test="${not empty tblTeacherList}">
							<c:forEach items="${tblTeacherList}" var="i" step="1">
								<li >姓名：${i.teachername}</li><br/>
								<li >性别：${i.teachersex}</li><br/>
								<li >年龄：${i.teacherage}</li><br/>
								<li >地址：${i.teacheradd}</li><br/>
								<li >电话：${i.teacherphone}</li><br/>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="type-content" style="display: none;">
	<div class="layui-form-item">
		<div class="layui-inline">
			<input type="password" id="oldTeacherPwd"  placeholder="请输入6-12位旧密码" value=""
			       autocomplete="off" class="layui-input" style="width: 300px">
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<input type="password" id="teacherPwd"  placeholder="请输入6-12位新密码" value=""
			       autocomplete="off" class="layui-input" style="width: 300px">
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<input type="password" id="sureTeacherPwd"  placeholder="请确认密码" value=""
			       autocomplete="off" class="layui-input" style="width: 300px">
		</div>
	</div>
</div>

<script>


	layui.use(['jquery','layer'], function () {
		var $ = layui.jquery;
		var layer = layui.layer;

		var path = $("#path").val();
		$('body').on('click', '.updateTeacherPwd', function () {
			layer.open({
				type: 1,
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: '修改密码',
				btn: ['确定', '取消'],
				offset: '100px',
				btnAlign: 'c',
				btn1: function (index) {

					var oldTeacherPwd = $("#oldTeacherPwd").val();
					var teacherPwd = $("#teacherPwd").val();
					var sureTeacherPwd= $("#sureTeacherPwd").val();

					if (oldTeacherPwd.length == 0 ) {
						console.log("进来");
						layer.alert("请输入旧密码", {icon: 2});
					}else if (teacherPwd.length < 6) {
						layer.alert("新密码长度低于6位", {icon: 2});
					} else if (teacherPwd.length > 12) {
						layer.alert("新密码长度大于12位", {icon: 2});
					} else if (teacherPwd.length == 0) {
						layer.alert("新密码不能为空", {icon: 2});
					} else if (sureTeacherPwd.length == 0) {
						layer.alert("请确认密码", {icon: 2});
					} else if (teacherPwd != sureTeacherPwd) {
						layer.alert("密码输入不一致", {icon: 2});
					} else {

						$.ajax({
							url: path + '/teacher/updateTeacherPwd',
							async: true,
							type: 'post',
							data: {"oldTeacherPwd": oldTeacherPwd,"teacherPwd":teacherPwd},
							datatype: 'text',
							success: function (data) {
								console.log(data);
								if (data =="success") {
									console.log("修改返回");
									alert("修改成功");
									$(":input").val(" ");
									//当你在iframe页面关闭自身时
									var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
									parent.layer.close(index); //再执行关闭
									///location.href = "login.html";
								}
								else if (data =="sureError") {
									console.log("旧密码错误");
									layer.msg('旧密码错误');
									///location.href = "login.html";
								}
								else {
									layer.msg('修改失败');
								}
							}, error: function (data) {
								layer.alert("网络繁忙！", {icon: 2});
							}
						});

					}
				}
			});
		});
	})
</script>
</body>
</html>
