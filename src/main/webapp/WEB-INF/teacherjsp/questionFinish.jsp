<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/3/10
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>安全教育试题完成情况</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>
<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;width: 100px">班级名称：${classname}</label>
	</div>
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;">查询条件：</label>
	</div>

	<div class="layui-form-item" style="display: inline-block;width: 24%;">
		<label class="layui-form-label">完成时间：</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="startDate" name="${startDate}" placeholder="请选择起始日期">
		</div>
	</div>
	<div class="layui-form-item" style="display: inline-block;width: 24%;">
		<label class="layui-form-label" style="text-align: left;width: 6%;">至</label>
		<div class="layui-input-inline" style="text-align: left;">
			<input type="text" class="layui-input" id="endDate" name="${endDate}" placeholder="请选择结束日期">
		</div>
	</div>
	<div class="layui-input-block" >
		<label class="layui-form-label" >完成状态：</label>
		<select name="finishStatus" id="finishStatus" lay-verify="required" style="width: 100px">
			<option value="" >请选择完成状态</option>
			<option value="已完成" selected>已完成</option>
			<option value="未完成" selected>未完成</option>
		</select>
	</div>
	<div class="layui-form-item" style="text-align: right;padding-right: 10%;">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">查询</button>

		</div>
	</div>

</div>

<table id="demo" lay-filter="test">
	<input type="hidden" id="path" value="<%=path%>">
</table>
</body>
<script>
	layui.use(['table','laydate','layer'], function(){
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path=$("#path").val();



		laydate.render({
			elem: '#startDate' //指定元素
			, theme: '#009688'
			, showBottom: false
			, format: 'yyyy-MM-dd'
			, done: function (value, date, endDate) {
				var startTime = new Date(value).getTime();
				var endTime = new Date($('#endDate').val()).getTime();
				if (endTime < startTime) {
					layer.msg('结束时间不能小于开始时间');
				}
			}
		});
		laydate.render({
			elem: '#endDate' //指定元素
			, theme: '#009688'
			, showBottom: false
			, format: 'yyyy-MM-dd'
			, done: function (value, date, startDate) {
				var startTime = new Date($('#startDate').val()).getTime();
				var endTime = new Date(value).getTime();
				if (endTime < startTime) {
					layer.msg('结束时间不能小于开始时间');
				}
			}
		});
		//第一个实例
		table.render({
			elem: '#demo'
			,height: 412
			,url: path+'/teacher/questionFinishTable' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'studentid', title: '宝宝编号', width:150, sort: true, fixed: 'left'}
				,{field: 'studentname', title: '宝宝名称', width:150}
				,{field: 'parentname', title: '家长名称', width:150}
				,{field: 'safetyfinishtime', title: '结束时间', width:200}
				,{field: 'safetytestfinshtime', title: '完成时间', width:200}
				,{field: 'safetytestscore', title: '得分', width:200}
				,{field: 'safetytestresult', title: '完成状态', width:200}
			]]
		});
        // 查询
		$('.demoTable .layui-btn').on('click', function () {
			console.log("查询进来");
			var type = $(this).data('type');
			if (type == 'reload') {

				console.log("查询进来2");
				//执行重载
				table.reload('demoTable', {
					url:path+'/teacher/questionFinishTable' //数据源
					,method:'post',
					page: {
						curr: 1 //重新从第 1 页开始
					}
					, where: {

				     finishStatus: $("#finishStatus").val(),
						startDate: $("#startDate").val(),
						endDate: $("#endDate").val()
					}
				});
			}
		});


	});
</script>

</html>