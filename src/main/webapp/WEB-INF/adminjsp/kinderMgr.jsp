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
		body{
			font-size: 140%;
		}
		h2{
			text-align: center;
			margin-top: 2%;
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
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >园 所 管 理</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="kinderTable">
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">申请时间：</span>
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
					<div class="layui-inline" >
						<span class="layui-form-label" style="margin-left: 35%">状态：</span>
						<div class="layui-input-inline" style="margin: -13% 75%;">
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >
								<option value="请选择">请选择</option>
								<option value="禁用">禁用</option>
								<option value="启用">启用</option>
							</select>
						</div>
					</div>
					<button class="layui-btn" data-type="reload" style="margin: -1.5% 14%;"><i class="layui-icon">&#xe615;查询</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" >
						</div>
					</div>
					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-left:50%"><i class="layui-icon">&#xe624;新增</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="kinder" lay-filter="test" class="layui-table-cell" style="margin-top: 2%"></table>
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
		<div class="layui-form-item" style="margin-top: 2%">
			<label class="layui-form-label" style="width: 30%">幼儿园名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="selNames" id="selNames" placeholder="请输入幼儿园名称" autocomplete="off"
				       class="layui-input" style="width: 160%">
			</div>
		</div>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label">园所名称：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<select name="selNames" id="selNames" lay-filter="selectNames" lay-verify="" >--%>
<%--					<option value="请选择">请选择</option>--%>
<%--					<c:if test="${not empty kinderList}">--%>
<%--						<c:forEach items="${kinderList}" var="u">--%>
<%--							<option value="${u.kindername}">${u.kindername}</option>--%>
<%--						</c:forEach>--%>
<%--					</c:if>--%>
<%--				</select>--%>
<%--			</div>--%>
<%--		</div>--%>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 30%">账号：</label>
			<div class="layui-inline">
				<input type="text" id="accounts" placeholder="请输入园所账号" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 30%">法人：</label>
			<div class="layui-inline">
				<input type="text" id="kinderlp" placeholder="请输入法人名字" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 30%">法人身份证号：</label>
			<div class="layui-inline">
				<input type="text" id="kinderlpid" placeholder="请输入法人身份证号" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 30%">法人住址：</label>
			<div class="layui-inline">
				<input type="text" id="kinderlpadd" placeholder="请输入法人住址" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 30%">法人手机号：</label>
			<div class="layui-inline">
				<input type="text" id="kinderlpphone" placeholder="请输入法人手机号" value=""
				       autocomplete="off" class="layui-input" >
			</div>
		</div>
	</div>
	<script type="text/html" id="barOption">
		{{#  if(d.kindercode == '启用'){ }}
		<a  class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden" style="height: 45px"><span class="sp">禁用</span></a>
		{{#  } }}
		{{#  if(d.kindercode == '禁用'){ }}
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open" style="height: 45px"><span class="sp">启用</span></a>
		{{#  } }}
		<a type="button" class="layui-btn layui-btn-xs" lay-event="restPwd" style="height: 45px"><span class="sp">重置密码</span></a>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="update" style="height: 45px"><span class="sp">修改</span></a>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="delete" style="height: 45px"><span class="sp">删除</span></a>
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
				, height: 450
				, url: path + "/admin/qualifyAppInfo"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'kinderid', title: '序号', align: 'center', width: 160, sort: true, fixed: 'left'}
					, {field: 'kindername', title: '园所名称', align: 'center', width: 340}
					, {field: 'rectorname', title: '园长名称', align: 'center', width: 180}
					, {field: 'kinderacount', title: '园所账号', align: 'center', width: 180}
					, {field: 'kindercode', title: '园所状态', align: 'center', width: 180}
					, {field: 'kinderapptime', title: '审批时间', align: 'center', width: 320
					   ,templet:"<div>{{layui.util.toDateString(d.kinderapptime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
					, {fixed: 'right', title: '操作', align: 'center', width: 360, toolbar: '#barOption'}
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
										layer.alert("禁用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
										tableIns.reload();
									}else{
										layer.alert("禁用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
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
											layer.alert("启用成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
											tableIns.reload();
										}else{
											layer.alert("启用失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
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
											layer.alert("密码重置成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
											tableIns.reload();
										}else{
											layer.alert("密码重置失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
										}
									}
								});
							});
						}else if(layEvent === 'update'){
								layer.open({
									type: 1,
									area: ['38%', '60%'],
									content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
									title: ['修改园所','font-size:18px'],
									btn: ['保存', '取消'],
									skin: 'demo-class',
									closeBtn:0,
									btnAlign: 'c',
									success:function(){
										$.ajax({
											url: path + "/admin/selectKinderInfo",
											type: "post",
											data: {"kinderid": data.kinderid},
											dataType: "json",
											success: function (result) {
												var kinderInfo = eval(result);
												for(i in kinderInfo)
												{
													$("#selNames").val(kinderInfo[i].kindername);
													$("#accounts").val(kinderInfo[i].kinderacount);
													$("#kinderlp").val(kinderInfo[i].kinderlp);
													$("#kinderlpid").val(kinderInfo[i].kinderlpid);
													$("#kinderlpadd").val(kinderInfo[i].kinderlpadd);
													$("#kinderlpphone").val(kinderInfo[i].kinderlpphone);
												}
											}
										});
									},
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
														layer.alert("修改园所信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
														tableIns.reload();
													}else{
														layer.alert("修改园所信息失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
													}
												}
											});
										}
									}
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
										layer.alert("园所删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
										tableIns.reload();
									}else{
										layer.alert("园所删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'});
									}
								}
							});
						});
					}
				});
			});


			$("#btn-add").click(function () {
				location.href = path+"/admin/toUrl/addKinder";
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
