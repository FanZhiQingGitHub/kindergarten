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
		/*#sel{*/
		/*	margin-left: -30%;*/
		/*}*/
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<h2 >资 质 审 批</h2>
	<hr style="color: whitesmoke">
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="qualifyTable">
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" >申请时间：</span>
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
					<div class="layui-inline" >
						<span class="layui-form-label" style="margin-left: -55%">状态：</span>
						<div class="layui-input-inline" style="margin-left: -18%;">
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >
								<option value="请选择" >请选择</option>
								<option value="未审核" >未审批</option>
								<option value="通过" >通过</option>
								<option value="未通过" >不通过</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 6%">
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
	<table id="qualify" lay-filter="test"></table>
	<script type="text/html" id="barOption">
		{{#  if(d.kinderstatus == '通过'){ }}
		<a type="button" class="layui-btn layui-btn-xs layui-btn-disabled" lay-event="" style="width: 35%;height: 75%" >审批完成</a>
		{{#  } }}
		{{#  if(d.kinderstatus == '未审批'){ }}
		<a type="button" class="layui-btn layui-btn-xs" lay-event="approve" style="width: 25%;height: 75%" >审批</a>
		{{#  } }}
		{{#  if(d.kinderstatus == '不通过'){ }}
		<a type="button" class="layui-btn layui-btn-xs" lay-event="approve" style="width: 25%;height: 75%" >审批</a>
		{{#  } }}
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
			elem: '#qualify'
			, height: 312
			, url: path + "/admin/qualifyAppInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'kinderid', title: '序号', align: 'center', width: 120, sort: true, fixed: 'left'}
				, {field: 'kindername', title: '园所名称', align: 'center', width: 220}
				, {field: 'kinderregtime', title: '申请时间', align: 'center', width: 240
					,templet:"<div>{{layui.util.toDateString(d.kinderregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderapptime', title: '审批时间', align: 'center', width: 240
				   ,templet:"<div>{{layui.util.toDateString(d.kinderapptime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderstatus', title: '状态', align: 'center', width: 120}
				, {fixed: 'right', title: '操作', align: 'center', width: 200, toolbar: '#barOption'}
			]]
			, id: 'qualifyTable'
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
				if (layEvent === 'approve') {
					$.ajax({
						url:path+"/admin/findTblKinderById",
						type:'POST',
						dataType:'text',
						data:{"kinderid":data.kinderid},
						success:function (msg) {
						}
					});
					layer.open({
						type:2
						,title:"园所审批"
						,area:['40%','83%']
						,offset:['80']
						,btn:['允许','拒绝']
						,btnAlign: 'c'
						,content:path+"/admin/toUrl/gardenApproval"
						,success : function(layero, index) {
						}
						,btn1:function () {
							$.ajax({
								url:path+"/admin/checkQualify",
								type:'POST',
								dataType:'text',
								data:{"kinderid":data.kinderid},
								success:function (result,index) {
									console.log(result);
									if (result == 'success')
									{
										layer.alert('审核成功！');
									}else if(result == 'codeerror')
									{
										layer.alert('无相关数据！');
									}
									else {
										layer.alert('审核失败！');
									}
									layer.close(index);
									tableIns.reload();    //审核之后,刷新表格
								}
							});
						}
						,btn2:function () {
							$.ajax({
								url:path+"/admin/reject",
								type:'POST',
								dataType:'text',
								data:{"kinderid":data.kinderid},
								success:function (result,index) {
									if (result == 'success')
									{
										layer.alert('审核成功！');
									}else if(result == 'codeerror')
									{
										layer.alert('无相关数据！');
									}
									else {
										layer.alert('审核失败！');
									}
									index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
									parent.layer.close(index);
									tableIns.reload();    //审核之后,刷新表格
								}
							});
						}
					});
				}
			});
		});

		//搜索功能的实现
		$('.qualifyTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('qualifyTable', {
					where: {
						time1: $('#time1').val()
						,time2: $('#time2').val()
						,kinderstatus: $('#sel').val()
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
