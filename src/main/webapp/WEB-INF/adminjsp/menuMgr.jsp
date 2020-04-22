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
			margin-top: 1%;
		}
		#pName{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
		#selNames{
			margin-top: 5%;
			width: 168%;
			height: 30%;
		}
		.layui-table-cell{
			height:40px;
			line-height: 40px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >菜 单 管 理</h2>
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="menuTable" style="margin-left: 5%;">
				<div class="layui-block">查询条件：</div>
				<div class="layui-inline">
					<span class="layui-form-label">菜单名称：</span>
					<div class="layui-inline">
						<input class="layui-input" name="mName" id="mName" autocomplete="off" placeholder="请输入菜单名称">
					</div>
				</div>

				<div class="layui-inline" >
					<label class="layui-form-label">一级菜单：</label>
					<div class="layui-input-inline">
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
				<button class="layui-btn" data-type="reload" ><i class="layui-icon">&#xe615;查询</i></button>
				<button class="layui-btn btn-add btn-default" id="btn-add" ><i class="layui-icon">&#xe624;新增</i></button>
			</div>
		</form>
	</div>
	<table id="menuDemo" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<span class="layui-form-label" style="margin-top: 2%">菜单名称：</span>
				<div class="layui-inline">
					<input type="text" id="menuName" name="menuName" placeholder="请输入菜单名称" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">上级菜单：</label>
				<div class="layui-inline">
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
				<label class="layui-form-label">URL：</label>
				<div class="layui-inline">
					<input type="text" id="menuUrl" name="menuUrl" placeholder="请输入URL" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">排序号：</label>
				<div class="layui-inline">
					<input type="text" id="sort" name="sort" placeholder="请输入菜单排序号" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
		</form>
	</div>

	<div id="type-content2" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<span class="layui-form-label" style="margin-top: 2%">菜单名称：</span>
				<div class="layui-inline">
					<input type="text" id="menuName2" name="menuName2" placeholder="请输入菜单名称" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">上级菜单：</label>
				<div class="layui-inline">
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
				<label class="layui-form-label">URL：</label>
				<div class="layui-inline">
					<input type="text" id="menuUrl2" name="menuUrl2" placeholder="请输入URL" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">排序号：</label>
				<div class="layui-inline">
					<input type="text" id="sort2" name="sort2" placeholder="请输入新的菜单排序号" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
		</form>
	</div>

	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="update" style="text-align: -moz-center"><i class="layui-icon">&#xe642;修改</i></button>
		<button type="button" class="layui-btn layui-btn-normal" lay-event="delete" ><i class="layui-icon">&#xe640;删除</i></button>
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
			, height: 350
			, url: path + "/admin/menuMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'menuid', title: '序号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'menuname', title: '菜单名称', align: 'center', width: 160}
				, {field: 'menuurl', title: 'URL', align: 'center', width: 260
					,templet:function(d){
						return d.menuurl == null ? '无':d.menuurl;
					}}
				, {field: 'supMenu', title: '上级菜单', align: 'center', width: 180
					,templet:function(d){
						return d.supMenu == null ? '无':d.supMenu;
					}}
				, {field: 'sort', title: '排序', align: 'center', width: 120}
				, {fixed: 'right', title: '操作', align: 'center', width: 300, toolbar: '#barOption'}
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
						area: ['30%', '65%'],
						content: $("#type-content2"), //数组第二项即吸附元素选择器或者DOM
						title: '修改菜单',
						btn: ['保存', '取消'],
						offset: '100px',
						btnAlign: 'c',
						success : function(layero, index) {
							$("#menuName2").val(data.menuname);
							console.log(data.supMenu);
							$("#pName2 option[value='" + data.supMenu + "']").attr("selected", "selected");
							$("#menuUrl2").val(data.menuurl);
							$("#sort2").val(data.sort);
						},
						btn1: function (index) {
							var menuName = $('#menuName2').val();
							var pName = $('#pName2').val();
							var sort = $('#sort2').val();
							var menuUrl = $('#menuUrl2').val();
							$.ajax({
								url: path + "/admin/updateMenuInfo",
								type: "post",
								data: {"menuname": menuName, "menuurl":menuUrl, "pName": pName,"sort":sort,"menuid":data.menuid},
								dataType: "text",
								success: function (result) {
									if(result == "success")
									{
										layer.close(index);
										layer.alert("修改菜单信息成功！", {icon: 6});
										tableIns.reload();
									}else{
										layer.alert("修改菜单信息失败！", {icon: 2});
									}
								}
							});
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该菜单信息？",{icon:3,title:'温馨提示'},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteMenuInfo",
							type: "post",
							data: {"menuid": data.menuid,"pName":data.supMenu},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("菜单删除成功！", {icon: 6});
									tableIns.reload();
								}else{
									layer.alert("菜单删除失败！", {icon: 2});
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
				area: ['30%', '65%'],
				content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
				title: '新增菜单',
				btn: ['提交', '返回'],
				offset: '100px',
				btnAlign: 'c',
				success:function(){
					form.render('select');
				},
				btn1: function (index) {
					var menuName = $('#menuName').val();
					var pName = $('#supName').val();
					var menuUrl = $('#menuUrl').val();
					var sort = $('#sort').val();
					$.ajax({
						url: path + '/admin/addMenuItems',
						async: true,
						type: 'post',
						data: {"menuname": menuName, "pName": pName,"menuurl":menuUrl,"sort":sort},
						datatype: 'text',
						success: function (data) {
							if (data == "success") {
								layer.alert("新增菜单成功！", {icon: 6});
								layer.close(index);
								tableIns.reload();
							} else {
								layer.alert("新增菜单失败", {icon: 2});
							}
						}, error: function (data) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});
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
						// console.log(arr[1].match(reg));
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
