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
		body{
			font-size: 140%;
		}

		.layui-input{
			width:120%;
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
		#mName{
			margin: -12% 125%;
		}

		#btn-add{
			margin: -5% 0 0 60%;
		}
		.sp{
			font-size: 140%;
			height: 40px;
			line-height: 40px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="uploadTable" style="margin-left: 10%">
				<div class="layui-inline">
					<span class="layui-form-label" style="width:auto;margin-left: 50%">绘本名称：</span>
					<div class="layui-inline" style="margin: -10% 85%;width: 60%">
						<select name="mName" id="mName" lay-filter="mySelect" lay-verify="" style="width:auto;">
							<option value="请选择绘本">请选择绘本</option>
							<c:if test="${not empty readNewList}">
								<c:forEach items="${readNewList}" var="i">
									<option value="${i}">${i}</option>
								</c:forEach>
							</c:if>
						</select>
<%--						<input class="layui-input" name="mName" id="mName" autocomplete="off" placeholder="请输入绘本名称">--%>
					</div>
				</div>
				<button class="layui-btn btn-add btn-default" id="btn-add" style="display: none;margin: -3.5% 65%;"><i class="layui-icon">&#xe624;新增图片</i></button>
			</div>
		</form>
	</div>
	<table id="upload" lay-filter="test" class="layui-table-cell" style="margin-top: 5%"></table>
	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><span class="sp"><i class="layui-icon">&#xe642;修改</i></span></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></button>
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
		form.render();
		var path = $("#path").val();

		$(function () {
			// $("#mySelect select").change(function ()
			form.on('select(mySelect)',function () {
			// {
				form.render('select');
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
							, height: 350
							, url: path + "/admin/findReadInfoByName?readmagname="+readMagName+""//数据接口
							, page: true //开启分页
							, limit: 2
							, limits: [2, 5]
							, cols: [[ //表头
								{field: 'readmagpage', title: '页数', align: 'center', width: 160, sort: true, fixed: 'left'}
								, {field: 'readmagdetail', title: '故事内容', align: 'center', width: 360 }
								, {
									field: 'photourl', title: '图片', align: 'center', width: 240
									, templet: function (d) { return '<div><img src="'+path+'/'+d.photourl+'" style="width: 60px;height: 60px"></div>' }
								}
								, {fixed: 'right', title: '操作', align: 'center', width: 442, toolbar: '#barOption'}
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
			layer.open({
				type: 2,
				area: ['40%', '80%'],
				content: path+"/admin/toUrl/addPhotoInfo", //数组第二项即吸附元素选择器或者DOM
				title: ['新增图片','font-size:18px'],
				// btn: ['保存','取消'],
				// offset: '30px',
				// closeBtn:0,
				btnAlign: 'c',
				success:function(layero, index){
					// layero.find('.layui-layer-btn0').id('test9');
					var body = layer.getChildFrame('body',index);
					body.find("#readMagName1").val(readMagName);
				}
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
