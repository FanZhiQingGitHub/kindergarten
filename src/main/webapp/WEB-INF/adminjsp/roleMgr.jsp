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
	<title>智慧幼儿园平台端-角色管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
		<legend style="text-align: center">角色信息</legend>
	</fieldset>
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="roleTable">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline" >
					<label class="layui-form-label">角色名称：</label>
					<div class="layui-input-inline">
						<select name="rolename" id="rolename" lay-filter="mySelect" lay-verify="" >
							<option value="请选择">请选择</option>
							<c:if test="${not empty tblRoleList}">
								<c:forEach items="${tblRoleList}" var="i">
									<option value="${i.rolename}">${i.rolename}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				<button class="layui-btn" data-type="reload" ><i class="layui-icon">&#xe615;查询</i></button>
				<button class="layui-btn btn-add btn-default" id="btn-add" ><i class="layui-icon">&#xe624;新增</i></button>
			</div>
		</form>
	</div>
	<table id="roleInfo" lay-filter="role"></table>
	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><i class="layui-icon">&#xe642;修改</i></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><i class="layui-icon">&#xe640;删除</i></button>
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
			, height: 312
			, url: path + "/admin/roleMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'roleid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}
				,{field: 'rolename', title: '角色名称', align: 'center', width: 100}
				, {fixed: 'right', title: '操作', align: 'center', width: 268, toolbar: '#barOption'}
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
				console.log(data);
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if (layEvent === 'update') {
					layer.confirm("确定要修改？", {icon: 3, title: '温馨提示'}, function (index) {
						layer.close(index);
						layer.prompt({
								formType: 0,
								id: "remarksPrompt",
								value: '',
								title: '修改角色名字信息'
							},
							function (value, index, elem) {
								layer.close(index);
								//向服务端发送修改指令
								$.ajax({
									url: path + "/admin/updateRoleInfo",
									type: "post",
									data: {"roleid": data.roleid, "rolename": value},
									dataType: "text",
									success: function (result) {
										if (result == "success") {
											layer.alert('角色名字修改成功！',{icon: 6});
										} else {
											layer.alert('角色名字修改失败！',{icon: 2});
										}
										tableIns.reload();    //状态修改之后,刷新表格
									}
								});
							});
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该角色信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteRoleInfo",
							type: "post",
							data: {"roleid": data.roleid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("角色删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("角色删除失败！", {icon: 2});
								}
							}
						});
					});
				}
			});
		})


		//搜索功能的实现
		$('.roleTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('role', {
					where: {
						rolename: $('#rolename').val()
					}
					, page: {
						curr: 1
					}
				});
			}
		};

		// 刷新表格
		$('#btn-refresh').on('click', function () {
			tableIns.reload();
		});
	});
</script>
</html>
