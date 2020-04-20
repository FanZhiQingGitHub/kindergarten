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
	<link rel="stylesheet" href="${path}/resources/css/ParentChildReading.css" type="text/css">

</head>
<body>

<button class="layui-btn" id="backMain" type="button" >返回主页</button>

<form name="form1" >


	<div class="seaeachresult">
		<div class="nav_left">
			<h1>亲子阅读列表</h1>
		</div>
		<c:if test="${not empty pageBean}">
			<c:forEach items="${pageBean.list}" step="1" var="i">
				<div class="item">
					<a href="javascript:void(0);" onclick="showDetails(this)">
						<img src="${path}/${i.photourl}" width="200px" height="200px">
						<div class="info">
							<input class="readId" type="hidden" value="${i.readmagid}"/>
							<div class="titleNames">${i.readmagname}</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</c:if>

	</div>
	<div class="footer" align="center">
		<table >
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


<div id="light" class="white_content" >

	<button class="layui-btn" onclick="HideDetails()">返回阅读列表</button>

	<h1 align="center" id="titleName"> </h1>

	<div align="center">
		<img src="" id="pageImg" style="height: 200px">
	</div>


	<div style="height: 200px;width: 90% " align="center" id="pageContent">

	</div>


	<div class="footer" align="center">

		<div class="layadmin-user-login-box layadmin-user-login-header">
			<div style="padding-bottom: 10px;">
				<button type="button" class="layui-btn layui-btn-normal" id="upPage" style="width: 200px"><i
						class="layui-icon"></i>上一页
				</button>

					<span id="nowPage">1 </span>/<span id="totalPage">1</span>

				<button type="button" class="layui-btn layui-btn-normal" id="nextPage" style="width: 200px;"><i
						class="layui-icon"></i>下一页
				</button>
			</div>
		</div>
	</div>



</div>
<div id="fade" class="black_overlay"></div>




<script type="text/javascript">

	var readId ;
	var nowPage =1;
	var totalPage  =1;
	var layer;
	
	
	
	$(function () {


		layui.use(['layer', 'form'], function() {
			layer = layui.layer
		});


		$("#upPage").click(function () {

			if (nowPage==1){
				layer.msg("已经没有上一页了哦");
			} else {
				nowPage-=1;
				showPageDetail();
			}


		});

		$("#nextPage").click(function () {

			if (nowPage==totalPage){
				layer.msg("已经没有下一页了哦");
			} else {
				nowPage+=1;
				showPageDetail();
			}
		});

	});

	//展示页面内容方法
	function showPageDetail() {

		$.ajax({
			url: path + '/parent/readBook',
			type: 'post',
			data: {"readId":readId,"nowPage":nowPage},
			success: function (pageInfo) {

				//数据回显
				var nowPageInfo =pageInfo.list[0];

				$("#pageContent").html(" "+nowPageInfo.readmagdetail);

				$("#pageImg").attr('src',path+'/'+nowPageInfo.photourl);

				$("#nowPage").html(nowPage);

				$("#totalPage").html(pageInfo.totalRecords);

				totalPage  =pageInfo.totalRecords;


			}, error: function (data) {
				layer.alert("网络繁忙！", {icon: 2});
			}
		});

	}
	
	

	//显示隐藏的详情页面
	function showDetails(node) {

		nowPage =1;
		readId = $(node).children("div").children("input").val();
		//改变你现在在看的标题
		$("#titleName").html($(node).children("div").children("div").html());
		//调用显示数据
		showPageDetail();
		//界面的显示
		$("#light").attr("style","display:block");
		$("#fade").attr("style","display:block");

	}


	//隐藏的页面
	function HideDetails() {
		//界面的显示
		$("#light").attr("style","display:none");
		$("#fade").attr("style","display:none");
	}







</script>



</body>
</html>
