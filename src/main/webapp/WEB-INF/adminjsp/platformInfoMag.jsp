<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-平台资讯管理</title>
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
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2>平台资讯</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="platformTable">
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">创建时间：</span>
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
					<button class="layui-btn" data-type="reload" style="margin-left: 10%"><i class="layui-icon">&#xe615;查询</i></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" ><i class="layui-icon">&#xe624;新增</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">咨询名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="platformInfoName" id="platformInfoName" placeholder="请输入咨询名称" >
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table id="platform" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto">资讯名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="platformInfoName2" id="platformInfoName2" value="" placeholder="" style="width: 180%;margin-top: 1%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto">资讯内容：</label>
				<div class="layui-input-inline">
					<textarea type="text" id="platformInfoDetail2" name="platformInfoDetail2" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 240%;height: 70%"></textarea>
				</div>
			</div>
		</form>
	</div>

	<div id="type-content2" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto">资讯名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="platformInfoName3" id="platformInfoName3" value="" placeholder="请输入资讯名称" style="width: 180%;margin-top: 1%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto">资讯内容：</label>
				<div class="layui-input-inline">
					<textarea type="text" id="platformInfoDetail3" name="platformInfoDetail3" required lay-verify="required" placeholder="请输入资讯内容" autocomplete="off" class="layui-input" style="width: 240%;height: 70%"></textarea>
				</div>
			</div>
		</form>
	</div>

	<script type="text/html" id="barOption">
		<a type="button" class="layui-btn " lay-event="update" ><span class="sp"><i class="layui-icon">&#xe642;修改</i></span></a>
		<a type="button" class="layui-btn " lay-event="delete" ><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></a>
		{{#  if(d.platforminfostatus == '已发布'){ }}
		<a  type="button" class="layui-btn " lay-event="cancel" ><span class="sp">取消发布</span></a>
		{{#  } }}
		{{#  if(d.platforminfostatus == '未发布'){ }}
		<a type="button" class="layui-btn " lay-event="release" ><span class="sp">发布</span></a>
		{{#  } }}
	</script>
</body>
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
			elem: '#platform'
			, height: 450
			, url: path + "/admin/platformInfoMag"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'platforminfoid', title: '资讯编号', align: 'center', width: 160, sort: true, fixed: 'left'}
				, {field: 'platforminfoname', title: '资讯名称', align: 'center', width: 280}
				, {field: 'platforminfodetail', title: '资讯内容', align: 'center', width: 462}
				, {field: 'platforminfotime', title: '创建时间', align: 'center', width: 280
					, templet:"<div>{{layui.util.toDateString(d.platforminfotime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {fixed: 'right', title: '操作', align: 'center', width: 440, toolbar: '#barOption'}
			]]
			, id: 'platformTable'
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
						area: ['50%', '80%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改资讯','font-size:18px'],
						btn: ['保存','取消'],
						offset: '50px',
						closeBtn:0,
						skin: 'demo-class',
						btnAlign: 'c',
						success : function(layero, index) {
							$("#platformInfoName2").val(data.platforminfoname);
							$("#platformInfoDetail2").val(data.platforminfodetail);
						},
						btn1: function (index) {
							var platformInfoName = $("#platformInfoName2").val();
							var platformInfoDetail = $("#platformInfoDetail2").val();
							$.ajax({
								url: path + '/admin/updatePlatFormInfo',
								async: true,
								type: 'post',
								data: {"platforminfoname": platformInfoName, "platforminfodetail": platformInfoDetail,"platforminfoid":data.platforminfoid},
								datatype: 'text',
								success: function (data) {
									if (data == "success") {
										layer.alert("修改资讯信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										layer.close(index);
										tableIns.reload();
									} else {
										layer.alert("修改资讯信息失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							});
						},
						btn2:function () {
							$("#platformInfoName2").val("");
							$("#platformInfoDetail2").val("");
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该资讯信息？",{icon:3,title:'温馨提示',area:['350px','150px']},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deletePlatFormInfo",
							type: "post",
							data: {"platforminfoid": data.platforminfoid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("平台资讯信息删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("平台资讯信息删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							},
							error:function (result) {
								layer.alert("网路异常！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						});
					});
				}else if(layEvent === 'release'){
					layer.confirm("确定发布咨询信息？",{icon:3,title:'温馨提示',area:['350px','150px']},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/releasePlatFormInfo",
							type: "post",
							data: {"platforminfoid": data.platforminfoid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("平台资讯信息发布成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("平台资讯信息发布失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}
				else if(layEvent === 'cancel'){
					layer.confirm("确定取消发布咨询信息？",{icon:3,title:'温馨提示',area:['350px','150px']},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/cancelPlatFormInfo",
							type: "post",
							data: {"platforminfoid": data.platforminfoid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("平台资讯信息取消发布成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("平台资讯信息取消发布失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}
			});
		});


		$(function () {
			$('#platformInfoName2').blur(function () {
				var reg = /^[\u4E00-\u9FA50-9_]+$/;
				var platformInfoName2 = $('#platformInfoName2').val();
				if(!$('#platformInfoName2').val().match(reg)||platformInfoName2 == 0)
				{
					layer.msg("请输入数字与中文字符组成的字符串", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});
			$('#platformInfoDetail2').blur(function () {
				var reg = /^[\u4E00-\u9FA50-9_]+$/;
				var platformInfoDetail2 = $('#platformInfoDetail2').val();
				if(!$('#platformInfoDetail2').val().match(reg)||platformInfoDetail2 == 0)
				{
					layer.msg("请输入数字与中文字符组成的字符串", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});

			$('#platformInfoName3').blur(function () {
				var reg = /^[\u4E00-\u9FA50-9_]+$/;
				var platformInfoName3 = $('#platformInfoName3').val();
				if(!$('#platformInfoName3').val().match(reg)||platformInfoName3 == 0)
				{
					layer.msg("请输入数字与中文字符组成的字符串", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});
			$('#platformInfoDetail3').blur(function () {
				var reg = /^[\u4E00-\u9FA50-9_]+$/;
				var platformInfoDetail3 = $('#platformInfoDetail3').val();
				if(!$('#platformInfoDetail3').val().match(reg)||platformInfoDetail3 == 0)
				{
					layer.msg("请输入数字与中文字符组成的字符串", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});
		});
		
		$("#btn-add").click(function () {
			layer.open({
				type: 1,
				area: ['50%', '80%'],
				content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
				title: ['新增资讯','font-size:18px'],
				btn: ['保存','取消'],
				offset: '50px',
				closeBtn:0,
				skin: 'demo-class',
				btnAlign: 'c',
				success : function(layero, index) {
				},
				btn1: function (index) {
					var platformInfoName = $("#platformInfoName3").val();
					var platformInfoDetail = $("#platformInfoDetail3").val();
					$.ajax({
						url: path + '/admin/addPlatFormInfo',
						async: true,
						type: 'post',
						data: {"platforminfoname": platformInfoName, "platforminfodetail": platformInfoDetail},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.alert("新增资讯信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								layer.close(index);
								tableIns.reload();
							} else {
								layer.alert("新增资讯信息失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}
					});
				},
				btn2:function () {
					$("#platformInfoName3").val("");
					$("#platformInfoDetail3").val("");
				}
			});
		});

		//搜索功能的实现
		$('.platformTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('platformTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
						,platforminfoname: $('#platformInfoName').val()
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
