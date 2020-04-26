<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-10
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-菜单管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2{
			text-align: center;
			margin-top: 2%;
		}

		body{
			font-size: 140%;
		}
		.layui-input{
			width:100%;
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
	<h2 >菜 单 管 理</h2>
	<hr style="color: white">
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="menuTable" style="margin-left: 5%;">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline" style="margin-top: 1%">
					<span class="layui-form-label" style="width: auto">菜单名称：</span>
					<div class="layui-inline">
						<input class="layui-input" name="mName" id="mName" autocomplete="off" placeholder="请输入菜单名称">
					</div>
				</div>

				<div class="layui-inline" style="margin-top: 1%">
					<label class="layui-form-label" style="width: auto">一级菜单：</label>
					<div class="layui-input-inline" style="width: 60%">
						<select name="pName" id="pName" lay-filter="mySelect" lay-verify="" >
							<option value="请选择">请选择</option>
							<c:if test="${not empty stairMenuList}">
								<c:forEach items="${stairMenuList}" var="i">
									<option value="${i.menuname}">${i.menuname}</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
				</div>
				<button class="layui-btn" data-type="reload" style="margin-top: 1%"><span class="sp"><i class="layui-icon">&#xe615;查询</i></span></button>
				<button class="layui-btn btn-add btn-default" id="btn-add" style="margin-top: 1%"><span class="sp"><i class="layui-icon">&#xe624;新增</i></span></button>
			</div>
		</form>
	</div>
	<table id="menuDemo" lay-filter="test" class="layui-table-cell" style="margin-top: 3%"></table>

	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item" style="margin-top: 3%">
				<span class="layui-form-label" style="width: auto;">菜单名称：</span>
				<div class="layui-inline">
					<input type="text" id="menuName" name="menuName" placeholder="请输入菜单名称" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto">上级菜单：</label>
				<div class="layui-inline" style="width: 58.5%">
					<select name="supNam" id="supName" lay-filter="selectName" lay-verify="required" >
						<option value="请选择">请选择</option>
						<c:if test="${not empty stairMenuList}">
							<c:forEach items="${stairMenuList}" var="i">
								<option value="${i.menuname}">${i.menuname}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto;margin-left: 9%">URL：</label>
				<div class="layui-inline">
					<input type="text" id="menuUrl" name="menuUrl" placeholder="请输入URL" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto;margin-left: 4.5%">排序号：</label>
				<div class="layui-inline">
					<input type="text" id="sort" name="sort" placeholder="请输入菜单排序号" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
		</form>
	</div>

	<div id="type-content2" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item" style="margin-top: 3%">
				<span class="layui-form-label" style="width: auto;">菜单名称：</span>
				<div class="layui-inline">
					<input type="text" id="menuName2" name="menuName2" placeholder="请输入菜单名称" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto" width: auto;>上级菜单：</label>
				<div class="layui-inline" style="width: 58.5%">
					<select name="pName2" id="pName2" lay-filter="selectName" lay-verify="required" >
						<option value="请选择">请选择</option>
						<c:if test="${not empty stairMenuList}">
							<c:forEach items="${stairMenuList}" var="i">
								<option value="${i.menuname}">${i.menuname}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto;margin-left: 9%">URL：</label>
				<div class="layui-inline">
					<input type="text" id="menuUrl2" name="menuUrl2" placeholder="请输入URL" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" style="width: auto;margin-left: 4.5%">排序号：</label>
				<div class="layui-inline">
					<input type="text" id="sort2" name="sort2" placeholder="请输入新的菜单排序号" value=""
					       autocomplete="off" class="layui-input"  lay-verify="required" style="width: 120%">
				</div>
			</div>
		</form>
	</div>

	<script type="text/html" id="barOption">
		<a type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><span class="sp"><i class="layui-icon">&#xe642;修改</i></span></a>
		<a type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></a>
	</script>
</body>
<script>
	layui.use(['form', 'layer','element'], function () {
		layui.form.render();
	});
</script>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
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
			elem: '#menuDemo'
			, height: 450
			, url: path + "/admin/menuMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'menuid', title: '序号', align: 'center', width: 180, sort: true, fixed: 'left'}
				, {field: 'menuname', title: '菜单名称', align: 'center', width: 260}
				, {field: 'menuurl', title: 'URL', align: 'center', width: 423
					,templet:function(d){
						return d.menuurl == null ? '无':d.menuurl;
					}}
				, {field: 'supMenu', title: '上级菜单', align: 'center', width: 280
					,templet:function(d){
						return d.supMenu == null ? '无':d.supMenu;
					}}
				, {field: 'sort', title: '排序', align: 'center', width: 180}
				, {fixed: 'right', title: '操作', align: 'center', width: 400, toolbar: '#barOption'}
			]]
			, id: 'condition'
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
				if(layEvent === 'update'){
					layer.open({
						type: 1,
						area: ['30%', '50%'],
						content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
						title: ['修改菜单','font-size:18px'],
						btn: ['保存', '取消'],
						skin: 'demo-class',
						closeBtn: 0,
						btnAlign: 'c',
						success : function(layero, index) {
							$("#menuName2").val(data.menuname);
							$("#pName2 option[value='" + data.supMenu + "']").attr("selected", "selected");
							$("#menuUrl2").val(data.menuurl);
							$("#sort2").val(data.sort);
						},
						btn1: function (index) {
							var menuName = $('#menuName2').val();
							var pName = $('#pName2').val();
							var sort = $('#sort2').val();
							var menuUrl = $('#menuUrl2').val();
							if (menuName.length == 0) {
								layer.msg("菜单名不能为空", {icon: 2});
							}
							else if(!menuName.match(/^[\u4e00-\u9fa5]{2,20}$/)){
								layer.msg("请输入至少2位中文字符", {icon: 2});
							}
							else if(pName == 0){
								layer.msg("上级菜单不能为空",{icon: 2})
							}
							else if(!pName.match(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/)){
								layer.msg("请输入至少2位中文字符", {icon: 2});
							}else if(menuUrl == 0)
							{
								layer.msg("菜单URL不能为空", {icon: 2});
							}else if( sort == 0)
							{
								layer.msg("菜单排序号不能为空", {icon: 2});
							}else if(!/^[0-9]*$/.test(sort))
							{
								layer.msg("请输入数字", {icon: 2});
							}else{
								$.ajax({
									url: path + "/admin/updateMenuInfo",
									type: "post",
									data: {"menuname": menuName, "menuurl":menuUrl, "pName": pName,"sort":sort,"menuid":data.menuid},
									dataType: "text",
									success: function (result) {
										if(result == "success")
										{
											layer.close(index);
											layer.alert("修改菜单信息成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
											tableIns.reload();
										}else{
											layer.alert("修改菜单信息失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										}
									},
									error: function () {
										layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
								});
							}

						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该菜单信息？",{icon:3,title:['温馨提示','font-size:18px'],area:['350px','200px'],skin:'demo'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteMenuInfo",
							type: "post",
							data: {"menuid": data.menuid,"pName":data.supMenu},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("菜单删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("菜单删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							}
						});
					});
				}
			});
		});

		$("#btn-add").click(function () {
			layer.open({
				type: 1,
				area: ['30%', '50%'],
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: ['新增菜单','font-size:18px'],
				btn: ['提交', '返回'],
				btnAlign: 'c',
				skin: 'demo-class',
				closeBtn: 0,
				success:function(){
					form.render('select');
				},
				btn1: function (index) {
					var menuName = $('#menuName').val();
					var pName = $('#supName').val();
					var menuUrl = $('#menuUrl').val();
					var sort = $('#sort').val();
					if (menuName.length == 0) {
						layer.msg("菜单名不能为空", {icon: 2});
					}
					else if(!menuName.match(/^[\u4e00-\u9fa5]{2,20}$/)){
						layer.msg("请输入至少2位中文字符", {icon: 2});
					}
					else if(pName == 0){
						layer.msg("上级菜单不能为空",{icon: 2})
					}
					else if(!pName.match(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/)){
						layer.msg("请输入至少2位中文字符", {icon: 2});
					}else if(menuUrl == 0)
					{
						layer.msg("菜单URL不能为空", {icon: 2});
					}else if( sort == 0)
					{
						layer.msg("菜单排序号不能为空", {icon: 2});
					}else if(!/^[0-9]*$/.test(sort))
					{
						layer.msg("请输入数字", {icon: 2});
					}else {
						$.ajax({
							url: path + '/admin/addMenuItems',
							async: true,
							type: 'post',
							data: {"menuname": menuName, "pName": pName, "menuurl": menuUrl, "sort": sort},
							datatype: 'text',
							success: function (data) {
								if (data == "success") {
									layer.alert("新增菜单成功！", {
										icon: 6,
										title: ['温馨提示', 'font-size:18px'],
										area: ['350px', '150px'],
										skin: 'demo'
									});
									layer.close(index);
									tableIns.reload();
								} else {
									layer.alert("新增菜单失败", {
										icon: 2,
										title: ['温馨提示', 'font-size:18px'],
										area: ['350px', '150px'],
										skin: 'demo'
									});
								}
							}, error: function (data) {
								layer.alert("网络繁忙！", {
									icon: 2,
									title: ['温馨提示', 'font-size:18px'],
									area: ['350px', '150px'],
									skin: 'demo'
								});
							}
						});
					}
				},
				btn2:function(index){
					layer.close(index);
					$('#menuName').val("");
					$('#supName').val("请选择");
					$('#menuUrl').val("");
					$('#sort').val("");
				}
			});
		});

		$(function(){
			$("#menuName").blur(function () {
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				var menuName = $('#menuName').val();
				if(!$('#menuName').val().match(reg)||menuName == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}else{
					$.ajax({
						url: path + '/admin/checkMenuName',
						async: true,
						type: 'post',
						data: {"menuname": menuName},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.msg("菜单名可用",{icon:6})
							} else {
								layer.msg("菜单名已存在,不可用",{icon:2});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});
				}
			});

			$("#supName").blur(function () {
				var reg = /^[\u4e00-\u9fa5]$/;
				var supName = $('#supName').val();
				if(!$('#supName').val().match(reg)||supName == 0)
				{
					layer.msg("请输入中文", {icon: 2});
				}
			});

			$("#menuUrl").blur(function () {
				var reg = /[a-zA-Z]/;
				var menuUrl = $('#menuUrl').val();
				var arr = menuUrl.split("/");
				if(menuUrl == 0 || arr.length <= 1)
				{
					layer.msg("必须是以admin/toUrl开头，如：admin/toUrl/**", {icon: 2});
				}else if(arr[1] != "" && arr.length >=2){
					if(menuUrl.split("/")[0] != "admin" || !arr[1].match(reg))
					{
						layer.msg("输入不合法，斜杠后必须是字母，请输入如格式：admin/toUrl/**", {icon: 2});
					}else{
					}
				}else{
					layer.msg("输入不合法，斜杠后必须是字母，请输入如格式：admin/toUrl/**", {icon: 2});
				}
			});

			$("#sort").blur(function () {
				var reg = /^[0-9]*$/;
				var sort = $('#sort').val();
				if(!$('#sort').val().match(reg)||sort == 0)
				{
					layer.msg("输入不合法，请输入数字", {icon: 2});
				}else{
					$.ajax({
						url: path + "/admin/checkMenuSort",
						async: true,
						type: "post",
						data: {"sort": sort},
						dataType: "text",
						success: function (msg) {
							if (msg === "success") {
								layer.msg("排序号已存在，请更换其他排序号！");
								$("#sort").focus();
							}
						},
						error: function () {
							layer.alert("网络繁忙");
						}
					});
				}
			});

			$("#menuName2").blur(function () {
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				var menuName = $('#menuName2').val();
				if(!$('#menuName2').val().match(reg)||menuName == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}
			});

			$("#pName2").blur(function () {
				var reg = /^[\u4e00-\u9fa5]$/;
				var pName = $('#pName2').val();
				if(!$('#pName2').val().match(reg)||pName == 0)
				{
					layer.msg("请输入至少2位中文字符", {icon: 2});
				}
			});

			$("#sort2").blur(function () {
				var reg = /^[0-9]*$/;
				var sort = $('#sort2').val();
				if(!$('#sort2').val().match(reg)||sort == 0)
				{
					layer.msg("输入不合法，请输入数字", {icon: 2});
				}else {
					$.ajax({
						url: path + "/admin/checkMenuSort",
						async: true,
						type: "post",
						data: {"sort": sort},
						dataType: "text",
						success: function (msg) {
							if (msg === "success") {
								layer.msg("排序号已存在，请更换其他排序号！");
								$("#sort2").focus();
							}
						},
						error: function () {
							layer.alert("网络繁忙");
						}
					});
				}
			});
		});

		//搜索功能的实现
		$('.menuTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('condition', {
					where: {
						mName: $('#mName').val()
						,pName: $('#pName').val()
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
