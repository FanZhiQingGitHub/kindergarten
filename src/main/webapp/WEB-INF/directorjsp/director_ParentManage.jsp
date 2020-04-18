<%--
  Created by IntelliJ IDEA.
  User: JK
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<title>家长管理</title>
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
<h1 style="text-align:center;font-size: 40px;color: #009688">家长管理</h1>
<!-- 增加搜索条件 -->
<div class="demoTable">
	<button class="layui-btn" data-type="cancel"><i class="layui-icon">&#xe65c;</i>返回首页</button>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	查询条件：
	<br/>
	创建时间：
	<div class="layui-inline selects">
		<input type="date" class="layui-input" name="beginTime" id="beginTime" autocomplete="off">
	</div>
	至
	<div class="layui-inline selects">
		<input type="date" class="layui-input" name="overTime" id="overTime" autocomplete="off">
	</div>
	家长名称：
	<div class="layui-inline selects">
		<input class="layui-input" name="parentname" id="parentname" autocomplete="off">
	</div>
	<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>查询</button>
	<button class="layui-btn" data-type="addChildren"><i class="layui-icon">&#xe654;</i>新增</button>
</div>
<input type="hidden" value="${pageContext.request.contextPath}" id="srcAddress"/>

<table id="demo" lay-filter="test"></table>
<script type="text/html" id="barDemo">
	<%--	<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
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
			, height: 445
			, limit: 5//设置的一页要有几条的记录
			, limits: [5, 10]//设置的是对应的是有几个内容值
			, url: src + '/director/selectParentManagement' //数据接口
			, page: true //开启分页
			, id: 'demotable'//当对应的进行条件查询的时候
			, cellMinWidth: 50 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			, cols: [[ //表头
				{field: 'parentId', title: '家长编号', sort: true, align: 'center', width: 120}
				, {field: 'parentName', title: '家长名称', align: 'center', width: 150}
				, {field: 'studentname', title: '宝宝名称', align: 'center', width: 180}
				, {field: 'parentSon', title: '亲子关系', align: 'center', width: 150}
				, {field: 'parentPhone', title: '联系方式', align: 'center', width: 150}
				, {field: 'parentJob', title: '职业', sort: true, align: 'center', width: 180}
				, {
					field: 'parentRegTime', title: '创建时间', align: 'center', width: 180,
					templet: "<div>{{layui.util.toDateString(d.parentRegTime,'yyyy-MM-dd HH:mm')}}</div>"
				}
				, {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值
			if (layEvent === 'del') {
				layer.confirm('真的删除行么', function (index) {
					obj.del(); //删除对应行（tr）的DOM结构
					layer.close(index);
					//向服务端发送删除指令
					$.ajax({
						url: src + '/director/delParentTable',
						type: 'post'
						, data: {parentId: data.parentId,studentname:data.studentname},
						success: function (data) {
							console.log("--" + data.toString());
							if(data==="success"){
								layer.alert("删除家长成功！",{icon: 6}, function(){
									window.location.href = src + "/director/toUrl/director_ParentManage";
								});
							}else{
								layer.alert("删除家长失败！",{icon: 2});
							}
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
						area: ['500px', '500px'],
						moveType: 1,//拖拽模式，0或者1
						btn: ['修改', '取消'],
						btn1: function (index, layero) {
							var src = $("#srcAddress").val();
							//layer.getChildFrame("form", index)获取iframe的表单
							//serializeArray jquery方法，将表单对象序列化为数组
							var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

							if (formData.parentName.length == 0) {
								layer.alert("请输入家长名称", {icon: 2});
							} else if (formData.studentname.length == 0) {
								layer.alert("请输入宝宝名称", {icon: 2});
							} else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(formData.studentname)) {
								layer.alert("宝宝名称不能有特殊字符", {icon: 2});
							} else if (formData.studentname == '暂无') {
								layer.alert("请选择宝宝名称！");
							} else if (formData.parentSon == '暂无') {
								layer.alert("请选择家长的亲子关系！");
							} else if (formData.parentJob.length == 0) {
								layer.alert("请选择家长的职业！");
							} else if (formData.parentPhone.length == 0) {
								layer.alert("请选择家长的联系方式！");
							}else if(!new RegExp("^([1-9]\\d?|1[01]\\d|120)$").test(formData.parentAge)){
								layer.alert("请输入1-120之间的家长的年龄！");
							}else if(formData.parentAdd.length == 0){
								layer.alert("请输入对应的家长的地址信息！");
							} else {
								$.ajax({
									url: src + '/director/updateParentTable',
									type: 'post',
									data: formData,
									success: function (data) {
										if(data==="success"){
											layer.alert("修改家长成功！",{icon: 6}, function(){
												window.location.href = src + "/director/toUrl/director_ParentManage";
											});
										}else{
											layer.alert("修改家长失败！",{icon: 2});
										}
										layer.close(index);
										}, error: function (err) {
										console.log(err);
									}
								});
							}
						},
						content: src + '/director/toUrl/director_ParentDetailManage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						, success: function (layero, index) {
							console.log(layero, index);
							//	显示
							var frameId = $(layero).find("iframe").attr('id');
							// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
							var iframeWindow = layero.find("iframe")[0].contentWindow;
							$(window.frames[frameId].document).find("#parentId").val(data.parentId);
							$(window.frames[frameId].document).find("#parentName").val(data.parentName);
							$(window.frames[frameId].document).find("#studentname").val(data.studentname).prop("selected",true);
							$(window.frames[frameId].document).find("#parentSon").val(data.parentSon).prop("selected",true);
							$(window.frames[frameId].document).find("#parentAge").val(data.parentAge);
							$(window.frames[frameId].document).find("#parentAdd").val(data.parentAdd);
							$(window.frames[frameId].document).find("#parentPhone").val(data.parentPhone);
							$(window.frames[frameId].document).find("#parentJob").val(data.parentJob);
							iframeWindow.layui.form.render(); //更新全部
						}
					});
				}
			}
			if(type === 'cancel'){
				layer.confirm('您确定退出到园长端首页吗?', {icon: 3, title: '温馨提示'}, function (index) {
					window.location.href = src+"/director/toUrl/directorMain";
					return true;
				});
				return false;
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
						parentname: $("#parentname").val(),
						beginTime: $("#beginTime").val(),
						overTime: $("#overTime").val()
					}
					, page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			}
			if (type === 'addChildren') {
				layer.open({
					type: 2,
					title: '添加信息',
					area: ['500px', '500px'],
					moveType: 1,//拖拽模式，0或者1
					btn: ['添加', '取消'],
					btn1: function (index, layero) {
						var src = $("#srcAddress").val();
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

						if (formData.parentName.length == 0) {
							layer.alert("请输入家长名称", {icon: 2});
						} else if (formData.studentname.length == 0) {
							layer.alert("请输入宝宝名称", {icon: 2});
						} else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(formData.studentname)) {
							layer.alert("宝宝名称不能有特殊字符", {icon: 2});
						} else if (formData.studentname == '暂无') {
							layer.alert("请选择宝宝名称！");
						} else if (formData.parentSon == '暂无') {
							layer.alert("请选择家长的亲子关系！");
						} else if (formData.parentJob.length == 0) {
							layer.alert("请选择家长的职业！");
						} else if (formData.parentPhone.length == 0) {
							layer.alert("请选择家长的联系方式！");
						}else if(!new RegExp("^([1-9]\\d?|1[01]\\d|120)$").test(formData.parentAge)){
							layer.alert("请输入1-120之间的家长的年龄！");
						}else if(formData.parentAdd.length == 0){
							layer.alert("请输入对应的家长的地址信息！");
						}
						else {
							$.ajax({
								url: src + '/director/addParentForm',
								type: 'post',
								data: formData,
								success: function (data) {
									if(data==="success"){
										layer.alert("新增家长成功！",{icon: 6}, function(){
											window.location.href = src + "/director/toUrl/director_ParentManage";
										});
									}else{
										layer.alert(data,{icon: 2});
									}
									layer.close(index);
								}, error: function (err) {
									console.log(err);
								}
							});
						}
					},
					content: src + '/director/toUrl/director_ParentDetailManage'  //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						console.log(layero, index);
					}
				});
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
