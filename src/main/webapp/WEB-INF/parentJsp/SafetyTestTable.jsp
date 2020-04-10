<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/3/10
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<head>
	<title>安全教育表格</title>
</head>
<body>

<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<h1 align="center">安全教育</h1>

<!-- 增加搜索条件 -->
<div class="demoTable">
	按名字模糊搜索：
	<div class="layui-inline">
		<input class="layui-input" name="name" id="uName" autocomplete="off">
	</div>

	<div class="layui-inline">
		按照时间搜索：
	     <div class="layui-input-inline">
		    <input type="date" name="beginTime" class="layui-input" id="beginTime" placeholder="开始时间">
		</div>
		至：
		<div class="layui-input-inline">
			    <input type="date" name="endTime" class="layui-input" id="endTime" placeholder="结束时间">
		</div>
	</div>

	<label>
		完成状态：
		<select id="status">
			<option value="0">未选择</option>
			<option value="">已完成</option>
			<option value="">未完成</option>
		</select>
	</label>

	<button class="layui-btn" data-type="reload">搜索</button>

</div>



<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">

	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="play">播放视频</a>


	{{#  if(d.safetytestresult == "已完成" ){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="showPoint">查看得分</a>

	{{#  } else if(d.safetytestresult == null ) { }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="SafetyTest">安全试题</a>
	{{#  } }}



</script>

<script>

	layui.use('table', function(){
		var table = layui.table;

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 480
			,url: path+'/parent/parentSafetyTestList' //数据接口
			,method:'post'
			,page: true //开启分页
			,id: 'demo'
			,limits:[5,10,20,30]//下拉框中得数量
			,cols: [[ //表头
				{field: 'safetyvideoid', title: '视频编号', sort: true, fixed: 'left'}
				,{field: 'safetyvideoname', title: '视频名称'}
				,{field: 'safetyvideotime', title: '发布时间',  sort: true}
				,{field: 'safetytestscore', title: '得分'}
				,{field: 'safetytestresult', title: '完成情况'  }
				,{fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
			]]
		});

		//layui按钮绑定绑定查询事件

		$('.layui-btn').click(function () {

			//获取按钮类型
			var type = $(this).data('type');

			var method = $(this).data('method');//data-method="dialog"中的值

			//类型等于重载的话 刷新表格数据
			if(type == 'reload'){
				table.reload('demo',{
					url:path+'/parent/parentSafetyTestList' //数据源
					,method:'post',
					page:{
						curr:1
					}
					,where:{
						//发送的值
						name:$('#uName').val(),
						status:$('#status').val(),
						beginTime:$('#beginTime').val(),
						endTime:$('#endTime').val()
					}
				})
			}



		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值

			//事件等于编辑
			if (layEvent === 'play') {
				var othis = $(this), //othis当前button对象
					method = othis.data('method');//data-method="dialog"中的值
					layer.open({
						type: 2,
						area: ['700px', '500px'],
						btn: ['修改', '取消'],
						btn1: function(index, layero){
						},
						content: path+'/parent/toUrl/parentVedioPlay' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						,success: function(layero, index){
						}
					});
			}













		});
	});

	$(function () {

		//前往家长端主页
		$("#backMain").click(function () {
			window.location.href=path+"/parent/toUrl/parentMain"
		})

	});




	//将表单转为js对象数据
	function serializeObject($, array){
		var obj=new Object();
		$.each(array, function(index,param){
			if(!(param.name in obj)){
				obj[param.name]=param.value;
			}
		});
		return obj;
	}



</script>


</body>

