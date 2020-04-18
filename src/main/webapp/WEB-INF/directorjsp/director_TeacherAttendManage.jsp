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
	<title>教师考勤管理</title>
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
<h1 style="text-align:center;font-size: 40px;color: #009688">教师考勤管理</h1>
<!-- 增加搜索条件 -->
<div class="demoTable">
	<div style="text-align: center">园所名称：<span>英才幼儿园</span></div>
	<button class="layui-btn" data-type="cancel"><i class="layui-icon">&#xe65c;</i>返回首页</button>
	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp查询条件：
	<br/>
	教师名称：
	<div class="layui-inline selects">
		<input class="layui-input" name="teachername" id="teachername" autocomplete="off">
	</div>
	角色：
	<div class="layui-inline selects">
		<select name="teacherjob" id="teacherjob"  lay-filter="mySelect">
			<option value="暂无" selected>暂无选择</option>
			<option value="班主任">班主任</option>
			<option value="安防员">安防员</option>
			<option value="保健员">保健员</option>
		</select>
	</div>
	<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>查询</button>
<%--	<button class="layui-btn" data-type="addTeacher"><i class="layui-icon">&#xe654;</i>新增</button>--%>
</div>
<input type="hidden" value="${pageContext.request.contextPath}" id="srcAddress"/>

<table id="demo" lay-filter="test"></table>
<script type="text/html" id="barDemo">
	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="edit"><i class="layui-icon">&#xe642;</i>考勤信息</a>
<%--	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe67e;</i>删除</a>--%>

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
			, height: 454
			, limit: 5//设置的一页要有几条的记录
			, limits: [5, 10]//设置的是对应的是有几个内容值
			, url: src + '/director/selectTeacherAttendManage' //数据接口
			, page: true //开启分页
			, id: 'demotable'//当对应的进行条件查询的时候
			, cellMinWidth: 50 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			, cols: [[ //表头
				{field: 'teacherid', title: '教师编号', align: 'center', sort: true, fixed: 'left', width: 180}
				, {field: 'teachername', title: '教师名称', align: 'center', width: 180}
				, {field: 'teacherjob', title: '教师角色', align: 'center', width: 180}
				, {field: 'tattendbegin', title: '考勤开始时间', align: 'center', sort: true, width: 180,
					templet: "<div>{{layui.util.toDateString(d.tattendbegin,'yyyy-MM-dd')}}</div>"
				}
				, {field: 'tattendover', title: '考勤结束时间', align: 'center', sort: true, width: 180,
					templet: "<div>{{layui.util.toDateString(d.tattendover,'yyyy-MM-dd')}}</div>"
				}
				, {field: 'classname', title: '班级', align: 'center', sort: true, width: 180,hide:true}
				, {fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值
			 if (layEvent === 'edit') {
				var othis = $(this), //othis当前button对象
					method = othis.data('method');//data-method="dialog"中的值
				if (method == "dialog") {
					layer.open({
						type: 2,
						title: '教师考勤信息信息',
						area: ['55%', '65%'],
						content: src + '/director/toUrl/director_TeacherAttendDetailmanage1' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						, success: function (layero, index) {
							console.log(layero, index);
							//	显示
							// 弹出一个页面的时候，下拉框赋值但不能刷新到选定的值。需要做如下调整:红色部分
							var iframeWindow = layero.find("iframe")[0].contentWindow;
							var frameId = $(layero).find("iframe").attr('id');
							$(window.frames[frameId].document).find("#teacherid").val(data.teacherid);
							$(window.frames[frameId].document).find("#teachername").val(data.teachername);
							$(window.frames[frameId].document).find("#teacherjob").val(data.teacherjob);
							$(window.frames[frameId].document).find("#tattendbegin").val(data.tattendbegin);
							$(window.frames[frameId].document).find("#tattendover").val(data.tattendover);
							$(window.frames[frameId].document).find("#classname").val(data.classname);

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
						teachername: $("#teachername").val(),
						teacherjob:$("#teacherjob").val()
					}
					, page: {
						curr: 1 //重新从第 1 页开始
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
