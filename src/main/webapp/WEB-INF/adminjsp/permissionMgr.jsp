<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-权限管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		#div1{
			margin-left: 5%;
			width:20%;
			height:75%;
			border:1px solid #38393c
		}
		#div2{
			width:50%;
			height:75%;
			border:1px solid #38393c
		}
		#test1{
			margin: 2%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-row" style="margin-top: 20px;">
		<div class="layui-form-item">
			<div class="layui-inline" id="div1">
				<div id="role" ></div>
			</div>
			<div class="layui-inline" id="div2">
				<div id="test1"></div>
			</div>
		</div>
	</div>
</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree', 'table','transfer'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery
			,transfer = layui.transfer;
		var path = $("#path").val();
		var tableIns = table.render({
			elem: '#kinder'
			, height: 312
			, url: path + "/admin/logMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'syslogid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}
				, {field: 'operateor', title: '操作人', align: 'center', width: 120}
				, {
					field: 'operatetime', title: '操作时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.operatetime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'operatetype', title: '操作事项', align: 'center', width: 120}
			]]
			, id: 'demotable'
			, parseData: function (res) { //res 即为原始返回的数据
				return {
					"code": res.code, //解析接口状态
					"msg": res.msg, //解析提示文本
					"count": res.count, //解析数据长度
					"data": res.data //解析数据列表
				};
			}
		});

		//树形组件
		var inst1 = tree.render({
			elem: '#role'  //绑定元素
			,data: [{
				title: '江西' //一级菜单
				,children: [{
					title: '南昌' //二级菜单
					,children: [{
						title: '高新区' //三级菜单
						//…… //以此类推，可无限层级
					}]
				}]
			},{
				title: '陕西' //一级菜单
				,children: [{
					title: '西安' //二级菜单
				}]
			}]
		});


		//渲染穿梭框
		transfer.render({
			elem: '#test1'  //绑定元素
			,title:['角色','已分配','未分配']
			,data: [
				{"value": "1", "title": "李白", "disabled": "", "checked": ""}
				,{"value": "2", "title": "杜甫", "disabled": "", "checked": ""}
				,{"value": "3", "title": "贤心", "disabled": "", "checked": ""}
			]
			,id: 'demo1' //定义索引
		});

		//搜索功能的实现
		$('.demoTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('demotable', {
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

		// 刷新表格
		$('#btn-refresh').on('click', function () {
			tableIns.reload();
		});
	});
</script>
</html>
