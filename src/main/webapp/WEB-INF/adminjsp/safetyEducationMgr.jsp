<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-安全教育管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		body{
			font-size: 140%;
		}
		h2{
			text-align: center;
			margin-top: 1%;
		}
		.layui-input{
			width:120%;
			margin: auto;
		}
		.layui-table-cell{
			height: 45px;
			line-height: 45px;
			font-size: 140%;
		}
		a{
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
		.layui-table-page > div {
			height: 50px;
		}

		.layui-table-page .layui-laypage a, .layui-table-page .layui-laypage span {
			height: 26px;
			line-height: 26px;
			margin-bottom: 10px;
			border: none;
			background: 0 0;
			font-size: 18px;
		}
		.layui-table-page select {
			height: 24px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >安 全 教 育 管 理</h2>
	<hr style="color: white">
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="educationTable">
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">上传时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" style="">
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin: 5% 15%;width: 10%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="margin: -27% 65%;">
						</div>
					</div>
					<button class="layui-btn" data-type="reload" style="margin-left: 10%"><i class="layui-icon">&#xe615;查询</i></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" style=""><i class="layui-icon">&#xe681;上传</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" style=" ">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<table id="education" lay-filter="test" layui-table-cell></table>
	<div id="type-content" style="display: none;">
		<input type="hidden" id="sid" name="sid>">
		<div class="layui-form-item">
			<label class="layui-form-label">上传视频：</label>
			<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadVideo"><i class="layui-icon">&#xe624;</i></button>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">视频名称：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="safetyVideoName" id="safetyVideoName" placeholder="请输入视频名称" style="width: 120%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件名称：</label>
			<div class="layui-inline">
				<input type="text" id="videoName" name="videoName" placeholder="请输入文件名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件地址：</label>
			<div class="layui-inline">
				<input type="text" id="videoAdd" name="videoAdd" placeholder="请输入文件地址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">上传视频：</label>
			<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadVideo2"><i class="layui-icon">&#xe624;</i></button>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">视频名称：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="safetyVideoName2" id="safetyVideoName2" placeholder="请输入视频名称" style="width: 120%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件名称：</label>
			<div class="layui-inline">
				<input type="text" id="videoName2" name="videoName2" placeholder="请输入文件名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件地址：</label>
			<div class="layui-inline">
				<input type="text" id="videoAdd2" name="videoAdd2" placeholder="请输入文件地址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>
	<script type="text/html" id="barOption">
		<a type="button" class="layui-btn layui-btn-sm" lay-event="reUpload" style="height: 45px"><span class="sp"><i class="layui-icon">&#xe67c;重新上传</i></span></a>
		<a type="button" class="layui-btn layui-btn-sm" lay-event="delete" style="height: 45px"><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></a>
	</script>
</body>

	<script>
		layui.use(['form','element'],function () {
			var form = layui.form
				,element = layui.element;
			element.render();
			form.render();
		});
	</script>
	<script>
		layui.use(['form', 'layer', 'upload', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
			var form = layui.form
				, layer = layui.layer
				, layedit = layui.layedit
				, laydate = layui.laydate
				, element = layui.element
				, tree = layui.tree
				,table = layui.table
				,$ = layui.jquery
				,upload = layui.upload;
			var path = $("#path").val();
			var tableIns = table.render({
				elem: '#education'
				, height: 450
				, url: path + "/admin/safetyEducationInfo"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'safetyvideoid', title: '视频编号', align: 'center', width: 150, sort: true, fixed: 'left'}
					, {field: 'safetyvideoname', title: '视频名称', align: 'center', width: 280,
						templet: '<div ><a href="${pageContext.request.contextPath}/{{d.videoadd}}" class="layui-table-link" style="font-size:100%">{{d.safetyvideoname}}</a></div>'}
					, {field: 'videoname', title: '文件名称', align: 'center', width: 362}
					, {field: 'videoadd', title: '文件地址', align: 'center', width: 396}
					, {field: 'safetyvideotime', title: '上传时间', align: 'center', width: 240
					   ,templet:"<div>{{layui.util.toDateString(d.safetyvideotime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
					, {fixed: 'right', title: '操作', align: 'center', width: 294, toolbar: '#barOption'}
				]]
				, id: 'educationTable'
				, parseData: function (res) { //res 即为原始返回的数据
					return {
						"code": res.code, //解析接口状态
						"msg": res.msg, //解析提示文本
						"count": res.count, //解析数据长度
						"data": res.data //解析数据列表
					};
				}
			});
			$(function () {
				var data;
				//监听工具条
				table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					data = obj.data; //获得当前行数据
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					if(layEvent === 'reUpload'){
							layer.open({
								type: 2,
								area: ['30%', '44%'],
								content: path+"/admin/toUrl/reUploadVideoInfo",
								title: ['重新上传','font-size:18px'],
								btnAlign: 'c',
								success:function(layero, index){
									var body = layer.getChildFrame('body',index);
									body.find("#safetyVideoName3").val(data.safetyvideoname);
									body.find("#videoName3").val(data.videoname);
									body.find("#videoAdd3").val(data.videoadd);
									body.find("#safetyvideoid").val(data.safetyvideoid)
								}
						});
					}else if(layEvent === 'delete'){
						layer.confirm("确定要删除该视频信息？",{icon:3,area:['350px','150px'],title:['温馨提示','font-size:18px']},function (index) {
							layer.close(index);
							$.ajax({
								url: path + "/admin/deleteSafetyVideoInfo",
								type: "post",
								data: {"safetyvideoid": data.safetyvideoid},
								dataType: "text",
								success: function (result) {
									if(result == "success")
									{
										layer.alert("视频删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										tableIns.reload();
									}else{
										layer.alert("视频删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
								}
							});
						});
					}
				});
			});

			$("#btn-add").click(function () {
				layer.open({
					type: 2,
					area: ['30%', '44%'],
					content: path+"/admin/toUrl/uploadVideoInfo",
					title: ['上传视频','font-size:18px'],
					kin: 'demo-class',
					closeBtn :0,
					btnAlign: 'c'
				});
			});

			//搜索功能的实现
			$('.educationTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});

			var $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('educationTable', {
						where: {
							time1: $('#time1').val()
							,time2: $('#time2').val()
							,kindername: $('#kindername').val()
						}
						,page:{
							curr:1
						}
					});
				}
			};

			// 刷新表格
			$('#btn-refresh').on('click', function () {
				tableIns.reload();
			});

		});
	</script>
</html>
