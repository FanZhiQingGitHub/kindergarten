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
	<script src=<%=path + "/js/jquery-3.4.1.js"%>></script>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>

		h2 {
			margin-top: 1.5%;
			text-align: center;
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
	<h2>亲子阅读管理</h2>
	<hr style="color: white">
	<div class="layui-row" >
		<form class="layui-form" action="" onsubmit="return false;" >
			<div class="readTable">
				<div class="layui-form-item" style="margin-left: 6%">
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
					<button class="layui-btn btn-add btn-default" id="btn-add" ><i class="layui-icon">&#xe681;上传绘本</i></button>
				</div>
				<div class="layui-form-item" style="margin-left: 6%">
					<div class="layui-inline">
						<span class="layui-form-label" style="width: auto">绘本名称：</span>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="readMagName0" id="readMagName0" placeholder="请输入绘本名称" >
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<table id="read" lay-filter="test" class="layui-table-cell" ></table>

	<div id="type-content" style="display: none;">
		<form class="layui-form" action="">
			<div class="layui-form-item" style="margin-top: 4%">
				<label class="layui-form-label" style="width: 24%">绘本名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="readMagName2" id="readMagName2" value="" placeholder="" style="width: 200%;height: 40px;">
				</div>
			</div>
			<div class="layui-form-item" >
				<label class="layui-form-label" style="width: 24%">绘本图片：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 200%;height: 40px;">
				</div>
			</div>

			<div class="layui-form-item" >
				<label class="layui-form-label" style="width: 24%">文件地址：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 200%;height: 40px;">
				</div>
			</div>

			<div class="layui-form-item" >
				<label class="layui-form-label" style="width: 24%">页数：</label>
				<div class="layui-input-inline">
					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 200%;height: 40px;">
				</div>
			</div>
		</form>
	</div>

	<div id="type-content2" style="display: none;">
		<button class="layui-btn" style="margin-top: 3%" id="reback"><span class="sp">返回亲子阅读管理</span></button>
		<h1 align="center" id="titleName" > </h1>

		<div align="center">
			<img src="" id="pageImg" style="height: 150px">
		</div>

		<div style="height: 100px;width: 90% " align="center" id="pageContent">

		</div>


		<div class="footer" align="center">

			<div class="layadmin-user-login-box layadmin-user-login-header">
				<div style="padding-bottom: 10px;">
					<button type="button" class="layui-btn layui-btn-normal" id="upPage" ><i
							class="layui-icon"></i>上一页
					</button>

					<span id="nowPage">1 </span>/<span id="totalPage">1</span>

					<button type="button" class="layui-btn layui-btn-normal" id="nextPage" ><i
							class="layui-icon"></i>下一页
					</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/html" id="barOption">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="detail" style="height: 40px"><span class="sp"><i class="layui-icon">&#xe642;查看绘本</i></span></button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="reUpload" style="height: 40px"><span class="sp"><i class="layui-icon">&#xe681;重新上传</i></span></button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="delete" style="height: 40px"><span class="sp"><i class="layui-icon">&#xe640;删除</i></span></button>
	</script>
</body>
<script>
	var nowPage =1;
	var totalPage  =1;
	var readmagid;
	var path;
	layui.use(['form', 'layer', 'jquery', 'laypage', 'layedit', 'laydate', 'element', 'tree', 'table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, laypage = layui.laypage
			, $ = layui.jquery;
		path = $("#path").val();
		var tableIns = table.render({
			elem: '#read'
			, height: 450
			, url: path + "/admin/readMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'readmagid', title: '绘本编号', align: 'center', width: 180, sort: true, fixed: 'left'}
				, {field: 'readmagname', title: '绘本名称', align: 'center', width: 240,
					templet: '<div ><a href="${pageContext.request.contextPath}/{{d.readmagurl}}" class="layui-table-link" style="font-size:100%">{{d.readmagname}}</a></div>'}
				, {field: 'readmagurl', title: '文件夹地址', align: 'center', width: 300
					,templet:function (d) {
						return d.readmagurl == null ? '无': d.readmagurl
					}}
				, {field: 'photourl', title: '图片地址', align: 'center', width: 180
					, templet: function (d) { return '<div><img src="'+path+'/'+d.photourl+'" style="width: 45px;height: 45px"></div>' }
				}
				, {
					field: 'readmagtime', title: '上传时间', align: 'center', width: 280
					, templet: "<div>{{layui.util.toDateString(d.readmagtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {fixed: 'right', title: '操作', align: 'center', width: 540, toolbar: '#barOption'}
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
				var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
				if (layEvent === 'detail') {
					layer.open({
						type: 1,
						area: ['50%', '85%'],
						content: $("#type-content2"),
						title: ['绘本详情','font-size:18px'],
						btnAlign: 'c',
						closeBtn :0,
						skin: 'demo-class',
						success : function(layero, index) {
							readmagid = data.readmagid;
							//方式二
							$.ajax({
								url: path + '/admin/readBookInfo',
								async: true,
								type: 'post',
								data: {"readmagid":readmagid,"nowPage":nowPage},
								success: function (data) {
									var nowPageInfo = data.list[0];
									$("#titleName").html(nowPageInfo.readmagname);

									$("#pageContent").html(nowPageInfo.readmagdetail);

									$("#pageImg").attr('src',path+'/'+nowPageInfo.photourl);

									$("#nowPage").html(nowPage);

									$("#totalPage").html(data.totalRecords);

									totalPage  = data.totalRecords;
								}, error: function (data) {
									layer.alert("网络繁忙！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							});
						}
					});
				}else if(layEvent === 'delete'){
					layer.confirm("确定要删除该绘本信息？",{icon:3,title:'温馨提示',area:['350px','150px']},function (index) {
						layer.close(index);
						$.ajax({
							url: path + "/admin/deleteReadInfo",
							type: "post",
							data: {"readmagid": data.readmagid},
							dataType: "text",
							success: function (result) {
								if(result == "success")
								{
									layer.alert("绘本信息删除成功！", {icon: 6,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
									tableIns.reload();
								}else{
									layer.alert("绘本信息删除失败！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
								}
							},
							error:function (result) {
								layer.alert("网路异常！", {icon: 2,title:['温馨提示','font-size:18px'],area:['350px','150px'],skin:'demo'});
							}
						});
					});
				}else if(layEvent === 'reUpload'){
					var path = $("#path").val();
					layer.open({
						type: 2,
						area: ['45%', '55%'],
						// content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
						content: path+"/admin/toUrl/reUploadPictureBook", //数组第二项即吸附元素选择器或者DOM
						title: ['重新上传绘本信息','font-size:18px'],
						// btn: ['保存','返回'],
						btnAlign: 'c',
						closeBtn:0,
						skin: 'demo-class',
						success:function(layero, index){

							var body = layer.getChildFrame('body',index);
							body.find("#readMagName4").val(data.readmagname);
							body.find("#readMagUrl4").val(data.readmagurl);
							body.find("#readMagPic4").val(data.photourl);
							body.find("#readId").val(data.readmagid);
						}
					});
				}
			});
		});

		$(function () {
			$('#readMagName2').blur(function () {
				var reg = /^[\u4e00-\u9fa5]{2,20}$/;
				var readMagName = $('#readMagName2').val();
				if(!$('#readMagName2').val().match(reg)||readMagName == 0)
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
					layer.msg("输入不合法，请输入数字", {icon: 2});
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
					}
				}else{
					layer.msg("输入不合法，斜杠后必须是字母，请输入如格式：image/adminimg/img/**", {icon: 2});
				}
			});
		});
		
		$("#btn-add").click(function () {
			layer.open({
				type: 2,
				area: ['70%', '70%'],
				content: path+"/admin/toUrl/uploadPictureBooks", //数组第二项即吸附元素选择器或者DOM
				title: ['上传绘本','font-size:18px'],
				btnAlign: 'c',
				closeBtn:0,
				skin: 'demo-class',
				success:function(){

				}
			});
		});

		$("#reback").click(function () {
			location.href = path+"/admin/toUrl/parentChildReadMgr"
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
						,readmagname: $('#readMagName0').val()
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
	$(function () {
		$("#upPage").click(function () {

			if (nowPage == 1){
				layer.msg("已经是第一页了哦");
			} else {
				nowPage -= 1;
				showPageDetail();
			}


		});

		$("#nextPage").click(function () {

			if (nowPage == totalPage){
				layer.msg("已经是最后一页了哦");
			} else {
				nowPage += 1;
				showPageDetail();
			}
		});
	});

	function showPageDetail() {
		$.ajax({
			url: path + '/admin/readBookInfo',
			type: 'post',
			data: {"readmagid":readmagid,"nowPage":nowPage},
			success: function (pageInfo) {

				//数据回显
				var nowPageInfo =pageInfo.list[0];

				$("#pageContent").html(nowPageInfo.readmagdetail);

				$("#pageImg").attr('src',path+'/'+nowPageInfo.photourl);

				$("#nowPage").html(nowPage);

				$("#totalPage").html(pageInfo.totalRecords);

				totalPage  = pageInfo.totalRecords;


			}, error: function (data) {
				layer.alert("网络繁忙！", {icon: 2});
			}
		});

	}

</script>
</html>
