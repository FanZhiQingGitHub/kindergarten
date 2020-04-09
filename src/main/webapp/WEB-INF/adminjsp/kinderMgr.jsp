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
	<script type="text/html" id="barOption">
		{{#  if(d.kindercode == '启用'){ }}
		<a  class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden" style="width: 15%;height: 75%">禁用</a>
		{{#  } }}
		{{#  if(d.kindercode == '禁用'){ }}
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open" style="width: 15%;height: 75%">启用</a>
		{{#  } }}
		<a type="button" class="layui-btn layui-btn-xs" lay-event="restpwd" style="width: 25%;height: 75%">重置密码</a>
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
					var tr = obj.tr; //获得当前行 tr 的DOM对象
					if (layEvent === 'restpwd') { //审核通过
						layer.prompt({
								formType: 0,
								id: "remarksPrompt",
								title: '资质审核-温馨提示(0:未审核,1:通过,2：未通过)',
								success: function (layero, index) {
								}
							},
							// function () {
							// 	$("#remarksPrompt").blur(function () {
							// 		var reg = /^[1-2]*$/;
							// 		if (!($('#remarksPrompt').val().match(reg))) {
							// 			layer.msg("请输入数字(1或2)！", {icon: 2, title: '温馨提示'})
							// 		} else {
							// 			layer.msg("输入合法", {icon: 5, title: '温馨提示'})
							// 		}
							// 	});
							// },
							function (value, index, elem) {
								layer.close(index);
								var reg = /^[1-2]*$/;
								//向服务端发送审核通过指令
								if (value == 0) {
									layer.msg("请输入数字(1或2)！", {icon: 2, title: '温馨提示'})
								} else if (value == 1 || value == 2) {
									$.ajax({
										url: path + "/admin/checkQualify",
										type: "post",
										data: {"kinderid": data.kinderid, "kinderstatus": value},
										dataType: "text",
										success: function (result) {
											if (result == "success") {
												layer.alert('审核通过！');
											} else if (result == "codeerror") {
												layer.alert('状态码输入异常！');
											} else {
												layer.alert('审核失败！');
											}
											tableIns.reload();    //审核之后,刷新表格
										}
									});
								} else {
									layer.msg("请输入数字(1或2)！", {icon: 2, title: '温馨提示'});
								}
							});
					}
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
							// var oldadminpwd = $("#oldadminpwd").val();
							// var adminpwd = $("#adminpwd").val();
							// var confrimAdminpwd = $("#confrimAdminpwd").val();
							//
							// if (oldadminpwd.length == 0) {
							// 	layer.alert("请输入旧密码", {icon: 2});
							// } else if (adminpwd.length < 6) {
							// 	layer.alert("新密码长度低于6位", {icon: 2});
							// } else if (adminpwd.length > 12) {
							// 	layer.alert("新密码长度大于12位", {icon: 2});
							// } else if (adminpwd.length == 0) {
							// 	layer.alert("新密码不能为空", {icon: 2});
							// } else if (confrimAdminpwd.length == 0) {
							// 	layer.alert("请确认密码", {icon: 2});
							// } else if (adminpwd != confrimAdminpwd) {
							// 	layer.alert("密码输入不一致", {icon: 2});
							// } else {
							// 	$.ajax({
							// 		url: path + '/admin/updateAdminpwd',
							// 		async: true,
							// 		type: 'post',
							// 		data: {
							// 			"adminid": $("#adminid").val(),
							// 			"oldadminpwd": oldadminpwd,
							// 			"adminpwd": adminpwd,
							// 			"confrimAdminpwd": confrimAdminpwd
							// 		},
							// 		datatype: 'text',
							// 		success: function (data) {
							// 			if (data == "error") {
							// 				layer.alert("修改失败！", {icon: 2});
							// 			} else if (data == "pwderror") {
							// 				layer.alert("旧密码输入错误", {icon: 2});
							// 			} else {
							// 				layer.alert("修改成功", {icon: 6});
							// 				layer.close(index);
							// 			}
							// 		}, error: function (data) {
							// 			layer.alert("网络繁忙！", {icon: 2});
							// 		}
							// 	});
							// }
						},
					});
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
