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
	<title>查看提交作业</title>
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
<h1 style="margin-left: 17%;font-size: 40px;color: coral">查看作业表</h1>

<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;width: 100px">班级名称：${classname}</label>
	</div>


	<%--</div>--%>
	<table id="demo" lay-filter="test">
		<input type="hidden" id="path" value="<%=path%>">
	</table>
	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<div class="layui-input-block" id="workeva">
				<label class="layui-form-label" >作业评级：</label>
				<select name="selectClass" id="score" lay-verify="required" style="width: 100px">
					<option value="" >请打分</option>
					<option value="A" selected>A</option>
					<option value="B" selected>B</option>
					<option value="C" selected>C</option>
					<option value="D" selected>D</option>
				</select>
			</div>
		</div>

	</div>

	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="downloadWork">查看下载作业</a>
		<a class="layui-btn layui-btn-danger layui-btn-xs score" >打分</a>
	</script>


</body>
<script>

	layui.use(['table','laydate','layer'], function() {
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path = $("#path").val();

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 300
			,url: path+'/teacher/checkWorkTable' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'sid', title: '宝宝编号', width:150, sort: true, fixed: 'left'}
				,{field: 'studentname', title: '学生名称', width:150}
				,{field: 'parentname', title: '家长名称', width:150}
				,{field: 'workreleasetime', title: '布置时间', width:200}
				,{field: 'wfinishtime', title: '完成时间', width:200}
				,{field: '', title: '操作', toolbar: '#barDemo' , width:200}
				, {field: 'workreleaseid', title: '发布作业', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'workid', title: '作业id', width: 100, edit: 'text', align: 'center', hide: true}
				, {field: 'workurl', title: '作业路径', width: 100, edit: 'text', align: 'center', hide: true}

			]]
		});
		//打分
		$('body').on('click', '.score', function () {
			var type = $(this).text();
			console.log("type=" + type);

			var $td = $(this).parents('tr').children('td');
			var sid = $td.eq(0).text();//获取点击按钮相对应的id
			var $td = $(this).parents('tr').children('td');
			var workreleaseid = $td.eq(6).text();//获取点击按钮相对应的id
			var $td = $(this).parents('tr').children('td');
			var workid = $td.eq(7).text();//获取点击按钮相对应的id
			console.log("sid=" + sid);

			layer.open({
				type: 1,
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: '作业打分',
				btn: ['确定', '取消'],
				offset: '200px',
				btnAlign: 'c',
				btn1: function (index) {

					var score = $("#score").val();
					console.log("score=" + score);

					$.ajax({
						url: path + '/teacher/workScore',
						async: true,
						type: 'post',
						data: {"score": score,"sid":sid,"workreleaseid":workreleaseid},
						datatype: 'text',
						success: function (data) {
							console.log(data);
							if (data =="success") {
								console.log("打分返回");
								layer.alert("打分成功",{icon:6});
								$(":input").val(" ");
								//当你在iframe页面关闭自身时
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭
								///location.href = "login.html";
							}
							else if (data =="error") {
								console.log("打分失败");
								layer.msg('打分失败',{icon:2});
								///location.href = "login.html";
							}
							else {
								layer.msg('修改失败',{icon:2});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});

				}
			});
		});

		//layui按钮绑定查询事件
		$('.layui-btn').click(function () {
			//获取按钮类型
			var type = $(this).data('type');

		});
		//下载作业
		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值


			//事件等于下载
			if (layEvent === 'downloadWork') {
				var downloadWorkUlr = data.workurl;
				console.log(downloadWorkUlr);
				window.location.href=path+'/teacher/download?workUrl='+downloadWorkUlr
			}
		});

	});
	//将表单转为js对象数据
	function serializeObject(array){
		var obj=new Object();

		$.each(array, function(index,param){
			if(!(param.name in obj)){
				obj[param.name]=param.value;
			}
		});
		return obj;
	}
</script>

</html>
