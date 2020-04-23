<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>智慧幼儿园-班级成员管理</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="start" value="1">
<input type="hidden" id="end" value="7">
<input type="hidden" id="path" value="<%=path%>">
<input type="text" id="classid" name="classid">

<div class="layui-fluid">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 47%">课程表</h2>
		<button type="button" class="layui-btn add"><i class="layui-icon">&#xe654;</i>新增</button>
		班级名称：<input type="text" id="classname" name="classname">
		<br/>
		<input type="text" id="datetimes" readonly>
	</div>
	<div class="layui-inline" style="width:100%;">
		<hr>
	</div>

	<table class="layui-hide" id="layui_table" lay-filter="checkData"></table>

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
	<div class="layui-btn-container" style="margin-left: 46.5%;margin-top: 1%">
		<button type="button" class="layui-btn layui-btn-normal " id="save">保存</button>
		<button type="button" class="layui-btn layui-btn-normal " id="cancel">取消</button>
	</div>
</div>

<script>

	//用户管理数据表格
	layui.use(['table', 'jquery', 'layer', 'laydate', 'form'], function () {
		$ = layui.jquery;
		var table = layui.table;
		var form = layui.form;
		var layer = layui.layer;
		var path = $("#path").val();
		var tblCourseList;
		table.render({
			elem: '#layui_table'
			, text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
				none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
			}
			, height: 250
			//数据接口
			, url: path + '/director/showAllCourseId'
			// , page: true //开启分页
			, id: 'searchTable'
			,where: { //设定异步数据接口的额外参数，任意设
				classid: $("#classid").val()
			}
			, cols: [[ //表头
				{field: 'coursenum', title: '课节', width: 135, align: 'center'}
				, {field: 'coursename1', title: '周一', width: 130, edit: 'text', align: 'center'}
				, {field: 'coursename2', title: '周二', width: 130, edit: 'text', align: 'center'}
				, {field: 'coursename3', title: '周三', width: 130, edit: 'text', align: 'center'}
				, {field: 'coursename4', title: '周四', width: 130, edit: 'text', align: 'center'}
				, {field: 'coursename5', title: '周五', width: 130, edit: 'text', align: 'center'}
				, {field: 'mondaydate', title: '开始时间', width: 200, edit: 'text', align: 'center'}
				, {field: 'sundaydate', title: '结束时间', width: 200, edit: 'text', align: 'center'}
				, {field: 'ctids', title: '课程表的时间id', width: 100, edit: 'text', align: 'center', hide: true}
			]],
			done: function (res) {
				tblCourseList = res.data;
			}
		});

		$(function () {
			$("#save").click(function () {
				var classid = $("#classid").val();
				var msg = {"tblCourseList": tblCourseList, "cid": classid};
				msg = JSON.stringify(msg);
				$.ajax({
					url: path + "/director/updateCourseInfo",
					async: true,
					type: "post",
					data: "TblCourse=" + msg,
					datatype: "text",
					success: function (msg) {
						if (msg == "success") {
							layer.alert("修改成功！", {icon: 6}, function (index) {
								window.parent.location.reload();
							});
						} else {
							layer.alert("修改失败！", {icon: 2});
						}
					}, error: function (msg) {
						layer.alert("网络繁忙！", {icon: 2});
					}
				})
			});
			$("#cancel").click(function () {
				window.parent.location.reload();
			});

			//新增的使用
			$(".add").click(function () {
				var classid = $("#classid").val();
				var path = $("#path").val();
				layer.open({
					type: 2,
					area: ['100%', '95%'],
					title: '新增课程信息',
					content: path + '/director/toUrl/director_CourseAddManage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						var frameId = $(layero).find("iframe").attr('id');
						// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
						var iframeWindow = layero.find("iframe")[0].contentWindow;
						$(window.frames[frameId].document).find("#classid").val(classid);
						iframeWindow.layui.form.render(); //更新全部
					}
				});
			});
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
						key3: $("#classid").val()
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
						key3: $("#classid").val()
					}
				});
			}
		});
	});

</script>

</body>
</html>
