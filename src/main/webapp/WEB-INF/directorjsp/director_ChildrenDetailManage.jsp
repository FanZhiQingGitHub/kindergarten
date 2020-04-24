<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>幼儿信息修改</title>
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
<input type="hidden" id="kindername" value="${kindername}">
<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" name="studentid" id="studentid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">宝宝名称：</label>
		<div class="layui-input-inline">
			<input type="text" name="studentname" id="studentname" autocomplete="off" required lay-verify="required"
			       placeholder="请输入宝宝名称" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">性别：</label>
		<div class="layui-input-inline">
			<div class="layui-form">
				<select name="studentsex" id="studentsex" lay-filter="mySelect">
					<option value="暂无" selected>暂无选择</option>
					<option value="男" selected>男</option>
					<option value="女">女</option>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">出生年月：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="date" class="layui-input" name="studentbrith" id="studentbrith" placeholder="出生年月" autocomplete="off">
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">地址：</label>
		<div class="layui-input-inline">
			<div class="layui-form" lay-filter="myDiv">
				<input type="text" class="layui-input" name="studentadd" id="studentadd"
				       autocomplete="off">
			</div>
		</div>
	</div>
</form>

<script>
	//Demo
	layui.use(['form', 'jquery', 'layer'], function () {
		var form = layui.form;
		$ = layui.$;
		var layer = layui.layer;

		$(function () {
			//幼儿名字判断是不是重复
			$("#studentname").on('blur', function () {
				var studentname = $("#studentname").val();
				var path = $("#path").val();
				$.ajax({
					url: path + "/director/selectStudentName",
					async: true,
					type: "post",
					data: {"studentname": studentname},
					dataType: "text",
					success: function (msg) {
						if (msg === "success") {
							layer.msg("幼儿名称已存在，请更改！");
							$("#studentname").focus();
						}
					},
					error: function () {
						layer.alert("网络繁忙");
					}
				});
			});
			// //日期范围
			// $("#studentbrith").on('blur', function (){
			// 	var birthday = $('#studentbrith').val(); //假设用户输入的是这种格式  birthday="2017-10-11"
			// 	var birthday1 = birthday.split('-');
			// 	var convert2Date = new Date(birthday1[0], birthday1[1], birthday1[2]);//把字符串转换成日期   网上很多方法
			// 	var nowDate = new Date();   //获取当前时间
			// 	var age = nowDate.getTime() - convert2Date.getTime();  //毫秒
			// 	age = age / (24 * 3600 * 1000); //天数  至于转换成多少年(岁)，详细的还要根据是否闰年计算 age/(24*3600*1000*366) 或者 age/(24*3600*1000*365)
			// 	if (age>5 && age< 8)
			// 		alert('符合年龄！');
			// 	else {
			// 		alert('不符合规范，请输入当前年份计算的年龄在5岁到8岁之间！');
			// 		$('#studentbrith').focus();
			// 	}
			//
			// });

		})
	});
	function validateAge() {

	}
</script>
</body>
</html>