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

	<button class="layui-btn" data-type="reload">搜索</button>

</div>



<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">

	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="play">播放视频</a>

	{{#  if(d.safetytestresult == null ){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="SafetyTest">安全试题</a>

	{{#  else if(d.safetytestresult == '已完成' ){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="SafetyTest">查看解析</a>
	{{#  } }}



</script>

<script>

	layui.use('table', function(){
		var table = layui.table;

		//第一个实例
		table.render({
			elem: '#demo'
			,height: 700
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
				,{field: 'safetytestresult', title: '完成情况',templet:function (d) {
					if (d.safetytestresult==null){
						return '未完成'
					}
					else {
						return  d.safetytestresult
					}

					}   }
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
					layer.open({
						//打开一个窗口播放视频
						type: 1,
						area: ['70%', '70%'],
						content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
							'<source src=" ${path}/'+data.videoadd+'" type="video/mp4"></source></video>'
						//直接跳出一个标签播放视频
					});
			}

			//事件等于做安全试题
			if (layEvent === 'SafetyTest') {
				layer.open({
					//打开一个窗口做题
					type: 2,
					area: ['70%', '70%'],
					btn: ['提交', '取消'],
					btn1: function(index){
						//找到窗口的body标签里面的内容
						var body = layer.getChildFrame("body", index);
						//检查是否有做完所有题目
							var score =0;
							//找到有多少题目
							var ChooseNumber = body.find(".Choose").length;

							if(body.find('input[type="radio"]:checked').length < ChooseNumber){
								layer.alert('您还有题目未选哦');
								//如果没有选择完整则返回
								return false;
							}else {

								//计算分数
								for(var i = 0;i < ChooseNumber;i++){
									{
										//分数累加
										if(Number(i+1) == ChooseNumber)
										{
											body.find('input:radio:checked').each(function () {
												score+=parseInt($(this).val());
											});
										}
									}
								}
							}
							//获取题目id
							var videoId= body.find("#videoId").val();
							//发送ajax
							$.ajax({
								url: path+'/parent/recordScore',
								type:"POST",
								async: false,
								cache: false,
								data: {"videoId":videoId,"score":score},
								success: function(result) {
									//如果成功记录分数
									if (result.success){
										layer.close(index);
										alert("提交成功,即将刷新页面");
										location.reload();
									}else {
										alert("提交失败,请您重试");
									}
								},
								error:function(msg) {
									console.log(msg);
								}
							});
					},
					content: path+"/parent/SafetyTestQuestion?safetyVideoId="+data.safetyvideoid
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

