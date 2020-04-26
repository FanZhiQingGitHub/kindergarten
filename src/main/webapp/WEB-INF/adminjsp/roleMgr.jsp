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
	<style>
		body{
			font-size: 140%;
		}
		.layui-input{
			width:120%;
			margin: auto;
		}
		.layui-table-cell{
			height: 45px;
			line-height: 45px;
			font-size: 140%;
		}
		a{
			font-size: 140%;
		}
		.sp{
			font-size: 140%;
			height: 40px;
			line-height: 40px;
		}
		h2{
			margin-top: 1%;
			text-align: center;
		}
		body .demo-class .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}

		body .demo2 .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:20px
		}

		.layui-table-page > div {
			height: 50px;
		}

		.layui-table-page .layui-laypage a, .layui-table-page .layui-laypage span {
			height: 26px;
			line-height: 26px;
			margin-bottom: 10px;
			border: none;
			background: 0 0;
			font-size: 18px;
		}
		.layui-table-page select {
			height: 24px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2>角色信息</h2>
	<hr style="color: white">
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="roleTable" style="margin-left: 6%;">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline" style="margin-top: 2%">
					<label class="layui-form-label" style="width: auto">角色名称：</label>
					<div class="layui-input-inline" style="width: 35%;">
						<select name="rolename" id="rolename" lay-filter="mySelect" lay-verify="" >
							<option value="请选择">请选择</option>
							<c:if test="${not empty roleNewList}">
								<c:forEach items="${roleNewList}" var="i">
									<option value="${i}">${i}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<button class="layui-btn" data-type="reload" style="margin-left: 10%;"><span class="sp"><i class="layui-icon">&#xe615;查询</i></span></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin: -6% 90%;" ><span class="sp"><i class="layui-icon">&#xe624;新增</i></span></button>
				</div>

			</div>
		</form>
	</div>
	<table id="roleInfo" lay-filter="role" class="layui-table-cell" style="margin-top: 3%"></table>
	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item" style="margin-top: 3%">
				<span class="layui-form-label" style="width:auto;margin-top: 2%">角色名称：</span>
				<div class="layui-inline">
					<input type="text" id="roleName2" name="roleName2" placeholder="请输入角色名称" value=""
					       autocomplete="off" class="layui-input" style="width: 120%;margin-top: 5%" lay-verify="required">
				</div>
			</div>
		</form>
	</div>
	<script type="text/html" id="barOption">
		{{#  if(d.rolename != '超级管理员') { }}
		<a type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><span class="sp"><i class="layui-icon">&#xe642;修改</i></span></a>
		<a type="button" class="layui-btn layui-btn-normal" lay-event="delete" style="text-align: -moz-center"><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></a>
		{{#  } }}
		{{#  if(d.rolename == '超级管理员') { }}
		<a type="button" class="layui-btn layui-btn-normal" lay-event="permission" style="text-align: -moz-center"><span class="sp">权限分配</span></a>
		{{#  } }}
		{{#  if(d.rolename == '资源管理员') { }}
		<a type="button" class="layui-btn layui-btn-normal" lay-event="permission" style="text-align: -moz-center"><span class="sp">权限分配</span></a>
		{{#  } }}
		{{#  if(d.rolename == '园所管理员') { }}
		<a type="button" class="layui-btn layui-btn-normal" lay-event="permission" style="text-align: -moz-center"><span class="sp">权限分配</span></a>
		{{#  } }}
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
			, height: 450
			, url: path + "/admin/roleMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'roleid', title: '序号', align: 'center', width: 284, sort: true, fixed: 'left'}
				,{field: 'rolename', title: '角色名称', align: 'center', width: 607}
				, {fixed: 'right', title: '操作', align: 'center', width: 835, toolbar: '#barOption'}
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
										layer.alert('角色名字修改成功！',{icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									} else {
										layer.alert('角色名字修改失败！',{icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
									tableIns.reload();    //状态修改之后,刷新表格
								}
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
									layer.alert("角色删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("角色删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}else if (layEvent === 'permission') {
					layer.open({
						type:2
						,title:['权限分配','font-size:18px']
						,area:['35%','80%']
						,shade:0.3
						,offset:'5%'
						,skin: 'demo2'
						,content:path+"/admin/toUrl/menuPortion"
						,success : function(layero, index) {
							var body = layer.getChildFrame('body',index);
							body.find("#rid").val(data.roleid);
						}
					});
				}
			});
		});

		$("#btn-add").click(function () {
			layer.open({
				type: 1,
				area: ['30%', '32%'],
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: ['新增角色','font-size:18px'],
				btn: ['提交', '返回'],
				btnAlign: 'c',
				closeBtn: 0,
				skin: 'demo-class',
				success:function(){

				},
				btn1: function (index) {
					var roleName2 = $('#roleName2').val();
					$.ajax({
						url: path + '/admin/addRoleItems',
						async: true,
						type: 'post',
						data: {"rolename": roleName2},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.alert("新增角色成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								layer.close(index);
								tableIns.reload();
							} else {
								layer.alert("新增角色失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}
					});
				},
				btn2:function(index){
					layer.close(index);
					$('#roleName2').val("");
				}
			});
		});

		$(function(){
			$("#roleName2").blur(function () {
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				var roleName2 = $('#roleName2').val();
				if(!$('#roleName2').val().match(reg)||roleName2 == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					$.ajax({
						url: path + '/admin/checkRoleName',
						async: true,
						type: 'post',
						data: {"rolename": roleName2},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.msg("角色名可用",{icon:6})
							} else {
								layer.msg("角色名已存在,不可用",{icon:2});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});
				}
			});
		});

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
