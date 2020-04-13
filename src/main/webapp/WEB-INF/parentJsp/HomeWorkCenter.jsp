<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/12
  Time: 18:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>作业中心</title>
</head>
<body>

<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<h1 align="center">作业中心</h1>

<!-- 增加搜索条件 -->
<div class="demoTable">
	作业模糊搜索：
	<div class="layui-inline">
		<input class="layui-input" name="name" id="uName" autocomplete="off">
	</div>

	<%--<div class="layui-form-item" style="text-align: right;padding-right: 10%;">--%>
	<%--	<div class="layui-input-block">--%>
	<%--		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">上一周</button>--%>
	<%--		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">下一周</button>--%>
	<%--	</div>--%>
	<%--</div>--%>

	<div class="layui-inline">
		按照发布时间搜索：
		<div class="layui-input-inline">
			    <input type="date" name="beginTime" class="layui-input" id="beginTime" placeholder="开始时间">
		</div>
		至：
		<div class="layui-input-inline">
			    <input type="date" name="endTime" class="layui-input" id="endTime" placeholder="结束时间">
		</div>
	</div>

	宝宝昵称：
	<div class="layui-inline" >
		<select id="status">
			<option value="">宝宝</option>
		</select>
	</div>




	<button class="layui-btn" data-type="reload">搜索</button>

</div>



<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">

	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="CheckHomeWork">查看作业</a>


	<a class="layui-btn edit layui-btn-xs"  lay-event="SubmitHomeWork">提交作业</a>


	<a class="layui-btn edit layui-btn-xs"  lay-event="DownloadHomeWork">下载作业</a>


</script>


<script type="text/javascript" >



	layui.use('table', function(){
		var table = layui.table;
		$.ajax({
			url: path+'/parent/getKids',
			type:"POST",
			async: false,
			cache: false,
			data: {},
			success: function(result) {

				var $selectKis =$("#status");
				var kidList =result.data;

				$selectKis.empty();

				for (var items =0;items<kidList.length;items++ ){
					$selectKis.append("<option value='"+kidList[items].studentid+"'>"+kidList[items].studentname+"</option>")
				}

				//查询作业数据
				table.render({
					elem: '#demo'
					,height: 700
					,url: path+'/parent/kidHomeWorkList?status='+$selectKis.val() //数据接口
					,method:'post'
					,page: true //开启分页
					,id: 'demo'
					,limits:[5,10,20,30]//下拉框中得数量
					,cols: [[ //表头
						{field: 'workreleaseid', title: '作业ID', sort: true, fixed: 'left'}
						,{field: 'workreleasedetail', title: '作业名称'}
						,{field: 'workreleasetime', title: '发布时间',  sort: true}
						,{field: 'wfinishtime', title: '完成时间',  sort: true}
						,{field: 'workeva', title: '作业评价'}
						,{field: 'studentname', title: '宝宝昵称'}
						,{field: 'workresult', title: '完成情况',templet:function (d) {
								if (d.workresult==null){
									return '未完成'
								}
								else {
									return  d.workresult
								}

							}   }
						,{fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo'}
					]]
				});

			},
			error:function(msg) {
				layer.alert("网络繁忙，请您稍后重试")
			}
		});


		//layui按钮绑定绑定查询事件

		$('.layui-btn').click(function () {

			//获取按钮类型
			var type = $(this).data('type');

			//类型等于重载的话 刷新表格数据
			if(type == 'reload'){
				table.reload('demo',{
					url:path+'/parent/kidHomeWorkList' //数据源
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

			//事件等于查看作业
			if (layEvent === 'CheckHomeWork') {

			}

			//事件等于提交作业
			if (layEvent === 'SubmitHomeWork') {


			}

			//事件等于下载
			if (layEvent === 'DownloadHomeWork') {




			}




		});
	});

</script>


</body>
</html>
