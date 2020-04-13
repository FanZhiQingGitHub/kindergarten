<%--
  Created by IntelliJ IDEA.
  User: junlong
  Date: 2019-11-13
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>教师考勤信息修改</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
	* {
		margin: 0 auto;
	}

	body {
		line-height: 50px;
	}
</style>
<body>
<h1 style="text-align:center;font-size: 40px;color: #009688">教师考勤信息</h1>
<input type="hidden" id="start" value="1">
<input type="hidden" id="end" value="7">
<input type="hidden" name="teacherid" id="teacherid">
<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
<div class="layui-form-item">
	<label class="layui-form-label">教师名称：</label>
	<div class="layui-input-inline">
		<input type="text" name="teachername" id="teachername" autocomplete="off" class="layui-input" readonly>
	</div>
</div>
<div class="layui-form-item layui-form-text">
	<label class="layui-form-label">角色：</label>
	<div class="layui-input-inline">
		<input type="text" name="teacherjob" id="teacherjob" autocomplete="off" class="layui-input" readonly>
	</div>
</div>
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


<table id="dataTable" lay-filter="test"></table>
<script>
	//用户管理数据表格
	layui.use(['table', 'jquery', 'layer', 'form', 'laydate'], function () {
		$ = layui.jquery;
		var table = layui.table;
		var form = layui.form;
		var layer = layui.layer;
		var laydate = layui.laydate;
		var teacherid = $("#teacherid").val();
		var path = $("#path").val();
		//第一个实例
		table.render({
			elem: '#dataTable'
			, height: 280
			, url: path + '/director/showTeacherAttendDetail?teacherid='+teacherid //数据接口
			, page: true //开启分页
			, id: 'searchTable'
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'tertime', title: '项目', width: 120, fixed: 'left', align: 'center'}
				, {field: 'tertimedate', title: '上午', width: 200, align: 'center'}
				, {field: 'tertimeperiod', title: '下午', width: 200, align: 'center'}
			]],
			done: function (res) {
				// res.data.forEach(function (item, index) {
				// 	//如果单元格数据时间大于8:30 和小于17：:30 的，将背景颜色改成红色，请假和无的变成蓝色
				// 	if (item.stutimemonday > "8:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimemonday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimemonday < "17:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimemonday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimemonday == "请假") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimemonday']").css({
				// 			"background-color": "darkturquoise",
				// 		});
				// 	}
				//
				// 	if (item.stutimetuesday > "8:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimetuesday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimetuesday < "17:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimetuesday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimetuesday == "请假") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimetuesday']").css({
				// 			"background-color": "darkturquoise",
				// 		});
				// 	}
				//
				// 	if (item.stutimethursday > "8:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimethursday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimethursday < "17:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimethursday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimethursday == "请假") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimethursday']").css({
				// 			"background-color": "darkturquoise",
				// 		});
				// 	}
				//
				//
				// 	if (item.stutimewednesday > "8:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimewednesday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimewednesday < "17:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimewednesday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimewednesday == "请假") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimewednesday']").css({
				// 			"background-color": "darkturquoise",
				// 		});
				// 	}
				//
				// 	if (item.stutimefriday > "8:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimefriday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimefriday < "17:30") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimefriday']").css({
				// 			"background-color": "yellow",
				// 		});
				// 	}
				// 	if (item.stutimefriday == "请假") {
				// 		$(".layui-table-body tbody tr[data-index='" + index + "'] td[data-field='stutimefriday']").css({
				// 			"background-color": "darkturquoise",
				// 		});
				// 	}
				// });
				// for (var i in res.data) {
				// 	if (res.data[i].stutimetype == "日期") {
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimemonday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimetuesday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimewednesday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimethursday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimefriday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 	}
				//
				// 	if (res.data[i].stutimetype == "接送人") {
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimemonday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimetuesday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimewednesday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimethursday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 		$(".layui-table-body tbody tr[data-index='" + i + "'] td[data-field='stutimefriday']").css({
				// 			"background-color": "#e6e6e6",
				// 		});
				// 	}
				//
				// }
			},
		});

		$('#searchTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			var mondaydate;//1
			var sundaydate;//7
			if (type == 'reload1') { //上周
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
						key2: $("#end").val(),
						key3: $("#teacherid").val()
					}
				});
			} else if (type == 'reload2') { //下周

				var start = $("#start").val();//1
				var end = $("#end").val();//7
				mondaydate = parseInt(start) + 7;
				sundaydate = parseInt(end) + 7;

				$("#start").val(mondaydate);
				$("#end").val(sundaydate);

				table.reload('searchTable', {
					where: {
						key1: $("#start").val(),
						key2: $("#end").val(),
						key3: $("#teacherid").val()
					}
				});
			}
		});
	});
</script>
</body>
</html>