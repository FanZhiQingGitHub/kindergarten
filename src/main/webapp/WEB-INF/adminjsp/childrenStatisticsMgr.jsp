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
	<title>智慧幼儿园平台端-幼儿统计</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<script src=<%=path + "/js/echarts.js"%>></script>
	<style>
		h3 {
			text-align: center;
		}

		.layui-table-cell {
			height: 40px;
			line-height: 40px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div style="margin: 1% 10%">
		<div id="echarts_div" style="width: 100%;height: 80%;margin: 3% 0 0 -5%"></div>
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
		var normalArr = [];
		var wellArr = [];
		var badArr = [];

		$.ajax({
			url:path+"/admin/findChildrenStatisticsInfo",
			type:"POST",
			async:true,
			// dataType:"json",
			dataType:"text",
			success:function (msg) {
				console.log(msg);
				var male = JSON.parse(msg.split("@")[0]);
				var feMale = JSON.parse(msg.split("@")[1]);
				var aAge = JSON.parse(msg.split("@")[2]);
				var bAge = JSON.parse(msg.split("@")[3]);
				var cAge = JSON.parse(msg.split("@")[4]);
				var status = JSON.parse(msg.split("@")[5]);
				// // var arr = eval(msg);

				for(var i in male)
				{
					nameArr.push(male[i].time);
					maleArr.push(male[i].maleCount);
				}

				for(var j in feMale)
				{
					feMaleArr.push(feMale[j].feMaleCount);
				}


				// for(var k in aAge) {
				// 	var time1 = [];
				// 	if(aAge.length == 0)
				// 	{
				// 		aAgeArr.push(0);
				// 	}
				// 	time1.push(aAge[k].time);
				// 	var nary = time1.sort();
				// 	if(nary.length >= 2)
				// 	{
				// 		for (var a = 0; a < nary.length - 1; a++) {
				// 			if (nary[a] == nary[a + 1]) {
				// 				var num = (aAge[a].aCount + aAge[a + 1].aCount);
				// 				aAgeArr.push(num);
				// 			}
				// 		}
				// 		aAgeArr.push(aAge[k].aCount);
				// 	}else{
				// 		if(aAge[k].aCount == 0)
				// 		{
				// 			aAgeArr.push(0);
				// 		}
				// 			aAgeArr.push(aAge[k].aCount);
				//
				// 	}
				// }
				//
				// for(var k1 in bAge) {
				// 	var t2 = [];
				// 	if(bAge.length == 0)
				// 	{
				// 		bAgeArr.push(0);
				// 	}
				// 	t2.push(bAge[k1].time);
				// 	var nary = t2.sort();
				// 	if(nary.length >= 2) {
				// 		for (var b = 0; b < nary.length - 1; b++) {
				// 			if (nary[b] == nary[b + 1]) {
				// 				var num = (bAge[b].bCount + bAge[b + 1].bCount);
				// 				bAgeArr.push(num);
				// 			}
				// 			bAgeArr.push(bAge[k1].bCount);
				// 		}
				// 	}else{
				// 		if(bAge[k1].bCount == 0)
				// 		{
				// 			bAgeArr.push(0);
				// 		}
				// 			bAgeArr.push(bAge[k1].bCount);
				// 	}
				// }
				//
				// for(var k2 in cAge) {
				// 	var t3 = [];
				// 	if(cAge.length == 0)
				// 	{
				// 		cAgeArr.push(0);
				// 	}
				// 	t3.push(cAge[k2].time);
				// 	var nary = t3.sort();
				// 	if(nary.length >= 2) {
				// 		for (var c = 0; c < nary.length - 1; c++) {
				// 			if (nary[c] == nary[c + 1]) {
				// 				var num = (cAge[c].cCount + cAge[c + 1].cCount);
				// 				cAgeArr.push(num);
				// 			}
				// 			cAgeArr.push(cAge[k2].cCount);
				// 		}
				// 	}else{
				// 		if(cAge[k2].cCount == 0){
				// 			cAgeArr.push(0);
				// 		}
				// 			cAgeArr.push(cAge[k2].cCount);
				//
				// 	}
				//
				// }
				// console.log(valueArr);


				var nary;
				for(var k in aAge) {
					var time1 = [];
					if(aAge.length == 0)
					{
						aAgeArr.push(0);
					}
					time1.push(aAge[k].time);
					nary = time1.sort();
					if(nary.length >= 2)
					{
						console.log(nary.length);
						for (var a = 0; a < nary.length - 1; a++) {
							if (nary[a] == nary[a + 1]) {
								var num = (aAge[a].aCount + aAge[a + 1].aCount);
								aAgeArr.push(num);
							}
						}
						aAgeArr.push(aAge[k].aCount);
					}else{
						if(aAge[k].aCount == 0)
						{
							aAgeArr.push(0);
						}
						aAgeArr.push(aAge[k].aCount);
					}
				}

				for(var k1 in bAge) {
					var t2 = [];
					if(bAge.length == 0)
					{
						bAgeArr.push(0);
					}
					t2.push(bAge[k1].time);
					var nary = t2.sort();
					if(nary.length >= 2) {
						for (var b = 0; b < nary.length - 1; b++) {
							if (nary[b] == nary[b + 1]) {
								var num = (bAge[b].bCount + bAge[b + 1].bCount);
								bAgeArr.push(num);
							}
							bAgeArr.push(bAge[k1].bCount);
						}
					}else{
						if(bAge[k1].bCount == 0)
						{
							bAgeArr.push(0);
						}
						bAgeArr.push(bAge[k1].bCount);
					}
				}

				for(var k2 in cAge) {
					var t3 = [];
					if(cAge.length == 0)
					{
						cAgeArr.push(0);
					}
					t3.push(cAge[k2].time);
					var nary = t3.sort();
					if(nary.length >= 2) {
						for (var c = 0; c < nary.length - 1; c++) {
							if (nary[c] == nary[c + 1]) {
								var num = (cAge[c].cCount + cAge[c + 1].cCount);
								cAgeArr.push(num);
							}
							cAgeArr.push(cAge[k2].cCount);
						}
					}else{
						if(cAge[k2].cCount == 0){
							cAgeArr.push(0);
						}
						cAgeArr.push(cAge[k2].cCount);
					}
				}

				for(var h in status)
				{
					var t4 = [];
					if(status.length == 0)
					{
						normalArr.push(0);
						wellArr.push(0);
						badArr.push(0);
					}
					t4.push(status[h].time);
					var nary = t4.sort();
					if(nary.length >= 2) {
						for (var d = 0; d < nary.length - 1; d++) {
							if (nary[d] == nary[d + 1]) {
								var num = (status[d].normalCount + status[d+1].normalCount);
								if(status[h].healthstatus == "正常")
								{
									normalArr.push(num);
								}else if(status[h].healthstatus == "良好")
								{
									wellArr.push(num);
								}else if(status[h].healthstatus == "很差"){
									badArr.push(num);
								}
							}
							if(status[h].healthstatus == "正常")
							{
								normalArr.push(status[h].normalCount);
							}else if(status[h].healthstatus == "良好")
							{
								wellArr.push(status[h].normalCount);
							}else if(status[h].healthstatus == "很差"){
								badArr.push(status[h].normalCount);
							}
						}
					}else{
						if(status[h].normalCount == 0){
							if(status[h].healthstatus == "正常")
							{
								normalArr.push(0);
							}else if(status[h].healthstatus == "良好")
							{
								wellArr.push(0);
							}else if(status[h].healthstatus == "很差"){
								badArr.push(0);
							}
						}

						if(status[h].healthstatus == "正常")
						{
							normalArr.push(status[h].normalCount);
						}else if(status[h].healthstatus == "良好")
						{
							wellArr.push(status[h].normalCount);
						}else if(status[h].healthstatus == "很差"){
							badArr.push(status[h].normalCount);
						}
					}
				}
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
					text : '幼儿统计'
				},
				tooltip : {trigger: 'axis'},
				legend: {
					data: ['男性','女性' , '健康状况：正常', '0~3岁', '3~5岁','大于5岁','健康状况：良好','健康状况：一般','健康状况：很差']
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
								}
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
								}
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
								}
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
								}
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
								}
							}
						}
					},
					{
						name : '健康状况：正常',
						type : 'bar',
						data : normalArr,
						// data : [1,3,1,4],
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
								}
							}
						}
					},
					{
						name : '健康状况：良好',
						type : 'bar',
						data : wellArr,
						// data : [0,1,1,1],
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
								}
							}
						}
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	});
</script>
</html>
