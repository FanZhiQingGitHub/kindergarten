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
	<title>智慧幼儿园平台端-管理账户</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2 {
			margin-top: 1.5%;
			text-align: center;
		}

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
		body .demo-class .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}

		body .demo .layui-layer-btn{
			margin-top: -5%;
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}
		body .demo .layui-layer-content{
			font-Size:18px
		}
		.layui-form-radio * {
			font-size: 20px;
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
	<h2>管理员账号信息</h2>
	<hr style="color: white">
	<div class="layui-row" style="margin-top: 12px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="adminTable" style="margin-left: 6%;">
				<div class="layui-form-item">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">创建时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择创建开始时间" >
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin: 5% 15%;width: 10%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择创建结束时间" style="margin: -27% 65%;">
						</div>
					</div>
					<button class="layui-btn" data-type="reload" style="margin-left: 10%"><span class="sp"><i class="layui-icon">&#xe615;查询</i></span></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-left: 5.3%;"><span class="sp"><i class="layui-icon">&#xe624;新增</i></span></button>
				</div>
				<div class="layui-form-item" >
					<div class="layui-inline" >
						<span class="layui-form-label" style="width: auto">账户名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="adminname" id="adminname" value="" placeholder="请输入账户名" >
						</div>
					</div>
					<div class="layui-inline" style="margin-left: 2%">
						<span class="layui-form-label" style="width: auto;">状态：</span>
						<div class="layui-input-inline" >
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" style="margin: -15% 0 0 50%">
								<option value="请选择">请选择</option>
								<option value="禁用">禁用</option>
								<option value="启用">启用</option>
							</select>
						</div>
					</div>
					<div class="layui-inline" style="margin-left: 2%">
						<span class="layui-form-label" style="width: auto;">角色名称：</span>
						<div class="layui-inline" style="width: 45%">
							<select name="rolename3" id="rolename3" lay-filter="mySelect" lay-verify="" >
								<option value="请选择" selected>请选择</option>
								<c:if test="${not empty roleList}">
									<c:forEach items="${roleList}" var="i">
										<option value="${i.rolename}">${i.rolename}</option>
									</c:forEach>
								</c:if>
							</select>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table id="admin" lay-filter="test" class="layui-table-cell" style="margin-top: 2%"></table>
	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item" style="margin-top: 3%">
				<span class="layui-form-label" style="width: 24%">账号名称：</span>
				<div class="layui-inline">
					<input type="text" id="adminname1" name="adminname1" placeholder="请输入账号名称" value=""
					       autocomplete="off" class="layui-input" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">密码：</span>
				<div class="layui-inline">
					<input type="password" id="adminpwd1" name="adminpwd1" placeholder="请输入6-12位密码" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">手机号：</span>
				<div class="layui-inline">
					<input type="text" id="adminphone1" name="adminphone1" placeholder="请输入11位手机号" value=""
					       autocomplete="off" class="layui-input" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">角色名称：</span>
				<div class="layui-inline" style="width: 40.5%">
					<select name="rolename" id="rolename1" lay-filter="mySelect" lay-verify="" >
						<option value="请选择" selected>请选择</option>
						<c:if test="${not empty roleList}">
							<c:forEach items="${roleList}" var="i">
								<option value="${i.rolename}">${i.rolename}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</form>
	</div>

	<div id="type-content2" style="display: none;">
		<form class="layui-form" action="" method="post">
			<div class="layui-form-item" style="margin-top: 3%">
				<span class="layui-form-label" style="width: 24%">账号名称：</span>
				<div class="layui-inline">
					<input type="text" id="adminname2" name="adminname2" placeholder="请输入账号名称" value=""
					       autocomplete="off" class="layui-input" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">密码：</span>
				<div class="layui-inline">
					<input type="password" id="adminpwd2" name="adminpwd2" placeholder="请输入6-12位密码" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">手机号：</span>
				<div class="layui-inline">
					<input type="text" id="adminphone2" name="adminphone2" placeholder="请输入11位手机号" value=""
					       autocomplete="off" class="layui-input" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">性别：</span>
				<div class="layui-inline">
					<input type="radio" name="adminsex2" class="adminsex2" value="男" title="男" checked >
					<input type="radio" name="adminsex2" class="adminsex2" value="女" title="女" style="margin-left: 10%;">
				</div>
			</div>
			<div class="layui-form-item">
				<span class="layui-form-label" style="width: 24%">角色名称：</span>
				<div class="layui-inline" style="width: 43%">
					<select name="rolename" id="rolename" lay-filter="mySelect" lay-verify="" >
						<option value="请选择" selected>请选择</option>
						<c:if test="${not empty roleList}">
							<c:forEach items="${roleList}" var="i">
								<option value="${i.rolename}">${i.rolename}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</form>
	</div>
	<script type="text/html" id="barOption">
		{{#  if(d.adminname == 'admin'){ }}
		<button type="button" class="layui-btn layui-btn-disabled" lay-event=""><span class="sp">不可删除</span></button>
		{{#  } }}
		{{#  if(d.adminname != 'admin'){ }}
		{{#  if(d.adminstatus == '启用'){ }}
		<a  class="layui-btn layui-btn-danger " lay-event="forbidden" ><span class="sp">禁用</span></a>
		{{#  } }}
		{{#  if(d.adminstatus == '禁用'){ }}
		<a class="layui-btn layui-btn-danger " lay-event="open" ><span class="sp">启用</span></a>
		{{#  } }}
		<button type="button" class="layui-btn " lay-event="update" ><span class="sp"><i class="layui-icon">&#xe642;修改</i></span></button>
		<button type="button" class="layui-btn " lay-event="delete" ><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></button>
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
			elem: '#admin'
			, height: 450
			, url: path + "/admin/adminMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'adminid', title: '编号', align: 'center', width: 121, sort: true, fixed: 'left'}
				,{field: 'adminname', title: '账号名称', align: 'center', width: 138}
				,{field: 'adminsex', title: '性别', align: 'center', width: 120}
				,{field: 'adminphone', title: '手机号', align: 'center', width: 170}
				,{field: 'adminheadurl', title: '头像地址', align: 'center', width: 323}
				, {field: 'createtime', title: '创建时间', align: 'center', width: 234
					,templet:"<div>{{layui.util.toDateString(d.createtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				,{field: 'adminstatus', title: '状态', align: 'center', width: 86}
				,{field: 'rolename', title: '角色名称', align: 'center', width: 155}
				, {fixed: 'right', title: '操作', align: 'center', width: 348, toolbar: '#barOption'}
			]]
			, id: 'adminTable'
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
			table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if (layEvent === 'update') {
					layer.open({
						type: 1,
						area: ['36%', '48%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改账号信息','font-size:18px'],
						btn: ['保存', '取消'],
						skin: 'demo-class',
						closeBtn: 0,
						btnAlign: 'c',
						success:function() {
							$("#adminname1").val(data.adminname);
							$("#adminphone1").val(data.adminphone);
							$.ajax({
								url: path + "/admin/selectAdminInfo",
								type: 'post',
								datatype: 'json',
								success: function (data) {
									var adminInfo = eval(data);
									for (i in adminInfo) {
										$("#adminpwd1").val(adminInfo[i].adminpwd);
									}
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
								}
							});
						},
						btn1:function (index){
							var adminname = $("#adminname1").val();
							var adminphone = $("#adminphone1").val();
							var adminpwd = $("#adminpwd1").val();
							var rolename = $("#rolename1 option:selected").val();
							if(adminname == 0)
							{
								layer.msg("账号不能为空",{icon:2});
							}
							else if(!/^[A-Za-z0-9]+$/.test(adminname))
							{
								layer.msg("请输入字母与数字组成的字符",{icon:2});
							}
							else if(adminphone == 0)
							{
								layer.msg("手机号不能为空",{icon:2});
							}else if(!/^1(3|4|5|6|7|8|9)\d{9}$/.test(adminphone))
							{
								layer.msg("请输入以1开头的11位手机号",{icon:2});
							}
							else if(adminpwd == 0)
							{
								layer.msg("密码不能为空",{icon:2});
							}
							else if(!adminpwd.match(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/)){
								layer.msg("输入的密码必须是6-12位字母与数字组成的字符串", {icon: 2});
							}
							else if( rolename == 0)
							{
								layer.msg("角色名称不能为空",{icon:2});
							}
							else if( !rolename.match(/^[\u4e00-\u9fa5]{2,20}$/))
							{
								layer.msg("请输入至少2位中文角色名称",{icon:2});
							}
							else {
								$.ajax({
									url: path + "/admin/updateAdminInfos",
									type: "post",
									data: {
										"adminid": data.adminid,
										"adminname": adminname,
										"adminphone": adminphone,
										"adminpwd": adminpwd,
										"rolename": rolename
									},
									dataType: "text",
									success: function (result) {
										if (result == "success") {
											layer.close(index);
											layer.alert('修改成功！', {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
											tableIns.reload();    //状态修改之后,刷新表格
										} else {
											layer.alert('修改失败！', {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
										}
									},
									error: function () {
										layer.alert('网络繁忙！', {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									}
								});
							}
						},
						btn2:function (index){
							$("#adminname1").val("");
							$("#adminphone1").val("");
							$("#adminpwd1").val("");
							layer.close(index);
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该信息？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteAdmin",
							type: "post",
							data: {"adminid": data.adminid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
								}
							},
							error: function () {
								layer.alert('网络繁忙！', {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
							}
						});
					});
				}
				else if (layEvent === 'forbidden') {
					layer.confirm("确定禁用该账号？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/forbiddenAdmin",
							type: "post",
							data: {"adminid": data.adminid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("禁用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("禁用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
								}
							}
						});
					});
				}else if(layEvent === 'open'){
					layer.confirm("确定启用该账号？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/openAdmin",
							type: "post",
							data: {"adminid": data.adminid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("启用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("启用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
								}
							}
						});
					});
				}
			});
		});

		$("#btn-add").click(function () {
			layer.open({
				type: 1,
				area: ['34%', '54%'],
				content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
				title: ['新增管理员','font-size:18px'],
				btn: ['提交', '返回'],
				skin: 'demo-class',
				closeBtn: 0,
				offset: '30px',
				btnAlign: 'c',
				success:function(){

				},
				btn1: function (index) {
					var adminname2 = $('#adminname2').val();
					var adminphone2 = $('#adminphone2').val();
					var adminsex2 = $('input[name="adminsex2"]:checked').val();
					var adminpwd2 = $('#adminpwd2').val();
					var rolename = $("#rolename option:selected").val();
					if(adminname2 == 0)
					{
						layer.msg("账号不能为空",{icon:2});
					}
					else if(!/^[A-Za-z0-9]+$/.test(adminname2))
					{
						layer.msg("请输入字母与数字组成的字符",{icon:2});
					}
					else if(adminpwd2 == 0)
					{
						layer.msg("密码不能为空",{icon:2});
					}
					else if(!adminpwd2.match(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/)){
						layer.msg("输入的密码必须是6-12位字母与数字组成的字符串", {icon: 2});
					}
					else if(adminphone2 == 0)
					{
						layer.msg("手机号不能为空",{icon:2});
					}else if(!/^1(3|4|5|6|7|8|9)\d{9}$/.test(adminphone2))
					{
						layer.msg("请输入以1开头的11位手机号",{icon:2});
					}else if(rolename == 0)
					{
						layer.msg("角色名称不能为空",{icon:2});
					}
					else{
						$.ajax({
							url: path + '/admin/addAdminInfos',
							async: true,
							type: 'post',
							data: {"adminname":adminname2,"adminphone":adminphone2,"adminsex":adminsex2,"rolename":rolename,"adminpwd":adminpwd2},
							datatype: 'text',
							success: function (data) {
								if (data == "success") {
									layer.alert("新增成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									layer.close(index);
									tableIns.reload();
								} else {
									layer.alert("新增失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
								}
							}, error: function (data) {
								layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
							}
						});
					}
				},
				btn2:function(index){
					$('#adminname2').val("");
					$('#adminphone2').val("");
					$('#adminpwd2').val("");
					$('#rolename').val("请选择");
					layer.close(index);
				}
			});
		});

		$(function(){
			$("#adminname2").blur(function () {
				var reg = /^[A-Za-z0-9]+$/;
				var adminname = $('#adminname2').val();
				if(!$('#adminname2').val().match(reg)||adminname == 0)
				{
					layer.msg("请输如字母与数字组成的字符", {icon: 2});
				}else{
					$.ajax({
						url: path + '/admin/checkAdminName',
						async: true,
						type: 'post',
						data: {"adminname": adminname},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.msg("账号可用",{icon:6})
							} else {
								layer.msg("账号已存在,不可用",{icon:2});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});
				}
			});
		});

		//搜索功能的实现
		$('.adminTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('adminTable', {
					where: {
						adminname: $('#adminname').val(),
						time1: $('#time1').val(),
						time2: $('#time2').val(),
						adminstatus: $('#sel').val(),
						rolename: $('#rolename3 option:selected').val()
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
