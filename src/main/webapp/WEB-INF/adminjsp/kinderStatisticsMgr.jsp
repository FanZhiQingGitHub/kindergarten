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
	<title>智慧幼儿园平台端-园所统计</title>
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
	<div style="margin: 6% 5%">
		<div class="layui-inline" style="width:40%;">
			<div id="echarts_div" style="height: 70%;"></div>
		</div>
		<div class="layui-inline" style="margin-left: 8%;width:40%;" >
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
		var sacleArr = [];
		var fundsArr = [];

		$.ajax({
			url:path+"/admin/findKinderStatisticsInfo",
			type:"POST",
			async:true,
			dataType:"text",
			success:function (msg) {
				var scale = JSON.parse(msg.split("@")[0]);
				var funds = JSON.parse(msg.split("@")[1]);

				for(var i in scale)
				{
					nameArr.push(scale[i].scale+"㎡");
					sacleArr.push(scale[i].num);
				}

				for(var j in funds)
				{
					nameArr2.push(funds[j].funds+'元');
					fundsArr.push(funds[j].num);
				}

				createScaleEchars();
				createFundsEchars();

			},
			error:function () {
				alert("网络繁忙！")
			}
		});


		//普通柱状图
		function createScaleEchars() {

			//基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('echarts_div'),'dark');//dark为暗黑主题 不要可以去掉
			// 指定图表的配置项和数据
			var option = {
				title : {
					text : '园所规模统计'
				},
				tooltip : {trigger: 'axis'
					,textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}},
				legend: {
					data: ['规模:㎡' ],
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
					},
					axisLabel: {
						interval:0,
						rotate:40
					}
				},
				yAxis : {type: 'value'},
				series : [
					{
						name : '规模:㎡',
						type : 'bar',
						data : sacleArr,
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"所",
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
		function createFundsEchars() {

			//基于准备好的dom，初始化echarts实例
			var fundsChart = echarts.init(document.getElementById('echarts_div2'),'dark');//dark为暗黑主题 不要可以去掉
			// 指定图表的配置项和数据
			var option2 = {
				title : {
					text : '园所注册资金统计'
				},
				tooltip : {trigger: 'axis'
					,textStyle: {
						fontWeight: "bolder",
						fontSize: "18",
						color: "#fff"
					}},
				legend: {
					data: ['注册资金:元'],
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
						name : '注册资金:元',
						type : 'bar',
						data : fundsArr,
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"所",
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
			fundsChart.setOption(option2);
		}

	});
</script>
</html>
