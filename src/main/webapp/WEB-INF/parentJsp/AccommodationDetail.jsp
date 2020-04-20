<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>膳食详情页面</title>
</head>
<body>

<input type="hidden" id="mealId">


<h1 align="center">周膳食详情</h1>

<table class="layui-hide" id="layui_table"></table>



<script>

	$(function () {

		layui.use(['table'], function () {
			var table = layui.table;
			var mealId = $("#mealId").val();
			table.render({
				elem: '#layui_table'
				, url: path + '/parent/findRecipeInfo' //数据接口
				,where:{
					mealId:mealId
				}
				, cols: [[ //表头
					{field: 'recipeid', title: '食谱id', width: 130, align: 'center',hide:true}
					,{field: 'recipename', title: '餐别', width: 158, align: 'center'}
					, {field: 'monday', title: '星期一', width: 250,  align: 'center'}
					, {field: 'tuesday', title: '星期二', width: 250,  align: 'center'}
					, {field: 'wednesday', title: '星期三', width: 250,  align: 'center'}
					, {field: 'thursday', title: '星期四', width: 250,  align: 'center'}
					, {field: 'friday', title: '星期五', width: 250,  align: 'center'}
					, {field: 'mid', title: '膳食id', width: 250,  align: 'center',hide:true}
				]]

			});

		});



	});


</script>

</body>
</html>
