<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-8
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>智慧幼儿园-教师考勤信息修改</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<script src=<%=path + "/layui/layui.js"%>></script>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="teacherid">
<input type="hidden" id="start" value="1">
<input type="hidden" id="end" value="7">

<div class="layui-fluid">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 43%">教师考勤信息</h2>
	</div>
	<div class="layui-inline" style="width:100%;">
		<hr>
	</div>

	<div class="layui-fluid" style="margin-left: 19%">
		<div class="layui-inline">
			<label class="layui-form-label">教师名称：</label>
			<div class="layui-input-inline">
				<input type="text" name="teachername" id="teachername" autocomplete="off" class="layui-input" readonly>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">角色：</label>
			<div class="layui-input-inline">
				<input type="text" name="teacherjob" id="teacherjob" autocomplete="off" class="layui-input" readonly>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">班级：</label>
			<div class="layui-input-inline">
				<input type="text" name="classname" id="classname" autocomplete="off" class="layui-input" readonly>
			</div>
		</div>
	</div>

	<div class="layui-fluid" id="searchTable" style="margin-left:33%;top:15px">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div style="padding-bottom: 10px;">
				<button type="button" class="layui-btn layui-btn-normal" id="reload1" style="width: 200px"><i
						class="layui-icon">&#xe615;</i>上一周
				</button>
				<button type="button" class="layui-btn layui-btn-normal" id="reload2" style="width: 200px;"><i
						class="layui-icon">&#xe615;</i>下一周
				</button>
			</div>
		</div>
	</div>


	<table class="layui-table" id="ta1">
		<thead>
		<tr>
			<th style="text-align: center">星期</th>
			<th style="text-align: center">星期一</th>
			<th style="text-align: center">星期二</th>
			<th style="text-align: center">星期三</th>
			<th style="text-align: center">星期四</th>
			<th style="text-align: center">星期五</th>
		</tr>
		</thead>
		<tbody id="tbo">

		</tbody>
	</table>


</div>

<script>
	layui.use(['jquery', 'layer', 'table', 'laydate'], function () {
		var $ = layui.$, layer = layui.layer;
		var tid = $("#teacherid").val();
		var path = $("#path").val();

		//上一周
		$(function () {
			$("#reload1").click(function () {
				var mondaydate;//1
				var sundaydate;//7
				//上周
				mondaydate = $("#start").val();//1
				sundaydate = $("#end").val();//7
				mondaydate -= parseInt(7);
				sundaydate -= parseInt(7);
				$("#start").val(mondaydate);
				$("#end").val(sundaydate);

				var teacherid = $("#teacherid").val();
				var startdate = $("#start").val();
				var enddate = $("#end").val();

				$.ajax({
					url: path + '/director/showTeacherAttendDetail',
					async: true,
					type: 'post',
					data: {'teacherid': teacherid,'startdate': startdate,'enddate': enddate},
					datatype: 'text',
					success: function (msg) {
						if (msg == "error") {
							//删除所有tr节点
							var table = document.getElementById("tbo");
							var rowNum = table.rows.length;
							if (rowNum > 0) {
								for (var i = 0; i < rowNum; i++) {
									table.deleteRow(i);
									rowNum = rowNum - 1;
									i = i - 1;
								}
								var erroroption;
								erroroption += "<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
								$("#tbo").html(erroroption);
								$("#tbo").show();
							}
						} else {
							layer.msg('查询成功');
							var info = msg;
							console.log("输出的信息=" + info.toString());
							var option;
							//--------------------------上午接送信息------------------------------------
							option += "<tr><td style='text-align: center'>日期</td>";
							for (var j in info) {
								if(info[j].tertime!=null){
									var d = new Date(info[j].tertime);
									var datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate();
									option += "<td style='text-align: center'>" + datetime + "</td>"
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";

							option += "<tr><td style='text-align: center'>上午</td>";
							for (var j in info) {
								if(info[j].tertimedate1!=null) {
									if (info[j].tertimedate1 == '请假') {
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									}else if (info[j].tertimedate1 > '8:30') {
										option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									} else {
										option += "<td style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";

//--------------------------中午接送信息------------------------------------

							option += "<tr><td style='text-align: center'>中午</td>";
							// var i = 0; i < data.length; i++
							for (var j = 0;j<info.length;j++) {
								console.log(j+"个="+info[j].noon);
								if(null!=info[j].noon&&info[j].noon!='undefined'){
									if(info[j].noon!="请假"){
										console.log("进入到对应的substring"+info[j].noon);
										var noon1 = info[j].noon.substring(0,5);
										var noon2 = info[j].noon.substring(5,10);
										if (noon1 < '12:01' || noon2 > '12:30' ) {
											option += "<td bgcolor='yellow' style='text-align: center'>" + noon1 +"</br>" +noon2+ "</td>"
										}else {
											option += "<td style='text-align: center'>" +noon1 +"</br>" +noon2+ "</td>"
										}
									}
									else if (info[j].noon == '请假') {
										console.log("未进入的substring");
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].noon + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}

							//--------------------------下午接送信息------------------------------------

							option += "<tr><td style='text-align: center'>下午</td>";
							for (var j in info) {
								if(info[j].tertimedate2!=null) {
									if (info[j].tertimedate2 == '请假') {
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									}else if (info[j].tertimedate2 < '17:30') {
										option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									}  else {
										option += "<td style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";
							$("#tbo").html(option);
							$("#tbo").show();
						}
					}, error: function () {
						layer.msg('网络繁忙');
					}
				});
			})
		});

		//下一周
		$(function () {
			$("#reload2").click(function () {
				var mondaydate;//1
				var sundaydate;//7
				//下周
				var start = $("#start").val();
				var end = $("#end").val();
				mondaydate = parseInt(start) + 7;
				sundaydate = parseInt(end) + 7;

				$("#start").val(mondaydate);
				$("#end").val(sundaydate);

				var teacherid = $("#teacherid").val();
				var startdate = $("#start").val();
				var enddate = $("#end").val();

				$.ajax({
					url: path + '/director/showTeacherAttendDetail',
					async: true,
					type: 'post',
					data: {'teacherid': teacherid, 'startdate': startdate, 'enddate': enddate},
					datatype: 'text',
					success: function (msg) {
						if (msg == "error") {
							//删除所有tr节点
							var table = document.getElementById("tbo");
							var rowNum = table.rows.length;
							if (rowNum > 0) {
								for (var i = 0; i < rowNum; i++) {
									table.deleteRow(i);
									rowNum = rowNum - 1;
									i = i - 1;
								}
								var erroroption;
								erroroption += "<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
								$("#tbo").html(erroroption);
								$("#tbo").show();
							}
						} else {
							layer.msg('查询成功');
							var info = msg;
							console.log("输出的信息=" + info.toString());
							var option;
							//--------------------------上午接送信息------------------------------------
							option += "<tr><td style='text-align: center'>日期</td>";
							for (var j in info) {
								if(info[j].tertime!=null){
									var d = new Date(info[j].tertime);
									var datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate();
									option += "<td style='text-align: center'>" + datetime + "</td>"
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";

							option += "<tr><td style='text-align: center'>上午</td>";
							for (var j in info) {
								if(info[j].tertimedate1!=null) {
									if (info[j].tertimedate1 == '请假') {
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									}else if (info[j].tertimedate1 > '8:30') {
										option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									} else {
										option += "<td style='text-align: center'>" + info[j].tertimedate1 + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";

//--------------------------中午接送信息------------------------------------

							option += "<tr><td style='text-align: center'>中午</td>";
							// var i = 0; i < data.length; i++
							for (var j = 0;j<info.length;j++) {
								console.log(j+"个="+info[j].noon);
								if(null!=info[j].noon&&info[j].noon!='undefined'){
									if(info[j].noon!="请假"){
										console.log("进入到对应的substring"+info[j].noon);
										var noon1 = info[j].noon.substring(0,5);
										var noon2 = info[j].noon.substring(5,10);
										if (noon1 < '12:01' || noon2 > '12:30' ) {
											option += "<td bgcolor='yellow' style='text-align: center'>" + noon1 +"</br>" +noon2+ "</td>"
										}else {
											option += "<td style='text-align: center'>" +noon1 +"</br>" +noon2+ "</td>"
										}
									}
									else if (info[j].noon == '请假') {
										console.log("未进入的substring");
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].noon + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}

							//--------------------------下午接送信息------------------------------------

							option += "<tr><td style='text-align: center'>下午</td>";
							for (var j in info) {
								if(info[j].tertimedate2!=null) {
									 if (info[j].tertimedate2 == '请假') {
										option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									} else if (info[j].tertimedate2 < '17:30') {
										option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									} else {
										option += "<td style='text-align: center'>" + info[j].tertimedate2 + "</td>"
									}
								}else{
									option += "<td style='text-align: center'></td>"
								}
							}
							option += "</tr>";
							$("#tbo").html(option);
							$("#tbo").show();
						}
					}, error: function () {
						layer.msg('网络繁忙');
					}
				});

			})
		});


		//默认显示本周
		$.ajax({
			url: path + '/director/showTeacherAttendDetail',
			async: true,
			type: 'post',
			data: {'tid': tid},
			datatype: 'text',
			success: function (msg) {
				if (msg == "error") {
					var erroroption;
					erroroption += "<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
					$("#tbo").html(erroroption);
					$("#tbo").show();
				} else {
					var info = msg;
					console.log("输出的信息=" + info.toString());
					var option;
					//--------------------------上午接送信息------------------------------------
					option += "<tr><td style='text-align: center'>日期</td>";
					for (var j in info) {
						if(info[j].tertime!=null){
							var d = new Date(info[j].tertime);
							var datetime = d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate();
							option += "<td style='text-align: center'>" + datetime + "</td>"
						}else{
							option += "<td style='text-align: center'></td>"
						}
					}
					option += "</tr>";

					option += "<tr><td style='text-align: center'>上午</td>";
					for (var j in info) {
						if(info[j].tertimedate1!=null) {
							if (info[j].tertimedate1 == '请假') {
								option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
							}else if (info[j].tertimedate1 > '8:30') {
								option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate1 + "</td>"
							} else {
								option += "<td style='text-align: center'>" + info[j].tertimedate1 + "</td>"
							}
						}else{
							option += "<td style='text-align: center'></td>"
						}
					}
					option += "</tr>";

//--------------------------中午接送信息------------------------------------

					option += "<tr><td style='text-align: center'>中午</td>";
					// var i = 0; i < data.length; i++
					for (var j = 0;j<info.length;j++) {
						console.log(j+"个="+info[j].noon);
						if(null!=info[j].noon&&info[j].noon!='undefined'){
							if(info[j].noon!="请假"){
								console.log("进入到对应的substring"+info[j].noon);
								var noon1 = info[j].noon.substring(0,5);
								var noon2 = info[j].noon.substring(5,10);
								if (noon1 < '12:01' || noon2 > '12:30' ) {
									option += "<td bgcolor='yellow' style='text-align: center'>" + noon1 +"</br>" +noon2+ "</td>"
								}else {
									option += "<td style='text-align: center'>" +noon1 +"</br>" +noon2+ "</td>"
								}
							}
							else if (info[j].noon == '请假') {
								console.log("未进入的substring");
								option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].noon + "</td>"
							}
						}else{
							option += "<td style='text-align: center'></td>"
						}
					}

					//--------------------------下午接送信息------------------------------------

					option += "<tr><td style='text-align: center'>下午</td>";
					for (var j in info) {
						if(info[j].tertimedate2!=null) {
							if (info[j].tertimedate2 == '请假') {
								option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
							} else if (info[j].tertimedate2 < '17:30') {
								option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].tertimedate2 + "</td>"
							} else {
								option += "<td style='text-align: center'>" + info[j].tertimedate2 + "</td>"
							}
						}else{
							option += "<td style='text-align: center'></td>"
						}
					}
					option += "</tr>";
					$("#tbo").html(option);
					$("#tbo").show();
				}
			}, error: function (data) {
				layer.alert("网络繁忙！", {icon: 2});
			}
		})
	});
</script>

</body>
</html>
