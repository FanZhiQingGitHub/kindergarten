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
	<title>班级考勤</title>
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
	<br>
	<div class="layui-form-item" style="display: inline-block;width: 80%;">

		<div class="layui-input-inline" style="display: inline-block;width: 70%;">
			<label class="layui-form-label">宝宝名称：</label>
			<input class="layui-input" id="studentname" value="" style="width: 150px">

		</div>
		<div class="layui-form-item" style="text-align: right;padding-right: 10%;">
			<div class="layui-input-block">
				<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">查询</button>

			</div>
		</div>
	</div>

</div>

<table id="demo" lay-filter="test">
	<input type="hidden" id="path" value="<%=path%>">
</table>
</body>
<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="studentAttendance">考勤信息</a>

</script>
<script>
	layui.use(['table','laydate','layer'], function(){
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path=$("#path").val();

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 412
			,url: path+'/teacher/classAttendanceTable' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'studentid', title: '宝宝编号', width:150, sort: true, fixed: 'left'}
				,{field: 'studentname', title: '宝宝名称', width:150}
				,{field: 'parentName', title: '家长名称', width:150}
				,{field: 'studentsex', title: '性别', width:200}
				,{field: '', title: '操作', toolbar: '#barDemo' , width:200}
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
					url:path+'/teacher/classAttendanceTable' //数据源
					,method:'post',
					page: {
						curr: 1 //重新从第 1 页开始
					}
					, where: {
						studentname: $("#studentname").val()
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
			if (layEvent === 'studentAttendance') {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '9.5%'],
					title: '智慧幼儿园-宝宝考勤以及详细接送信息',
					content: path + '/teacher/toUrl/studentAttendance?studentid='+data.studentid+",studentname="+data.studentname+",studentsex="+data.studentsex //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						var body = layer.getChildFrame("body", index);

						//	显示
						// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
						var iframeWindow = layero.find("iframe")[0].contentWindow;
						var frameId = $(layero).find("iframe").attr('id');
						$(window.frames[frameId].document).find("#studentid").val(data.studentid);
						$(window.frames[frameId].document).find("#studentname").val(data.studentname);
						$(window.frames[frameId].document).find("#studentsex").val(data.studentsex);





					}
				});

			}
		});

	});
	//将表单转为js对象数据
	function serializeObject($, array){
		var obj=new Object();
		$.each(array, function(index,param){
			if(!(param.name in obj)){
				obj[param.name]=param.value;
			}
		});
		return obj;
	}

</script>

</html>