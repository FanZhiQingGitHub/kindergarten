<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/9
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>课程表</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>
<h1 style="margin-left: 17%;font-size: 40px;color: coral">课程表</h1>
<input type="hidden" id="start" value="1">
<input type="hidden" id="end" value="7">
<input type="hidden" id="path" value="<%=path%>">


<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;width: 100px">班级名称：${classname}</label>

	</div>
</div>
<table id="demo" lay-filter="test">
	<input type="hidden" id="path" value="<%=path%>">
</table>
<div class="layui-fluid" id="searchTable" style="margin-left:33%;top:15px">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<div style="padding-bottom: 10px;">
			<button type="button" class="layui-btn layui-btn-normal" data-type="reload1" style="width: 200px"><i
					class="layui-icon">&#xe615;</i>上一周
			</button>
			<button type="button" class="layui-btn layui-btn-normal" data-type="reload2" style="width: 200px;"><i
					class="layui-icon">&#xe615;</i>下一周
			</button>
		</div>
	</div>
</div>

</body>
<script>

	layui.use(['table','laydate','layer'], function() {
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path = $("#path").val();
		var tblCourseList;
		//第一个实例 课程表
		table.render({
			elem: '#demo'
			, text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
				none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
			}
			,height: 300
			,url: path+'/teacher/thisWeekCourse' //数据接口
			// ,page: true //开启分页
			,limit:5
			,id: 'searchTable'
			,cols: [[ //表头
				{field: 'coursenum', title: '课节', width:100, sort: true, fixed: 'left'}
				,{field: 'coursename1', title: '周一', width:100}
				,{field: 'coursename2', title: '周二', width:100}
				,{field: 'coursename3', title: '周三', width:100}
				,{field: 'coursename4', title: '周四', width:100}
				,{field: 'coursename5', title: '周五', width:100}
				, {field: 'mondaydate', title: '开始时间', width: 200, edit: 'text', align: 'center'}
				, {field: 'sundaydate', title: '结束时间', width: 200, edit: 'text', align: 'center'}
				, {field: 'ctids', title: '课程表的时间id', width: 100, edit: 'text', align: 'center', hide: true}
			]],
			done: function (res) {
				tblCourseList = res.data;
			}
		});

		$('#searchTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			var mondaydate;//1
			var sundaydate;//7
			if (type == 'reload1') { //上周
				console.log("上周");
				//执行重载
				mondaydate = $("#start").val();//1
				sundaydate = $("#end").val();//7
				mondaydate -= parseInt(7);
				sundaydate -= parseInt(7);

				$("#start").val(mondaydate);
				$("#end").val(sundaydate);

				table.reload('searchTable', {
					where: {
						key1: $("#start").val(),
						key2: $("#end").val()

					}
				});
			} else if (type == 'reload2') { //下周
				console.log("下周");
				var start = $("#start").val();//1
				var end = $("#end").val();//7
				mondaydate = parseInt(start) + 7;
				sundaydate = parseInt(end) + 7;

				$("#start").val(mondaydate);
				$("#end").val(sundaydate);

				table.reload('searchTable', {
					where: {
						key1: $("#start").val(),
						key2: $("#end").val()

					}
				});
			}
		});


	});
</script>

</html>
