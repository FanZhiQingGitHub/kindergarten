<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/9
  Time: 21:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>智慧幼儿园-人脸识别界面</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="layui-fluid">

	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 47%">人脸识别界面</h2>
	</div>
	<div class="layui-inline" style="width:100%;">
		<hr>
	</div>

	<div id="allCamera">
		<div id="videodiv" style="border:none;width:43% ;height: 70%;margin-top: 1%;margin-left: 5%" >
			<video id="webcam" width="100%" height="100%" class="myVideo" autoplay playsinline></video>
		</div>

		<div id="canvasdiv" style="border: none;width:43% ;height: 70%; margin-left: 52%; margin-top: -29.34%">
			<canvas id="canvas" width="500px" height="500px" style="display: block;"></canvas>
		</div>
	</div>

	<div class="layui-fluid" style="margin-left: 13%">
		<div class="layui-inline" style="margin-left: 32%;margin-top: 4%">
			<div class="layui-input-inline">
				<button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal "
						style="width: 330px;height: 60px;font-size: 25px" id="bu2"><i class="layui-icon">&#xe6af;</i>上下课记得点我哦
				</button>

				<button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-warm"
						style="width: 170px;" id="bu3"><i class="layui-icon">&#xe654;</i>这边可以请假哦
				</button>
			</div>
		</div>
	</div>

</div>

<script>

	layui.use(['carousel', 'jquery', 'element', 'layer','form'], function () {
		var carousel = layui.carousel, $ = layui.jquery;
		var element = layui.element;
		var layer = layui.layer;
		var form = layui.form;
		var path = $("#path").val();
		var video = document.getElementById('webcam');

		layer.msg('温馨提醒：摄像头功能需要使用谷歌浏览器才可以访问！');

		//判断是否支持开启视频(默认开启相机)
		if (navigator.getUserMedia) {
			navigator.getUserMedia({
				audio : false,
				video : {
					width : 400,
					height : 400,
					facingMode : "user"
				}
			}, function(stream) {
				try {
					video.src = window.URL.createObjectURL(stream);
				} catch (e) {
					video.srcObject = stream;         //注意，不同版本video.src和video.srcObject两种
				}
				video.onloadedmetadata = function(e) {
					//开始录制
					video.play();
				};

			}, function(err) {
				console.log("The following error occurred: " + err.name);
			});
		} else {
			console.log("getUserMedia not supported");
		}


		$(function () {
			$("#bu2").click(function () { //获取视频中人脸，转换成图片，发送后台请求，识别图片
				//找到视频显示的位置
				var video = document.querySelector('video');
				//canvas 用来保存图片的一个标签
				var canvasObj = document.querySelector('canvas');
				//创建一个2d环境的画布
				var context1 = canvasObj.getContext('2d');
				//框框的样式颜色
				context1.fillStyle = "#000000";
				//填充获取的范围
				context1.fillRect(0, 0, 400, 400);
				//绘画的范围 400*400大小
				context1.drawImage(video, 0, 0, 400, 400);

				//toDataURL()获取的数据有images前缀，要split取后面一部分传给后台，后台直接用
				var url = canvasObj.toDataURL();
				//获取到String类型的image信息
				var face = url.split(",")[1];

				console.log("face="+face)
				if(face == null){
					layer.alert('您好，请先开启相机拍照后打卡！',{icon:2});
				}else {
					//用ajax做验证 ,判断是否验证成功
					$.ajax({
						url: path+'/parent/addStuTime',
						type:"post",
						async: true,
						cache: false,
						data: {"face":face},
						success: function(msg) {
							if(msg == "amsuccess"){
								layer.alert("早上好，打卡成功！",{icon:6},function () {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);//关闭当前页
								});
							}else if(msg == "pmsuccess") {
								layer.alert("打卡成功，祝您一路顺风！", {icon: 6},function () {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);//关闭当前页
								});
							}else if(msg == "notadd"){
									layer.alert("亲，今天是周末哦！",{icon:6},function () {
										var index = parent.layer.getFrameIndex(window.name);
										parent.layer.close(index);//关闭当前页
									});
							}else {
								layer.alert("亲，不知道哪里出错了！",{icon:2},function () {
									var index = parent.layer.getFrameIndex(window.name);
									parent.layer.close(index);//关闭当前页
								});
							}
						},
						error:function(msg) {
							layer.alert("网络繁忙，请您稍后重试",{icon:2},function () {
								var index = parent.layer.getFrameIndex(window.name);
								parent.layer.close(index);//关闭当前页
							});
						}
					});
				}

			}),$("#bu3").click(function () {
				var path = $("#path").val();
				layer.open({
					type: 2,
					area: ['400px', '450px'],
					offset: ['120px', '650px'],
					title: '新增请假信息',
					content: path + '/parent/toUrl/addLeaveInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
		});
	});

</script>

</body>
</html>
