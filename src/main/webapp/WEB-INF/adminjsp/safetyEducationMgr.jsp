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
		h2{
			text-align: center;
			margin-top: 1%;
		}
		#selName{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
		#selNames{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >安 全 教 育 管 理</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="educationTable">
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label">上传时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" style="width: 82%;margin-top: 2% ">
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin-left: -35%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="width: 82%;margin: 2% 0 0 10%">
						</div>
					</div>
<%--					<div class="layui-inline" >--%>
<%--						<span class="layui-form-label" style="margin-left: -55%">状态：</span>--%>
<%--						<div class="layui-input-inline" style="margin-left: -18%;">--%>
<%--							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >--%>
<%--								<option value="请选择">请选择</option>--%>
<%--								<option value="禁用">禁用</option>--%>
<%--								<option value="启用">启用</option>--%>
<%--							</select>--%>
<%--						</div>--%>
<%--					</div>--%>
					<button class="layui-btn" data-type="reload" style="margin-left: -5%"><i class="layui-icon">&#xe615;查询</i></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" style=""><i class="layui-icon">&#xe681;上传</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-inline">
						<span class="layui-form-label">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" style="width: 82%;margin-top: 3% ">
						</div>
					</div>
<%--					<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-left:45%"><i class="layui-icon">&#xe624;新增</i></button>--%>
				</div>
			</div>
		</form>
	</div>
	<table id="education" lay-filter="test"></table>
	<div id="type-content" style="display: none;">
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
<%--		{{#  if(d.kindercode == '启用'){ }}--%>
<%--		<a  class="layui-btn layui-btn-danger layui-btn-xs" lay-event="forbidden" style="width: 15%;height: 75%">禁用</a>--%>
<%--		{{#  } }}--%>
<%--		{{#  if(d.kindercode == '禁用'){ }}--%>
<%--		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="open" style="width: 15%;height: 75%">启用</a>--%>
<%--		{{#  } }}--%>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="reUpload" style="width: 40%;height: 80%"><i class="layui-icon">&#xe67c;重新上传</i></a>
		<a type="button" class="layui-btn layui-btn-xs" lay-event="delete" style="width: 25%;height: 80%"><i class="layui-icon">&#xe640;删除</i></a>
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
				, height: 312
				, url: path + "/admin/safetyEducationInfo"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'safetyvideoid', title: '视频编号', align: 'center', width: 120, sort: true, fixed: 'left'}
					, {field: 'safetyvideoname', title: '视频名称', align: 'center', width: 120}
					, {field: 'videoname', title: '文件名称', align: 'center', width: 120}
					, {field: 'videoadd', title: '文件地址', align: 'center', width: 260}
					, {field: 'safetyvideotime', title: '上传时间', align: 'center', width: 180
					   ,templet:"<div>{{layui.util.toDateString(d.safetyvideotime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
					, {fixed: 'right', title: '操作', align: 'center', width: 260, toolbar: '#barOption'}
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
						layer.confirm("确定要重新上传？",{icon:3,title:'温馨提示'},function (index) {
							layer.close(index);
							layer.open({
								type: 1,
								area: ['30%', '60%'],
								content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
								title: '重新上传',
								btn: ['保存', '取消'],
								offset: '100px',
								btnAlign: 'c',
								btn1: function (index) {
									var safetyVideoName = $("#safetyVideoName").val();
									var videoName = $("#videoName").val();
									var videoAdd = $("#videoAdd").val();
									if (safetyVideoName.length == 0) {
										layer.alert("请输入视频名称", {icon: 2});
									}  else {
										$.ajax({
											url: path + "/admin/updateSafetyVideoInfo",
											type: "post",
											data: {"safetyvideoid": data.safetyvideoid,"safetyvideoname":safetyVideoName,"videoname":videoName,"videoadd":videoAdd},
											dataType: "text",
											success: function (result) {
												if(result == "success")
												{
													layer.close(index);
													layer.alert("重新上传信息成功！", {icon: 6});
													tableIns.reload();
												}else{
													layer.alert("重新上传信失败！", {icon: 2});
												}
											}
										});
									}
								},
							});
						});
					}else if(layEvent === 'delete'){
						layer.confirm("确定要删除该视频信息？",{icon:3,title:'温馨提示'},function (index) {
							layer.close(index);
							$.ajax({
								url: path + "/admin/deleteSafetyVideoInfo",
								type: "post",
								data: {"safetyvideoid": data.safetyvideoid},
								dataType: "text",
								success: function (result) {
									if(result == "success")
									{
										layer.alert("视频删除成功！", {icon: 6});
										tableIns.reload();
									}else{
										layer.alert("视频删除失败！", {icon: 2});
									}
								}
							});
						});
					}
				});
			});

			// var uploadInst = upload.render({
			// 	elem: '#uploadVideo' //绑定元素
			// 	,url: path+"/admin/uploadVideo" //上传接口
			// 	,auto: false
			// 	,accept: 'video'
			// 	// ,acceptMime: 'image/*'
			// 	,bindAction: '#save'
			// 	,choose:function(obj){//选择文件的回调，obj为选中的文件
			// 		//将每次选择的文件追加到文件队列
			// 		var files = obj.pushFile();
			// 		//预览选中的文件（本地文件）
			// 		obj.preview(function(index,file,result){
			// 			$('#demo1').attr('src', result);
			// 		});
			// 	}
			// 	,before: function(obj){
			// 		this.data = {
			// 			contentInfo: $("#contentInfo").val()
			// 			,pageNum: $("#pageNum").val()
			// 			,readMagName1: $("#readMagName1").val()
			// 		}
			// 	}
			// 	,done: function(res){
			// 		//上传完毕回调
			// 		if(res.code > 0){
			// 			return layer.msg('上传失败');
			// 		}
			// 		layer.alert("上传成功！",{icon:6});
			// 		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			// 		setTimeout(function () {
			// 			parent.layer.close(index); //再执行关闭
			// 		}, 6000);
			// 	}
			// 	,error: function(){
			// 		//请求异常回调
			// 		layer.alert("上传失败！",{icon:2});
			// 	}
			// });

			$("#btn-add").click(function () {
				layer.open({
					type: 2,
					area: ['40%', '60%'],
					// content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
					content: path+"/admin/toUrl/uploadVideoInfo",
					title: '上传视频',
					// btn: ['保存', '取消'],
					offset: '100px',
					btnAlign: 'c',
					// btn1: function (index) {
					// 	var safetyVideoName = $("#safetyVideoName").val();
					// 	var videoName = $("#videoName").val();
					// 	var videoAdd = $("#videoAdd").val();
					// 	if (safetyVideoName.length == 0) {
					// 		layer.alert("请输入视频名称", {icon: 2});
					// 	}  else {
					// 		$.ajax({
					// 			url: path + '/admin/addSafetyVideo',
					// 			async: true,
					// 			type: 'post',
					// 			data: {"safetyvideoname":safetyVideoName,"videoname":videoName,"videoadd":videoAdd},
					// 			datatype: 'text',
					// 			success: function (data) {
					// 				if (data == "success") {
					// 					layer.alert("新增成功！", {icon: 6});
					// 					layer.close(index);
					// 					tableIns.reload();
					// 				} else {
					// 					layer.alert("新增失败", {icon: 2});
					// 				}
					// 			}, error: function (data) {
					// 				layer.alert("网络繁忙！", {icon: 2});
					// 			}
					// 		});
					// 	}
					// },
				});
			});

				// $("#selName").change(function () {
				// 	var kindername = $("#selName").val();
				// 	$.ajax({
				// 		url: path + "/admin/kinderAccount",
				// 		type: "post",
				// 		data: {"kindername": kindername},
				// 		dataType: "text",
				// 		success: function (result) {
				// 			$("#account").val(result);
				// 		}
				// 	});
				// });

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
