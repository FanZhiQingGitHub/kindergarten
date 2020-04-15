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

<table>

	<tr>
		<td>
			作业ID：
		</td>

		<td>
			作业名称：
		</td>

		<td>
			发布时间：
		</td>

		<td>
			完成情况：
		</td>

		<td>
			宝宝昵称：
		</td>

	</tr>

	<tr>
		<td>
			<div id="homeWorkId"></div>
		</td>

		<td>
			<div id="homeWorkName"></div>
		</td>

		<td>
			<div id="homeWorkSetTime"></div>
		</td>

		<td>
			<div id="homeWorkResult"></div>
		</td>

		<td>
			<div id="babyName"></div>
		</td>
	</tr>

</table>


<button  class="layui-btn" id="homeWorkSubmitBtn"><i class="layui-icon"></i>提交作业</button>


</body>
</html>
