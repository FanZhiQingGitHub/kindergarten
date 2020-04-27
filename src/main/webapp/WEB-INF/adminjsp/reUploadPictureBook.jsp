<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-13
  Time: 7:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-重新上床绘本</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			overflow:hidden;
			font-size: 120%;
		}

		.layui-input{
			width:180%;
			margin: auto;
		}

		h3 {
			text-align: center;
		}
		.layui-table-cell {
			height: 70px;
			line-height: 70px;
			white-space:normal;
			font-size: 140%;
		}

		.sp{
			font-size: 140%;
			height: 40px;
			line-height: 40px;
		}
		body .demo-class .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}

		body .demo .layui-layer-btn{
			margin-top: -5%;
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}
		body .demo .layui-layer-content{
			font-Size:18px
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">

	<div class="layui-main readInfo">
		<form id="reUploads" class="layui-form" action="" enctype="multipart/form-data" lay-filter="example">
			<input type="hidden" id="readId" name="readId" value="">
			<div class="layadmin-user-login-box layadmin-user-login-header">
				<div class="layui-form-item" style="margin-top: 3%;" >
					<label class="layui-form-label" style="width: 12%">绘本名称：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="readMagName4" id="readMagName4" value="" placeholder="" style="width: 180%">
					</div>
					<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadBook" style="margin-left: 15%"><i class="layui-icon">&#xe624;</i></button>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label" style="width: 12%">绘本图片：</label>
					<div class="layui-input-inline">
						<input type="text" id="readMagPic4" name="readMagPic4" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
					</div>
				</div>

				<div class="layui-form-item">
					<label class="layui-form-label" style="width: 12%">文件地址：</label>
					<div class="layui-input-inline">
						<input type="text" id="readMagUrl4" name="readMagUrl4" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
					</div>
				</div>

				<div class="demoTable" >
					<div style="padding-bottom: 15px;">
						<div class="layui-upload" >
							<button type="button" class="layui-btn" id="save" style="margin-left: 20%"> <span class="sp">保存</span></button>
							<button type="button" class="layui-btn" id="cancel"><span class="sp">取消</span></button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
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
		$("#uploadBook").mouseover(function() {
			layer.tips('温馨提示：点击按钮+选择要上传的图片，再点击保存', this, {
				tips: [1, "#8f9199"]
			});
		});
		var path = $("#path").val();
		upload.render({
			elem: '#uploadBook' //绑定元素
			,url: path+"/admin/reUploadBook" //上传接口
			,auto: false
			,accept: 'images'
			,acceptMime: 'image/*'
			,bindAction: '#save'
			,choose:function(obj){//选择文件的回调，obj为选中的文件
				//将每次选择的文件追加到文件队列
				var files = obj.pushFile();
				//预览选中的文件（本地文件）
				obj.preview(function(index,file,result){
					$("#readMagPic4").val("image/adminimg/img/"+file.name);
				});
			}
			,before: function(obj){
				this.data = {
					readMagName:$("#readMagName4").val(),
					readMagUrl:$("#readMagUrl4").val(),
					readMagPic:$("#readMagPic4").val(),
					readMagId:$("#readId").val()
				}
			}
			,done: function(res){
				//上传完毕回调
				if(res.code > 0){
					return layer.msg('上传失败');
				}
				if(res.code == 0){
					layer.alert("上传成功！",{icon:6});
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					setTimeout(function () {
						parent.layer.close(index); //再执行关闭
						parent.location.reload();
					}, 3000);
				}

			}
			,error: function(){
				//请求异常回调
				layer.alert("上传失败！",{icon:2});
			}
		});

		$(function () {
			$("#cancel").click(function () {
				var path = $("#path").val();
				parent.location.href = path+"/admin/toUrl/parentChildReadMgr";
				$("#mName").val($("#readMagName1").val());
			})
		})
	});
</script>
</html>
