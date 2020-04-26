<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-11
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>智慧幼儿园平台端-绘本详情</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<style>

	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">

	<div class="layui-main readInfo" style="width: 50%">

		<div>
			<c:if test="${not empty readPageBean}">
				<c:forEach items="${readPageBean.list}" var="i">
					<div>
						<h2>${i.readmagname}</h2>
					</div>
					<div>
						<img src="${pageContext.request.contextPath}/${i.photourl}" style="width: 150px;height: 150px" >
					</div>
					<div>
							${i.readmagdetail}
					</div>
				</c:forEach>
			</c:if>
		</div>
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div style="padding-bottom: 10px;">
				<a href="${pageContext.request.contextPath}/admin/readBook?curPage=${readPageBean.prePageNum}" style="text-decoration: none;margin-left: 10px">上一页</a>
				<c:forEach begin="${readPageBean.startPage}" end="${readPageBean.endPage}" var="p">
					<a href="${pageContext.request.contextPath}/admin/readBook?curPage=${p}" style="text-decoration: none;margin-left: 10px">${p}</a>
				</c:forEach>
				<a href="${pageContext.request.contextPath}/admin/readBook?curPage=${readPageBean.nextPageNum}" style="text-decoration: none;margin-left: 10px">下一页</a>
			</div>
		</div>
	</div>
</body>
</html>
