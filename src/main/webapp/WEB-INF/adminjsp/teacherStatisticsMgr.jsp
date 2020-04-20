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
		h3 {
			text-align: center;
		}

	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div style="margin: 1% 5%">
		<div id="echarts_div" style="width: 110%;height: 80%;margin: 3% 0 0 -5%"></div>
		<div id="echarts_div2"></div>
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
		var maleArr = [];
		var feMaleArr = [];
		var aAgeArr = [];
		var bAgeArr = [];
		var cAgeArr = [];
		var badArr = [];

		$.ajax({
			url:path+"/admin/findTeacherStatisticsInfo",
			type:"POST",
			async:true,
			// dataType:"json",
			dataType:"text",
			success:function (msg) {
				console.log(msg);
				var sex = JSON.parse(msg.split("@")[0]);
				var age = JSON.parse(msg.split("@")[1]);
				for(var i in age)
				{
					nameArr.push(age[i].time);
					aAgeArr.push(age[i].aCount);
				}
				var num = 0;
				var num1 = 0;
				for(var j in sex)
				{
					var time1 = [];
					time1.push(sex[j].time);
					var nary = time1.sort();
					if(sex[j].teachersex == "男")
					{
						// for (var a = 0; a < nary.length - 1; a++) {
						// 	if (nary[a] == nary[a + 1]) {
						// 		var num2 = (sex[a].maleCount + sex[a + 1].maleCount);
						// 		maleArr.push(num2);
						// 	}else{
						// 		maleArr.push(sex[j].maleCount);
						// 	}
						// }
						num += sex[j].maleCount;
					}else{

						// for (var b = 0; b < nary.length - 1; b++) {
						// 	if (nary[b] == nary[b + 1]) {
						// 		var num3 = (sex[b].maleCount + sex[b + 1].maleCount);
						// 		feMaleArr.push(num3);
						// 	}else{
						// 		feMaleArr.push(sex[j].maleCount);
						// 	}
						// }
						num1 += sex[j].maleCount;
					}
				}
				console.log(maleArr);
				console.log(feMaleArr);
				maleArr.push(num);
				feMaleArr.push(num1);
				createEchars();// 创建普通柱状图
			},
			error:function () {
				alert("网络繁忙！")
			}
		});


		//普通柱状图
		function createEchars() {

			//基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('echarts_div'),'dark');//dark为暗黑主题 不要可以去掉
			// 指定图表的配置项和数据
			var option = {
				title : {
					text : '教师统计'
				},
				tooltip : {trigger: 'axis'},
				legend: {
					data: ['男性','女性' , '0~3岁', '3~5岁','大于5岁']
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
					data : nameArr
				},
				yAxis : {type: 'value'},
				series : [
					{
						name : '男性',
						type : 'bar',
						data : maleArr,
						// data : [1,2,3,4],
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "12",
										color: "#fff"
									}
								},
							}
						}
					},
					{
						name : '女性',
						type : 'bar',
						data : feMaleArr,
						// data : [1,2,3,4],
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "12",
										color: "#fff"
									}
								},
							}
						}
					},
					{
						name : '0~3岁',
						type : 'bar',
						data : aAgeArr,
						// data : [1,3,1,2],
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "12",
										color: "#fff"
									}
								},
							}
						}
					},
					{
						name : '3~5岁',
						type : 'bar',
						data : bAgeArr,
						// data : [1,3,1,2],
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "12",
										color: "#fff"
									}
								},
							}
						}
					},
					{
						name : '大于5岁',
						type : 'bar',
						data : cAgeArr,
						// data : [1,3,1,2],
						itemStyle: {
							normal: {
								label: {
									formatter: "{c}"+"人",
									show: true,
									position: "top",
									textStyle: {
										fontWeight: "bolder",
										fontSize: "12",
										color: "#fff"
									}
								},
							}
						}
					},
				],
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	});
</script>
</html>
