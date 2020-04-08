<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 1:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-日志查看</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		.demoTable{
			margin-left: 5%;
		}
		span{
			margin-top: 3%;
		}
		button{
			margin: 1.5% -1%;
		}

		h2{
			text-align: center;
			margin-top: 1%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >日 志 查 看</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="demoTable">
				<div class="layui-form-item">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label">日志时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="2020-04-07" placeholder="请选择上传开始时间" style="width: 82%;margin-top: 6% ">
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin-left: -28%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="2020-04-08" placeholder="请选择上传结束时间" style="width: 82%;margin: 7% 0 0 30%">
						</div>
					</div>
					<button class="layui-btn" data-type="reload" ><i class="layui-icon">&#xe615;查询</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="demo" lay-filter="test"></table>
</body>

	<script>
		layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
			var form = layui.form
				, layer = layui.layer
				, layedit = layui.layedit
				, laydate = layui.laydate
				, element = layui.element
				, tree = layui.tree
				,table = layui.table
				,$ = layui.jquery
				,path = $("#path").val();
			var tableIns = table.render({
				elem: '#demo'
				, height: 312
				, url: path + "/admin/logMgrInfo"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'syslogid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}
					, {field: 'operateor', title: '操作人', align: 'center', width: 120}
					, {field: 'operatetime', title: '操作时间', align: 'center', width: 180
						,templet:"<div>{{layui.util.toDateString(d.operatetime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
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
							,time2: $('#time2').val()
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
