<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/9
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>课程表</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>
<h1 style="margin-left: 17%;font-size: 40px;color: coral">课程表</h1>

<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;width: 100px">班级名称：${classname}</label>
		<label class="layui-form-label" style="float: right;width: 100px">日期：${classname}</label>

	</div>
</div>
<table id="demo" lay-filter="test">
	<input type="hidden" id="path" value="<%=path%>">
</table>
<div class="layui-form-item" style="text-align: right;padding-right: 10%;">
	<div class="layui-input-block">
		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">上一周</button>
		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">下一周</button>
	</div>
</div>

</body>
<script>

	layui.use(['table','laydate','layer'], function() {
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path = $("#path").val();
		//第一个实例 课程表
		table.render({
			elem: '#demo'
			,height: 300
			,url: path+'/teacher/courseTable' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'coursenum', title: '课节', width:150, sort: true, fixed: 'left'}
				,{field: 'coursename1', title: '周一', width:150}
				,{field: 'coursename2', title: '周二', width:150}
				,{field: 'coursename3', title: '周三', width:150}
				,{field: 'coursename4', title: '周四', width:150}
				,{field: 'coursename5', title: '周五', width:150}
			]]
		});
	});
</script>

</html>
