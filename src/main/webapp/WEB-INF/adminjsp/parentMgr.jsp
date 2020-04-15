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
	<title>智慧幼儿园平台端-家长管理</title>
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
	<h2>家长管理</h2>
	<div class="layui-row" >
	<form class="layui-form" action="" onsubmit="return false;" >
		<div class="parentTable">
			<div class="layui-form-item" style="margin-left: 3%">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline">
					<span class="layui-form-label">注册时间：</span>
					<div class="layui-input-inline">
						<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" style="width: 100%;margin-top: 2% ">
					</div>
				</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: -24%">至</span>
					<div class="layui-input-inline">
						<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="width: 100%;margin: 2% 0 0 8%">
					</div>
				</div>
				<button class="layui-btn" data-type="reload" style="margin-left: -2%"><i class="layui-icon">&#xe615;查询</i></button>
				<button class="layui-btn btn-add  layui-btn-disabled" id="btn-add" ><i class="layui-icon">&#xe624;新增</i></button>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: 11%">家长名称：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="parentName" id="parentName" placeholder="请输入家长名称" style="margin: -20% 0 0 75%;">
					</div>
				</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: -8%">状态：</span>
					<div class="layui-input-inline">
						<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" style="margin: -15% 0 0 50%">
							<option value="请选择">请选择</option>
							<option value="禁用">禁用</option>
							<option value="启用">启用</option>
						</select>
					</div>
				</div>
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: -25%;">职业：</span>
					<div class="layui-inline">
						<select name="parentJob" id="parentJob" lay-filter="selectName" lay-verify="" >
							<option value="请选择">请选择</option>
							<c:if test="${not empty parentNewList}">
								<c:forEach items="${parentNewList}" var="u">
									<option value="${u}">${u}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	</div>
	<table id="parent" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">家长名称：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入教师名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">住址：</label>
			<div class="layui-inline">
				<input type="text" id="parentAdd" name = "parentAdd" placeholder="请输入家长住址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号：</label>
			<div class="layui-inline">
				<input type="text" id="phone" name = "phone" placeholder="请输入家长手机号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">职业：</label>
			<div class="layui-inline">
				<input type="text" id="job" name = "job" placeholder="请输入家长职业" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">家长名称：</label>
			<div class="layui-inline">
				<input type="text" id="name2" name = "name2" placeholder="请输入家长名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">住址：</label>
			<div class="layui-inline">
				<input type="text" id="teacherAdd2" name = "teacherAdd2" placeholder="请输入家长住址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号：</label>
			<div class="layui-inline">
				<input type="text" id="phone2" name = "phone2" placeholder="请输入家长手机号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">职业：</label>
			<div class="layui-inline">
				<input type="text" id="job2" name = "job2" placeholder="请输入家长职业" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		{{#  if(d.parentStatus == '启用'){ }}
		<button type="button" class="layui-btn layui-btn-danger" lay-event="forbidden" >禁用</button>
		{{#  } }}
		{{#  if(d.parentStatus == '禁用'){ }}
		<button type="button" class="layui-btn layui-btn-danger" lay-event="open" >启用</button>
		{{#  } }}
		<button type="button" class="layui-btn " lay-event="restPwd" >重置密码</button>
		<button type="button" class="layui-btn " lay-event="update" >修改</button>
		<button type="button" class="layui-btn " lay-event="delete" >删除</button>
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
			elem: '#parent'
			, height: 350
			, url: path + "/admin/parentMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'parentId', title: '家长编号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'parentName', title: '家长名称', align: 'center', width: 90}
				, {field: 'parentAdd', title: '住址', align: 'center', width: 160}
				, {field: 'parentPhone', title: '手机号', align: 'center', width: 120}
				, {field: 'parentJob', title: '职业', align: 'center', width: 80}
				, {
					field: 'parentRegTime', title: '注册时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.parentRegTime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'parentSon', title: '亲子关系', align: 'center', width: 120}
				, {field: 'parentStatus', title: '状态', align: 'center', width: 60}
				, {fixed: 'right', title: '操作', align: 'center', width: 360, toolbar: '#barOption'}
			]]
			, id: 'parentTable'
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
					layer.confirm("确定禁用家长账号？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/forbiddenParent",
							type: "post",
							data: {"parentId": data.parentId},
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
					layer.confirm("确定启用家长账号？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/openParent",
							type: "post",
							data: {"parentId": data.parentId},
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
							url: path + "/admin/restParentPwd",
							type: "post",
							data: {"parentId": data.parentId},
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
							area: ['30%', '60%'],
							content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
							title: '修改家长信息',
							btn: ['保存', '取消'],
							offset: '100px',
							btnAlign: 'c',
							success:function(){
								$("#name").val(data.parentname);
								$("#parentAdd").val(data.parentadd);
								$("#phone").val(data.parentphone);
								$("#job").val(data.parentjob);
							},
							btn1: function (index) {
								var name = $("#name").val();
								var add = $("#parentAdd").val();
								var phone = $("#phone").val();
								var job = $("#job").val();
								if (name.length == 0) {
									layer.alert("请输入家长名称", {icon: 2});
								}  else {
									$.ajax({
										url: path + "/admin/updateParent",
										type: "post",
										data: {"parentId": data.parentId,"parentName":name,"parentAdd":add,"parentPhone":phone,"parentJob":job},
										dataType: "text",
										success: function (result) {
											if(result == "success")
											{
												layer.close(index);
												layer.alert("修改家长信息成功！", {icon: 6});
												tableIns.reload();
											}else{
												layer.alert("修改家长信失败！", {icon: 2});
											}
										}
									});
								}
							},
						});
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该家长信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteParent",
							type: "post",
							data: {"parentId": data.parentId},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("家长信息删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("家长信息删除失败！", {icon: 2});
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
				title: '新增家长',
				btn: ['保存', '取消'],
				offset: '100px',
				btnAlign: 'c',
				btn1: function (index) {
					var name = $("#name2").val();
					var add = $("#parentAdd2").val();
					var phone = $("#phone2").val();
					var job = $("#job2").val();
					if (name.length == 0) {
						layer.alert("请输入家长名称", {icon: 2});
					}  else {
						$.ajax({
							url: path + '/admin/addParent',
							async: true,
							type: 'post',
							data: {
								"parentName": name,
								"parentAdd": add,
								"parentPhone":phone,
								"parentJob":job},
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
			$("#parentAdd").blur(function () {
				var add = $("#parentAdd").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#parentAdd').val().match(reg)||add == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
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
			$("#job").blur(function () {
				var job = $("#job").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#job').val().match(reg)||job == 0)
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
			$("#parentAdd2").blur(function () {
				var add = $("#parentAdd2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#parentAdd2').val().match(reg)||add == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#phone2").blur(function () {
				var phone = $("#phone2").val();
				var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
				if(!$('#phone2').val().match(reg)||phone == 0)
				{
					layer.msg("请输入以1开头的11位手机号", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});
			$("#job2").blur(function () {
				var job = $("#job2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#job2').val().match(reg)||job == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法",{icon:6});
				}
			});

		});

		//搜索功能的实现
		$('.parentTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('parentTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
						, parentStatus: $('#sel').val()
						, parentName: $('#parentName').val()
						, parentJob: $('#parentJob').val()
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
