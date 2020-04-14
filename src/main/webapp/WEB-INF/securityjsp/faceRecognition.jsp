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
	<title>家长人脸识别页面</title>
</head>
<body>


<canvas width="500px" id="canvas" height="500px" style="display: block;"></canvas>

<video id="webcam" class="myVideo" autoplay playsinline></video>

<button class="check" onclick="startFace();">开始验证</button>

<button class="check" onclick="getFaceImg();">发送图片到后台</button>

<script type="text/javascript">


	var video = document.getElementById('webcam');

	function startFace() {
		//判断是否支持开启视频
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
	}

	//获取视频中人脸，转换成图片，发送后台请求，识别图片
	function getFaceImg() {
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

		//用ajax做验证 ,判断是否验证成功
		$.ajax({
			url: path+'/parent/parentFaceRecognition',
			type:"POST",
			async: false,
			cache: false,
			data: {"face":face},
			success: function(result) {



			},
			error:function(msg) {
				layer.alert("网络繁忙，请您稍后重试")
			}
		});
	}




</script>






</body>
</html>
