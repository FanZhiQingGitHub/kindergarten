<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/13
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>作业打分</title>
</head>
<body>

<%--选择班级--%>
<div class="layui-form-item">
	<button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>

	<div class="layui-input-block">
		<label class="layui-form-label" >作业评级：</label>
		<select name="selectClass" id="selectClass" lay-verify="required" style="width: 100px">
			<option value="请打分" selected>请打分</option>
			<option value="A" selected>A</option>
			<option value="B" selected>B</option>
			<option value="C" selected>C</option>
			<option value="D" selected>D</option>

		</select>
	</div>
</div>

</body>
</html>
