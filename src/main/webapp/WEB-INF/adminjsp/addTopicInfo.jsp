<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-15
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-新增题目</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h3 {
			text-align: center;
		}

	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<input type="hidden" id="safetyVideoId" name="safetyVideoId">
	<div class="layui-form-item">
		<label class="layui-form-label">题目：</label>
		<div class="layui-inline">
			<input type="text" class="layui-input" name="topicName" id="topicName" placeholder="请输入题目" style="width: 120%;">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">选项：</label>
		<div class="layui-inline">
			<input type="text" class="layui-input" name="options" id="options" placeholder="请输入选项名称" style="width: 120%;">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">正确答案：</label>
		<div class="layui-inline">
			<input type="text" id="result" name="result" placeholder="请输入答案" value=""
			       autocomplete="off" class="layui-input" style="width: 120%">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">得分：</label>
		<div class="layui-inline">
			<input type="text" id="score" name="score" placeholder="请输入分值" value=""
			       autocomplete="off" class="layui-input" style="width: 120%">
		</div>
	</div>
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
			elem: '#kinder'
			, height: 312
			, url: path + "/admin/logMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'syslogid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}
				, {field: 'operateor', title: '操作人', align: 'center', width: 120}
				, {
					field: 'operatetime', title: '操作时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.operatetime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'operatetype', title: '操作事项', align: 'center', width: 120}
			]]
			, id: 'demotable'
			, parseData: function (res) { //res 即为原始返回的数据
				return {
					"code": res.code, //解析接口状态
					"msg": res.msg, //解析提示文本
					"count": res.count, //解析数据长度
					"data": res.data //解析数据列表
				};
			}
		});

		//搜索功能的实现
		$('.demoTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('demotable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
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
