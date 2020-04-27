<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-13
  Time: 23:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-安防员管理</title>
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
	<h2>安防员管理</h2>
	<hr style="color: white">
	<div class="layui-row" >
	<form class="layui-form" action="" onsubmit="return false;" >
		<div class="securityTable">
			<div class="layui-form-item" style="margin-left: 6%">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="width: auto">注册时间：</span>
					<div class="layui-input-inline">
						<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" >
					</div>
				</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="margin: 5% 15%;width: 10%">至</span>
					<div class="layui-input-inline">
						<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="margin: -27% 65%;">
					</div>
				</div>
				<button class="layui-btn" data-type="reload" style="margin-left: 12%"><span class="sp"><i class="layui-icon">&#xe615;查询</i></span></button>
			</div>
			<div class="layui-form-item" style="margin-left: 8.5%">
				<div class="layui-inline">
					<span class="layui-form-label" style="width: auto">姓名：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="securityName" id="securityName" placeholder="请输入安防员名字" >
					</div>
				</div>
				<div class="layui-inline" style="margin-left: 2%">
					<span class="layui-form-label" style="width: auto;">状态：</span>
					<div class="layui-input-inline">
						<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" style="margin: -15% 0 0 50%">
							<option value="请选择">请选择</option>
							<option value="禁用">禁用</option>
							<option value="启用">启用</option>
						</select>
					</div>
				</div>
				<div class="layui-inline" style="margin-left: 2%">
					<span class="layui-form-label" style="width: auto;">园所名称：</span>
					<div class="layui-inline" style="width: 45%">
						<select name="kindername" id="kindername" lay-filter="mySelect" lay-verify="" >
							<option value="请选择" selected>请选择</option>
							<c:if test="${not empty kinderList}">
								<c:forEach items="${kinderList}" var="u">
									<option value="${u.kindername}">${u.kindername}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	</div>
	<table id="security" lay-filter="test" class="layui-table-cell" style="margin-top: 2%"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item" style="margin-top: 3%">
			<label class="layui-form-label" style="width: 24%">姓名：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入安全员名称" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 24%">住址：</label>
			<div class="layui-inline">
				<input type="text" id="securityAdd" name = "securityAdd" placeholder="请输入安防员住址" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 24%">手机号：</label>
			<div class="layui-inline">
				<input type="text" id="phone" name = "phone" placeholder="请输入安防员手机号" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
	</div>


	<script type="text/html" id="barOption">
		{{#  if(d.securitystatus == '启用'){ }}
		<button type="button" class="layui-btn layui-btn-danger" lay-event="forbidden" ><span class="sp">禁用</span></button>
		{{#  } }}
		{{#  if(d.securitystatus == '禁用'){ }}
		<button type="button" class="layui-btn layui-btn-danger" lay-event="open" ><span class="sp">启用</span></button>
		{{#  } }}
		<button type="button" class="layui-btn " lay-event="restPwd" ><span class="sp">重置密码</span></button>
		<button type="button" class="layui-btn " lay-event="update" ><span class="sp">修改</span></button>
		<button type="button" class="layui-btn " lay-event="delete" ><span class="sp">删除</span></button>
	</script>
</body>
<script>
	layui.use(['form', 'tree', 'table'], function () {
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
			elem: '#security'
			, height: 450
			, url: path + "/admin/securityMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'securityid', title: '编号', align: 'center', width: 97, sort: true, fixed: 'left'}
				, {field: 'securityname', title: '姓名', align: 'center', width: 131}
				, {field: 'securityadd', title: '住址', align: 'center', width: 303}
				, {field: 'securityphone', title: '手机号', align: 'center', width: 174}
				, {
					field: 'securityregtime', title: '注册时间', align: 'center', width: 243
					, templet: "<div>{{layui.util.toDateString(d.securityregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'kindername', title: '所在园所', align: 'center', width: 192
				,templet:function (d) {
					return d.kindername == null ? '无': d.kindername
				}}
				, {field: 'securitystatus', title: '状态', align: 'center', width: 100}
				, {fixed: 'right', title: '操作', align: 'center', width: 454, toolbar: '#barOption'}
			]]
			, id: 'securityTable'
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
				if (layEvent === 'forbidden') {
					layer.confirm("确定禁用安防员账号？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/forbiddenSecurity",
							type: "post",
							data: {"securityid": data.securityid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("禁用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("禁用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}else if(layEvent === 'open'){
					layer.confirm("确定启用安防员账号？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/openSecurity",
							type: "post",
							data: {"securityid": data.securityid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("启用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("启用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}else if(layEvent === 'restPwd'){
					layer.confirm("确定要重置密码？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/restSecurityPwd",
							type: "post",
							data: {"securityid": data.securityid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("密码重置成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("密码重置失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}else if(layEvent === 'update'){
					layer.open({
						type: 1,
						area: ['30%', '45%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改安防员信息','font-size:18px'],
						btn: ['保存', '取消'],
						skin: 'demo-class',
						closeBtn: 0,
						btnAlign: 'c',
						success:function(){
							$("#name").val(data.securityname);
							$("#securityAdd").val(data.securityadd);
							$("#phone").val(data.securityphone);
						},
						btn1: function (index) {
							var name = $("#name").val();
							var add = $("#securityAdd").val();
							var phone = $("#phone").val();
							if (name.length == 0) {
								layer.alert("安防员名字不能为空", {icon: 2});
							}
							else if(!name.match(/^[\u4e00-\u9fa5]{2,20}$/)){
								layer.msg("请输入至少2位中文字符", {icon: 2});
							}
							else if(add == 0){
								layer.msg("住址不能为空", {icon: 2});
							}
							else if(!add.match(/^([\u4E00-\u9FA5A-Za-z0-9_]+(省|市|区|县|道|路|街|号)){2,}$/)){
								layer.msg("输入地址格式如：福建省厦门市仓山区", {icon: 2});
							}
							else if(phone == 0){
								layer.msg("住址不能为空", {icon: 2});
							}
							else if(!phone.match(/^1(3|4|5|6|7|8|9)\d{9}$/)){
								layer.msg("请输入以1开头的11位手机号", {icon: 2});
							}
							else {
								$.ajax({
									url: path + "/admin/updateSecurity",
									type: "post",
									data: {"securityid": data.securityid,"securityname":name,"securityadd":add,"securityphone":phone},
									dataType: "text",
									success: function (result) {
										if(result == "success")
										{
											layer.close(index);
											layer.alert("修改安防员信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
											tableIns.reload();
										}else{
											layer.alert("修改安防员信失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										}
									}
								});
							}
						},
						btn2: function (index) {
							$("#name").val("");
							$("#securityAdd").val("");
							$("#phone").val("");
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该安防员信息？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteSecurity",
							type: "post",
							data: {"securityid": data.securityid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("安防员信息删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("安防员信息删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}
			});
		});

		$(function () {
			$("#name").blur(function () {
				var name = $("#name").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#name').val().match(reg)||name == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#securityAdd").blur(function () {
				var add = $("#securityadd").val();
				var reg = /^([\u4E00-\u9FA5A-Za-z0-9_]+(省|市|区|县|道|路|街|号)){2,}$/;
				if(!$('#securityAdd').val().match(reg)||add == 0)
				{
					layer.msg("输入地址格式如：福建省厦门市仓山区", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#phone").blur(function () {
				var phone = $("#phone").val();
				var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
				if(!$('#phone').val().match(reg)||phone == 0)
				{
					layer.msg("请输入以1开头的11位手机号", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
		});

		//搜索功能的实现
		$('.securityTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('securityTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
						, securitystatus: $('#sel').val()
						, securityname: $('#securityName').val()
						, kindername: $('#kindername option:selected').val()
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
