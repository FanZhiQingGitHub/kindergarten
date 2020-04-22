<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 15:19
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

		h2 {
			text-align: center;
		}
		.layui-table-cell{
			height:38px;
			line-height: 38px;
			white-space:normal;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2>亲子阅读管理</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="readTable">
				<div class="layui-form-item" style="margin-left: 3%">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label">上传时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" style="width: 82%;margin-top: 2% ">
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin-left: -40%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="width: 82%;margin: 2% 0 0 -5%">
						</div>
					</div>
					<button class="layui-btn" data-type="reload" style="margin-left: -8%"><i class="layui-icon">&#xe615;查询</i></button>
					<button class="layui-btn btn-add btn-default" id="btn-add" ><i class="layui-icon">&#xe681;上传绘本</i></button>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<span class="layui-form-label" style="margin-left: 11%">绘本名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="readMagName" id="readMagName" placeholder="请输入绘本名称" style="width: 82%;margin: -20% 0 0 75%;">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table id="read" lay-filter="test" class="layui-table-cell" style="margin-top: -2%"></table>
	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label" style="">绘本名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="readMagName2" id="readMagName2" value="" placeholder="" style="width: 122%;margin-top: 1%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">绘本图片：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 122%">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 122%">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">页数：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 122%">
				</div>
			</div>
		</form>
	</div>

	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="detail" style="text-align: -moz-center"><i class="layui-icon">&#xe642;查看</i></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="reUpload" style="text-align: -moz-center"><i class="layui-icon">&#xe642;重新上传</i></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><i class="layui-icon">&#xe640;删除</i></button>
	</script>
</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery;
		var path = $("#path").val();
		var tableIns = table.render({
			elem: '#read'
			, height: 350
			, url: path + "/admin/readMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'readmagid', title: '绘本编号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'readmagname', title: '绘本名称', align: 'center', width: 120}
				, {field: 'readmagurl', title: '文件夹地址', align: 'center', width: 202}
				, {field: 'photourl', title: '图片地址', align: 'center', width: 120
					, templet: function (d) { return '<div><img src="'+path+'/'+d.photourl+'" style="width: 40px;height: 40px"></div>' }
				}
				, {field: 'readmagpage', title: '页数', align: 'center', width: 120}
				, {
					field: 'readmagtime', title: '上传时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.readmagtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {fixed: 'right', title: '操作', align: 'center', width: 400, toolbar: '#barOption'}
			]]
			, id: 'readTable'
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
				console.log(data);
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if (layEvent === 'detail') {
					layer.open({
						type: 2,
						area: ['35%', '80%'],
						content: path+"/admin/toUrl/pictureBookInfo", //数组第二项即吸附元素选择器或者DOM
						title: '绘本详情',
						btn: ['返回'],
						offset: '100px',
						btnAlign: 'c',
						success : function(layero, index) {
							//方式二
							var body = layer.getChildFrame('body',index);
							body.find("#readMagName").val(data.readmagname);
							body.find("#readMagUrl").val(data.readmagurl);
							body.find("#readMagTime").val(data.readmagtime);
							body.find("#readMagPic").val(data.photourl);
							<%--var img = "";--%>
							<%--	img += "<img src='${pageContext.request.contextPath}/"+data.photourl+"' style='width: 60px;height: 60px'>";--%>
							<%--	$("#readMagPic").val(img);--%>
							<%--$("#readMagPic").show();--%>
							// $("#test1").attr("src",""+path+"/"+data.photourl+"");
						//
						}
						// btn1: function (index) {
						// 	var menuName = $('#menuName').val();
						// 	var pName = $('#supName').val();
						// 	var menuUrl = $('#menuUrl').val();
						// 	var sort = $('#sort').val();
						// 	$.ajax({
						// 		url: path + '/admin/addMenuItems',
						// 		async: true,
						// 		type: 'post',
						// 		data: {"menuname": menuName, "pName": pName,"menuurl":menuUrl,"sort":sort},
						// 		datatype: 'text',
						// 		success: function (data) {
						// 			if (data == "success") {
						// 				layer.alert("新增菜单成功！", {icon: 6});
						// 				layer.close(index);
						// 				tableIns.reload();
						// 			} else {
						// 				layer.alert("新增菜单失败", {icon: 2});
						// 			}
						// 		}, error: function (data) {
						// 			layer.alert("网络繁忙！", {icon: 2});
						// 		}
						// 	});
						// },
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该绘本信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteReadInfo",
							type: "post",
							data: {"readmagid": data.readmagid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("绘本信息删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("绘本信息删除失败！", {icon: 2});
								}
							},
							error:function (result) {
								layer.alert("网路异常！", {icon: 2});
							}
						});
					});
				}else if(layEvent === 'reUpload'){
					layer.open({
						type: 1,
						area: ['35%', '60%'],
						// content: path+"/admin/toUrl/reUploadPictureBook", //数组第二项即吸附元素选择器或者DOM
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: '修改绘本信息',
						btn: ['保存','返回'],
						offset: '30px',
						btnAlign: 'c',
						success:function(layero, index){
							$("#readMagName2").val(data.readmagname);
							$("#readMagUrl").val(data.readmagurl);
							$("#readMagPic").val(data.photourl);
							$("#readMagPage").val(data.readmagpage);
							// var body = layer.getChildFrame('body',index);
							// body.find("#readMagName").val(data.readmagname);
							// body.find("#readMagUrl").val(data.readmagurl);
							// // body.find("#readMagTime").val(data.readmagtime);
							// body.find("#readMagPic").val(data.photourl);
							// body.find("#readMagPage").val(data.readmagpage);
						},
						btn1:function (index) {
							var readMagName = $("#readMagName2").val();
							var readMagUrl = $("#readMagUrl").val();
							var readMagPic = $("#readMagPic").val();
							var readMagPage = $("#readMagPage").val();
							var date = new Date()
								,dateYear = date.getFullYear()             //获取年
								,dateMonth = date.getMonth() +1              //获取月
								,dateDate = date.getDate()                //获取当日
								,dateHours = date.getHours()               //获取小时
								,dateMinutes = date.getMinutes()           //获取分钟
								,dateSeconds = date.getSeconds();           //获取秒
							var time = dateYear+'-'+dateMonth+'-'+dateDate+' '+dateHours+':'+dateMinutes+':'+dateSeconds;
							var msg = {"readmagname": readMagName, "readmagurl": readMagUrl,"photourl":readMagPic,"readmagpage":readMagPage};
							console.log(time);
							msg = JSON.stringify(msg);
							$.ajax({
								url: path + '/admin/reUploadBook',
								async: true,
								type: 'post',
								data:{"readmagname": readMagName, "readmagurl": readMagUrl,"photourl":readMagPic,"readmagpage":readMagPage,"readmagid":data.readmagid},
								datatype: 'text',
								success: function (data) {
									if (data == "success") {
										layer.alert("重新上传成功！", {icon: 6});
										layer.close(index);
										tableIns.reload();
									} else {
										layer.alert("重新上传失败", {icon: 2});
									}
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2});
								}
							});
						},
						btn2:function () {
							$('#readMagName2').val("");
							$('#readMagUrl').val("");
							$('#readMagPic').val("");
							$('#readMagPage').val("");
						}
					});
				}
			});
		});

		// function setFormValue(obj,data){
		// 	form.on('submit(test1)', function(massage) {
		// 		// $('#updateUser').serialize();
		// 		var formData=$("#reUploads").serializeObject();   //这个把表单按对象类型序列化
		// 		console.log(formData);
		// 		$.ajax({
		// 			url:path+"/admin/reUploadBook",
		// 			type:'POST',
		// 			dataType:'text',
		// 			data:JSON.stringify(formData),
		// 			contentType : 'application/json;charset=utf-8',
		// 			async: true,
		// 			success:function (msg) {
		// 				console.log(msg);
		// 				// //取得返回数据（Sting类型的字符串）的信息进行取值判断
		// 				if(msg != null){
		// 				// 	// var index = parent.layer.getFrameIndex(window.name);
		// 				// 	// setTimeout(function(){parent.layer.close(index)}, 1000);
		// 				// 	var index = parent.layer.getFrameIndex(window.name);//获得index
		// 				// 	setTimeout(function () { parent.layer.close(index) }, 100);//延迟
		// 				// 	tableIns.reload();
		// 				}else{
		// 					layer.msg("修改失败", {icon: 5});
		// 				}
		// 			}
		// 		});
		// 		return false;
		// 	})
		// }

		$(function () {
			$('#readMagName').blur(function () {
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				var readMagName = $('#readMagName').val();
				if(!$('#readMagName').val().match(reg)||readMagName == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});
			$('#readMagPage').blur(function () {
				var reg = /^[0-9]*$/;
				var readMagPage = $('#readMagPage').val();
				if(!$('#readMagPage').val().match(reg)||readMagPage == 0)
				{
					layer.msg("请输入不合法，请输入数字", {icon: 2});
				}else{
					layer.msg("输入合法", {icon: 6});
				}
			});

			$("#readMagPic").blur(function () {
				var reg = /[a-zA-Z]/;
				var readMagPic = $('#readMagPic').val();
				var arr = readMagPic.split("/");
				if(readMagPic == 0 || arr.length <= 1)
				{
					layer.msg("必须是以image/adminimg/img/开头，如：image/adminimg/img/**", {icon: 2});
				}else if(arr[1] != "" && arr.length >=2){
					if(readMagPic.split("/")[0] != "image" || !arr[1].match(reg))
					{
						layer.msg("输入不合法，斜杠后必须是字母，请输入如格式：admin/toUrl/**", {icon: 2});
					}else{
						// console.log(arr[1].match(reg));
					}
				}else{
					layer.msg("输入不合法，斜杠后必须是字母，请输入如格式：image/adminimg/img/**", {icon: 2});
				}
			});
		});
		
		$("#btn-add").click(function () {
			layer.open({
				type: 2,
				area: ['70%', '90%'],
				content: path+"/admin/toUrl/uploadPictureBooks", //数组第二项即吸附元素选择器或者DOM
				title: '上传绘本',
				btn: ['保存', '取消'],
				// offset: '100px',
				btnAlign: 'c',
				success:function(){

				},
				// btn1: function (index) {
				// 	var roleName2 = $('#roleName2').val();
				// 	$.ajax({
				// 		url: path + '/admin/addRoleItems',
				// 		async: true,
				// 		type: 'post',
				// 		data: {"rolename": roleName2},
				// 		datatype: 'text',
				// 		success: function (data) {
				// 			if (data == "success") {
				// 				layer.alert("新增角色成功！", {icon: 6});
				// 				layer.close(index);
				// 				tableIns.reload();
				// 			} else {
				// 				layer.alert("新增角色失败", {icon: 2});
				// 			}
				// 		}, error: function (data) {
				// 			layer.alert("网络繁忙！", {icon: 2});
				// 		}
				// 	});
				// },
				// btn2:function(index){
				// 	layer.close(index);
				// 	$('#roleName2').val("");
				// }
			});
		});

		//搜索功能的实现
		$('.readTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('readTable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
						,readmagname: $('#readMagName').val()
					}
					, page: {
						curr: 1
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
