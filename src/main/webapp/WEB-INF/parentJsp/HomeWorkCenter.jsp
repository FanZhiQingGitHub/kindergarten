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
		<select id="status" onchange="selectClass()">
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

<%--	<button class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="CheckHomeWork">查看作业</button>--%>

	<button  class="layui-btn" lay-event="SubmitHomeWork"><i class="layui-icon"></i>提交作业</button>

	<button class="layui-btn edit layui-btn-xs"  lay-event="DownloadHomeWork">下载作业</button>


</script>


<script type="text/javascript" >

	var kidList;

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
						$selectKis.append("<option value='"+kidList[startNumber].studentid+"'>"+kidList[startNumber].studentname+"</option>")
					}
				}

				//更改班级信息
				selectClass();

				//查询作业数据
				table.render({
					elem: '#demo'
					,height: 700
					,url: path+'/parent/kidHomeWorkList?status='+$selectKis.val()+'&cid='+$kidClass.html() //数据接口
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
						endTime:$('#endTime').val(),
						status:$('#status').val(),
						cid:$('#classId').html()
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

				layer.open({
					//打开一个窗口播放视频
					type: 2,
					area: ['70%', '70%'],
					offset:['10%','5%'],
					title:'作业提交',
					content:path+'/parent/toUrl/HomeWorkSubmit'
					//直接跳出一页面提交作业
					,success: function(layero, index){
						//	显示
						var body = layer.getChildFrame("body", index);
						body.find("#workreleaseid").html(data.workreleaseid);
						body.find("#workreleasedetail").html(data.workreleasedetail);
						body.find("#workreleasetime").html(data.workreleasetime);
						body.find("#studentname").html($("#status").html());

						var upLoadMsg = 'sid='+$("#status").val()+'&sName='+body.find("#studentname").html()+"&cid="+data.cid+"&workreleaseid="+data.workreleaseid
						+"&workName="+data.workreleasedetail;
						// 给打开的窗口绑定上传
						upload.render({
							elem: body.find("#homeWorkSubmitBtn"),
							accept: 'file'
							,size:10000 //此处设为最大100M
							,url: path+'/parent/upload?'+upLoadMsg//上传接口
							,before: function(obj){
								layer.load(); //上传loading

							}
							,done: function(res, index, upload){
								if (res.code==0){
									confirm(" 上传成功");
									layer.close(index);
									//刷新表格
									window.location.reload();
								}
								//上传完毕回调
								layer.closeAll('loading'); //关闭loading
							}
							,error: function(index, upload){
								layer.closeAll('loading'); //关闭loading
							}
						});
					}
				});

			}


			//事件等于下载
			if (layEvent === 'DownloadHomeWork') {
				var DownloadHomeWorkUlr = data.workurl;
				window.location.href=path+'/parent/download?url='+DownloadHomeWorkUlr

			}




		});
	});

	function selectClass() {
		var kidId =$("#status").val();
		var $kidClass =$("#classId");
		$kidClass.empty();
		//在页面隐藏宝宝的班级
		for (var numbers =0;numbers<kidList.length;numbers++ ){
			if (kidList[numbers].studentid==kidId){
				$kidClass.html(kidList[numbers].cid);
				return;
			}
		}
	}


	//将表单转为js对象数据
	function serializeObject(array){
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
</html>
