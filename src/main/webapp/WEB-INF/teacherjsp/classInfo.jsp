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

	<div class="layui-form-item" style="display: inline-block;width: 28%;">
		<label class="layui-form-label">入学时间：</label>
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
<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="studentInfo">宝宝信息</a>

</script>
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
			,url: path+'/teacher/classInfo' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'studentid', title: '宝宝编号', width:150, sort: true, fixed: 'left'}
				,{field: 'studentname', title: '宝宝名称', width:150}
				,{field: 'parentName', title: '家长名称', width:150}
				,{field: 'studenttime', title: '入学时间', width:200}
				,{field: 'studentsex', title: '性别', width:200}
				,{field: '', title: '操作', toolbar: '#barDemo' , width:200}

				, {field: 'studentbrith', title: '学生生日', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'studentadd', title: '学生地址', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'parentSon', title: '亲子关系', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'parentPhone', title: '手机号码', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'parentAdd', title: '家长地址', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'parentJob', title: '职业', width: 100, edit: 'text', align: 'center', hide: true}
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
					url:path+'/teacher/classInfo' //数据源
					,method:'post',
					page: {
						curr: 1 //重新从第 1 页开始
					}
					, where: {

						startDate: $("#startDate").val(),
						endDate: $("#endDate").val()
					}
				});
			}
		});

		//layui按钮绑定查询事件
		$('.layui-btn').click(function () {
			//获取按钮类型
			var type = $(this).data('type');

		});
		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值

			//事件等于学生考勤信息
			if (layEvent === 'studentInfo') {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '9.5%'],
					title: '智慧幼儿园-宝宝考勤以及详细接送信息',
					content: path + '/teacher/toUrl/studentInfo?studentid='+data.studentid+",studentname="+data.studentname+",studentsex="+data.studentsex //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						var body = layer.getChildFrame("body", index);

						//	显示
						// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
						var iframeWindow = layero.find("iframe")[0].contentWindow;
						var frameId = $(layero).find("iframe").attr('id');

						$(window.frames[frameId].document).find("#studentName").val(data.studentname);
						$(window.frames[frameId].document).find("#studentBrith").val(data.studentbrith);
						$(window.frames[frameId].document).find("#studentSex").val(data.studentsex);
						$(window.frames[frameId].document).find("#studentAdd").val(data.studentadd);

						$(window.frames[frameId].document).find("#parentName").val(data.parentName);
						$(window.frames[frameId].document).find("#parentSon").val(data.parentSon);
						$(window.frames[frameId].document).find("#parentPhone").val(data.parentPhone);
						$(window.frames[frameId].document).find("#parentAdd").val(data.parentAdd);
						$(window.frames[frameId].document).find("#parentJob").val(data.parentJob);
						$(window.frames[frameId].document).find("#parentBrith").val(data.parentBrith);


					}
				});

			}
		});


	});
</script>

</html>