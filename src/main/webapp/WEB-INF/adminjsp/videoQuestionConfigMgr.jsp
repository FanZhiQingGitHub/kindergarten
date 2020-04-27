<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-8
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-视频试题配置管理</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
	<style>
		h2{
			text-align: center;
			margin-top: 1.5%;
		}
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
	<h2 >视频试题配置</h2>
	<hr style="color: white">
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="videoQuestionTable">
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-block">查询条件：</div>
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">上传时间：</span>
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
					<button class="layui-btn" data-type="reload" style="margin-left: 10%"><i class="layui-icon">&#xe615;查询</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%;">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">视频名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="safetyVideoName1" id="safetyVideoName1" placeholder="请输入视频名称" >
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table id="videoQuestion" lay-filter="test" class="layui-table-cell"></table>

	<div id="type-content" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">上传视频：</label>
			<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadVideo"><i class="layui-icon">&#xe624;</i></button>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">视频名称：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="safetyVideoName" id="safetyVideoName" placeholder="请输入视频名称" style="width: 120%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件名称：</label>
			<div class="layui-inline">
				<input type="text" id="videoName" name="videoName" placeholder="请输入文件名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件地址：</label>
			<div class="layui-inline">
				<input type="text" id="videoAdd" name="videoAdd" placeholder="请输入文件地址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content2" style="display: none;">
		<div class="layui-form-item">
			<label class="layui-form-label">上传视频：</label>
			<button type="button" class="layui-btn layui-btn-primary" name="file" id="uploadVideo2"><i class="layui-icon">&#xe624;</i></button>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">视频名称：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="safetyVideoName2" id="safetyVideoName2" placeholder="请输入视频名称" style="width: 120%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件名称：</label>
			<div class="layui-inline">
				<input type="text" id="videoName2" name="videoName2" placeholder="请输入文件名称" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件地址：</label>
			<div class="layui-inline">
				<input type="text" id="videoAdd2" name="videoAdd2" placeholder="请输入文件地址" value=""
				       autocomplete="off" class="layui-input" style="width: 120%">
			</div>
		</div>
	</div>

	<div id="type-content3" style="display: none;">
		<input type="hidden" id="id" name="id">
		<table id="configItems" lay-filter="test" class="">
			<div class="layui-form-item" style="margin-left: 15%;">
				<div class="layui-inline">
					<span class="layui-form-label">标题：</span>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="title" id="title" value="" placeholder="请输入标题" style="width: 120%;margin-top: 2% " readonly>
					</div>
				</div>
				<button class="layui-btn btn-add btn-default" id="btn-add2" style="margin-left: 10%"><i class="layui-icon">&#xe624;新增</i></button>
			</div>
			<span style="margin-left:1%;font-size: 90%">题目预览：</span>
		</table>
	</div>

	<div id="type-content4" style="display: none;">
		<input type="hidden" id="safetyVideoId" name="safetyVideoId">
		<div class="layui-form-item" style="margin-top: 1%;">
			<label class="layui-form-label" style="width: auto;margin-left: 7.2%">题目：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="topicName" id="topicName" placeholder="请输入题目" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 5%">选项A：</label>
			<div class="layui-input-inline" style="margin-top: 1%;width: 60%">
				<input type="radio" id="ra1" name="optionA" class="optionA" value="正确" title="正确" checked>正确
				<input type="radio" id="ra2" name="optionA" class="optionA" value="是" title="是" style="margin-left: 10%;">是
				<input type="radio" id="ra3" name="optionA" class="optionA" value="符合" title="符合" style="margin-left: 10%;">符合
			</div>

		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 5%">选项B：</label>
			<div class="layui-input-inline" style="margin-top: 1%;width: 60%">
				<input type="radio" id="ra4" name="optionB" class="optionB" value="错误" title="错误" checked>错误
				<input type="radio" id="ra5" name="optionB" class="optionB" value="否" title="否" style="margin-left: 10%;">否
				<input type="radio" id="ra6" name="optionB" class="optionB" value="不符合" title="不符合" style="margin-left: 10%;">不符合
			</div>

		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 0.5%">正确答案：</label>
			<div class="layui-inline">
				<input type="text" id="result" name="result" placeholder="请输入正确答案" value=""
				       autocomplete="off" class="layui-input" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label" style="width: auto;margin-left: 7.2%">得分：</label>
			<div class="layui-input-inline" style="margin-top: 1%;width: 60%">
				<input type="radio" id="ra7" name="score" class="score" value="5" title="5" checked>5分
				<input type="radio" id="ra8" name="score" class="score" value="10" title="10" style="margin-left: 4%;">10分
				<input type="radio" id="ra9" name="score" class="score" value="15" title="15" style="margin-left: 4%;">15分
				<input type="radio" id="ra10" name="score" class="score" value="20" title="20" style="margin-left: 4%;">20分
				<input type="radio" id="ra11" name="score" class="score" value="25" title="25" style="margin-left: 4%;">25分
			</div>
		</div>
	</div>

	<div id="type-content5" style="display: none;">
		<input type="hidden" id="safetyVideoName5" name="safetyVideoName5">
		<input type="hidden" id="safetyvtqid" name="safetyvtqid">
		<div class="layui-form-item" style="margin-top: 1%;">
			<label class="layui-form-label">题目：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="topicName2" id="topicName2" placeholder="请输入题目" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选项A：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="a2" id="a2" placeholder="请输入选项A名称" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选项A分值：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="avalue" id="avalue" placeholder="请输入选项A分值" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选项B：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="b2" id="b2" placeholder="请输入选项B名称" style="width: 180%;">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">选项B分值：</label>
			<div class="layui-inline">
				<input type="text" class="layui-input" name="bvalue" id="bvalue" placeholder="请输入选项B分值" style="width: 180%;">
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		<a type="button" class="layui-btn layui-btn-sm" lay-event="configItems" style="height: 40px;"><span class="sp">配置试题</span></a>
	</script>
</body>

	<script>
		layui.use(['form','element'],function () {
			var form = layui.form
				,element = layui.element;
			element.render();
			form.render();
		});
	</script>
	<script>
		layui.use(['form', 'layer', 'upload', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
			var form = layui.form
				, layer = layui.layer
				, layedit = layui.layedit
				, laydate = layui.laydate
				, element = layui.element
				, tree = layui.tree
				,table = layui.table
				,upload = layui.upload;
			$ = layui.jquery;
			var path = $("#path").val();
			var tableIns = table.render({
				elem: '#videoQuestion'
				, height: 450
				, url: path + "/admin/videoQuestionConfiguration"//数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					{field: 'safetyvideoid', title: '视频编号', align: 'center', width: 200, sort: true, fixed: 'left'}
					, {field: 'safetyvideoname', title: '视频名称', align: 'center', width: 340}
					, {field: 'videoname', title: '文件名称', align: 'center', width: 400}
					, {field: 'safetyvideotime', title: '上传时间', align: 'center', width: 340
					   ,templet:"<div>{{layui.util.toDateString(d.safetyvideotime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
					, {fixed: 'right', title: '操作', align: 'center', width: 442, toolbar: '#barOption'}
				]]
				, id: 'videoQuestionTable'
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
					if(layEvent === 'configItems') {
						var data2 = "";
							layer.open({
								type: 1,
								area: ['60%', '86%'],
								closeBtn :0,
								content: $("#type-content3"),
								title: ['配置试题','font-size:18px'],
								btn: ['保存', '取消'],
								skin: 'demo-class',
								offset: '60px',
								btnAlign: 'c',
								success:function (layero, index) {
									var opt = "";
									var title = "";
									$.ajax({
										url: path + "/admin/findAllSafetyVideoItemsInfo",
										type: "post",
										data: {"safetyvideoid": data.safetyvideoid},
										dataType: "json",
										success: function (result) {
											data2 = eval(result);
											for(var i in data2)
											{
												title = data2[i].safetyvideoname;
												var id = i-0+1;
												var safetyvtqid = data2[i].safetyvtqid;
												var safetyvtqname = data2[i].safetyvtqname;
												var a = data2[i].a;
												var avalue = data2[i].avalue;
												var b = data2[i].b;
												var bvalue = data2[i].bvalue;
												opt += "<tr>" +
													"<td colspan='4' id='top' style='font-size: 110%;padding: 1%' >" + safetyvtqid + "." + safetyvtqname + "</td>" +
													"<td><input type='button' class='layui-btn-primary' id = 'btn' name='btn' value='修改' style='width: 180%;margin-left: 60%;font-size: 110%;' onclick='showCurTopInfo(this)'></td>" +
													"<td><input type='button' class='layui-btn-primary' id = 'btn1' name='btn1' value='删除' style='width: 180%;height:8%;margin-left: 160%;font-size: 110%;'  onclick='deleteTopic(this)'></td>" +
													"</tr>";
												opt += "<tr>" +
													"<td colspan='4' id='td1' style='font-size: 110%;padding: 1% 2%;'>" +
													"<input type='radio' class='rad' name='answer" + safetyvtqid + "' value='" + avalue + "' >" + a + "</td>" +
													"<td colspan='4' id='td1' style='font-size: 110%;'>" +
													"<input type='radio' class='rad' name='answer" + safetyvtqid + "' value='" + bvalue + "' >" + b + "</td>" +
													"</tr>";
											}
											$("#configItems").append(opt);
											$("#title").val(data.safetyvideoname);
										}
									});
									$("#id").val(data.safetyvideoid);
								},
								btn2:function (index){
									data2 = "";
									layer.close(index);
								}
							});
					}
				});
			});

			$("#btn-add2").click(function () {
				layer.open({
					type: 1,
					area: ['40%', '60%'],
					closeBtn :0,
					content:$("#type-content4"),
					title: ['新增题目','font-size:18px'],
					btn: ['保存', '取消'],
					skin: 'demo-class',
					btnAlign: 'c',
					success : function(layero, index) {
						var id = $("#id").val();
						$("#safetyVideoId").val(id);
					},
					btn1: function (index) {
						var title = $("#safetyVideoId").val();
						var topicName = $("#topicName").val();
						var a = $("input[name='optionA']:checked").val();
						var b = $("input[name='optionB']:checked").val();
						var avalue = 0;
						var bvalue = 0;
						var result = $("#result").val();
						var score = $("input[name='score']:checked").val();
						if(result == "正确" || result == "是" || result == "符合")
						{
							avalue = score;
							bvalue = 0;
						}else{
							bvalue = score;
							avalue = 0;
						}
						if (topicName.length == 0) {
							layer.alert("不能为空,请输入题目", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}else if(a == 0) {
							layer.alert("不能为空,请先选择A选项内容", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}else if(b == 0)
						{
							layer.alert("不能为空,请先选择B选项内容", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}else if(result == 0)
						{
							layer.alert("答案不能为空，请输入正确答案", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
						}
						else {
							$.ajax({
								url: path + '/admin/addTopic',
								async: true,
								type: 'post',
								data: {"safetyvideoid":title,"safetyvtqname":topicName,"a":a,"b":b,"bvalue":bvalue,"avalue":avalue},
								datatype: 'json',
								success: function (data) {
									if (data == "error") {
										layer.alert("新增失败", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									} else {
										$("#configItems").append("");
										layer.alert("新增成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
										layer.close(index);
										// parent.location.reload();
										var opt = "";
										var title = "";
										var items = eval(data);
										for(var i in items)
										{
											title = items[i].safetyvideoname;
											var id = i-0+1;
											var safetyvtqid =items[i].safetyvtqid;
											var safetyvtqname = items[i].safetyvtqname;
											var a = items[i].a;
											var avalue = items[i].avalue;
											var b = items[i].b;
											var bvalue = items[i].bvalue;
											opt += "<tr>" +
												"<td colspan='4' id='top' style='font-size: 110%;padding: 1%' >" + safetyvtqid + "." + safetyvtqname + "</td></tr>";
											opt += "<tr>" +
												"<td colspan='4' id='td1' style='font-size: 110%;padding: 1% 2%;'>" +
												"<input type='radio' class='rad' name='answer" + safetyvtqid + "' value='" + avalue + "' >" + a + "</td>" +
												"<td colspan='4' id='td1' style='font-size: 110%;'>" +
												"<input type='radio' class='rad' name='answer" + safetyvtqid + "' value='" + bvalue + "' >" + b + "</td>" +
												"<td><input type='button' class='layui-btn-primary' id = 'btn' name='btn' value='修改' style='width: 180%;margin-left: 60%;font-size: 110%;' onclick='showCurTopInfo(this)'></td>" +
												"<td><input type='button' class='layui-btn-primary' id = 'btn1' name='btn1' value='删除' style='width: 180%;height:8%;margin-left: 160%;font-size: 110%;' onclick='deleteTopic(this)'></td>" +
												"</tr>";
										}
										$("#configItems").append(opt);
										tableIns.reload();
									}
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							});
						}
					},
					btn2:function (index) {
						$("#topicName").val("");
						$("#result").val("");
						layer.close(index);
					}
				});
			});

			$(function () {
				$("#topicName").blur(function () {
					var reg = /[\u4e00-\u9fa5]|[\（\）\《\》\——\；\，\。\“\”\<\>\！\？]/;
					var topicName = $('#topicName').val();
					if (!$('#topicName').val().match(reg) || topicName == 0) {
						layer.msg("请输入至少6位中文字符", {icon: 2});
					} else {
						layer.msg("题目输入合法", {icon: 6});
					}
				});

				$("#result").blur(function () {
					var reg = /^[\u4e00-\u9fa5]{1,2}$/;
					var result = $('#result').val();
					if (!$('#result').val().match(reg) || result == 0 ) {
						layer.msg("输入不合法，请重新输入正确答案：", {icon: 2});
					} else {
						layer.msg("输入合法", {icon: 6});
					}
				});

			});

			$("#btn-add").click(function () {
				layer.open({
					type: 2,
					area: ['40%', '60%'],
					content: path+"/admin/toUrl/uploadVideoInfo",
					title: '上传视频',
					offset: '100px',
					btnAlign: 'c',
					skin: 'demo-class'
				});
			});

			//搜索功能的实现
			$('.videoQuestionTable .layui-btn').on('click', function () {
				var type = $(this).data('type');
				active[type] ? active[type].call(this) : '';
			});

			var $ = layui.$, active = {
				reload: function () {
					//执行重载
					table.reload('videoQuestionTable', {
						where: {
							time1: $('#time1').val()
							,time2: $('#time2').val()
							,safetyvideoname: $('#safetyVideoName1').val()
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
		var path = $("#path").val();
		function deleteTopic(node){
			var topName = $(node).parent().parent('tr').text().split(".")[1];
			var id = $(node).parent().parent('tr').text().split(".")[0];
			$.ajax({
				url: path + "/admin/deleteTopic",
				type: "POST",
				async: true,
				data: {"safetyvtqname":topName,"safetyvtqid":id},
				dataType: "text",
				success: function (msg) {
					if (msg == "success") {
						alert("题目删除成功");
						parent.location.reload();
					} else {
						alert("题目删除失败");
					}
				},
				error: function () {
					alert("网络繁忙！")
				}
			})
		}

		function showCurTopInfo(node) {
			layui.use(['form', 'layer', 'jquery','table'], function () {
				var form = layui.form
					, layer = layui.layer
					, table = layui.table
					, $ = layui.jquery;
				var topName = $(node).parent().parent('tr').text();
				$.ajax({
					url: path + "/admin/queryTopic",
					type: "POST",
					async: true,
					data: {"safetyvtqname":topName.split(".")[1],"safetyvtqid":topName.split(".")[0]},
					dataType: "json",
					success: function (msg) {
						if (msg == "error") {
							layer.alert("无相关记录",{icon:2})
						} else {
							for(var i in eval(msg))
							{
								$("#safetyvtqid").val(eval(msg)[i].safetyvtqid);
								$("#topicName2").val(eval(msg)[i].safetyvtqname);
								$("#a2").val(eval(msg)[i].a);
								$("#b2").val(eval(msg)[i].b);
								$("#avalue").val(eval(msg)[i].avalue);
								$("#bvalue").val(eval(msg)[i].bvalue);
							}
						}
					},
					error: function () {
						alert("网络繁忙！")
					}
				});
				layer.open({
					type: 1,
					area: ['40%', '80%'],
					content:$("#type-content5"),
					title: '修改题目',
					btn: ['保存', '取消'],
					offset: ['60px','300px'],
					btnAlign: 'c',

					success : function(layero, index) {
						$("#safetyVideoName5").val($("#title").val());
						$("#topicName2").val(topName.split(".")[1]);
					},
					btn1: function (index) {
						var safetyvtqid = $("#safetyvtqid").val()
						var safetyVideoName = $("#safetyVideoName5").val();
						var topicName = $("#topicName2").val();
						var a = $("#a2").val();
						var b = $("#b2").val();
						var avalue = $("#avalue").val();
						var bvalue = $("#bvalue").val();
						if (topicName.length == 0) {
							layer.alert("请输入题目", {icon: 2});
						}
						else {
							$.ajax({
								url: path + '/admin/updateTopic?safetyVideoName='+safetyVideoName+'',
								async: true,
								type: 'post',
								data: {"safetyvtqid":safetyvtqid,"safetyvtqname":topicName,"a":a,"b":b,"bvalue":bvalue,"avalue":avalue},
								datatype: 'text',
								success: function (data) {
									if (data == "success") {
										layer.alert("修改成功！", {icon: 6});
										setTimeout(function () {
											location.reload(); //再执行关闭
										}, 3000);
									} else {
										layer.alert("修改失败", {icon: 2});
									}
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2});
								}
							});
						}
					},
					btn2:function () {
						$("#topicName2").val("");
						$("#a2").val("");
						$("#b2").val("");
						$("#avalue").val("");
						$("#bvalue").val("");
					}
				});
				$(function () {
					$("#topicName2").blur(function () {
						var reg = /[\u4e00-\u9fa5]|[\（\）\《\》\——\；\，\。\“\”\<\>\！\？]/;
						var topicName2 = $('#topicName2').val();
						if (!$('#topicName2').val().match(reg) || topicName2 == 0) {
							layer.msg("请输入至少6位中文字符", {icon: 2});
						} else {
							layer.msg("题目输入合法", {icon: 6});
						}
					});
					$("#a2").blur(function () {
						var reg = /^[\u4e00-\u9fa5]$/;
						var a2 = $('#a2').val();
						if (!$('#a2').val().match(reg) || a2 == 0) {
							layer.msg("请输入正确或是", {icon: 2});
						} else {
							layer.msg("选项A输入合法", {icon: 6});
						}
					});
					$("#b2").blur(function () {
						var reg = /^[\u4e00-\u9fa5]$/;
						var b2 = $('#b2').val();
						if (!$('#b2').val().match(reg) || b2 == 0 ) {
							layer.msg("请输入错误或否", {icon: 2});
						} else {
							layer.msg("选项A输入合法", {icon: 6});
						}
					});
					$("#avalue").blur(function () {
						var reg = /^[0-9]*$/;;
						var avalue = $('#avalue').val();
						if (!$('#avalue').val().match(reg) || avalue == 0 ) {
							layer.msg("输入不合法，请输入数字", {icon: 2});
						} else {
							layer.msg("输入合法", {icon: 6});
						}
					});
					$("#bvalue").blur(function () {
						var reg = /^[0-9]*$/;
						var bvalue = $('#bvalue').val();
						if(!$('#bvalue').val().match(reg) || bvalue == 0)
						{
							layer.msg("输入不合法，请输入数字", {icon: 2});
						}else{
							layer.msg("输入合法", {icon: 6});
						}
					});
				});
				});
			}

	</script>
</html>
