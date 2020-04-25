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
		body{
			font-size: 140%;
		}
		.layui-input{
			width:120%;
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
		h2{
			text-align: center;
			margin-top: 2%;
		}
		body .demo-class .layui-layer-btn{
			width: auto;
			height: 12%;
			text-align: center;
			font-Size:16px
		}

		body .demo1 .layui-layer-btn{
			width: auto;
			margin-top: 5%;
			height: 10%;
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
	<h2 >资 质 审 批</h2>
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="qualifyTable">
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">申请时间：</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time1" id="time1" value="" placeholder="请选择上传开始时间" >
						</div>
					</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="margin: 5% 15%;width: 10%">至</span>
						<div class="layui-input-inline">
							<input type="date" class="layui-input" name="time2" id="time2" value="" placeholder="请选择上传结束时间" style="margin: -27% 65%;">
						</div>
					</div>
					<div class="layui-inline" >
						<span class="layui-form-label" style="margin-left: 35%">状态：</span>
						<div class="layui-input-inline" style="margin: -13% 75%;">
							<select name="sel" id="sel" lay-filter="mySelect" lay-verify="" >
								<option value="请选择" >请选择</option>
								<option value="未审批" >未审批</option>
								<option value="通过" >通过</option>
								<option value="不通过" >不通过</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">园所名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="kindername" id="kindername" placeholder="请输入园所名称" >
						</div>
					</div>
					<button class="layui-btn" data-type="reload" style="margin-left: 8.5%;" ><i class="layui-icon">&#xe615;查询</i></button>
				</div>
			</div>
		</form>
	</div>
	<table id="qualify" lay-filter="test" class="layui-table-cell"></table>
	<script type="text/html" id="barOption">
		{{#  if(d.kinderstatus == '通过'){ }}
		<a type="button" class="layui-btn layui-btn-sm layui-btn-disabled" lay-event="" style="height: 40px;"><span class="sp">审批完成</span></a>
		{{#  } }}
		{{#  if(d.kinderstatus == '未审批'){ }}
		<a type="button" class="layui-btn layui-btn-sm" lay-event="approve" style="height: 40px;"><span class="sp">审批</span></a>
		{{#  } }}
		{{#  if(d.kinderstatus == '不通过'){ }}
		<a type="button" class="layui-btn layui-btn-sm" lay-event="approve" style="height: 40px;"><span class="sp">审批</span></a>
		{{#  } }}
		<a type="button" class="layui-btn layui-btn-sm" lay-event="look" style="height: 40px;"><span class="sp">查看</span></a>
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
			, height: 450
			, url: path + "/admin/qualifyAppInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'kinderid', title: '序号', align: 'center', width: 160, sort: true, fixed: 'left'}
				, {field: 'kindername', title: '园所名称', align: 'center', width: 320}
				, {field: 'kinderregtime', title: '申请时间', align: 'center', width: 320
					,templet:"<div>{{layui.util.toDateString(d.kinderregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderapptime', title: '审批时间', align: 'center', width: 320
				   ,templet:"<div>{{layui.util.toDateString(d.kinderapptime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
				, {field: 'kinderstatus', title: '状态', align: 'center', width: 160}
				, {fixed: 'right', title: '操作', align: 'center', width: 442, toolbar: '#barOption'}
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
					layer.open({
						type:2
						,title: ['园所审批', 'font-size:18px;']
						,area:['38%','90%']
						,btn:['允许','拒绝','取消']
						,btnAlign: 'c'
						,closeBtn:0
						,offset: '50px'
						,skin: 'demo-class'
						,content:path+"/admin/toUrl/gardenApproval"
						,success : function(layero, index) {
							$.ajax({
								url:path+"/admin/findKinderInfoById",
								type:'POST',
								dataType:'json',
								data:{"kinderid":data.kinderid},
								success:function (result) {
									var kinderInfo = eval(result);
									var body = layer.getChildFrame('body',index);
									for(i in kinderInfo)
									{
										body.find("#kindername").val(kinderInfo[i].kindername);
										body.find("#kinderacount").val(kinderInfo[i].kinderacount);
										body.find("#kinderlp").val(kinderInfo[i].rectorname);
										body.find("#kinderlpid").val(kinderInfo[i].kinderlpid);
										body.find("#kinderlpadd").val(kinderInfo[i].kinderlpadd);
										body.find("#kinderlpphone").val(kinderInfo[i].kinderlpphone);
										body.find("#schoolpermit").val(kinderInfo[i].schoolpermit);
										body.find("#healthpermit").val(kinderInfo[i].healthpermit);
										body.find("#firepermit").val(kinderInfo[i].firepermit);
										body.find("#grouppermit").val(kinderInfo[i].grouppermit);
										body.find("#registrationpermit").val(kinderInfo[i].registrationpermit);
										body.find("#kinderstatus").val(kinderInfo[i].kinderstatus);
										body.find("#kinderscale").val(kinderInfo[i].kinderscale);
										body.find("#kinderfunds").val(kinderInfo[i].kinderfunds);
									}
								}
							});
						}
						,btn1:function () {
							$.ajax({
								url:path+"/admin/checkQualify",
								type:'POST',
								dataType:'text',
								data:{"kinderid":data.kinderid},
								success:function (result,index) {
									if (result == 'success')
									{
										index = parent.layer.getFrameIndex(window.name);
										parent.layer.close(index); //再执行关闭
										layer.alert('园所申请审批已通过！',{icon:6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										tableIns.reload();

									}else if(result == 'codeerror')
									{
										layer.alert('无相关数据！',{icon:2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
									else {
										layer.alert('园所审批失败！',{icon:2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
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
										index = parent.layer.getFrameIndex(window.name);
										parent.layer.close(index); //再执行关闭
										layer.alert('园所申请审批未通过！',{icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										tableIns.reload();

									}else if(result == 'codeerror')
									{
										layer.alert('无相关数据！',{icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
									else {
										layer.alert('园所审批失败！',{icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									}
								}
							});
						},
						btn3:function (){
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.close(index); //再执行关闭
						}
					});
				}
				else if(layEvent === 'look'){
					layer.open({
						type:2
						,title:['园所详情信息','font-size:18px;']
						,area:['38%','90%']
						,btn:['返回']
						,offset: '50px'
						,skin: 'demo1'
						,content: path+"/admin/toUrl/kinderDetailInfo"
						,success : function(layero, index) {
							$.ajax({
								url:path+"/admin/findKinderInfoById",
								type:'POST',
								dataType:'json',
								data:{"kinderid":data.kinderid},
								success:function (result) {
									var kinderInfo = eval(result);
									var body = layer.getChildFrame('body',index);
									for(i in kinderInfo)
									{
										body.find("#kindername").val(kinderInfo[i].kindername);
										body.find("#kinderacount").val(kinderInfo[i].kinderacount);
										body.find("#kinderlp").val(kinderInfo[i].rectorname);
										body.find("#kinderlpid").val(kinderInfo[i].kinderlpid);
										body.find("#kinderlpadd").val(kinderInfo[i].kinderlpadd);
										body.find("#kinderlpphone").val(kinderInfo[i].kinderlpphone);
										body.find("#schoolpermit").val(kinderInfo[i].schoolpermit);
										body.find("#healthpermit").val(kinderInfo[i].healthpermit);
										body.find("#firepermit").val(kinderInfo[i].firepermit);
										body.find("#grouppermit").val(kinderInfo[i].grouppermit);
										body.find("#registrationpermit").val(kinderInfo[i].registrationpermit);
										body.find("#kinderstatus").val(kinderInfo[i].kinderstatus);
										body.find("#kinderscale").val(kinderInfo[i].kinderscale);
										body.find("#kinderfunds").val(kinderInfo[i].kinderfunds);
									}
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
						,kinderstatus: $('#sel option:selected').val()
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
