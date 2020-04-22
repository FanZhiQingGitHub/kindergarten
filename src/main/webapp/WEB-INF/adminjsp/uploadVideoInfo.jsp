<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-12
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-上传视频</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			overflow:hidden;
		}
		#save{margin-left: 30%;}
		div{
			margin: 2% 4%;
		}
		.layui-input{
			margin: -2% -9%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<form class="layui-form" action=""  enctype="multipart/form-data" lay-filter="example">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div class="layui-form-item">
				<label class="layui-form-label">上传视频：</label>
				<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadVideo"><i class="layui-icon">&#xe624;</i></button>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">视频名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="safetyVideoName" id="safetyVideoName" placeholder="请输入视频名称" style="width: 140%;">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">文件名称：</label>
				<div class="layui-input-inline">
					<input type="text" id="videoName" name="videoName" placeholder="请输入文件名称" value=""
					       autocomplete="off" class="layui-input" style="width: 140%" readonly>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="videoAdd" name="videoAdd" placeholder="请输入文件地址" value=""
					       autocomplete="off" class="layui-input" style="width: 140%" readonly>
				</div>
			</div>
			<div class="demoTable">
				<div style="padding-bottom: 10px;">
					<div class="layui-upload">
						<button type="button" class="layui-btn" id="save">保存</button>
						<button type="button" class="layui-btn" id="cancel">取消</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
<script>
	layui.use(['form', 'layer', 'upload', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery
			,upload = layui.upload;
		var path = $("#path").val();
		var uploadInst = upload.render({
			elem: '#uploadVideo' //绑定元素
			,url: path+"/admin/uploadVideo" //上传接口
			,auto: false
			,accept: 'video'
			// ,acceptMime: 'image/*'
			,bindAction: '#save'
			,choose:function(obj){//选择文件的回调，obj为选中的文件
			//将每次选择的文件追加到文件队列
			var files = obj.pushFile();
			//预览选中的文件（本地文件）
			obj.preview(function(index,file,result){
				$("#videoName").val(file.name);
				$("#videoAdd").val("videos/"+file.name);
			});
			}
			,before: function(obj){
				this.data = {
					safetyVideoName: $("#safetyVideoName").val()
					,videoName: $("#videoName").val()
					,videoAdd: $("#videoAdd").val()
				}
			}
			,done: function(res){
				//上传完毕回调
				if(res.code > 0){
					return layer.msg('上传失败');
				}
				layer.alert("上传成功！",{icon:6});
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				setTimeout(function () {
					parent.layer.close(index); //再执行关闭
				}, 6000);
			}
			,error: function(){
				//请求异常回调
				layer.alert("上传失败！",{icon:2});
			}
		});

		// $(function () {
		// 	$("#cancel").click(function () {
		// 		layer.closeAll();
		// 	})
		// })
		
		//搜索功能的实现
		// $('.demoTable .layui-btn').on('click', function () {
		// 	var type = $(this).data('type');
		// 	active[type] ? active[type].call(this) : '';
		// });

		// var $ = layui.$, active = {
		// 	reload: function () {
		// 		//执行重载
		// 		table.reload('demotable', {
		// 			where: {
		// 				time1: $('#time1').val()
		// 				, time2: $('#time2').val()
		// 			}
		// 			, page: {
		// 				curr: 1
		// 			}
		// 		});
		// 	}
		// };

		// // 刷新表格
		// $('#btn-refresh').on('click', function () {
		// 	tableIns.reload();
		// });
	});
</script>
</html>
