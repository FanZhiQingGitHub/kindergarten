<%@ page import="java.util.List" %>
<%@ page import="com.great.kindergarten.commons.entity.TblRole" %><%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-权限管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		.layui-table-cell{
			height:40px;
			line-height: 40px;
		}
		h2{
			margin-top: 2%;
			text-align: center;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2>权限管理</h2>
	<table id="roleInfo" lay-filter="role" class="layui-table-cell"></table>
	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><i class="layui-icon">&#xe642;权限分配</i></button>
	</script>
</body>
<script>
	layui.use('form', function(){ //此段代码必不可少
		var form = layui.form;
		form.render();
	});
</script>
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
		var tableIns = table.render({
			elem: '#roleInfo'
			, height: 350
			, url: path + "/admin/permissionAssignmentInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'roleid', title: '序号', align: 'center', width: 128, sort: true, fixed: 'left'}
				,{field: 'rolename', title: '角色名称', align: 'center', width: 431}
				, {fixed: 'right', title: '操作', align: 'center', width: 586, toolbar: '#barOption'}
			]]
			, id: 'role'
			, parseData: function (res) { //res 即为原始返回的数据
				return {
					"code": res.code, //解析接口状态
					"msg": res.msg, //解析提示文本
					"count": res.count, //解析数据长度
					"data": res.data //解析数据列表
				};
			}
		});

		$(function () {
			var data;
			//监听工具条
			table.on('tool(role)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if (layEvent === 'update') {
					layer.open({
						type:2
						,title:"权限分配"
						,area:['35%','80%']
						,shade:0.3
						,offset:'5%'
						,content:path+"/admin/toUrl/menuPortion"
						,success : function(layero, index) {
							var body = layer.getChildFrame('body',index);
							body.find("#rid").val(data.roleid);
						}
					});
				}
			});
		});

	});
</script>
</html>
