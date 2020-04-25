<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/21
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>直播中心</title>
</head>
<body>

<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<div class="layadmin-user-login-box layadmin-user-login-header">
	<h2 style="margin-left: 46%">直播中心</h2>
</div>
<div class="layui-inline" style="width:100%;">
	<hr>
</div>

<div class="layui-fluid" id="searchTable" style="top:5px;margin-left: 20%">
	<div class="layadmin-user-login-box layadmin-user-login-header">
		<div style="padding-bottom: 10px;">

			<div class="layui-inline">
				<label class="layui-form-label" style="font-size: 16px">当前时间：</label>
				<div class="layui-input-inline">
					<p id="dateinfo"
					   style="width: 200px;height:35px ; margin-top:4% ;text-align: center;font-size: 16px"></p>
				</div>
			</div>
		</div>
	</div>
</div>



<table id="dataTable" lay-filter="test"></table>

<script type="text/html" id="butdiv">

	<button class="layui-btn layui-btn-sm layui-btn-normal play"><i class="layui-icon">&#xe652;</i>播放视频</button>

</script>










<script>



	layui.use(['table', 'jquery', 'layer', 'form'], function () {
		var table = layui.table;
		var layer = layui.layer;


		function timeTimer() {
			var d = new Date();//实例化日期对象
			var a = d.toLocaleTimeString();//获取日期
			var b = d.toLocaleDateString();//获取时间
			document.getElementById("dateinfo").innerHTML = b + "&nbsp" + "&nbsp" + "&nbsp" + a;//.innerHTML是dom里面的方法（获取对象的内容  或  向对象插入内容，可以直接在网页上显示）
		}//系统时间显示
		setInterval(function () {
			timeTimer()
		}, 1000);//时间显示


		//第一个实例
		table.render({
			elem: '#dataTable'
			, height: 550
			, url: path + '/parent/showMonitorInfo' //数据接口
			, page: true //开启分页
			, id: 'searchTable'
			, limit: 5
			, limits: [5, 10, 15, 20]
			, cols: [[ //表头
				{field: 'monitorid', title: '监控位置ID', fixed: 'left', align: 'center'}
				, {field: 'monitorname', title: '监控区域',  align: 'center'}
				, {field: 'monitorimgurl', title: '监控图片',  align: 'center',templet:'<div><img src="${pageContext.request.contextPath}/{{d.monitorimgurl}}"></div>'}
				, {field: 'monitormvurl', title: '视频地址',  align: 'center', hide: 'true'}
				, {field: 'kid', title: '园所ID',  align: 'center', hide: 'true'}
				, {field: '', title: '操作', toolbar: "#butdiv",  align: 'center'}
			]],
		});

		$('#searchTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			if (type == 'reload') {
				//执行重载
				table.reload('searchTable', {
					page: {
						curr: 1 //重新从第 1 页开始
					}
					, where: {
						key: $("#classname").val(),
					}
				});
			}
		});


		//打开监控视频
		$('body').on('click', '.play', function () {
			var monitorname = $(this).parents('tr').children('td').eq(1).text();
			var videoUrl = $(this).parents('tr').children('td').eq(3).text();
			layer.open({
				//打开一个窗口播放视频
				type: 1,
				area: ['95%', '80%'],
				offset:['10%','3%'],
				title:monitorname,
				content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
					'<source src="${pageContext.request.contextPath}/'+videoUrl+'" type="video/mp4"></source></video>'
				//直接跳出一个标签播放视频
			});
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
