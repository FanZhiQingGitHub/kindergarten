<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>宝宝体检信息查询</title>
</head>
<body>


<div class="layui-fluid" style="margin-left: 19%">

	<div class="layui-inline" >
		宝宝昵称：
		<select id="studentId" onchange="selectClass()">
			<option value="">宝宝</option>
		</select>
	</div>

</div>

<div class="layui-inline">
	按照时间搜索：
	<div class="layui-input-inline">
		    <input type="date" name="beginTime" class="layui-input" id="beginTime" placeholder="开始时间">
	</div>
	至：
	<div class="layui-input-inline">
		    <input type="date" name="endTime" class="layui-input" id="endTime" placeholder="结束时间">
	</div>
</div>

<button class="layui-btn" data-type="reload">搜索</button>



<table id="demo" lay-filter="test"></table>

<script>
	//用户管理数据表格
	layui.use(['table', 'jquery', 'layer', 'form'], function () {


		var table = layui.table;
		table.render({
			elem: '#demo'
			, height: 350
			, url: path + '/parent/findExaminationByStudentId' //数据接口
			,where:{
				name:$("#studentId").val()
			}
			, page: true //开启分页
			, limits: [5, 10, 15, 20]
			, cols: [[ //表头
				{field: 'examinationid', title: '体检ID',  align: 'center', hide: 'true'}
				, {field: 'studentid', title: '宝宝ID', fixed: 'left', align: 'center'}
				, {field: 'studentname', title: '宝宝名称', align: 'center'}
				, {field: 'height', title: '身高',  sort: true, align: 'center'}
				, {field: 'weight', title: '体重',  sort: true, align: 'center'}
				, {field: 'vision', title: '视力',  sort: true, align: 'center'}
				, {field: 'temperature', title: '体温',  sort: true, align: 'center'}
				, {field: 'skin', title: '皮肤状况',  sort: true, align: 'center'}
				, {field: 'healthstatus', title: '健康状况',  sort: true, align: 'center'}
				, {
					field: 'examinationtime',
					title: '体检时间',
					sort: true,
					align: 'center'
				}
			]]
		});


		$('.layui-btn').click(function () {

			//获取按钮类型
			var type = $(this).data('type');

			//类型等于重载的话 刷新表格数据
			if(type == 'reload'){
				table.reload('demo',{
					url:path+'/parent/findExaminationByStudentId' //数据源
					,method:'post',
					page:{
						curr:1
					}
					,where:{
						//发送的值
						name:$('#studentId').val(),
						beginTime:$('#beginTime').val(),
						endTime:$('#endTime').val()
					}
				})
			}

		});


	});

</script>


</body>
</html>
