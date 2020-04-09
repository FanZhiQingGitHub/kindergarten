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
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-main garden">
	<form id="garden" class="layui-form layui-from-pane" action="${pageContext.request.contextPath}/updateServlet" lay-filter="test1" style="margin-top:20px" method="post">

		<div class="layui-form-item">
			<label class="layui-form-label">幼儿园名称</label>
			<div class="layui-input-inline">
				<input type="text" id="kindername" name="kindernam" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.kindername}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">法人</label>
			<div class="layui-input-inline">
				<input type="text" id="kinderlp" name="kinderlp" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.kinderlp}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">法人身份证</label>
			<div class="layui-input-inline">
				<input type="text" id="kinderlpid" name="kinderlpid" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.kinderlpid}" readonly>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">地址</label>
			<div class="layui-input-inline">
				<input type="text" id="kinderlpadd" name="kinderlpadd" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.kinderlpadd}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">联系电话</label>
			<div class="layui-input-inline">
				<input type="text" id="kinderlpphone" name="kinderlpphone" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.kinderlpphone}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">办学许可证</label>
			<div class="layui-input-inline">
				<input type="text" id="schoolpermit" name="schoolpermit" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.schoolpermit}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">卫生许可证</label>
			<div class="layui-input-inline">
				<input type="text" id="healthpermit" name="healthpermit" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.healthpermit}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">消防许可证</label>
			<div class="layui-input-inline">
				<input type="text" id="firepermit" name="firepermit" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.firepermit}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">组织代码证</label>
			<div class="layui-input-inline">
				<input type="text" id="grouppermit" name="grouppermit" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.grouppermit}" readonly>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">税务登记证</label>
			<div class="layui-input-inline">
				<input type="text" id="registrationpermit" name="registrationpermit" required  lay-verify="required" autocomplete="off" placeholder="" class="layui-input" value="${tblKinder.registrationpermit}">
			</div>
		</div>

<%--		<div class="layui-form-item" style="margin-top:20px">--%>
<%--			<div class="layui-input-block">--%>
<%--				<button class="layui-btn " lay-filter="demo11">允许</button>--%>
<%--				<button class="layui-btn layui-btn-normal">拒绝</button>--%>
<%--			</div>--%>
<%--		</div>--%>
	</form>
	</div>
</body>
</html>
