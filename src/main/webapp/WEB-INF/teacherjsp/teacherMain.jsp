<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-6
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<input type="hidden" id="kindername" value="${kindername}">
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
				<dd><a href="javascript:void(0);"  class="schoolMessage">校园消息通知</a></dd>
				<dd><a href="javascript:void(0);"  class="addTeaAttendTime">教师上课打卡</a></dd>
				<dd><a href="javascript:void(0)" id="regFaceId">人脸注册</a></dd>
				<dd><a href="javascript:void(0);"  class="classMessage">班级消息通知</a></dd>
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

	<div class="nav_btn" style="margin-left: 14.5%">
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="course">课<br/>程<br/>表</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="publishAssignment">发<br/>布<br/>作<br/>业</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="examineAssignment">查<br/>看<br/>作<br/>业</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="configurationTopic">配<br/>置<br/>试<br/>题</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="finish">完<br/>成<br/>情<br/>况</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classInfo">班<br/>级<br/>信<br/>息</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="attendanceManagement">考<br/>勤<br/>管<br/>理</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classPhoto">班<br/>级<br/>相<br/>册</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classMessageInform">班<br/>级<br/>通<br/>知</button>
		<button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="chatParent">联<br/>系<br/>家<br/>长</button>

	</div>
	<div class="prod-show" style="max-width: 80%;">
		<div class="layui-fluid">
			<div class="row layui-col-space12 layui-clear">
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
					<div class="img-txt">
						<h3 style="text-align: left">园所动态News</h3>
						<div style=" overflow:auto;">
							<a><img style="width: 100%"
							        src="${pageContext.request.contextPath}/image/healtherimg/img/news.jpg"></a>
						</div>
						<div style=" overflow:auto;">
							<c:if test="${not empty tblCampusList}">
								<c:forEach items="${tblCampusList}" var="i" step="1">
<%--									<a href="javascript:;" style="font-size: 18px" class="showNewsInfo">${i.campusinfoname}:  ${i.campusinfodetail}--%>
<%--										<br/>--%>
<%--										发布时间：<fmt:formatDate value='${i.campustime}' pattern='yyyy-MM-dd hh:mm:ss' /></a><br>--%>
									<p><a class="showNewsInfo" href="javascript:void(0);" style="font-size: 15px;width: 200px">${i.campusinfoname}:${i.campusinfodetail}</a><span style="font-size: 15px;margin-left: 10%">发布时间：<fmt:formatDate value='${i.campustime}' pattern='yyyy-MM-dd hh:mm:ss' /></span><span></span></p>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 layui-col-sm6 layui-col-md3" style="width: 50%">
					<div class="img-txt">
						<h3 style="text-align: left">园所视频Videos</h3>
						<div class="layui-carousel videobox" id="test2">
							<div carousel-item class="videroH">
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/2019-nCoV.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/2019-nCoV.jpg"></a></div>
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/CrossTheRoadSafely.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/CrossTheRoadSafely.jpg"></a></div>
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/farmPropaganda.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/farmPropaganda.jpg"></a></div>
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/SafetyRollerSkate.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/SafetyRollerSkate.jpg"></a></div>
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/TakeTheElevatorSafely.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/TakeTheElevatorSafely.jpg"></a></div>
								<div><a href="javascript:void(0);" class="playVideos" title="${pageContext.request.contextPath}/videos/Traffic_safety.mp4"><img style="width: 100%" src="${pageContext.request.contextPath}/image/videoimg/Traffic_safety.jpg"></a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
<script >

	layui.use(['carousel', 'jquery', 'element','layer'], function () {
		var carousel = layui.carousel, $ = layui.jquery;
		var element = layui.element;
		var layer = layui.layer;
		var path = $("#path").val();


		//首页轮播图
		carousel.render({
			elem: '#test1'
			, width: '100%' //设置容器宽度
			, arrow: 'always'
			, height: 'auto'
			//,anim: 'updown' //切换动画方式
		});
		//首页轮播视频
		carousel.render({
			elem: '#test2'
			, width: '100%' //设置容器宽度
			, arrow: 'always'
			, height: 'auto'
			//,anim: 'updown' //切换动画方式
		});

		$('.app-header-menuicon').on('click', function () {
			$('.header-down-nav').toggleClass('down-nav')
		})
		var imgH = $('.imgbox div.layui-this').outerHeight();
		$('.imgH').css('height', imgH + 'px');

		var videroH = $('.videobox div.layui-this').outerHeight();
		$('.videroH').css('height', videroH + 'px');

		window.onresize = function () {
			var imgH = $('.imgbox div.layui-this').outerHeight();
			$('.imgH').css('height', imgH + 'px');

			var videroH = $('.videobox div.layui-this').outerHeight();
			$('.videroH').css('height', videroH + 'px');
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
			//退出
			$("#exit").click(function () {
				layer.confirm('您确定要退出到登录界面吗?', {icon: 3, title:'温馨提示'},function(index){
					layer.close(index);
					sessionStorage.clear();//清除session信息

					location.href = path + "/teacher/teacherOut";
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
			// 安全教育视频配置
			$("#configurationTopic").click(function () {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-安全教育配置",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/safetyEducation' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});

			// 安全教育试题完成情况
			$("#finish").click(function () {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-安全教育试题完成情况",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/questionFinish' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
			// 班级考勤
			$("#attendanceManagement").click(function () {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-班级考勤",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/classAttendance' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});

			// 班级信息
			$("#classInfo").click(function () {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-班级信息",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/classInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});
			//班级相册

			$("#classPhoto").click(function () {
				layer.open({
					type: 2,
					area: ['80%', '80%'],
					offset: ['10%', '3%'],
					title:"智慧幼儿园-班级相册",
					btn1: function (index, layero) {
						//layer.getChildFrame("form", index)获取iframe的表单
						//serializeArray jquery方法，将表单对象序列化为数组
						layer.close(index);
					},
					content: path + '/teacher/toUrl/classPhoto' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
					}
				});
			});

			//对应显示校园消息通知的内容
			$('.schoolMessage').on('click',function () {
				layer.open({
					type: 2,
					title: '校园消息通知',
					shade: 0.8//表示的是阴影的大小
					, area: ['55%', '65%'],
					moveType: 1,//拖拽模式，0或者1
					content: path + '/director/toUrl/director_SchoolMessage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						console.log(layero, index);
					}
				});
			});
			//个人打卡  人脸识别
			$(".addTeaAttendTime").click(function () {
				// var path = $("#path").val();
				// var weekInfo = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
				// var week = new Date().getDay();
				// var weekToday = weekInfo[week];

				// if(weekToday == "星期六" || weekToday == "星期日"){
				//     layer.alert('亲，现在是周末哦，打卡功能暂时关闭。',{icon:6});
				// }else {
				layer.open({
					type: 2,
					area: ['95%', '81%'],
					offset: ['10%', '3%'],
					title: '智慧幼儿园-人脸识别界面',
					content: path + '/teacher/toUrl/dirFaceID' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						var body = layer.getChildFrame("body", index);
					}
				});
				// }
			});
		});
		// // 联系家长  在线聊天
		// $("#chatParent").on('click',function () {
		// 	layer.confirm('请问您确定要进入到在线聊天中心吗?', {icon: 3, title: '温馨提示'},
		// 		function (index) {
		// 		layer.close(index);
		// 		window.location.href = path+"/director/toUrl/chatlogin";
		// 		return true;
		// 	});
		// 	return false;
		// });

		//在线聊天 联系家长
		$("#chatParent").on('click',function () {
				layer.open({
					type: 2,
					title: '在线聊天首页',
					area: ['80%', '85%'],
					moveType: 1,//拖拽模式，0或者1
					content: path + '/director/toUrl/chatlogin' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
					, success: function (layero, index) {
						console.log(layero, index);
					}
				});
				// layer.close(index);
				// window.location.href = src+"/director/toUrl/chatlogin";
				return true;

			return false;
		});
		//班级通知
		$("#classMessageInform").on('click',function () {
			layer.confirm('请问您确定要进入到消息通知进行编辑吗?', {icon: 3, title: '温馨提示'}, function (index) {
				layer.close(index);
				window.location.href = path+"/teacher/toUrl/classMessageInform";
				return true;
			});
			return false;
		});

		//点击查看园所视频
		$(".playVideos").click(function () {
			var videoUrl = $(this).attr('title');
			//打开一个窗口播放视频
			layer.open({
				//打开一个窗口播放视频
				type: 1,
				area: ['95%', '80%'],
				offset:['10%','3%'],
				title:'园所视频播放',
				content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
						'<source src="'+videoUrl+'" type="video/mp4"></source></video>'
				//直接跳出一个标签播放视频
			});
		});


        //人脸识别注册
		$("#regFaceId").click(function () {
			layer.open({
				type: 2,
				area: ['95%', '81%'],
				offset: ['10%', '3%'],
				title: '智慧幼儿园-人脸注册界面',
				content: path + '/teacher/toUrl/teacherFaceRegistered' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
				, success: function (layero, index) {
					var body = layer.getChildFrame("body", index);
				}
			});

		});
		//点击查看园所新闻
		$(".showNewsInfo").click(function () {
			var name = $(this).text();
			var titleInfo = name.split(":")[0];
			var detailInfo = name.split(":")[1];
			var kindername = $("#kindername").val();
			//打开一个窗口播放视频
			layer.open({
				//打开一个窗口播放视频
				// area: ['40%', '50%'],
				area: 'auto',
				// offset:['26%','31%'],
				offset:'auto',
				title:titleInfo,
				content: detailInfo+'------'+kindername,
			});
		});

		//显示班级消息通知的内容
		$('.classMessage').on('click',function () {
			layer.open({
				type: 2,
				title: '班级消息通知',
				shade: 0.8//表示的是阴影的大小
				, area: ['55%', '65%'],
				moveType: 1,//拖拽模式，0或者1
				content: path + '/teacher/toUrl/classMessage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
				, success: function (layero, index) {
					console.log(layero, index);
				}
			});
		});

	});
</script>


</body>
</html>
