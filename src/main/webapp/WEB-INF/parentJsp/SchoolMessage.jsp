<%--
  Created by IntelliJ IDEA.
  User: JK
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<title>校园消息通知</title>
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
<div class="demoTable">
	<%--	查询条件：--%>
	<%--	<br/>--%>
		推送时间：
		<div class="layui-inline selects">
			<input type="date" class="layui-input" name="beginTime" id="beginTime" autocomplete="off">
		</div>
		至
		<div class="layui-inline selects">
			<input type="date" class="layui-input" name="overTime" id="overTime" autocomplete="off">
		</div>
		通知标题模糊搜索：
	<div class="layui-inline selects">
		<input class="layui-input" name="campusinfoname" id="campusinfoname" autocomplete="off">
	</div>
	<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>查询</button>
</div>
<input type="hidden" value="${pageContext.request.contextPath}" id="srcAddress"/>

<table id="demo" lay-filter="test"></table>
<script type="text/html" id="barDemo">
	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="detail"><i class="layui-icon">&#xe642;</i>查看具体信息</a>
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
			, height: 280
			, limit: 5//设置的一页要有几条的记录
			, limits: [5, 10]//设置的是对应的是有几个内容值
			, url: src + '/parent/findCampusBulletinAll' //数据接口
			, page: true //开启分页
			, id: 'demotable'//当对应的进行条件查询的时候
			, cellMinWidth: 50 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			, cols: [[ //表头
				{field: 'campusinfoid', title: '消息编号', sort: true, align: 'center'}
				, {field: 'campusinfoname', title: '通知标题', align: 'center'}
				, {field: 'campusinfodetail', title: '通知内容', align: 'center'}
				,
				{
					field: 'campustime', title: '推送时间', align: 'center', width: 180,
					templet: "<div>{{layui.util.toDateString(d.campustime,'yyyy-MM-dd HH:mm')}}</div>"
				}
				, {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值
			if (layEvent === 'detail') {
				// layer.alert(JSON.stringify(data), {
				// 	title: '当前行数据：'
				// });
				//示范一个公告层
				layer.open({
					type: 1
					,
					title: '消息内容：' //不显示标题栏
					,
					closeBtn: false
					,
					area: ['430px', '260px']
					// ,
					// shade: 0.4//表示的是阴影的大小
					,
					id: 'LAY_layuipro' //设定一个id，防止重复弹出
					,btn: ['返回']
					,btnAlign: 'c',
					moveType: 1 //拖拽模式，0或者1
					,
					content: '<textarea style="padding: 50px; line-height: 22px; ' +
						' color: #1d0e17; font-weight: 300;width: 400px;height: 230px">' +
						JSON.stringify(data.campusinfodetail)+'</textarea>'
				});
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
						campusinfoname: $("#campusinfoname").val()
						,beginTime: $("#beginTime").val(),
						overTime: $("#overTime").val()
					}, page: {
						curr: 1 //重新从第 1 页开始
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
