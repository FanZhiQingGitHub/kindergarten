<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/9
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>安全教育配置</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
	<style type="text/css">
		html, body {
			margin: 0;
			padding: 0;
		}
		#workeva{
			margin-left: 30px;
			min-height: 36px;
		}

	</style>

</head>
<body>
<h1 style="margin-left: 17%;font-size: 40px;color: coral">安全教育配置</h1>
<%--    选择班级--%>

<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
	<button class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal addSafetyVideo" style="margin-top: 2px">
		新增
	</button>
	</div>

	<table id="demo" lay-filter="test">
		<input type="hidden" id="path" value="<%=path%>">
	</table>
</div>


<div id="type-content" style="display: none;">
	<div class="layui-form-item">
		<div class="layui-input-block">
<%--			<label class="layui-form-label" >选择班级：</label>--%>
			<h5>选择班级：</h5>
			<select name="selectClass" id="selectClass" lay-verify="required" style="width: 100px">
				<option value="" selected>请选择班级</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block">
			<%--			<label class="layui-form-label" >选择班级：</label>--%>
			<h5>视频名称：</h5>
			<select name="selectVideoName" id="selectVideoName" lay-verify="required" style="width: 100px">
				<option value="" selected>请选择视频</option>
			</select>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">布置时间：</label>
		<div class="layui-input-inline">

			<input type="text" class="layui-input" id="startDate" name="startDate" placeholder="请选择起始日期">

		</div>
		<label class="layui-form-label">完成时间：</label>
		<div class="layui-input-inline" style="text-align: left;">
			<input type="text" class="layui-input" id="endDate" name="endDate" placeholder="请选择结束日期">

		</div>
	</div>
</div>
<script type="text/html" id="barDemo">
	<%--		<a class="layui-btn layui-btn-primary layui-btn-xs questions" >查看配置试题</a>--%>
	{{#  if(d.safetytestresult == null ){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="SafetyTest">安全试题</a>
	{{#  } }}
</script>
<script>

	layui.use(['table','laydate','layer','jquery'], function() {
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path = $("#path").val();

		laydate.render({
			elem: '#startDate' //指定元素
			,type: 'datetime'
			, theme: '#009688'
			// , showBottom: false
			// , format: 'yyyy-MM-dd HH:mm:ss'

			, done: function (value, date, endDate) {
				var startTime = new Date(value).getTime();
				var endTime = new Date($('#endDate').val()).getTime();
				if (endTime < startTime) {
					layer.msg('结束时间不能小于开始时间');
				}
			}
		});
		laydate.render({
			elem: '#endDate' //指定元素
			// ,type: 'datetime'
			, theme: '#009688'
			, showBottom: false
			, format: 'yyyy-MM-dd HH:mm:ss'

			, done: function (value, date, startDate) {
				var startTime = new Date($('#startDate').val()).getTime();
				var endTime = new Date(value).getTime();
				if (endTime < startTime) {
					layer.msg('结束时间不能小于开始时间');
				}
			}
		});

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 300
			,url: path+'/teacher/safetyVideoTable' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'safetyvideoid', title: '视频编号', width:100, sort: true, fixed: 'left'}
				,{field: 'safetyvideoname', title: '视频名称', width:200}
				,{field: 'safetyvideotime', title: '布置时间', width:200, templet:" <div>{{layui.util.toDateString(d.safetyvideotime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				,{field: 'safetyfinishtime', title: '完成时间', width:200,templet:" <div>{{layui.util.toDateString(d.safetyfinishtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				,{field: 'classname', title: '班级名称', width:150}
				,{field: '', title: '操作', toolbar: '#barDemo' , width:200}
			]]
		});


        // 新增安全教育视频
		// $("#addSafetyVideo").click(function () {
		// 	layer.open({
		// 		type: 2,
		// 		area: ['70%', '80%'],
		// 		btn: ['确定', '取消'],
		// 		offset: ['10%', '3%'],
		// 		title:"智慧幼儿园-新增安全教育视频",
		// 		btn1: function (index, layero) {
		// 			//layer.getChildFrame("form", index)获取iframe的表单
		// 			//serializeArray jquery方法，将表单对象序列化为数组
		// 			layer.close(index);
		// 		},
		// 		content: path + '/teacher/toUrl/safetyConfig' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
		// 		, success: function (layero, index) {
		// 		}
		// 	});
		// });


		$('body').on('click', '.addSafetyVideo', function () {
			$(function () {
				$.ajax({
					//提交数据的类型 POST GET
					type:"POST",
					//提交的网址
					url:path + '/teacher/selectClass',
					//提交的数据
					//返回数据的格式
					datatype:"json",//“xml”, “html”, “script”, “json”, “jsonp”, “text”.
					//成功返回之后调用的函数
					success: function (data) {
						console.log(data);
						var list = "";
						for(var i=0;i<data.length;i++){
							list = data[i].classname ;
							console.log("list="+list);
							$('#selectClass').append(new Option(list));// 下拉菜单里添加元素
						}

					}, error:function () {
						alert("查询班级失败！！！")
					}
				});

				$.ajax({
					//提交数据的类型 POST GET
					type:"POST",
					//提交的网址
					url:path + '/teacher/selectVideoName',
					//提交的数据
					//返回数据的格式
					datatype:"json",//“xml”, “html”, “script”, “json”, “jsonp”, “text”.
					//成功返回之后调用的函数
					success: function (data) {
						console.log(data);
						var list = "";
						for(var i=0;i<data.length;i++){
							list = data[i].safetyvideoname;
							console.log("list="+list);
							$('#selectVideoName').append(new Option(list));// 下拉菜单里添加元素
						}

					}, error:function () {
						alert("查询视频名称失败！！！")
					}
				});
			});
			layer.open({
				type: 1,
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: '安全教育配置',
				btn: ['确定', '取消'],
				offset: '100px',
				btnAlign: 'c',
				btn1: function (index) {

					var classname = $("#selectClass").val();
					var safetyvideoname = $("#selectVideoName").val();
					var startDate= $("#startDate").val();
					var endDate= $("#endDate").val();
					console.log(classname);
					console.log(safetyvideoname);
					console.log(startDate);
					console.log(endDate);
					if (classname.length ==0 ) {
						console.log("进来");
						layer.alert("请选择班级", {icon: 2});
					}else if (safetyvideoname.length ==0) {
						layer.alert("请选择视频", {icon: 2});
					}else if (startDate.length ==0) {
						layer.alert("请选择开始时间", {icon: 2});
					} else if (endDate.length ==0) {
						layer.alert("请选择结束完成时间", {icon: 2});
					} else {

						$.ajax({
							url: path + '/teacher/addSafetyConfig',
							async: true,
							type: 'post',
							data: {"classname": classname,"safetyvideoname":safetyvideoname,"startDate": startDate,"endDate":endDate},
							datatype: 'text',
							success: function (data) {
								console.log(data);
								if (data =="success") {
									console.log("配置成功");
									alert("配置成功");
									$(":input").val(" ");
									//当你在iframe页面关闭自身时
									var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
									parent.layer.close(index); //再执行关闭
									///location.href = "login.html";
								}

								else {
									layer.msg('配置失败');
								}
							}, error: function (data) {
								layer.alert("网络繁忙！", {icon: 2});
							}
						});

					}
				}
			});
		});

		//layui按钮绑定绑定查询事件
		$('.layui-btn').click(function () {
			//获取按钮类型
			var type = $(this).data('type');

		});
		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值

             //事件等于做安全试题
			if (layEvent === 'SafetyTest') {
				layer.open({
					//打开一个窗口做题
					type: 2,
					area: ['70%', '70%'],
					btn: ['确定', '取消'],
					offset:['10%','5%'],
					title:'安全教育试题',
					btn1: function(index){
						// var index1 = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						// parent.layer.close(index1); //再执行关闭
						location.href=path+'/teacher/toUrl/safetyEducation';

					},
					content: path+"/teacher/SafetyTestQuestion?safetyVideoId="+data.safetyvideoid
				});

			}
		});
		});
	//将表单转为js对象数据
	function serializeObject($, array){
		var obj=new Object();
		$.each(array, function(index,param){
			if(!(param.name in obj)){
				obj[param.name]=param.value;
			}
		});
		return obj;
	}
</script>
</body>
</html>
