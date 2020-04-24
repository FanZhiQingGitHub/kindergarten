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
	<title>智慧幼儿园-人脸注册界面</title>


</head>
<body>
<div class="layui-fluid">

	<div class="layadmin-user-login-box layadmin-user-login-header">
		<h2 style="margin-left: 47%">人脸注册界面</h2>
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
						style="width: 330px;height: 60px;font-size: 25px" id="bu2"><i class="layui-icon">&#xe6af;</i>点我进行注册
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

				if(face == null){
					layer.alert('您好，请先开启相机拍照后打卡！',{icon:2});
				}else {
					//用ajax做验证 ,判断是否验证成功
					$.ajax({
						url: path+'/parent/regFaceId',
						type:"post",
						async: true,
						cache: false,
						data: {"face":face},
						success: function(result) {
							if (result.success){
									layer.alert("注册成功，现在可以进行打卡",{icon:6},function () {
										var index = parent.layer.getFrameIndex(window.name);
										parent.layer.close(index);//关闭当前页
									});
							}else {
								layer.alert("请勿多次重复注册",{icon:2},function () {
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

			})

		});
	});

</script>

</body>
</html>
