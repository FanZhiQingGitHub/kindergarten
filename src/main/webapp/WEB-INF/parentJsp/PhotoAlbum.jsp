<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/21
  Time: 9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>相册查看页面</title>
</head>
<body>



<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<h1 align="center">作业中心</h1>

<!-- 增加搜索条件 -->
<div class="demoTable">
	按名字模糊搜索：
	<div class="layui-inline">
		<input class="layui-input" name="name" id="uName" autocomplete="off">
	</div>


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


	<div class="layui-inline" >
		宝宝昵称：
		<select id="status">
			<option value="">宝宝</option>
		</select>
	</div>

	<div class="layui-inline" >
		<div id="classId" style="display: none">

		</div>
	</div>



	<button class="layui-btn" data-type="reload">搜索</button>

</div>



<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo" style="width: 300px">

<button class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="ViewPhotos">查看照片</button>


</script>



<script type="text/javascript">


	layui.use(['table','upload'], function(){
		var table = layui.table
			,upload = layui.upload;

		$.ajax({
			url: path+'/parent/getKids',
			type:"POST",
			async: false,
			cache: false,
			data: {},
			success: function(result) {
				//获取宝宝列表
				var $selectKis =$("#status");
				var $kidClass =$("#classId");
				//获取宝宝列表数据
				kidList =result.data;
				//清空原本有的宝宝
				$selectKis.empty();

				if (kidList.length>0){
					//输入打印出自己的宝宝
					for (var startNumber =0;startNumber<kidList.length;startNumber++ ){
						$selectKis.append("<option value='"+kidList[startNumber].cid+"'>"+kidList[startNumber].studentname+"</option>")
					}
				}


				//查询作业数据
				table.render({
					elem: '#demo'
					,height: 700
					,url: path+'/parent/findPhotosByCid' //数据接口
					,method:'post'
					,where:{
						status:$selectKis.val()
					}
					,page: true //开启分页
					,id: 'demo'
					,limits:[5,10,20,30]//下拉框中得数量
					,cols: [[ //表头
						{field: 'photoid', title: '作业ID', sort: true, fixed: 'left'}
						,{field: 'photoname', title: '照片名称'}
						,{field: 'photodetail', title: '照片详情',  sort: true}
						,{field: 'phototime', title: '上传时间',  sort: true}
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
					url:path+'/parent/findPhotosByCid' //数据源
					,method:'post',
					page:{
						curr:1
					}
					,where:{
						//发送的值
						name:$('#uName').val(),
						beginTime:$('#beginTime').val(),
						endTime:$('#endTime').val(),
						status:$('#status').val(),
					}
				})
			}

		});

		//监听行工具事件
		table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data //获得当前行数据
				, layEvent = obj.event; //获得 lay-event 对应的值



			//事件等于查看图片
			if (layEvent === 'ViewPhotos') {

				//打开一个窗口查看图片
				layer.open({
					//打开一个窗口查看图片
					type: 1,
					area: ['70%', '70%'],
					offset:['10%','5%'],
					title:'图片查看',
					content:'<img src="'+path+'/'+data.photourl+'" style="width: 100% ;height: 100%" >'
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

</script>


</body>
</html>
