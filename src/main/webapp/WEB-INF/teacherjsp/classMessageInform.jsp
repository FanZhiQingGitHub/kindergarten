<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
	<meta charset="utf-8">
	<title>班级通知</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
	* {
		margin: 0 auto;
	}

	body {
		line-height: 100px;
	}
	#claMsgDetail{
		height: 200px;
		width: 300px;
	}
	form{
		margin-left: 46.5%;
		margin-top: 1%;
	}
	.layui-form-item{
		margin-left: -20%;
	}
</style>
<body>
<h1 style="text-align:center;font-size: 40px;color: #009688">班级通知</h1>
<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label" style="width: 200px">班级名称：${classname}</label>

	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">内容：</label>
		<div class="layui-input-inline">
			<textarea name="claMsgDetail" id="claMsgDetail" autocomplete="off" placeholder="请输入内容"
			          class="layui-textarea" onkeydown="checkMaxInput(this,200)"
			          onkeyup="checkMaxInput(this,200)" onfocus="checkMaxInput(this,200)"
			          onblur="checkMaxInput(this,200);resetMaxmsg()"></textarea>
		</div>
	</div>
	<div class="layui-btn-container" >
		<button type="button" class="layui-btn layui-btn-normal " id="save">发送</button>
		<button type="button" class="layui-btn layui-btn-normal " id="cancel">返回</button>
	</div>
</form>

<script>
	layui.use(['jquery','layer'], function () {
		var $ = layui.$;
		var layer = layui.layer;
		var path = $("#path").val();
		$(function () {
			$("#save").click(function () {
				layer.confirm('您确定消息通知吗?', {icon: 3, title: '温馨提示'}, function (index) {
					var claMsgDetail = $("#claMsgDetail").val();

					$.ajax({
						url: path + "/teacher/addClassMsg",
						async: true,
						type: "post",
						data: {"claMsgDetail": claMsgDetail},
						datatype: "text",
						success: function (msg) {
							if (msg == "success") {
								layer.alert("添加消息成功！", {icon: 6}, function (index) {
									window.parent.location.reload();
								});
							} else {
								layer.alert("添加消息失败！", {icon: 2});
							}
						}, error: function (msg) {
							layer.alert("网络繁忙！", {icon: 2});
						}
					});
					return true;
				});
				return false;

			});
			$("#cancel").click(function () {
				layer.confirm('您确定要退出消息编辑界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
					layer.close(index);
					window.location.href = path + "/teacher/toUrl/teacherMain";
					return true;
				});
				return false;

			});


		});
	});
	/*
* ------------文本域的使用-------
* */
	//-------------------------------文本域的内容的数量大小限制
	//多行文本输入框剩余字数计算
	function checkMaxInput(obj, maxLen) {
		layui.use(['jquery'], function () {
			var $ = layui.$;
			if (obj == null || obj == undefined || obj == "") {
				return;
			}
			if (maxLen == null || maxLen == undefined || maxLen == "") {
				maxLen = 100;
			}

			var strResult;
			var $obj = $(obj);
			var newid = $obj.attr("id") + 'msg';

			if (obj.value.length > maxLen) {	//如果输入的字数超过了限制
				obj.value = obj.value.substring(0, maxLen); //就去掉多余的字
				strResult = '<span id="' + newid + '" class=\'Max_msg\' ><br/>剩(' + (maxLen - obj.value.length) + ')字</span>'; //计算并显示剩余字数
			} else {
				strResult = '<span id="' + newid + '" class=\'Max_msg\' ><br/>剩(' + (maxLen - obj.value.length) + ')字</span>'; //计算并显示剩余字数
			}

			var $msg = $("#" + newid);
			if ($msg.length == 0) {
				$obj.after(strResult);
			} else {
				$msg.html(strResult);
			}
		});
	}

	//清空剩除字数提醒信息
	function resetMaxmsg() {
		layui.use(['jquery'], function () {
			var $ = layui.$;
			$("span.Max_msg").remove();
		});
	}
</script>
</body>
</html>