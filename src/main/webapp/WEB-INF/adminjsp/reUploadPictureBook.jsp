<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-13
  Time: 7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-重新上床绘本</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			overflow: hidden;
		}
		h3 {
			text-align: center;
		}

		.layui-table-cell {
			height: 40px;
			line-height: 40px;
		}
	</style>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
	<table id="read" lay-filter="test" class="layui-table-cell"></table>
	<div class="layui-main readInfo">
		<form id="reUploads" class="layui-form" action="" onsubmit="return false;">
			<div class="layui-form-item">
				<label class="layui-form-label" style="">绘本名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="readMagName" id="readMagName" value="" placeholder="" style="width: 22%;margin-top: 1%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">绘本图片：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
					<%--					<span id="readMagPic" style="width: 80px ;height: 80px"></span>--%>
					<%--	${pageContext.request.contextPath}/image/adminimg/img/timg.jpg--%>
					<%--					<img src="" class="theimg" style="width: 80px;height: 80px" id="test1"/>--%>
					<%--					<img type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">--%>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
				</div>
			</div>

<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">上传时间：</label>--%>
<%--				<div class="layui-input-inline">--%>
<%--					<input type="text" name="readMagTime" id="readMagTime" autocomplete="off" class="layui-input" style="width: 22%">--%>
<%--				</div>--%>
<%--			</div>--%>

			<div class="layui-form-item">
				<label class="layui-form-label">页数：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">
				</div>
			</div>

<%--			<div class="layui-form-item" style="margin-top:20px">--%>
<%--				<div class="layui-input-block">--%>
<%--					<button type="button" class="layui-btn " lay-submit="" lay-filter="test1">保存</button>--%>
<%--					<button type="button" class="layui-btn layui-btn-primary" id="test2">取消</button>--%>
<%--				</div>--%>
<%--			</div>--%>
		</form>
	</div>
</body>
<%--<script>--%>
<%--	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {--%>
<%--		var form = layui.form--%>
<%--			, layer = layui.layer--%>
<%--			, layedit = layui.layedit--%>
<%--			, laydate = layui.laydate--%>
<%--			, element = layui.element--%>
<%--			, tree = layui.tree--%>
<%--			, table = layui.table--%>
<%--			, $ = layui.jquery;--%>
<%--		form.render();--%>
<%--		var path = $("#path").val();--%>
<%--		var tableIns = table.render({--%>
<%--			elem: '#kinder'--%>
<%--			, height: 312--%>
<%--			, url: path + "/admin/logMgrInfo"//数据接口--%>
<%--			, page: true //开启分页--%>
<%--			, limit: 5--%>
<%--			, limits: [5, 10]--%>
<%--			, cols: [[ //表头--%>
<%--				{field: 'syslogid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}--%>
<%--				, {field: 'operateor', title: '操作人', align: 'center', width: 120}--%>
<%--				, {--%>
<%--					field: 'operatetime', title: '操作时间', align: 'center', width: 180--%>
<%--					, templet: "<div>{{layui.util.toDateString(d.operatetime,'yyyy-MM-dd HH:mm:ss')}}</div>"--%>
<%--				}--%>
<%--				, {field: 'operatetype', title: '操作事项', align: 'center', width: 120}--%>
<%--			]]--%>
<%--			, id: 'demotable'--%>
<%--			, parseData: function (res) { //res 即为原始返回的数据--%>
<%--				return {--%>
<%--					"code": res.code, //解析接口状态--%>
<%--					"msg": res.msg, //解析提示文本--%>
<%--					"count": res.count, //解析数据长度--%>
<%--					"data": res.data //解析数据列表--%>
<%--				};--%>
<%--			}--%>
<%--		});--%>

<%--		//搜索功能的实现--%>
<%--		$('.demoTable .layui-btn').on('click', function () {--%>
<%--			var type = $(this).data('type');--%>
<%--			active[type] ? active[type].call(this) : '';--%>
<%--		});--%>

<%--		var $ = layui.$, active = {--%>
<%--			reload: function () {--%>
<%--				//执行重载--%>
<%--				table.reload('demotable', {--%>
<%--					where: {--%>
<%--						time1: $('#time1').val()--%>
<%--						, time2: $('#time2').val()--%>
<%--					}--%>
<%--					, page: {--%>
<%--						curr: 1--%>
<%--					}--%>
<%--				});--%>
<%--			}--%>
<%--		};--%>

<%--		// 刷新表格--%>
<%--		$('#btn-refresh').on('click', function () {--%>
<%--			tableIns.reload();--%>
<%--		});--%>
<%--	});--%>
<%--</script>--%>
</html>
