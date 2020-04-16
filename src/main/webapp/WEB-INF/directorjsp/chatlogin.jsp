<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>聊天室登录首页</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lbt.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css" media="all" />
<script type="text/javascript">
	$(function(){
		
	});

</script>

</head>
<body>
<!--头部开始-->
<div class="header">
	<h1>智慧幼儿园聊天室中心</h1>
</div>
<!--头部end-->
<!--登陆区域开始-->
<div class="loginMain">
	<div class="con">
    	<div class="inCon">
            <ul class="imgList">
<%--	           mainres/static/al_img10.jpg--%>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img10.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img12.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img6.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img8.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img9.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img10.jpg" width="680" height="494" /></li>
                <li><img src="${pageContext.request.contextPath}/mainres/static/al_img12.jpg" width="680" height="494" /></li>
            </ul>
        </div>
        <ol class="btnList">
        	<li class="current"></li>
        	<li></li>
        	<li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ol>
        <a href="javascript:;" class="left"></a>
        <a href="javascript:;" class="right"></a>    </div>


	<div class="loginArea">
    	<h2>欢迎登陆</h2>
        <p>欢迎您来到智慧幼儿园的聊天空间！</p>
        <div><font color="red" size="16">${requestScope.errorTips }</font></div>
        <form action="${pageContext.request.contextPath }/director/chatLogin"  method="post">
        	<input type="text" value="请输入您想显示的昵称" name="nickname" id="myText" />
            <button>进入聊天室</button>
        </form>
    </div>
</div>
<!--登陆区域结束-->

<div class="footer">
	<p>@2020 最后#的小组 版权所有©<br/>
		E-MAIL:kindergarten@outlook.com<br/>TEL:400-888-888</p>
</div>
</body>
<script type="text/javascript">
	var myText=document.getElementById('myText');
	myText.onfocus=function(){
		if(myText.value=='请输入您想显示的昵称'){
			myText.value='';
			myText.style.color='#333';	
		}	
	}
	myText.onblur=function(){
		if(myText.value==''){
			myText.value='请输入您想显示的昵称';
			myText.style.color='#ccc';
		}	
	}

</script>
</html>