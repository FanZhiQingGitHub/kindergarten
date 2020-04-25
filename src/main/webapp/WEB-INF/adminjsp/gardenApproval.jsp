<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title>智慧幼儿园平台端-园所审批</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/image/adminimg/css/gardenApproval.css"/>
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<style type="text/css">
		body {
			font-size: 120%;
		}

		.container {
			position: relative;
			width: 36%;
			min-height: 33%;
			top: 1%;
			left: 0;
			bottom: 0;
			right: 0;
			margin: auto;
			padding: 10px;
			z-index: 130;
			border-radius: 10px;
		}
		.layui-form-item .layui-input-inline{
			width: 300px;
		}
		.layui-form-label {
			width: 140px;
		}

		label{
			margin-left: -75%;
		}
	</style>
</head>
<body >
	<form class="layui-form" method="post">
		<input type="hidden" id="path" value="<%=path%>">
		<div id="alldiv">
			<div class="container">
				<div class="layui-form-item" >
					<label class="layui-form-label">幼儿园名称：</label>
					<div class="layui-input-inline">
						<input type="text" name="kindername" id="kindername" lay-verify="kindername" placeholder="" autocomplete="off"
						       class="layui-input" readonly style="margin-top: -0.2%">
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">账号：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderacount" id="kinderacount" lay-verify="kinderacount" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label" >法人：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderlp" id="kinderlp" lay-verify="kinderlp" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label" >法人身份证：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderlpid" id="kinderlpid" lay-verify="kinderlpid" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">地址：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderlpadd" id="kinderlpadd" lay-verify="kinderlpadd" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">联系电话：</label>
					<div class="layui-input-inline">
						<input type="tel" name="kinderlpphone" id="kinderlpphone" lay-verify="kinderlpphone" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">办学许可证：</label>
					<div class="layui-input-inline">
						<input type="text" name="schoolpermit" id="schoolpermit" lay-verify="schoolpermit|license" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">卫生许可证：</label>
					<div class="layui-input-inline">
						<input type="text" name="healthpermit" id="healthpermit" lay-verify="healthpermit|license" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">消防许可证：</label>
					<div class="layui-input-inline">
						<input type="text" name="firepermit" id="firepermit" lay-verify="firepermit|license" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item" >
					<label class="layui-form-label">组织代码证：</label>
					<div class="layui-input-inline">
						<input type="text" name="grouppermit" id="grouppermit" lay-verify="grouppermit|license" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">税务登记证：</label>
					<div class="layui-input-inline">
						<input type="text" name="registrationpermit" id="registrationpermit" lay-verify="registrationpermit|license" placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label">园所规模：</label>
					<div class="layui-input-inline" readonly>
						<input type="text" name="kinderscale" id="kinderscale" lay-verify="kinderscale"
						       placeholder="" autocomplete="off"
						       class="layui-input">
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label" >注册资金：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderfunds" id="kinderfunds" lay-verify="kinderfunds"
						       placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label" >审批状态：</label>
					<div class="layui-input-inline">
						<input type="text" name="kinderstatus" id="kinderstatus" lay-verify="kinderfunds"
						       placeholder="" autocomplete="off"
						       class="layui-input" readonly>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
