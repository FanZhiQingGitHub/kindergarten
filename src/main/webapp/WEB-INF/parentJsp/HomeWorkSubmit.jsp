<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/15
  Time: 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>作业提交界面</title>
</head>
<body>

<h1 align="center"> 重复提交会覆盖原来的作业</h1>
<form>


<table>

	<tr>
		<td width="100px">
			作业ID：
		</td>

		<td width="300px">
			作业名称：
		</td>

		<td width="300px">
			发布时间：
		</td>

		<td width="200px">
			完成情况：
		</td>

		<td width="100px">
			宝宝昵称：
		</td>

	</tr>

	<tr>
		<td>
			<div id="workreleaseid"></div>
		</td>

		<td>
			<div id="workreleasedetail"></div>
		</td>

		<td>
			<div id="workreleasetime"></div>
		</td>

		<td>
			<div id="workresult"></div>
		</td>

		<td>
			<div id="studentname"></div>
		</td>
	</tr>

</table>
</form>

<button  class="layui-btn" id="homeWorkSubmitBtn"><i class="layui-icon"></i>提交作业</button>


</body>
</html>
