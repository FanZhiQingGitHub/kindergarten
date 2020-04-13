<%--标签 --%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<%@ page isELIgnored="false" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--basePath --%>
<c:set var="base" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
<%--静态文件目录 --%>
<c:set var="path" value="${base}" />
<%--项目路径 --%>
<c:set var="staticPath" value="${base}" />


<%--导入layui插件 --%>
<link rel="stylesheet" href="${path}/layui/css/layui.css" type="text/css">

<script src="${path}/layui/layui.js" type="text/javascript"></script>

<script src="${path}/js/jquery-3.4.1.js" type="text/javascript"></script>



<script type="text/javascript">
	var basePath = "${staticPath}";
	var path= "${path}";
</script>