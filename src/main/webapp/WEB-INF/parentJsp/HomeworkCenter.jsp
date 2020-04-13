<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/12
  Time: 18:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Title</title>
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

	<%--<div class="layui-form-item" style="text-align: right;padding-right: 10%;">--%>
	<%--	<div class="layui-input-block">--%>
	<%--		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">上一周</button>--%>
	<%--		<button class="layui-btn layui-btn-normal" data-type="reload" style="width: 100px;">下一周</button>--%>
	<%--	</div>--%>
	<%--</div>--%>




	<button class="layui-btn" data-type="reload">搜索</button>

</div>



<table id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">

	<a class="layui-btn edit layui-btn-xs" data-method="dialog" lay-event="play">播放视频</a>


	{{#  if(d.safetytestresult == null ){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="SafetyTest">安全试题</a>
	{{#  } }}



</script>



</body>
</html>
