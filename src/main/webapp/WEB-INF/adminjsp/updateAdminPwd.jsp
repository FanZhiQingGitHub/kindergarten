<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-21
  Time: 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-修改密码</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		#hh1 {
			font-weight: bold;
			font-size: 35px;
			margin-top: 1%;
			text-align: center;
			font-family: 楷体;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<form class="layui-form" method="post">
		<div id="alldiv">
			<h1 id="hh1">修改密码</h1>
			<hr style="color: white">
			<div class="container" style="margin-top: 3%">
				<div class="layui-form-item">
					<label class="layui-form-label">当前密码</label>
					<div class="layui-inline">
						<input type="password" id="oldadminpwd" placeholder="请输入6-12位旧密码"
						       autocomplete="off" class="layui-input" style="width: 160%" >
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">新密码</label>
					<div class="layui-inline">
						<input type="password" id="adminpwd" placeholder="请输入6-12位新密码" value=""
						       autocomplete="off" class="layui-input" style="width: 160%">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认密码</label>
					<div class="layui-inline">
						<input type="password" id="confrimAdminpwd" placeholder="请输入确认密码" value=""
						       autocomplete="off" class="layui-input" style="width: 160%">
					</div>
				</div>

				<div class="layui-form-item">
					<div class="layui-input-inline" style="margin-left: 10%;">
						<button type="button" class="layui-btn layui-btn-normal" id="bu2" lay-submit lay-filter="updateAdminPwd">
							确认修改
						</button>
						<button type="button" class="layui-btn layui-btn-primary" id="bu3" style="margin-left: 10%">取消</button>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery;
		var path = $("#path").val();

		//验证规则
		form.verify({
			oldadminpwd:[
				/^[\S]{6,12}$/
				, '您好，密码必须6~12位，且不能出现空格！'
			],
			adminpwd:[
				/^[\S]{6,12}$/
				, '您好，密码必须6~12位，且不能出现空格！'
			],
			confrimAdminpwd:[
				/^[\S]{6,12}$/
				, '您好，密码必须6~12位，且不能出现空格！'
			],
			content: function (value) {
				layedit.sync(editIndex);
			}

		});

		$(function () {
			$("#oldadminpwd").blur(function () {
				var reg = /^[\w]{6,12}$/;
				var oldadminpwd = $(this).val();
				$.ajax({
					url: path + "/admin/checkOldPwd",
					type: 'post',
					dataType: 'text',
					data: {"oldadminpwd": oldadminpwd},
					//验证旧密码是否输入正确
					success: function (msg) {
						if (msg == "success" && oldadminpwd != 0 && ($('#oldadminpwd').val().match(reg))) {
							layer.msg('输入旧密码正确', {icon: 1});
						} else if (oldadminpwd == 0 || !($('#oldadminpwd').val().match(reg))) {
							layer.msg('请输入6-12位字符! ')
						} else {
							layer.msg('输入旧密码错误! ')
						}
					}
				});
			});
		});

		form.on('submit(updateAdminPwd)', function (data) {
			var path = $("#path").val();

			var oldadminpwd = $("#oldadminpwd").val();
			var adminpwd = $("#adminpwd").val();
			var confrimAdminpwd = $("#confrimAdminpwd").val();

			if (oldadminpwd.length == 0) {
				layer.msg("请输入旧密码", {icon: 2});
			} else if (adminpwd.length < 6) {
				layer.msg("新密码长度低于6位", {icon: 2});
			} else if (adminpwd.length > 12) {
				layer.msg("新密码长度大于12位", {icon: 2});
			} else if (adminpwd.length == 0) {
				layer.msg("新密码不能为空", {icon: 2});
			} else if (confrimAdminpwd.length == 0) {
				layer.msg("请确认密码", {icon: 2});
			} else if (adminpwd != confrimAdminpwd) {
				layer.msg("密码输入不一致", {icon: 2});
			} else {
				$.ajax({
					url: path + "/admin/updateAdminPwd",
					async: true,
					type: "post",
				    data: {
					    "adminid": $("#adminid").val(),
					    "oldadminpwd": oldadminpwd,
					    "adminpwd": adminpwd,
					    "confrimAdminpwd": confrimAdminpwd
				    },
					datatype: "text",
					success: function (msg) {
						if (data == "error") {
							layer.alert("修改失败！", {icon: 2});
						} else if (data == "pwderror") {
							layer.alert("旧密码输入错误", {icon: 2});
						} else {
							layer.alert("修改成功", {icon: 6});
							setTimeout(function () {
								parent.location.href = path + "/admin/logout";
							}, 3000);
						}
					}, error: function (msg) {
						layer.alert("网络繁忙！", {icon: 2});
					}
				})
			}
		});
		$(function () {
			$("#bu3").click(function () {
				layer.confirm('您确定返回到后台管理页面吗?', {icon: 3, title: '温馨提示'}, function (index) {
					var path = $("#path").val();
					parent.location.href = path + "/admin/toUrl/adminMain";
					return true;
				});
				return false;
			});
		});
	});
</script>
</html>
