<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-17
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-教师统计</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<script src=<%=path + "/js/echarts.js"%>></script>
	<style>
		body{
			font-size: 18px;
		}
		h3 {
			text-align: center;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div style="margin: 6% 3%">
		<div class="layui-inline" style="width:30%;">
			<div id="echarts_div" style="height: 70%;"></div>
		</div>
		<div class="layui-inline" style="margin-left: 6%;width:40%;" >
			<div id="echarts_div2" style="height: 70%;"></div>
		</div>
	</div>
</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery;
		var path = $("#path").val();
		var nameArr = [];
		var nameArr2 = [];
		var sexArr = [];
		var ageArr = [];

		$.ajax({
			url:path+"/admin/findTeacherStatisticsInfo",
			type:"POST",
			async:true,
			dataType:"text",
			success:function (msg) {
				console.log(msg);
				var sex = JSON.parse(msg.split("@")[0]);
				var age = JSON.parse(msg.split("@")[1]);

				for(var i in sex)
				{
					nameArr.push(sex[i].sex);
					sexArr.push(sex[i].num);
				}

				for(var j in age)
				{
					nameArr2.push(age[j].age+'岁');
					ageArr.push(age[j].num);
				}

				createSexEchars();
				createAgeEchars();

			},
			error:function () {
				alert("网络繁忙！")
			}
		});


		//普通柱状图
		function createSexEchars() {

			//基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('echarts_div'),'dark');//dark为暗黑主题 不要可以去掉
			// 指定图表的配置项和数据
			var option = {
				title : {
					text : '教师性别统计'
				},
				tooltip : {trigger: 'axis'
					,textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}},
				legend: {
					data: ['男性','女性' ],
					textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}
				},
				toolbox: {
					show: true,
					feature: {
						dataView: {show: true, readOnly: false},
						magicType: {show: true, type: ['line', 'bar']},
						restore: {show: true},
						saveAsImage: {show: true}
					}
				},
				calculable: true,
				xAxis : {
					type: 'category',
					data : nameArr,
					nameTextStyle :{
						fontSize: 28
					}
				},
				yAxis : {type: 'value'},
				series : [
					{
						name : '性别',
						type : 'bar',
						data : sexArr,
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "18",
										color: "#fff"
									}
								}
							}
						},
						nameTextStyle :{
							fontSize: 28
						}
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}

		//普通柱状图
		function createAgeEchars() {

			//基于准备好的dom，初始化echarts实例
			var ageChart = echarts.init(document.getElementById('echarts_div2'),'dark');//dark为暗黑主题 不要可以去掉
			// 指定图表的配置项和数据
			var option2 = {
				title : {
					text : '教师年龄统计'
				},
				tooltip : {trigger: 'axis'
					,textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}},
				legend: {
					data: ['年龄'],
					textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}
				},
				toolbox: {
					show: true,
					feature: {
						dataView: {show: true, readOnly: false},
						magicType: {show: true, type: ['line', 'bar']},
						restore: {show: true},
						saveAsImage: {show: true}
					}
				},
				calculable: true,
				xAxis : {
					type: 'category',
					data : nameArr2,
					axisLabel: {
						interval:0,
						rotate:40
					},
					nameTextStyle :{
						fontSize: 28
					}
				},
				yAxis : {type: 'value'},
				series : [
					{
						name : '年龄',
						type : 'bar',
						data : ageArr,
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "18",
										color: "#fff"
									}
								}
							}
						},
						nameTextStyle :{
							fontSize: 28
						}
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			ageChart.setOption(option2);
		}

	});
</script>
</html>
