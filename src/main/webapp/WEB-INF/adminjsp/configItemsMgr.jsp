<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-15
  Time: 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-配置试题管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2 {
			text-align: center;
		}

	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
<%--	<h2>配置试题管理</h2>--%>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="configItemsTable">
				<div class="layui-form-item" style="margin-left: 10%;">
					<div class="layui-inline">
						<span class="layui-form-label">标题：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="title" id="title" value="" placeholder="请输入标题" style="width: 120%;margin-top: 2% ">
						</div>
					</div>
					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-left: 10%"><i class="layui-icon">&#xe624;新增</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="configItems" lay-filter="test" class=""></table>
<%--	<button class="layui-btn btn-add btn-default" id="save" style="">保存</button>--%>
<%--	<button class="layui-btn btn-add btn-default" id="cancel" style="">取消</button>--%>

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

		// $("#cancel").click(function () {
		// 	location.href = path + "/admin/toUrl/videoQuestionConfigMgr"
		// });

		$("#btn-add").click(function () {
			var index = parent.layer.open({
				type: 2,
				area: ['60%', '90%'],
				// content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
				content: path+"/admin/toUrl/addTopicInfo",
				title: '新增题目',
				btn: ['保存', '取消'],
				offset: ['60px','300px'],
				btnAlign: 'c',
				// maxmin: true
				// btn1: function (index) {
				// 	var safetyVideoName = $("#safetyVideoName").val();
				// 	var videoName = $("#videoName").val();
				// 	var videoAdd = $("#videoAdd").val();
				// 	if (safetyVideoName.length == 0) {
				// 		layer.alert("请输入视频名称", {icon: 2});
				// 	}  else {
				// 		$.ajax({
				// 			url: path + '/admin/addSafetyVideo',
				// 			async: true,
				// 			type: 'post',
				// 			data: {"safetyvideoname":safetyVideoName,"videoname":videoName,"videoadd":videoAdd},
				// 			datatype: 'text',
				// 			success: function (data) {
				// 				if (data == "success") {
				// 					layer.alert("新增成功！", {icon: 6});
				// 					layer.close(index);
				// 					tableIns.reload();
				// 				} else {
				// 					layer.alert("新增失败", {icon: 2});
				// 				}
				// 			}, error: function (data) {
				// 				layer.alert("网络繁忙！", {icon: 2});
				// 			}
				// 		});
				// 	}
				// },
			});
			// layer.full(index);
		});
	});
</script>
</html>
