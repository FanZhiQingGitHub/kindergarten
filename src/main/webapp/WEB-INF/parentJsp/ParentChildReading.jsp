<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/18
  Time: 14:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/commons/basejs.jsp" %>
<html>
<head>
	<title>亲子阅读页面</title>
</head>
<body>

<script type="text/css">
	*{
		border: 0;
		margin: 0;
		padding: 0;
		text-decoration: none;
	}
	body{
		margin: 0 auto;
		width: 80%;
		height: 332px;
	}
	form{
		height: 100%;
	}
	.nav_left{
		margin-bottom: 20px;
	}
	.seaeachresult{
		border: 1px solid #D3D4D3;
		padding: 20px 0 20px 20px;
		height: 150%;
		text-align: center;
	}
	.item {
		float: left;
		width: 158px;
		margin: 0 20px 30px 20px;
		padding: 20px 30px;
		text-align: center;
		border: 1px solid #D3D4D3;
		background-color: #f0e8e8;
		height: 150px;
	}
	.item a{
		color: #0000FF;
	}
	/*    下半部分*/
	.info{
		padding: 50px 20px;
	}
	.info .title{
		width: 158px;
		height: 34px;
		overflow: hidden;
		color: #000;
		margin-top: 5px;
	}
	.shopNick{
		border: 1px solid red;
		color: #f95b27;
		margin-left: 30px;
	}
	.footer{
		text-align: center;
	}
	.pages{
		margin-top: 20px;
		margin-left: 20px;
		line-height: 30px;
		text-align: center;
		width: 100px;
		color: #eeeeee;
		border: 0;
		cursor: pointer;
	}
	.pages a{
		text-decoration: none;
	}
	.pages:hover{
		background-color: #f29ada;
		color: #aa6798;
	}
	.downs,.isCannel,.resetPwd{
		border: 0;
		background-color: #884e78;
		height: 30px;
		width: 100px;
		color: #eeeeee;
		cursor: pointer;
	}
	.downs:hover,.isCannel:hover,resetPwd:hover{
		background-color: #f29ada;
		color: #7e376e;
	}
	.zero{
		margin-left: 15px;
		text-decoration: none;
	}


	.black_overlay{
		display: none;
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: black;
		z-index:1001;
		-moz-opacity: 0.8;
		opacity:.80;
		filter: alpha(opacity=88);
	}
	.white_content {
		display: none;
		position: absolute;
		top: 15%;
		left: 15%;
		width: 70%;
		height: 70%;
		padding: 20px;
		border: 10px solid orange;
		background-color: white;
		z-index: 1002;
		overflow: auto;
	}

</script>


<form name="form1" >


	<div class="seaeachresult">
		<div class="nav_left">
			<h1>亲子阅读列表</h1>
		</div>
		<c:if test="${not empty pageBean}">
			<c:forEach items="${pageBean.list}" step="1" var="i">
				<div class="item">

					<a href="javascript:void(0);" onclick="showDetails(this)">
						<img src="${i.photourl}" width="200px" height="200px">

						<div class="info">
							<input class="readId" type="hidden" value="${i.readmagid}"/>
	                   <div>${i.readmagname}</div>

						</div>
					</a>
				</div>
			</c:forEach>
		</c:if>

	</div>
	<div class="footer">
		<table>
		<tr>
			<td>
				<a
						href="${path}/parent/findReadList?&curPage=1">首页</a>
				<a
						href="${path}/parent/findReadList?&curPage=${pageBean.prePageNum}">上一页</a>

				<span style="margin-right: 50px;margin-left: 50px">

				${pageBean.currentPageNum}/${pageBean.totalPageNum}

				</span>

				<a
						href="${path}/parent/findReadList?&curPage=${pageBean.nextPageNum}">下一页</a>
				<a
						href="${path}/parent/findReadList?&curPage=${pageBean.totalPageNum}" >尾页</a>
			</td>
		</tr>

		</table>
	</div>
</form>








</body>
</html>
