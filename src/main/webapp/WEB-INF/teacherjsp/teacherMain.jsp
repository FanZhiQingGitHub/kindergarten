<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Stict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>

	<title>智慧幼儿园-首页</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
	<style type="text/css">
		html, body {
			margin: 0;
			padding: 0;
		}

		.nav_btn{
			padding: 30px 0;
			max-width: 80%;
			margin: 0 auto;
		}
		.getbtn{
			height: 240px;
			/*width: 75px;*/
			width: 8%;
			font-weight: bold;
			font-size: 18px;
			background: #FF5722;
		}
		.footer{
			margin: 0 auto;
			width: 80%;
			padding: 0;
		}

	</style>
	<!--加载meta IE兼容文件-->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
	<![endif]-->


</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<!-- header -->
<div class="header_box">

	<ul class="layui-nav layui-layout-right" style="background-color: white;">
		<li class="layui-nav-item" >
			<a href="javascript:;" style="color: black;font-size: 18px">
				<img src="${pageContext.request.contextPath}/image/logo/head.jpg" class="layui-nav-img">
				欢迎&nbsp;,${teachername}&nbsp;老师
			</a>
			<dl class="layui-nav-child">
				<dd><a href="javascript:void(0);" id="a1" >个人信息</a></dd>
			</dl>
		</li>
		<li class="layui-nav-item"><a href="javascript:void(0);" id="exit" style="color: black;font-size: 18px">注销</a></li>
	</ul>


	<div class="header" style="max-width: 80%">
		<ul class="app-header">
			<li class="app-header-menuicon">
				<i class="layui-icon layui-icon-more-vertical"></i>
			</li>
		</ul>
		<h1 class="logo">
			<img style="width: 100%;height: 90px" src="${pageContext.request.contextPath}/image/logo/logo.png">
		</h1>
		<h1 style="margin-left: 21%;font-size: 40px;color: coral">教师首页</h1>

	</div>
</div>
<!-- end-header -->


<!-- content -->
<div class="content">
	<div class="title">
		<h3>您是辛勤的园丁，默默给孩子带来最好的知识</h3>
		<h4>You are a hard-working gardener who silently brings the best knowledge to your children.</h4>
	</div>
	<div class="layui-carousel imgbox" id="test1">
		<div carousel-item class="imgH">
			<div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-1.jpg"></div>
			<div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-2.jpg"></div>
			<div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-3.jpg"></div>
			<div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-4.jpg"></div>
			<div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-5.jpg"></div>
		</div>
	</div>

	<div class="prod-show">
		<div class="layui-fluid">
			<div class="row layui-col-space12 layui-clear">
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
					<div class="img-txt">
						<img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-1.jpg"
						     alt="">
						<h3>作业中心</h3>
					</div>
				</div>
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
					<div class="img-txt">
						<img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
						     alt="">
						<h3>安全教育</h3>
					</div>
				</div>
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
					<div class="img-txt">
						<img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
						     alt="">
						<h3>班级中心</h3>
					</div>
				</div>
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3">
					<div class="img-txt">
						<img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
						     alt="">
						<h3>资源中心</h3>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="nav_btn">
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="course">课<br/>程<br/>表</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="publishAssignment">发<br/>布<br/>作<br/>业</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="examineAssignment">查<br/>看<br/>作<br/>业</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="configurationTopic">配<br/>置<br/>试<br/>题</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="finish">完<br/>成<br/>情<br/>况</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classInfo">班<br/>级<br/>信<br/>息</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="attendanceManagement">考<br/>勤<br/>管<br/>理</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classPhoto">班<br/>级<br/>相<br/>册</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="messageInform">消<br/>息<br/>通<br/>知</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="parentInform">家<br/>长<br/>通<br/>知</button>

	</div>
</div>

<!-- footer -->
<div class="footer">
	<div class="line"></div>
	<p class="copyright">
		@2020 最后#的小组 版权所有©<br/>
		E-MAIL:kindergarten@outlook.com<br/>
		TEL:400-888-888
	</p>
	<div class="icon_box">
		<a href="#"><i class="layui-icon layui-icon-login-wechat weixin-icon"></i></a>
		<a href="#"><i class="layui-icon layui-icon-login-weibo weibo-icon"></i></a>
	</div>
</div>
<!-- end-footer -->
<script>

	layui.use(['carousel', 'jquery', 'element','layer'], function () {
		var carousel = layui.carousel, $ = layui.$;
		var element = layui.element;
		var layer = layui.layer;
		var path = $("#path").val();


		//建造实例
		carousel.render({
			elem: '#test1'
			, width: '100%' //设置容器宽度
			, arrow: 'always'
			, height: 'auto'
			//,anim: 'updown' //切换动画方式
		});
		$('.app-header-menuicon').on('click', function () {
			$('.header-down-nav').toggleClass('down-nav')
		});
		var imgH = $('.imgbox div.layui-this').outerHeight();
		$('.imgH').css('height', imgH + 'px');
		window.onresize = function () {
			var imgH = $('.imgbox div.layui-this').outerHeight();
			$('.imgH').css('height', imgH + 'px')
		};

		$(function () {
			$("#a1").click(function () {
				layer.open({
					type: 2,
					area: ['95%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-教师个人信息页",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/teacherInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
			$("#exit").click(function () {
				layer.confirm('您确定要退出到登录界面吗?', {icon: 3, title:'温馨提示'},function(index){
					layer.close(index);
					location.href = path + "/teacher/toUrl/teacherLogin";
				});
			});
			// 课程表弹窗
			$("#course").click(function () {
				layer.open({
					type: 2,
					area: ['70%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-教师课程表",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/course' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
			// 发布作业
			$("#publishAssignment").click(function () {
				layer.open({
					type: 2,
					area: ['70%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-教师发布作业",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/workRelease' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
			// 查看作业
			$("#examineAssignment").click(function () {
				layer.open({
					type: 2,
					area: ['70%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-教师查看作业",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/checkWork' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});

	});

	});
</script>


</body>
</html>
