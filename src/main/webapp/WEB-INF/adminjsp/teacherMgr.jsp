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
	<title>智慧幼儿园平台端-教师管理</title>
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
	<h2>教师管理</h2>
	<div class="layui-row" >
	<form class="layui-form" action="" onsubmit="return false;" >
		<div class="teacherTable">
			<div class="layui-form-item" style="margin-left: 3%">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline">
					<span class="layui-form-label">入职时间：</span>
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
					<span class="layui-form-label" style="margin-left: 11%">教师名称：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="teacherName" id="teacherName" placeholder="请输入教师名称" style="margin: -20% 0 0 75%;">
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
					<span class="layui-form-label" style="margin-left: -25%;">职位：</span>
					<div class="layui-inline">
						<select name="teacherJob" id="teacherJob" lay-filter="selectName" lay-verify="" >
							<option value="请选择">请选择</option>
							<c:if test="${not empty teacherNewList}">
								<c:forEach items="${teacherNewList}" var="u">
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
	<table id="teacher" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">教师名称：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入教师名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">住址：</label>
			<div class="layui-inline">
				<input type="text" id="teacherAdd" name = "teacherAdd" placeholder="请输入教师住址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号：</label>
			<div class="layui-inline">
				<input type="text" id="phone" name = "phone" placeholder="请输入教师手机号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">职位：</label>
			<div class="layui-inline">
				<input type="text" id="job" name = "job" placeholder="请输入教师职位" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">教师名称：</label>
			<div class="layui-inline">
				<input type="text" id="name2" name = "name2" placeholder="请输入教师名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">住址：</label>
			<div class="layui-inline">
				<input type="text" id="teacherAdd2" name = "teacherAdd2" placeholder="请输入教师住址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号：</label>
			<div class="layui-inline">
				<input type="text" id="phone2" name = "phone2" placeholder="请输入教师手机号" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">职位：</label>
			<div class="layui-inline">
				<input type="text" id="job2" name = "job2" placeholder="请输入教师职位" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		{{#  if(d.teacherstatus == '启用'){ }}
		<button type="button" class="layui-btn layui-btn-danger" lay-event="forbidden" >禁用</button>
		{{#  } }}
		{{#  if(d.teacherstatus == '禁用'){ }}
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
			elem: '#teacher'
			, height: 350
			, url: path + "/admin/teacherMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'teacherid', title: '教师编号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'teachername', title: '教师名称', align: 'center', width: 90}
				, {field: 'teacheradd', title: '住址', align: 'center', width: 160}
				, {field: 'teacherphone', title: '手机号', align: 'center', width: 120}
				, {field: 'teacherjob', title: '职位', align: 'center', width: 80}
				, {
					field: 'teacherregtime', title: '入职时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.teacherregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'classname', title: '班级', align: 'center', width: 120}
				, {field: 'teacherstatus', title: '状态', align: 'center', width: 60}
				, {fixed: 'right', title: '操作', align: 'center', width: 360, toolbar: '#barOption'}
			]]
			, id: 'teacherTable'
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
					layer.confirm("确定禁用教师账号？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/forbiddenTeacher",
							type: "post",
							data: {"teacherid": data.teacherid},
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
					layer.confirm("确定启用教师账号？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/openTeacher",
							type: "post",
							data: {"teacherid": data.teacherid},
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
							url: path + "/admin/restTeacherPwd",
							type: "post",
							data: {"teacherid": data.teacherid},
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
							title: '修改教师信息',
							btn: ['保存', '取消'],
							offset: '100px',
							btnAlign: 'c',
							success:function(){
								$("#name").val(data.teachername);
								$("#teacherAdd").val(data.teacheradd);
								$("#phone").val(data.teacherphone);
								$("#job").val(data.teacherjob);
							},
							btn1: function (index) {
								var name = $("#name").val();
								var add = $("#teacherAdd").val();
								var phone = $("#phone").val();
								var job = $("#job").val();
								if (name.length == 0) {
									layer.alert("请输入教师名称", {icon: 2});
								}  else {
									$.ajax({
										url: path + "/admin/updateTeacher",
										type: "post",
										data: {"teacherid": data.teacherid,"teachername":name,"teacheradd":add,"teacherphone":phone,"teacherjob":job},
										dataType: "text",
										success: function (result) {
											if(result == "success")
											{
												layer.close(index);
												layer.alert("修改教师信息成功！", {icon: 6});
												tableIns.reload();
											}else{
												layer.alert("修改教师信失败！", {icon: 2});
											}
										}
									});
								}
							},
						});
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该教师信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteTeacher",
							type: "post",
							data: {"teacherid": data.teacherid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("教师信息删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("教师信息删除失败！", {icon: 2});
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
				title: '新增教师',
				btn: ['保存', '取消'],
				offset: '100px',
				btnAlign: 'c',
				btn1: function (index) {
					var name = $("#name2").val();
					var add = $("#rectorAdd2").val();
					var phone = $("#phone2").val();
					var job = $("#job2").val();
					if (name.length == 0) {
						layer.alert("请输入教师名称", {icon: 2});
					}  else {
						$.ajax({
							url: path + '/admin/addTeacher',
							async: true,
							type: 'post',
							data: {
								"teachername": name,
								"teacheradd": add,
								"teacherphone":phone,
								"teacherjob":job},
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
			$("#teacherAdd").blur(function () {
				var add = $("#teacherAdd").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#teacherAdd').val().match(reg)||add == 0)
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
			$("#teacherAdd2").blur(function () {
				var add = $("#teacherAdd2").val();
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				if(!$('#teacherAdd2').val().match(reg)||add == 0)
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
			})
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
		$('.teacherTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('teacherTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
						, teacherstatus: $('#sel').val()
						, teachername: $('#teacherName').val()
						, teacherjob: $('#teacherJob').val()
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
