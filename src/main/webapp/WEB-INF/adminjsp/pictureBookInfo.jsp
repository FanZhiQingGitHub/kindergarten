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
		/*body{*/
		/*	overflow:hidden*/
		/*}*/
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
<%--	<div class="layui-main readInfo">--%>
<%--		<form class="layui-form" action="" onsubmit="return false;">--%>
<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label" style="">绘本名称：</label>--%>
<%--				<div class="layui-input-inline">--%>
<%--					<input type="text" class="layui-input" name="readMagName" id="readMagName" value="" placeholder="" style="width: 22%;margin-top: 1%">--%>
<%--				</div>--%>
<%--			</div>--%>
<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">绘本图片：</label>--%>
<%--				<div class="layui-input-inline">--%>
<%--					<input type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">--%>
<%--&lt;%&ndash;					<span id="readMagPic" style="width: 80px ;height: 80px"></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;	${pageContext.request.contextPath}/image/adminimg/img/timg.jpg&ndash;%&gt;--%>
<%--&lt;%&ndash;					<img src="" class="theimg" style="width: 80px;height: 80px" id="test1"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;					<img type="text" id="readMagPic" name="readMagPic" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">&ndash;%&gt;--%>
<%--				</div>--%>
<%--			</div>--%>

<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">文件地址：</label>--%>
<%--				<div class="layui-input-inline">--%>
<%--					<input type="text" id="readMagUrl" name="readMagUrl" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">--%>
<%--				</div>--%>
<%--			</div>--%>

<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">上传时间：</label>--%>
<%--				<div class="layui-input-inline">--%>
<%--					<input type="text" name="readMagTime" id="readMagTime" autocomplete="off" class="layui-input" style="width: 22%">--%>
<%--				</div>--%>
<%--			</div>--%>

<%--&lt;%&ndash;			<div class="layui-form-item">&ndash;%&gt;--%>
<%--&lt;%&ndash;				<label class="layui-form-label">页数：</label>&ndash;%&gt;--%>
<%--&lt;%&ndash;				<div class="layui-input-inline">&ndash;%&gt;--%>
<%--&lt;%&ndash;					<input type="text" id="readMagPage" name="readMagPage" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 22%">&ndash;%&gt;--%>
<%--&lt;%&ndash;				</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;			</div>&ndash;%&gt;--%>
<%--		</form>--%>
<%--	</div>--%>

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
