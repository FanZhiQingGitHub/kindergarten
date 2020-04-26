<%@ page import="java.util.List" %><%--
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
	<title>智慧幼儿园平台端-参数配置</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2 {
			margin-top: 2%;
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
	<h2>参数配置</h2>
	<div class="layui-row" >
	<form class="layui-form" action="" onsubmit="return false;" >
		<div class="parameterTable">
			<div class="layui-form-item" style="margin-left: 6%">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline" style="margin-top: 2%">
					<span class="layui-form-label" style="width: auto;">参数名称：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="parameterName" id="parameterName" placeholder="请输入参数名称" >
					</div>
				</div>

				<div class="layui-inline" style="margin-top: 2%">
					<span class="layui-form-label" style="width: auto;margin-left: 5%">参数类型：</span>
					<div class="layui-input-inline">
						<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" style="margin: -15% 0 0 50%">
							<option value="请选择">请选择</option>
							<c:if test="${not empty parameterNewList}">
								<c:forEach items="${parameterNewList}" var="u">
									<option value="${u}">${u}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<button class="layui-btn" data-type="reload" style="margin: -7% 80%;"><span class="sp"><i class="layui-icon">&#xe615;查询</i></span></button>
					<button class="layui-btn btn-add " id="btn-add" style="margin: -7% 100%;"><span class="sp"><i class="layui-icon">&#xe624;新增</i></span></button>
				</div>

			</div>
		</div>
	</form>
	</div>
	<table id="parameter" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item" style="margin-top: 5%">
			<label class="layui-form-label" style="width: auto">参数名称：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入参数名称" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<span class="layui-form-label" style="width: auto">参数类型：</span>
				<div class="layui-input-inline" style="margin: -11% 43%">
					<select name="selType" id="selType" lay-filter="mySelect" lay-verify="" style="width: 160%;height: 17%;">
						<option value="请选择">请选择</option>
						<c:if test="${not empty parameterNewList}">
							<c:forEach items="${parameterNewList}" var="u">
								<option value="${u}">${u}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 4.5%">参数值：</label>
			<div class="layui-inline">
				<input type="text" id="val" name = "val" placeholder="请输入参数值" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item" style="margin-top: 5%">
			<label class="layui-form-label" style="width: auto">参数名称：</label>
			<div class="layui-inline">
				<input type="text" id="name2" name = "name2" placeholder="请输入参数名称" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<span class="layui-form-label" style="width: auto">参数类型：</span>
				<div class="layui-input-inline" style="margin: -11% 43%">
					<select name="selType2" id="selType2" lay-filter="mySelect" lay-verify="" style="width: 160%;height: 17%;">
						<option value="请选择">请选择</option>
						<c:if test="${not empty parameterNewList}">
							<c:forEach items="${parameterNewList}" var="u">
								<option value="${u}">${u}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 4.5%">参数值：</label>
			<div class="layui-inline">
				<input type="text" id="val2" name = "val2" placeholder="请输入参数值" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn " lay-event="update" ><span class="sp">修改</span></button>
		<button type="button" class="layui-btn " lay-event="delete" ><span class="sp">删除</span></button>
	</script>
</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form;
		form.render();
	})
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
			elem: '#parameter'
			, height: 450
			, url: path + "/admin/parameterMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'parameterid', title: '序号', align: 'center', width: 180, sort: true, fixed: 'left'}
				, {field: 'parametername', title: '参数名称', align: 'center', width: 307}
				, {field: 'parametertype', title: '参数类型', align: 'center', width: 240}
				, {field: 'parameterval', title: '参数值', align: 'center', width: 529}
				, {fixed: 'right', title: '操作', align: 'center', width: 466, toolbar: '#barOption'}
			]]
			, id: 'parameterTable'
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
				if(layEvent === 'update'){
					layer.open({
						type: 1,
						area: ['30%', '45%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改参数信息','font-size:18px'],
						btn: ['保存', '取消'],
						skin: 'demo-class',
						btnAlign: 'c',
						closeBtn: 0,
						success:function(){
							$("#name").val(data.parametername);
							$("#type").val(data.parametertype);
							$("#val").val(data.parameterval);
						},
						btn1: function (index) {
							var name = $("#name").val();
							var type = $("#type").val();
							var val = $("#val").val();
							if (name.length == 0) {
								layer.alert("请输入参数名称", {icon: 2});
							}  else {
								$.ajax({
									url: path + "/admin/updateParameter",
									type: "post",
									data: {"parameterid": data.parameterid,"parametername":name,"parametertype":type,"parameterval":val},
									dataType: "text",
									success: function (result) {
										if(result == "success")
										{
											layer.close(index);
											layer.alert("修改参数信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
											tableIns.reload();
										}else{
											layer.alert("修改参数信失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										}
									}
								});
							}
						},
						btn2:function () {
							$("#name").val("");
							$("#type").val("");
							$("#val").val("");
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该参数信息？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteParameter",
							type: "post",
							data: {"parameterid": data.parameterid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("参数信息删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("参数信息删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
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
				area: ['30%', '45%'],
				content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
				title: ['新增参数','font-size:18px'],
				btn: ['保存', '取消'],
				skin: 'demo-class',
				closeBtn: 0,
				btnAlign: 'c',
				btn1: function (index) {
					var name = $("#name2").val();
					var type = $("#selType2").val();
					var val = $("#val2").val();
					if (name.length == 0) {
						layer.alert("请输入参数名称", {icon: 2});
					}  else {
						$.ajax({
							url: path + '/admin/addParameter',
							async: true,
							type: 'post',
							data: {
								"parametername": name,
								"parametertype": type,
								"parameterval": val},
							datatype: 'text',
							success: function (data) {
								if (data == "success") {
									layer.alert("新增成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									layer.close(index);
									tableIns.reload();
								} else {
									layer.alert("新增失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}, error: function (data) {
								layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						});
					}
				},
				btn2:function () {
					$("#name2").val("");
					$("#selType2").val("");
					$("#val2").val("");
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
			$("#selType").blur(function () {
				var type = $("#selType").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#selType').val().match(reg)||type == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#val").blur(function () {
				var val = $("#val2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#val').val().match(reg)|| val == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#name2").blur(function () {
				var name = $("#name2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#name2').val().match(reg)||name == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#selType2").blur(function () {
				var type = $("#selType2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#selType2').val().match(reg)||type == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#val2").blur(function () {
				var val = $("#val2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#val2').val().match(reg)||val == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			})

		});

		//搜索功能的实现
		$('.parameterTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('parameterTable', {
					where: {
						parametertype: $('#sel').val()
						, parametername: $('#parameterName').val()
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
