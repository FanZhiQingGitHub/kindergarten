<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-园所管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2{
			text-align: center;
			margin-top: 1%;
		}
		#selName{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
		#selNames{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >园 所 管 理</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="kinderTable">
				<div class="layui-form-item">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label">申请时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" style="width: 82%;margin-top: 2% ">
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin-left: -28%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="width: 82%;margin: 2% 0 0 30%">
						</div>
					</div>
					<div class="layui-inline" >
						<span class="layui-form-label" style="margin-left: -20%">状态：</span>
						<div class="layui-input-inline">
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >
								<option value="请选择">请选择</option>
								<option value="禁用">禁用</option>
								<option value="启用">启用</option>
							</select>
						</div>
					</div>
					<button class="layui-btn" data-type="reload" ><i class="layui-icon">&#xe615;查询</i></button>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<span class="layui-form-label">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" style="width: 82%;margin-top: 3% ">
						</div>
					</div>
					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-left: 56.5%"><i class="layui-icon">&#xe624;新增</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="kinder" lay-filter="test"></table>
	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">园所名称：</label>
			<div class="layui-inline">
				<select name="selName" id="selName" lay-filter="selectName" lay-verify="" >
					<option value="请选择">请选择</option>
					<c:if test="${not empty kinderList}">
						<c:forEach items="${kinderList}" var="u">
							<option value="${u.kindername}">${u.kindername}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">账号：</label>
			<div class="layui-inline">
				<input type="text" id="account" placeholder="请输入园所账号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">园所名称：</label>
			<div class="layui-inline">
				<select name="selNames" id="selNames" lay-filter="selectNames" lay-verify="" >
					<option value="请选择">请选择</option>
					<c:if test="${not empty kinderList}">
						<c:forEach items="${kinderList}" var="u">
							<option value="${u.kindername}">${u.kindername}</option>
						</c:forEach>
					</c:if>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">账号：</label>
			<div class="layui-inline">
				<input type="text" id="accounts" placeholder="请输入园所账号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label">法人：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<input type="text" id="kinderlp" placeholder="请输入法人名字" value=""--%>
<%--				       autocomplete="off" class="layui-input" style="width: 120%">--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label">法人身份证号：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<input type="text" id="kinderlpid" placeholder="请输入法人身份证号" value=""--%>
<%--				       autocomplete="off" class="layui-input" style="width: 120%">--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label">法人住址：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<input type="text" id="kinderlpadd" placeholder="请输入法人住址" value=""--%>
<%--				       autocomplete="off" class="layui-input" style="width: 120%">--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label">法人手机号：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<input type="text" id="kinderlpphone" placeholder="请输入法人手机号" value=""--%>
<%--				       autocomplete="off" class="layui-input" style="width: 120%">--%>
<%--			</div>--%>
<%--		</div>--%>
	</div>
	<script type="text/html" id="barOption">
		{{#  if(d.kindercode == '启用'){ }}
		<a  class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden" style="width: 15%;height: 75%">禁用</a>
		{{#  } }}
		{{#  if(d.kindercode == '禁用'){ }}
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open" style="width: 15%;height: 75%">启用</a>
		{{#  } }}
		<a type="button" class="layui-btn layui-btn-xs" lay-event="restPwd" style="width: 25%;height: 75%">重置密码</a>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="update" style="width: 15%;height: 75%">修改</a>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="delete" style="width: 15%;height: 75%">删除</a>
	</script>
</body>

	<script>
		layui.use(['form','element'],function () {
			var form = layui.form
				,element = layui.element;
			element.render();
			form.render();
		});
	</script>
	<script>
		layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
			var form = layui.form
				, layer = layui.layer
				, layedit = layui.layedit
				, laydate = layui.laydate
				, element = layui.element
				, tree = layui.tree
				,table = layui.table
				,$ = layui.jquery;
			var path = $("#path").val();
			var tableIns = table.render({
				elem: '#kinder'
				, height: 312
				, url: path + "/admin/qualifyAppInfo"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'kinderid', title: '序号', align: 'center', width: 120, sort: true, fixed: 'left'}
					, {field: 'kindername', title: '园所名称', align: 'center', width: 120}
					, {field: 'kinderapptime', title: '审批时间', align: 'center', width: 180
					   ,templet:"<div>{{layui.util.toDateString(d.kinderapptime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
					, {fixed: 'right', title: '操作', align: 'center', width: 400, toolbar: '#barOption'}
				]]
				, id: 'kinderTable'
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
						layer.confirm("确定禁用园所账号？",{icon:3,title:'温馨提示'},function (index) {
							layer.close(index);
							$.ajax({
								url: path + "/admin/forbiddenAccount",
								type: "post",
								data: {"kinderid": data.kinderid},
								dataType: "text",
								success: function (result) {
									if(result == "success")
									{
										layer.alert("禁用成功！", {icon: 6});
										tableIns.reload();
									}else{
										layer.alert("禁用失败！", {icon: 2});
									}
								}
							});
						});
						}else if(layEvent === 'open'){
							layer.confirm("确定启用园所账号？",{icon:3,title:'温馨提示'},function (index) {
								layer.close(index);
								$.ajax({
									url: path + "/admin/openAccount",
									type: "post",
									data: {"kinderid": data.kinderid},
									dataType: "text",
									success: function (result) {
										if(result == "success")
										{
											layer.alert("启用成功！", {icon: 6});
											tableIns.reload();
										}else{
											layer.alert("启用失败！", {icon: 2});
										}
									}
								});
							});
						}else if(layEvent === 'restPwd'){
							layer.confirm("确定要重置密码？",{icon:3,title:'温馨提示'},function (index) {
								layer.close(index);
								$.ajax({
									url: path + "/admin/restKinderPwd",
									type: "post",
									data: {"kinderid": data.kinderid},
									dataType: "text",
									success: function (result) {
										if(result == "success")
										{
											layer.alert("密码重置成功！", {icon: 6});
											tableIns.reload();
										}else{
											layer.alert("密码重置失败！", {icon: 2});
										}
									}
								});
							});
						}else if(layEvent === 'update'){
							layer.confirm("确定要修改？",{icon:3,title:'温馨提示'},function (index) {
								layer.close(index);
								layer.open({
									type: 1,
									area: ['30%', '40%'],
									content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
									title: '修改园所',
									btn: ['保存', '取消'],
									offset: '100px',
									btnAlign: 'c',
									btn1: function (index) {
										$("#selNames").find("option[value="+data.kinderid+"]").prop("selected",true);
										var kindername = $("#selNames").val();
										var kinderacount = $("#accounts").val();
										if (kinderacount.length == 0) {
											layer.alert("请输入园所账号", {icon: 2});
										}  else {
											$.ajax({
												url: path + "/admin/updateKinderInfo",
												type: "post",
												data: {"kinderid": data.kinderid,"kindername":kindername,"kinderacount":kinderacount},
												dataType: "text",
												success: function (result) {
													if(result == "success")
													{
														layer.close(index);
														layer.alert("修改园所信息成功！", {icon: 6});
														tableIns.reload();
													}else{
														layer.alert("修改园所信失败！", {icon: 2});
													}
												}
											});
										}
									},
								});
							});
						}else if(layEvent === 'delete'){
						layer.confirm("确定要删除该园所信息？",{icon:3,title:'温馨提示'},function (index) {
							layer.close(index);
							$.ajax({
								url: path + "/admin/deleteKinderInfo",
								type: "post",
								data: {"kinderid": data.kinderid},
								dataType: "text",
								success: function (result) {
									if(result == "success")
									{
										layer.alert("园所删除成功！", {icon: 6});
										tableIns.reload();
									}else{
										layer.alert("园所删除失败！", {icon: 2});
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
						area: ['30%', '40%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: '新增园所',
						btn: ['保存', '取消'],
						offset: '100px',
						btnAlign: 'c',
						btn1: function (index) {
							var kindername = $("#selName").val();
							var kinderacount = $("#account").val();
							if (kinderacount.length == 0) {
								layer.alert("请输入园所账号", {icon: 2});
							}  else {
								$.ajax({
									url: path + '/admin/addKinder',
									async: true,
									type: 'post',
									data: {
										"kindername": kindername,
										"kinderacount": kinderacount,},
									datatype: 'text',
									success: function (data) {
										if (data == "success") {
											layer.alert("新增成功！", {icon: 6});
											layer.close(index);
											tableIns.reload();
										} else {
											layer.alert("新增失败", {icon: 2});
										}
									}, error: function (data) {
										layer.alert("网络繁忙！", {icon: 2});
									}
								});
							}
						},
					});
				});

				$("#selName").change(function () {
					var kindername = $("#selName").val();
					$.ajax({
						url: path + "/admin/kinderAccount",
						type: "post",
						data: {"kindername": kindername},
						dataType: "text",
						success: function (result) {
							$("#account").val(result);
						}
					});
				});

			//搜索功能的实现
			$('.kinderTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});

			var $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('kinderTable', {
						where: {
							time1: $('#time1').val()
							,time2: $('#time2').val()
							,kindercode: $('#sel').val()
							,kindername: $('#kindername').val()
						}
						,page:{
							curr:1
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
