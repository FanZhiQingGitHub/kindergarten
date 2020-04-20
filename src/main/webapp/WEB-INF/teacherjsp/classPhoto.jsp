<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/3/10
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>班级相册</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>
<div class="demoTable" style="padding: 15px">
	<div class="layui-form-item" style="display: inline-block;width: 10%;">
		<label class="layui-form-label" style="float: right;width: 100px">班级名称：${classname}</label>
	</div>

	<div class="layui-form-item" style="text-align: right;padding-right: 10%;">
		<div class="layui-input-block">
			<input class="layui-btn layui-btn-normal" onclick="addPhoto(this)" type="button"
			       value="新增照片" style="width: 100px;">
		</div>
	</div>

</div>

<table id="demo" lay-filter="test">
	<input type="hidden" id="path" value="<%=path%>">
</table>
</body>
<script>
	//新增照片
	function addPhoto(node) {

		layui.use('layer', function () {
			var layer = layui.layer;
			var $ = layui.jquery;
			var path = $("#path").val();
			layer.open({
				type: 2,
				title: false,
				fix: false,
				maxmin: false,
				shadeClose: true,
				shade: 0.3,
				area: ['500px', '450px'],
				btn: ['确定', '取消'],
				content: path + '/teacher/toUrl/addPhoto',
				// end: function () {
				// 	location.reload();
				// }
				btn1: function(index){
					// var index1 = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					// parent.layer.close(index1); //再执行关闭
					location.href=path+'/teacher/toUrl/classPhoto';

				}
			});
		});
	}
	layui.use(['table','laydate','layer'], function(){
		var laydate = layui.laydate;
		var layer = layui.layer;
		var table = layui.table;
		var $ = layui.jquery;
		var path=$("#path").val();

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 412
			,url: path+'/teacher/classphoto' //数据接口
			,page: true //开启分页
			,id: 'demoTable'
			,cols: [[ //表头
				{field: 'photoid', title: '照片编号', width:150, sort: true, fixed: 'left'}
				,{field: 'photoname', title: '照片名称', width:150}
				,{field: 'photodetail', title: '照片描述', width:150}
				,{field: 'photourl', title: '图片', width:200}
				,{field: 'phototime', title: '图片上传时间', width:200}


			]]
		});



	});
</script>

</html>