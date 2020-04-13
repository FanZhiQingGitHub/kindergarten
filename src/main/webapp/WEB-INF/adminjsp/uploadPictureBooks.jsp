<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-上传绘本</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h3 {
			text-align: center;
		}
		.layui-table-cell {
			height: 70px;
			line-height: 70px;
			white-space:normal;
		}
		/*.layui-table-cell{*/
		/*	height:auto!important;*/
		/*	*/
		/*}*/
		#mName{
			margin: -24% 0 0 155%;
		}
		#btn-add{
			/*margin-left: 20%;*/
			margin: -5% 0 0 60%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="uploadTable">
				<div class="layui-inline">
					<span class="layui-form-label" style="margin-left: 50%">绘本名称：</span>
					<div class="layui-inline">
						<input class="layui-input" name="mName" id="mName" autocomplete="off" placeholder="请输入绘本名称">
					</div>
				</div>
				<button class="layui-btn btn-add btn-default" id="btn-add" style="display: none"><i class="layui-icon">&#xe624;新增图片</i></button>
			</div>
		</form>
	</div>
	<table id="upload" lay-filter="test" class="layui-table-cell"></table>
	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><i class="layui-icon">&#xe642;修改</i></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><i class="layui-icon">&#xe640;删除</i></button>
	</script>
</body>

<script>
	layui.use(['form', 'layer', 'jquery', 'upload', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery
			, upload = layui.upload;
		var path = $("#path").val();
		// var tableIns = table.render({
		// 	elem: '#upload'
		// 	, height: 300
		// 	, url: path + "/admin/readMgrInfo"//数据接口
		// 	, page: true //开启分页
		// 	, limit: 2
		// 	, limits: [2, 5]
		// 	, cols: [[ //表头
		// 		{field: 'readmagpage', title: '页数', align: 'center', width: 100, sort: true, fixed: 'left'}
		// 		, {field: 'readmagdetail', title: '故事内容', align: 'center', width: 120 }
		// 		, {
		// 			field: 'photourl', title: '图片', align: 'center', width: 240
		// 			, templet: function (d) { return '<div><img src="'+path+'/'+d.photourl+'" style="width: 60px;height: 60px"></div>' }
		// 		}
		// 		, {fixed: 'right', title: '操作', align: 'center', width: 300, toolbar: '#barOption'}
		// 	]]
		// 	, id: 'uploadTable'
		// 	, parseData: function (res) { //res 即为原始返回的数据
		// 		return {
		// 			"code": res.code, //解析接口状态
		// 			"msg": res.msg, //解析提示文本
		// 			"count": res.count, //解析数据长度
		// 			"data": res.data //解析数据列表
		// 		};
		// 	}
		// });

		$(function () {
			$("#mName").blur(function () {
				var readMagName = $("#mName").val();
				document.getElementById('btn-add').style.display = "block";
				// $.ajax({
				// 	url: path + '/admin/readMgrInfo',
				// 	async: true,
				// 	type: 'post',
				// 	data: {"readmagname": readMagName},
				// 	datatype: 'text',
				// 	success: function (data) {
						var tableIns = table.render({
							elem: '#upload'
							, height: 300
							, url: path + "/admin/readMgrInfo?readmagname="+readMagName+""//数据接口
							, page: true //开启分页
							, limit: 2
							, limits: [2, 5]
							, cols: [[ //表头
								{field: 'readmagpage', title: '页数', align: 'center', width: 100, sort: true, fixed: 'left'}
								, {field: 'readmagdetail', title: '故事内容', align: 'center', width: 120 }
								, {
									field: 'photourl', title: '图片', align: 'center', width: 240
									, templet: function (d) { return '<div><img src="'+path+'/'+d.photourl+'" style="width: 60px;height: 60px"></div>' }
								}
								, {fixed: 'right', title: '操作', align: 'center', width: 300, toolbar: '#barOption'}
							]]
							, id: 'uploadTable'
							, parseData: function (res) { //res 即为原始返回的数据
								return {
									"code": res.code, //解析接口状态
									"msg": res.msg, //解析提示文本
									"count": res.count, //解析数据长度
									"data": res.data //解析数据列表
								};
							}
						});
					// }, error: function (data) {
					// 	layer.alert("网络繁忙！", {icon: 2});
					// }
				});
			// })
		});

		$("#btn-add").click(function () {
			var readMagName = $("#mName").val();
			console.log(readMagName);
			layer.open({
				type: 2,
				area: ['60%', '80%'],
				content: path+"/admin/toUrl/addPhotoInfo", //数组第二项即吸附元素选择器或者DOM
				title: '新增图片',
				// btn: ['保存','取消'],
				offset: '30px',
				btnAlign: 'c',
				success:function(layero, index){
					layero.find('.layui-layer-btn0').id('test9');
					var body = layer.getChildFrame('body',index);
					body.find("#readMagName1").val(readMagName);
					console.log(1);
				},
				// yes: function (index) {
				// 	var uploadInst = upload.render({
				// 		elem: '#uploadImg' //绑定元素
				// 		,url: path+"/admin/uploadImg" //上传接口
				// 		,auto: false
				// 		,accept: 'images'
				// 		,acceptMime: 'image/*'
				// 		,bindAction: '#test9'
				// 		,choose:function(obj){//选择文件的回调，obj为选中的文件
				// 			//将每次选择的文件追加到文件队列
				// 			var files = obj.pushFile();
				// 			//预览选中的文件（本地文件）
				// 			obj.preview(function(index,file,result){
				// 				$('#demo1').attr('src', result);
				// 			});
				// 		}
				// 		,before: function(obj){
				// 			this.data = {
				// 				contentInfo: $("#contentInfo").val()
				// 				,pageNum: $("#pageNum").val()
				// 				,readMagName1: $("#readMagName1").val()
				// 			}
				// 		}
				// 		,done: function(res){
				// 			//上传完毕回调
				// 			if(res.code > 0){
				// 				return layer.msg('上传失败');
				// 			}
				// 			layer.alert("上传成功！",{icon:6});
				// 		}
				// 		,error: function(){
				// 			//请求异常回调
				// 			layer.alert("上传失败！",{icon:2});
				// 		}
				// 	});
				//
				// 	// var roleName2 = $('#roleName2').val();
				// 	// $.ajax({
				// 	// 	url: path + '/admin/addRoleItems',
				// 	// 	async: true,
				// 	// 	type: 'post',
				// 	// 	data: {"rolename": roleName2},
				// 	// 	datatype: 'text',
				// 	// 	success: function (data) {
				// 	// 		if (data == "success") {
				// 	// 			layer.alert("新增角色成功！", {icon: 6});
				// 	// 			layer.close(index);
				// 	// 			tableIns.reload();
				// 	// 		} else {
				// 	// 			layer.alert("新增角色失败", {icon: 2});
				// 	// 		}
				// 	// 	}, error: function (data) {
				// 	// 		layer.alert("网络繁忙！", {icon: 2});
				// 	// 	}
				// 	// });
				// },
				// btn2:function(index){
				// 	layer.close(index);
				// 	$('#contentInfo').val("");
				// 	$('#pageNum').val("");
				// }
			});
		});

		//搜索功能的实现
		$('.uploadTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('uploadTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
					}
					, page: {
						curr: 1
					}
				});
			}
		};

		// // 刷新表格
		// $('#btn-refresh').on('click', function () {
		// 	tableIns.reload();
		// });
	});
</script>

</html>
