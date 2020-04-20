<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/17
  Time: 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>宝宝膳食查看</title>
</head>
<body>

<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<h1 align="center">膳食查看列表</h1>

<table id="dataTable" lay-filter="test"></table>

<script type="text/html" id="barDemo">

	<button class="layui-btn edit layui-btn-xs"  lay-event="showMealDetail">查看</button>

</script>


<script type="text/javascript">

	layui.use(['table', 'jquery','layer','form'], function () {
		var table = layui.table;
		var layer = layui.layer;
		//第一个实例
		table.render({
			elem: '#dataTable'
			,text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
				none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
			}
			, height: 280
			, url: path + '/parent/findAllMealInfo' //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10, 15, 20]
			, cols: [[ //表头
				{field: 'mealid', title: '膳食编号', width: 200, align: 'center'}
				, {field: 'mealstarttime', title: '起始时间', align: 'center'}
				, {field: 'mealendtime', title: '结束时间', align: 'center'}
				, {field: '', title: '操作', toolbar: "#barDemo", width: 200, align: 'center'}
			]]
		});



		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event  对应的值

			//事件等于查看
			if (layEvent === 'showMealDetail') {

				layer.open({
					type: 2,
					area: ['80%', '58%'],
					offset: ['10%', '9.5%'],
					title: '膳食信息详情',
					content: path + '/parent/toUrl/AccommodationDetail' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						var body = layer.getChildFrame("body", index);
						//给显示的赋值
						body.find("#mealId").val(data.mealid);





					}
				});


			}






		});








	});


	$(function () {

		//前往家长端主页
		$("#backMain").click(function () {
			window.location.href=path+"/parent/toUrl/parentMain"
		})

	});


</script>

</body>
</html>
