<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>智慧幼儿园-班级管理</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>

<input type="hidden" id="path" value="<%=path%>">
<input type="text" id="classid" name="classid">

<div class="layui-fluid">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 47%">课程表</h2>
		班级名称：<input type="text" id="classname" name="classname">
		<br/>
		日期选择：<select name="studentname" id="studentname" lay-filter="mySelect">
			<option value="暂无" selected>暂无选择</option>
			<c:if test="${not empty tblStudentList}">
				<c:forEach items="${tblStudentList}" var="i" step="1">
					<option value="${i.studentname}">${i.studentname}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
	<div class="layui-inline" style="width:100%;">
		<hr>
	</div>

	<table class="layui-hide" id="layui_table" lay-filter="checkData"></table>

	<div class="layui-btn-container" style="margin-left: 46.5%;margin-top: 6%">
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
		var laydate = layui.laydate;
		var path = $("#path").val();
		var classid = $("#classid").val();
		var tblCourseList;
		table.render({
			elem: '#layui_table'
			, text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
				none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
			}
			, height: 250
			, url: path + '/director/showAllCourseId?classid=' + classid //数据接口
			// , page: true //开启分页
			, id: 'searchTable'
			// , limit: 5
			// , limits: [5, 10, 15, 20]
			, cols: [[ //表头
				// {type: 'checkbox',fixed: 'left'},
				// {field: 'recipeid', title: '食谱id', width: 130, align: 'center',hide:true},
				{field: 'coursenum', title: '课节', width: 135, align: 'center'}
				, {field: 'coursename1', title: '周一', width: 225, edit: 'text', align: 'center'}
				, {field: 'coursename2', title: '周二', width: 225, edit: 'text', align: 'center'}
				, {field: 'coursename3', title: '周三', width: 225, edit: 'text', align: 'center'}
				, {field: 'coursename4', title: '周四', width: 225, edit: 'text', align: 'center'}
				, {field: 'coursename5', title: '周五', width: 225, edit: 'text', align: 'center'}
			]],
			done:function (res) {
				tblCourseList=  res.data;
			}
		});

		$(function () {
			$("#save").click(function () {
				// var tblCourseList = layui.table.data;
				// console.log("对应的集合是"+tblCourseList.toString()+classid);
				if(tblCourseList.length == 0){
					layer.alert("您必须选择一行数据进行修改！", {icon: 2});
				}else {
					var msg = {"tblCourseList": tblCourseList,"cid":classid};
					msg = JSON.stringify(msg);
					$.ajax({
						url: path + "/director/updateCourseInfo",
						async: true,
						type: "post",
						data: "TblCourse="+msg,
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
				}
			});
			$("#cancel").click(function () {
				var path = $("#path").val();
				location.href = path + "/director/toUrl/director_CourseManage";
			});
		})
	});

</script>

</body>
</html>
