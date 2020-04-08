<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-园所资质审批</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>
		h2{
			text-align: center;
			margin-top: 1%;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >资 质 审 批</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="kinderTable">
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
					<div class="layui-inline" >
						<label class="layui-form-label">状态：</label>
						<div class="layui-input-inline">
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >
								<option value="请选择">请选择</option>
								<option value="未审核">未审核</option>
								<option value="通过">通过</option>
								<option value="未通过">未通过</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline">
						<span class="layui-form-label">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" style="width: 82%;margin-top: 3% ">
						</div>
					</div>
					<button class="layui-btn" data-type="reload" ><i class="layui-icon">&#xe615;查询</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="kinder" lay-filter="test"></table>
	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-normal" lay-event="approve" >审批</button>
	</script>
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
			,$ = layui.jquery;
		var path = $("#path").val();
		var tableIns = table.render({
			elem: '#kinder'
			, height: 312
			, url: path + "/admin/kinderMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'kinderid', title: '序号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'kindername', title: '园所名称', align: 'center', width: 120}
				, {field: 'kinderregtime', title: '申请时间', align: 'center', width: 180
					,templet:"<div>{{layui.util.toDateString(d.kinderregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderapptime', title: '审批时间', align: 'center', width: 180
				   ,templet:"<div>{{layui.util.toDateString(d.kinderapptime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderstatus', title: '状态', align: 'center', width: 120}
				, {fixed: 'right', title: '操作', align: 'center', width: 200, toolbar: '#barOption'}
			]]
			, id: 'kinderTable'
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
			table.on('tool(test)', function(obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
				data = obj.data; //获得当前行数据
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				var tr = obj.tr; //获得当前行 tr 的DOM对象
				if (layEvent === 'approve') { //审核通过
					layer.prompt({
							formType: 0,
							id: "remarksPrompt",
							title: '资质审核-温馨提示(0:未审核,1:通过,2：未通过)',
							success:function (layero,index) {
							}
						},
						function () {
							$("#remarksPrompt").blur(function () {
								var reg = /^[1-2]*$/;
								if (!($('#oldadminpwd').val().match(reg))) {
									layer.msg("请输入数字(1或2)！", {icon: 2, title: '温馨提示'})
								} else {
									layer.msg("输入合法", {icon: 5, title: '温馨提示'})
								}
							});
						},
						function (value, index, elem) {
							layer.close(index);
							//向服务端发送审核通过指令
							if(value == 0)
							{
								layer.msg("请输入数字(1或2)！",{icon:2,title:'温馨提示'})
							}
							else if (isNaN(value)) {
								$.ajax({
									url: path + "/admin/checkQualify",
									type: "post",
									data: {"kinderid": data.kinderid, "kinderstatus": value},
									dataType: "text",
									success: function (result) {
										if (result == "success") {
											layer.msg('审核通过！');
										} else if (result == "codeerror") {
											layer.msg('状态码输入异常！');
										} else {
											layer.msg('审核失败！');
										}
										tableIns.reload();    //审核之后,刷新表格
									}
								});
							}
							else {
								layer.msg("请输入数字(1或2)！",{icon:2,title:'温馨提示'});
							}
						});
				}
			});
		});

		//搜索功能的实现
		$('.kinderTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('kinderTable', {
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
