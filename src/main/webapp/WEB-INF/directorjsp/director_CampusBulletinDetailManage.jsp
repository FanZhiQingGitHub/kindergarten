<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="utf-8">
	<title>校园公告信息管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<style>
	* {
		margin: 0 auto;
	}

	body {
		line-height: 50px;
	}
	#campusinfodetail{
		height: 200px;
		width: 300px;
	}
</style>
<body>

<form class="layui-form" action="#" lay-filter="test1">
	<input type="hidden" name="campusinfoid" id="campusinfoid">
	<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
	<div class="layui-form-item">
		<label class="layui-form-label">标题：</label>
		<div class="layui-input-inline">
			<input type="text" name="campusinfoname" id="campusinfoname" autocomplete="off" required
			       lay-verify="required"
			       placeholder="请输入标题" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">内容：</label>
		<div class="layui-input-inline">
			<textarea name="campusinfodetail" id="campusinfodetail" placeholder="请输入内容"
			          class="layui-textarea" onkeydown="checkMaxInput(this,200)"
			          onkeyup="checkMaxInput(this,200)" onfocus="checkMaxInput(this,200)"
			          onblur="checkMaxInput(this,200);resetMaxmsg()"></textarea>
		</div>
	</div>
</form>

<script>
	/*
* ------------文本域的使用-------
* */
	//-------------------------------文本域的内容的数量大小限制
	//多行文本输入框剩余字数计算
	function checkMaxInput(obj, maxLen) {
		layui.use(['form', 'jquery', 'layer'], function () {
			var form = layui.form;
			$ = layui.$;
			var layer = layui.layer;
			if (obj == null || obj == undefined || obj == "") {
				return;
			}
			if (maxLen == null || maxLen == undefined || maxLen == "") {
				maxLen = 200;
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
		layui.use(['form', 'jquery', 'layer'], function () {
			var form = layui.form;
			$ = layui.$;
			var layer = layui.layer;
			$("span.Max_msg").remove();
		});
	}
</script>
</body>
</html>