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
			text-align: center;
		}

		.layui-table-cell {
			height: 40px;
			line-height: 40px;
		}
		#sel{
			width: 62%;
		}
	</style>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
	<h2>参数配置</h2>
	<hr style="color: whitesmoke">
	<div class="layui-row" >
	<form class="layui-form" action="" onsubmit="return false;" >
		<div class="parameterTable">
			<div class="layui-form-item" style="margin-left: 3%">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: 11%">参数名称：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="parameterName" id="parameterName" placeholder="请输入参数名称" style="margin: -20% 0 0 75%;">
					</div>
				</div>

				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: -1%">参数类型：</span>
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
				</div>
				<button class="layui-btn" data-type="reload" style=""><i class="layui-icon">&#xe615;查询</i></button>
				<button class="layui-btn btn-add " id="btn-add" ><i class="layui-icon">&#xe624;新增</i></button>
			</div>
		</div>
	</form>
	</div>
	<table id="parameter" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">参数名称：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入参数名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<span class="layui-form-label" style="">参数类型：</span>
				<div class="layui-input-inline">
					<select name="selType" id="selType" lay-filter="mySelect" lay-verify="" style="margin: 2% 0 0 0;width: 98%;height: 18%">
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
			<label class="layui-form-label">参数值：</label>
			<div class="layui-inline">
				<input type="text" id="val" name = "val" placeholder="请输入参数值" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">参数名称：</label>
			<div class="layui-inline">
				<input type="text" id="name2" name = "name2" placeholder="请输入参数名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<span class="layui-form-label" style="">参数类型：</span>
				<div class="layui-input-inline">
					<select name="selType2" id="selType2" lay-filter="mySelect" lay-verify="" style="margin: 2% 0 0 0;height: 18%;width: 98%">
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
			<label class="layui-form-label">参数值：</label>
			<div class="layui-inline">
				<input type="text" id="val2" name = "val2" placeholder="请输入参数值" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn " lay-event="update" >修改</button>
		<button type="button" class="layui-btn " lay-event="delete" >删除</button>
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
			, height: 350
			, url: path + "/admin/parameterMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'parameterid', title: '序号', align: 'center', width: 122, sort: true, fixed: 'left'}
				, {field: 'parametername', title: '参数名称', align: 'center', width: 160}
				, {field: 'parametertype', title: '参数类型', align: 'center', width: 200}
				, {field: 'parameterval', title: '参数值', align: 'center', width: 300}
				, {fixed: 'right', title: '操作', align: 'center', width: 360, toolbar: '#barOption'}
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
						area: ['30%', '60%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: '修改参数信息',
						btn: ['保存', '取消'],
						offset: '100px',
						btnAlign: 'c',
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
											layer.alert("修改参数信息成功！", {icon: 6});
											tableIns.reload();
										}else{
											layer.alert("修改参数信失败！", {icon: 2});
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
					layer.confirm("确定要删除该参数信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteParameter",
							type: "post",
							data: {"parameterid": data.parameterid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("参数信息删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("参数信息删除失败！", {icon: 2});
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
				area: ['30%', '60%'],
				content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
				title: '新增参数',
				btn: ['保存', '取消'],
				offset: '100px',
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
				// var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
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
