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
	<title>智慧幼儿园平台端-亲子阅读管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			overflow:hidden;
		}
		#uploadImg{
			margin: 1% 0 0 -6%;
		}
		#demo1{
			width: 50px;
			height: 50px;
		}
		#save{margin-left: 30%;}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<form class="layui-form" action=""  enctype="multipart/form-data" lay-filter="example">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div class="layui-form-item">
				<label class="layui-form-label">图片信息：</label>
				<div class="layui-input-inline">
					<img class="layui-upload-img" id="demo1">
				</div>
				<button type="button" class="layui-btn layui-btn-normal" name="file" id="uploadImg"><i class="layui-icon">&#xe67c;上传图片</i></button>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">内容信息：</label>
				<div class="layui-input-inline">
					<textarea type="text" name="contentInfo" id="contentInfo" lay-verify="title" autocomplete="off" placeholder="请输入绘本信息" class="layui-input" style="width: 300px;height: 80px"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">页数：</label>
				<div class="layui-input-inline">
					<input type="text" name="pageNum" id="pageNum" lay-verify="title" autocomplete="off"
					       class="layui-input"style="width: 300px">
				</div>
			</div>
			<input type="hidden" id="readMagName1" name="readMagName1">
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
		upload.render({
			elem: '#uploadImg' //绑定元素
			,url: path+"/admin/uploadImg" //上传接口
			,auto: false
			,accept: 'images'
			,acceptMime: 'image/*'
			,bindAction: '#save'
			,choose:function(obj){//选择文件的回调，obj为选中的文件
			//将每次选择的文件追加到文件队列
			var files = obj.pushFile();
			//预览选中的文件（本地文件）
			obj.preview(function(index,file,result){
				$('#demo1').attr('src', result);
			});
			}
			,before: function(obj){
				this.data = {
					contentInfo: $("#contentInfo").val()
					,pageNum: $("#pageNum").val()
					,readMagName1: $("#readMagName1").val()
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
	});
</script>
</html>
