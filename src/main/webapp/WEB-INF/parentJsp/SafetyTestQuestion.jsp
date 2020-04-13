<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/11
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>

	<title>在线答题</title>
	<style type="text/css">
		* {
			margin: 0 auto;
			padding: 0;
			text-decoration: none;
		}

		body, html {
			width: 100%;
			height: 100%;
		}

		.top {
			/*padding-top: 5%;*/
			text-align: center;
		}

		.tb {
			width: 80%;
			line-height: 40px;
			border-collapse: collapse;
			margin-top: 20px;
			margin-left: 15%;
		}

		/*表格里面的第一部分*/
		.t1 {
			color: #1d0e17;
		}

		.tb td {
			vertical-align: top;
			word-break: break-all;
			word-wrap: break-word;
			width: 150px;
		}

		.down_btn {
			text-align: center;
			margin: 40px 0;
		}

		.submit, .cannel {
			width: 150px;
			height: 40px;
			margin-top: 10px;
		}
	</style>

</head>

<body>


<table  class="tb" >

	<c:if test="${not empty subject}">

		<input type="hidden" value="${subject[0].safetyvideoid}" id="videoId">


		<c:forEach items="${subject}" var="i" >

			<div class="Choose">

				<tr class="t1">
					<td colspan="4"> ${i.safetyvtqname}</td>
				</tr>

				<tr class="t1">
					<c:if test="${!empty i.a}">
						<td><input name="${i.safetyvtqid}"  type="radio" value="${i.avalue}">&nbsp${i.a}</td>
					</c:if>
					<c:if test="${!empty i.b}">
						<td><input name="${i.safetyvtqid}"  type="radio" value="${i.bvalue}">&nbsp${i.b}</td>
					</c:if>
					<c:if test="${!empty i.c}">
						<td><input name="${i.safetyvtqid}"  type="radio" value="${i.cvalue}">&nbsp${i.c}</td>
					</c:if>
					<c:if test="${!empty i.d}">
						<td><input name="${i.safetyvtqid}"  type="radio" value="${i.dvalue}">&nbsp${i.d}</td>
					</c:if>
				</tr>
			</div>

		</c:forEach>
	</c:if>

</table>



<script type="text/javascript">


</script>
</body>
</html>
