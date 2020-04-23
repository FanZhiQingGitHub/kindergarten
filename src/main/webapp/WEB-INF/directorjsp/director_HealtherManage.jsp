<%--
  Created by IntelliJ IDEA.
  User: JK
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<title>智慧幼儿园-保健员管理</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 48%">保健员管理</h2>
	</div>
	<div class="layui-inline" style="width:100%;">
		<hr>
	</div>

	<div class="layui-fluid" id="searchTable" style="top:5px">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div style="padding-bottom: 10px;">
				<label class="layui-form-label">查询条件</label>

				<div class="layui-inline">
					<label class="layui-form-label">保健员名称</label>
					<div class="layui-input-inline">
						<input class="layui-input" name="${hName}" id="hName" autocomplete="off" placeholder="请输入保健员名称">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label">创建时间</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" id="addtime" placeholder=" ~ " style="width: 200px">
					</div>
				</div>
				<button type="button" class="layui-btn layui-btn-normal" data-type="reload"><i class="layui-icon">&#xe615;</i>查询
				</button>
				<button type="button" class="layui-btn add"><i class="layui-icon">&#xe654;</i>新增保健员</button>
			</div>

		</div>
	</div>

	<table id="dataTable" lay-filter="test"></table>

	<script type="text/html" id="butdiv">
		<button class="layui-btn layui-btn-sm layui-btn-normal update"><i class="layui-icon">&#xe642;</i>编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-normal update"><i class="layui-icon">&#xe642;</i>删除</button>
	</script>
</div>

<script>
	layui.use(['table', 'jquery', 'layer', 'form', 'laydate'], function () {
		$ = layui.jquery;
		var table = layui.table;
		var form = layui.form;
		var layer = layui.layer;
		var laydate = layui.laydate;
		var path = $("#path").val();
		//第一个实例
		table.render({
			elem: '#dataTable'
			, height: 350
			, url: path + '/director/showAllHealtherInfo' //数据接口
			, page: true //开启分页
			, id: 'searchTable'
			, limit: 5
			, limits: [5, 10, 15, 20]
			, cols: [[ //表头
				{field: 'healtherid', title: '保健员ID', width: 120, sort: true, fixed: 'left', align: 'center'}
				, {field: 'healthername', title: '保健员名称', width: 200, align: 'center'}
				, {field: 'healthersex', title: '保健员性别', width: 200, sort: true, align: 'center'}
				, {field: 'healtherage', title: '保健员年龄', width: 200, sort: true, align: 'center'}
				, {field: 'healtheradd', title: '通讯地址', width: 200, sort: true, align: 'center'}
				, {field: 'healtherphone', title: '手机号码', width: 200, sort: true, align: 'center'}
				, {field: 'healtherregtime', title: '注册时间', width: 300, align: 'center',templet:"<div>{{layui.util.toDateString(d.healtherregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'healtherstatus', title: '状态', width: 300, align: 'center'}
				, {field: '', title: '操作', toolbar: "#butdiv", width: 200, align: 'center'}
			]]
		});

		$('#searchTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			if (type == 'reload') {
				//执行重载
				table.reload('searchTable', {
					page: {
						curr: 1 //重新从第 1 页开始
					}
					, where: {
						key1: $("#hName").val(),
						key2: $("#addtime").val(),
					}
				});
			}
		});
		//日期范围
		laydate.render({
			elem: '#addtime'
			, range: '~'
			, isInitValue: false
		});
	});
</script>
</body>
</html>
