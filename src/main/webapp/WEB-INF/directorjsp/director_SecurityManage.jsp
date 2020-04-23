<%--
  Created by IntelliJ IDEA.
  User: JK
  Date: 2020-3-10
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<title>安防员管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<style>
	.demoTable {
		line-height: 50px;
		margin: 0 70px;
	}

	.selects {
		margin: 0 30px;
	}
</style>
<body>
<h1 style="text-align:center;font-size: 40px;color: #009688">安防员管理</h1>
<!-- 增加搜索条件 -->
<div class="demoTable">
	<button class="layui-btn" data-type="cancel"><i class="layui-icon">&#xe65c;</i>返回首页</button>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp查询条件：
	<br/>
	安防员名称：
	<div class="layui-inline selects">
		<input class="layui-input" name="securityname" id="securityname" autocomplete="off">
	</div>
	<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>查询</button>
	<button class="layui-btn" data-type="addTeacher"><i class="layui-icon">&#xe654;</i>新增</button>
</div>
<input type="hidden" value="${pageContext.request.contextPath}" id="srcAddress"/>

<table id="demo" lay-filter="test"></table>
<script type="text/html" id="barDemo">
	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe67e;</i>删除</a>

</script>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
	layui.use(['table', 'layer', 'form'], function () {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		$ = layui.jquery;
		var src = $("#srcAddress").val();
		//第一个实例
		table.render({
			elem: '#demo'
			, height: 332
			, limit: 5//设置的一页要有几条的记录
			, limits: [5, 10]//设置的是对应的是有几个内容值
			, url: src + '/director/selectSecurityManage' //数据接口
			, page: true //开启分页
			, id: 'demotable'//当对应的进行条件查询的时候
			, cellMinWidth: 50 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			, cols: [[ //表头
				{field: 'securityid', title: '安防员编号', align: 'center', sort: true, fixed: 'left', width: 180}
				, {field: 'securityname', title: '安防员名称', align: 'center', width: 180}
				, {field: 'securityregtime', title: '创建时间', align: 'center', sort: true, width: 180,
					templet: "<div>{{layui.util.toDateString(d.securityregtime,'yyyy-MM-dd HH:mm')}}</div>"
				}, {field: 'securitysex', title: '性别', align: 'center'}
				, {field: 'securityage', title: '年龄', align: 'center'}
				, {field: 'securityadd', title: '地址', align: 'center'}
				, {field: 'securityphone', title: '手机', align: 'center'}
				, {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值
			if (layEvent === 'del') {
				layer.confirm('真的删除本行么？', function (index) {
					obj.del(); //删除对应行（tr）的DOM结构
					layer.close(index);
					//向服务端发送删除指令
					$.ajax({
						url: src + '/director/delSecurityTable',
						type: 'post'
						, data: {securityid: data.securityid},
						success: function (data) {
							console.log("--" + data.toString());
							if(data==="success"){
								layer.alert("删除安防员信息成功！",{icon: 6}, function(){
									window.location.href = src + "/director/toUrl/director_SecurityManage";
								});
							}else{
								layer.alert("删除安防员信息失败！",{icon: 2});
							}
							layer.close(index);
						}, error: function (err) {
							console.log(err);
						}
					});
					return false;//阻止表单跳转
				});
			} else if (layEvent === 'edit') {
				var othis = $(this), //othis当前button对象
					method = othis.data('method');//data-method="dialog"中的值
				if (method == "dialog") {
					layer.open({
						type: 2,
						title: '修改信息',
						area: ['500px', '400px'],
						btn: ['修改', '取消'],
						btn1: function (index, layero) {
							var src = $("#srcAddress").val();
							//layer.getChildFrame("form", index)获取iframe的表单
							//serializeArray jquery方法，将表单对象序列化为数组
							var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

							if (formData.securityname.length == 0) {
								layer.alert("请输入安防员名称", {icon: 2});
							} else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(formData.securityname)) {
								layer.alert('安防员名称不能有特殊字符');
							}else if(formData.securitysex=='暂无') {
								layer.alert("请选择安防员性别！");
							} else if (formData.securityphone.length == 0) {
								layer.alert("请选择安防员的联系方式！");
							}else if(!new RegExp("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$").test(formData.securityphone)){
								layer.alert("请输入正确的手机格式！");
							}else if(!new RegExp("^([2-5]\\d|60)$").test(formData.securityage)){
								layer.alert("请输入20-60之间的安防员的年龄！");
							}else if(formData.securityadd.length == 0){
								layer.alert("请输入对应的安防员的地址信息！");
							} else {
								$.ajax({
									url: src + '/director/updateSecurityTable',
									type: 'post',
									data: formData,
									success: function (data) {
										if(data==="success"){
											layer.alert("更新安防员信息成功！",{icon: 6}, function(){
												window.location.href = src + "/director/toUrl/director_SecurityManage";
											});
										}else{
											layer.alert("更新安防员信息失败！",{icon: 2});
										}
										layer.close(index);
									}, error: function (err) {
										console.log(err);
									}
								});
							}
						},
						content: src + '/director/toUrl/director_SecurityDetailmanage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						, success: function (layero, index) {
							console.log(layero, index);
							//	显示
							// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
							var iframeWindow = layero.find("iframe")[0].contentWindow;
							var frameId = $(layero).find("iframe").attr('id');
							$(window.frames[frameId].document).find("#securityid").val(data.securityid);
							$(window.frames[frameId].document).find("#securityname").val(data.securityname);
							$(window.frames[frameId].document).find("#securitysex").val(data.securitysex).prop("selected",true);
							$(window.frames[frameId].document).find("#securityage").val(data.securityage);
							$(window.frames[frameId].document).find("#securityadd").val(data.securityadd);
							$(window.frames[frameId].document).find("#securityphone").val(data.securityphone);
							iframeWindow.layui.form.render(); //更新全部
						}
					});
				}
			}
		});


		var s = $("#demoReload").val();
		$('.demoTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			//	重载--点击对应的搜索按钮的时候进行对应的重载
			if (type == 'reload') {
				//执行重载--只重载数据
				table.reload('demotable', {
					where: { //设定异步数据接口的额外参数，任意设
						securityname: $("#securityname").val()
					}
					, page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			}
			if (type === 'addTeacher') {
				layer.open({
					type: 2,
					title: '添加信息',
					area: ['500px', '400px'],
					btn: ['添加', '取消'],
					btn1: function (index, layero) {
						var src = $("#srcAddress").val();
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

						if (formData.securityname.length == 0) {
							layer.alert("请输入安防员名称", {icon: 2});
						} else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(formData.securityname)) {
							layer.alert('安防员名称不能有特殊字符');
						}else if(formData.securitysex=='暂无') {
							layer.alert("请选择安防员性别！");
						} else if (formData.securityphone.length == 0) {
							layer.alert("请选择安防员的联系方式！");
						}else if(!new RegExp("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$").test(formData.securityphone)){
							layer.alert("请输入正确的手机格式！");
						}else if(!new RegExp("^([2-5]\\d|60)$").test(formData.securityage)){
							layer.alert("请输入20-60之间的安防员的年龄！");
						}else if(formData.securityadd.length == 0){
							layer.alert("请输入对应的安防员的地址信息！");
						}  else {
							$.ajax({
								url: src + '/director/addSecurityForm',
								type: 'post',
								data: formData,
								success: function (data) {
									if(data==="success"){
										layer.alert("新增安防员成功！",{icon: 6}, function(){
											window.location.href = src + "/director/toUrl/director_SecurityManage";
										});
									}else{
										layer.alert("新增安防员失败！",{icon: 2});
									}
									layer.close(index);
								}, error: function (err) {
									console.log(err);
								}
							});
						}
					},
					content: src + '/director/toUrl/director_SecurityDetailmanage'  //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						console.log(layero, index);
					}
				});
			}
			if(type === 'cancel'){
				layer.confirm('您确定退出到园长端首页吗?', {icon: 3, title: '温馨提示'}, function (index) {
					window.location.href = src+"/director/toUrl/directorMain";
					return true;
				});
				return false;
			}
		});

		//将表单转为js对象数据
		function serializeObject($, array) {
			var obj = new Object();
			$.each(array, function (index, param) {
				if (!(param.name in obj)) {
					obj[param.name] = param.value;
				}
			});
			return obj;
		}
	});
</script>
</body>
</html>
