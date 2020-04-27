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
					</div>
				</div>
				<button class="layui-btn btn-default" id="btn-cancel" style="margin: -4% 65%;">返回</button>
				<button class="layui-btn btn-add btn-default" id="btn-add" style="display: none;margin: -4% 74%;"><i class="layui-icon">&#xe624;新增图片</i></button>
			</div>
		</form>
	</div>
	<table id="upload" lay-filter="test" class="layui-table-cell" style="margin-top: 5%"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item" style="margin-top: 3%">
			<label class="layui-form-label" style="width: 24%">绘本名称：</label>
			<div class="layui-inline">
				<input type="text" id="name" name = "name" placeholder="请输入绘本名称" value=""
				       autocomplete="off" class="layui-input" style="width: 135%">
			</div>
		</div>
<%--		<div class="layui-form-item">--%>
<%--			<label class="layui-form-label" style="width: 24%">故事内容：</label>--%>
<%--			<div class="layui-inline">--%>
<%--				<input type="text" id="detail" name = "detail" placeholder="请输入故事内容" value=""--%>
<%--				       autocomplete="off" class="layui-input" >--%>
<%--			</div>--%>
<%--		</div>--%>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 24%">页数：</label>
			<div class="layui-inline">
				<input type="text" id="page" name = "page" placeholder="请输入页数" value=""
				       autocomplete="off" class="layui-input" style="width: 135%">
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label" style="width: 24%">故事内容：</label>
			<div class="layui-input-inline">
				<textarea name="detail" id="detail" placeholder="请输入内容" class="layui-textarea" style="width: 119%"></textarea>
			</div>
		</div>
	</div>

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
		$("#mName").mouseover(function() {
			layer.tips('温馨提示：请先选择绘本名称！', this, {
				tips: [1, "#8f9199"]
			});
		});
		var tableIns;
		$(function () {
			form.on('select(mySelect)',function () {
				form.render('select');
				var readMagName = $("#mName").val();
				document.getElementById('btn-add').style.display = "block";
					tableIns = table.render({
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
				});
		});

		$(function () {
			var data;
			//监听工具条
			table.on('tool(test)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if(layEvent === 'delete'){
					layer.confirm("确定要删除该绘本图片信息？",{icon:3,title:'温馨提示',area:['350px','150px']},function(index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteReadInfo",
							type: "post",
							data: {"readmagid": data.readmagid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("绘本图片信息删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("绘本图片信息删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							},
							error:function (result) {
								layer.alert("网路异常！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						});
					});
				}else if(layEvent === 'update'){
					var readMagName = $('#mName option:selected').val();
					layer.open({
						type: 1,
						area: ['50%', '74%'],
						content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改绘本信息','font-size:18px'],
						btn: ['保存','返回'],
						btnAlign: 'c',
						closeBtn:0,
						skin: 'demo-class',
						success:function(layero, index){
							$("#name").val(readMagName);
							$("#detail").val(data.readmagdetail);
							$("#page").val(data.readmagpage);
						},
						btn1:function (index) {
							var name = $("#name").val();
							var detail = $("#detail").val();
							var page = $("#page").val();
							if(name == 0)
							{
								layer.msg("绘本名字不能为空",{icon: 2});
							}else if(!name.match(/^[\u4e00-\u9fa5]{2,20}$/))
							{
								layer.msg("请输入至少2位中文字符", {icon: 2});
							}else if(page == 0)
							{
								layer.msg("页数不能为空",{icon: 2});
							}else if(!page.match(/^[0-9]*$/))
							{
								layer.msg("页码必须是数字数字",{icon: 2});
							}
							else if(detail == 0)
							{
								layer.msg("绘本内容不能为空",{icon: 2});
							}else if(!detail.match(/^[\u4e00-\u9fa5]{2,}$/))
							{
								layer.msg("绘本呢绒必须是中文",{icon: 2});
							}else{
								$.ajax({
									url: path + '/admin/updateReadImg',
									async: true,
									type: 'post',
									data:{"readmagname": name, "readmagdetail": detail,"readmagpage":page,"readmagid":data.readmagid},
									datatype: 'text',
									success: function (data) {
										if (data == "success") {
											layer.alert("修改成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
											layer.close(index);
											tableIns.reload();
										} else {
											layer.alert("修改失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										}
									}, error: function (data) {
										layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
								});
							}
						},
						btn2:function (index) {
							$('#name').val("");
							$('#detail').val("");
							$('#page').val("");
							layer.close(index);
						}
					});
				}
			});
		});

		$("#btn-cancel").click(function () {
			parent.location.href = path + "/admin/toUrl/parentChildReadMgr";
		});

		$("#btn-add").click(function () {
			var readMagName = $("#mName").val();
			layer.open({
				type: 2,
				area: ['40%', '80%'],
				content: path+"/admin/toUrl/addPhotoInfo", //数组第二项即吸附元素选择器或者DOM
				title: ['新增图片','font-size:18px'],
				skin: 'demo-class',
				btnAlign: 'c',
				success:function(layero, index){
					var body = layer.getChildFrame('body',index);
					body.find("#readMagName1").val(readMagName);
				}
			});
		});

	});
</script>

</html>
