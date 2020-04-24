<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Stict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <title>智慧幼儿园-园长端主界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            margin: 0 auto;
        }
        .contentimg{
            width: 33%;
            padding: 0 50px;
        }
        .nav_btn{
            padding: 30px 0;
            max-width: 80%;
            margin: 0 auto;
        }
        .getbtn{
            height: 240px;
            width: 6.8%;
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
<input type="hidden" value="${pageContext.request.contextPath}" id="path"/>

<!-- header -->
<div class="header_box">
    <ul class="layui-nav layui-layout-right" style="background-color: white;">
        <li class="layui-nav-item" >
            <a href="javascript:;" style="color: black;font-size: 18px">
                <img src="${pageContext.request.contextPath}/image/logo/headDirector.jpg" class="layui-nav-img">
                欢迎&nbsp;&nbsp;&nbsp;${logintblRector.rectorname}&nbsp;,&nbsp;园长
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:void(0);"  class="personMsg">个人信息</a></dd>
                <dd><a href="javascript:void(0);"  class="updatePwd">修改密码</a></dd>
                <dd><a href="javascript:void(0);"  class="schoolMessage">校园消息通知</a></dd>
                <dd><a href="javascript:void(0);"  class="addTeaAttendTime">教师上课打卡</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a  href="javascript:void(0); "  id="exit" style="color: black;font-size: 18px">注销</a></li>
    </ul>

    <div class="header" style="max-width: 80%">
        <ul class="app-header">
            <li class="app-header-menuicon">
                <i class="layui-icon layui-icon-more-vertical"></i>
            </li>
        </ul>
        <h1 class="logo">
            <img style="width: 100%;height: 88px" src="${pageContext.request.contextPath}/image/logo/logo.png">
        </h1>
        <h1 style="margin-left: 22%;font-size: 40px;color: coral">园长首页</h1>
    </div>
</div>
<!-- end-header -->

<!-- content -->
<div class="content">
    <div class="title">
        <h3>您是辛勤的园丁，默默给孩子带来最好的知识</h3>
        <h4>You are a hard-working gardener who silently brings the best knowledge to your children.</h4>
    </div>
    <div class="layui-carousel imgbox" id="test1" style="margin: 0 auto">
        <div carousel-item class="imgH">
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-1.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-2.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-3.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-4.jpg"></div>
            <div><img style="width: 100%" src="${pageContext.request.contextPath}/image/carousel/main-5.jpg"></div>
        </div>
    </div>

    <div class="prod-show" style="padding: 50px 0;">
        <div class="layui-fluid">
            <div class="row layui-col-space12 layui-clear">
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-1.jpg"
                             alt="">
                        <h3>资格审批</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-2.jpg"
                             alt="">
                        <h3>班级中心</h3>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm6 layui-col-md3 contentimg">
                    <div class="img-txt">
                        <img style="width: 100%;" src="${pageContext.request.contextPath}/image/growthfile/growth-3.jpg"
                             alt="">
                        <h3>消息中心</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="nav_btn">
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="approvalGarden">园<br/>所<br/>审<br/>批</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="teachersManagement">教<br/>师<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="healtherManagement">保<br/>健<br/>员<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="securityManagement">安<br/>防<br/>员<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="teachersAttendManagement">教<br/>师<br/>考<br/>勤</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="childrenManagement">幼<br/>儿<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="parentManagement">家<br/>长<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classManagement">班<br/>级<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="classMemberManagement">班<br/>级<br/>成<br/>员<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="courseManagement">课<br/>程<br/>管<br/>理</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="messageNotice">消<br/>息<br/>通<br/>知</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="campusBulletinManagement">校<br/>园<br/>公<br/>告</button>
        <button type="button" class="layui-btn layui-btn-normal layui-btn-radius getbtn" id="chatTeacher">联<br/>系<br/>老<br/>师</button>

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
                        <div id="demo">
                            <div style=" overflow:auto;">
                                <c:if test="${not empty tblCampusList}">
                                    <c:forEach items="${tblCampusList}" var="i" step="1">
                                        <a href="javascript:;" style="font-size: 18px" class="showNewsInfo">${i.campusinfoname}<span style="display: none">:${i.campusinfodetail}</span><br/>发布时间：<fmt:formatDate value='${i.campustime}' pattern='yyyy-MM-dd hh:mm:ss' /></a><br>
                                    </c:forEach>
                                </c:if>
                            </div>
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
<script>
    layui.use(['carousel', 'jquery' ,'layer', 'element'], function () {
        var carousel = layui.carousel, $ = layui.$;
        var layer = layui.layer;
	    var src = $("#path").val();

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
        //个人信息的显示
        $('.personMsg').on('click',function () {
            layer.open({
                type: 2,
                title: '园长个人信息',
                area: ['500px', '400px'],
                moveType: 1,//拖拽模式，0或者1
                content: src + '/director/toUrl/personMsg' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
		            console.log(layero, index);
	            }
            });
        });
        //对应显示消息通知的内容
        $('.schoolMessage').on('click',function () {
            layer.open({
                type: 2,
                title: '校园消息通知',
                shade: 0.8//表示的是阴影的大小
                , area: ['55%', '65%'],
                moveType: 1,//拖拽模式，0或者1
                content: src + '/director/toUrl/director_SchoolMessage' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    console.log(layero, index);
                }
            });
        });
        //修改密码
        $('.updatePwd').on('click',function () {
            layer.open({
                type: 2,
                // offset: '100px',
                title: '修改密码',
                moveType: 1,//拖拽模式，0或者1
                area: ['500px', '400px'],
                btn: ['确认', '取消'],
                btn1: function (index, layero) {
                    // var src = $("#srcAddress").val();
                    //layer.getChildFrame("form", index)获取iframe的表单
                    //serializeArray jquery方法，将表单对象序列化为数组
                    var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());

                    console.log("修改密码："+formData.password);
                    if (formData.oldpwd.length == 0 ) {
                        layer.alert("请输入旧密码", {icon: 2});
                    }else if (formData.password.length == 0) {
                        layer.alert("新密码不能为空", {icon: 2});
                    } else if (formData.repassword.length == 0) {
                        layer.alert("请确认密码", {icon: 2});
                    } else if (formData.password != formData.repassword) {
                        layer.alert("确认密码输入不一致", {icon: 2});
                    }else{
                        $.ajax({
                            url: src + '/director/updatePwd',
                            type: 'post',
                            data: formData,
                            success: function (data) {
                                layer.alert(data);
                                layer.close(index);
                                // window.location.href = src + "/servlet/pback/userManage";
                            }, error: function (err) {
                                console.log(err);
                            }
                        });
                    }
                },
                content: src + '/director/toUrl/updatePwd' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    console.log(layero, index);
                }
            });
        });

        //查看主页校园公告内容
        $(".showNewsInfo").on('click',function () {
            var shownews = $(this).text();
            var titleInfo = shownews.split(":")[0];
            var detailInfo = shownews.split(":")[1];
            console.log("对应进行显示="+titleInfo+"="+detailInfo);
            //打开一个窗口播放视频
            layer.open({
                //打开一个窗口播放视频
                area: 'auto',
                offset:'auto',
                title:titleInfo,
                content: detailInfo,
            });
        });

        //退出到首页
	    $("#exit").on('click',function () {
		    layer.confirm('您确定退出到园长端登录界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
			    layer.close(index);
                sessionStorage.clear();//清除session信息
			    window.location.href = src+"/director/exit";
                return true;
		    });
		    return false;
	    });

        //将表单转为js对象数据
        function serializeObject($, array) {
            var obj = new Object();
            $.each(array, function (index, param) {
                if (!(param.name in obj)) {
                    obj[param.name] = param.value;
                }
            });
            return obj;
        }

        //园所界面的跳转
        $("#approvalGarden").on('click',function () {
            layer.confirm('您确定要进入到园长审批界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/directorReg";
                return true;
            });
            return false;
        });

        //教师管理
        $("#teachersManagement").on('click',function () {
            layer.confirm('您确定要进入到教师管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_TeacherManage";
                return true;
            });
            return false;
        });

        //教师考勤管理
        $("#teachersAttendManagement").on('click',function () {
            layer.confirm('您确定要进入到教师考勤管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_TeacherAttendManage";
                return true;
            });
            return false;
        });
        //幼儿管理
        $("#childrenManagement").on('click',function () {
            layer.confirm('您确定要进入到幼儿管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_ChildrenManage";
                return true;
            });
            return false;
        });

        //家长管理
        $("#parentManagement").on('click',function () {
            layer.confirm('您确定要进入到家长管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_ParentManage";
                return true;
            });
            return false;
        });

        //课程管理
        $("#courseManagement").on('click',function () {
            layer.confirm('您确定要进入到课程管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_CourseManage";
                return true;
            });
            return false;
        });

        //班级管理
        $("#classManagement").on('click',function () {
            layer.confirm('您确定要进入到班级管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_ClassManage";
                return true;
            });
            return false;
        });

        //班级成员管理
        $("#classMemberManagement").on('click',function () {
            layer.confirm('您确定要进入到班级成员管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_ClassMemberManage";
                return true;
            });
            return false;
        });
        //校园公告管理
        $("#campusBulletinManagement").on('click',function () {
            layer.confirm('您确定要进入到校园公告管理界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/director_CampusBulletinManage";
                return true;
            });
            return false;
        });
        //在线聊天
        $("#chatTeacher").on('click',function () {
            layer.confirm('您确定要进入到在线聊天中心吗?', {icon: 3, title: '温馨提示'}, function (index) {
                layer.close(index);
                window.location.href = src+"/director/toUrl/chatlogin";
                return true;
            });
            return false;
        });
        //保健员管理
        $("#healtherManagement").on('click',function () {
                window.location.href = src+"/director/toUrl/director_HealtherManage";
        });

        //安防员管理
        $("#securityManagement").on('click',function () {
                window.location.href = src+"/director/toUrl/director_SecurityManage";
        });

        //消息通知
        $("#messageNotice").on('click',function () {
            layer.confirm('您确定要进入到消息通知进行编辑吗?', {icon: 3, title: '温馨提示'}, function (index) {
                $.ajax({
                    url: src + "/director/selectInfoType",
                    async: true,
                    type: "post",
                    success: function (msg) {
                        if (msg == "success") {
                                layer.close(index);
                                window.location.href = src+"/director/toUrl/director_SchoolMessageNotice";
                        } else {
                            layer.alert("该账户未申请园所或未通过审批，请先操作后再进入!!!", {icon: 2});
                        }
                    }, error: function (msg) {
                        layer.alert("网络繁忙！", {icon: 2});
                    }
                });
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

        $(".addTeaAttendTime").click(function () {
            layer.open({
                type: 2,
                area: ['95%', '81%'],
                offset: ['10%', '3%'],
                title: '智慧幼儿园-人脸识别界面',
                content: src + '/director/toUrl/dirFaceID' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                }
            });

        });

        $(document).ready(function(){
            $.ajax({
                url: src + "/director/selectCampus",
                async: true,
                type: "post",
                success: function (msg) {
                }
            });
        });

    });

</script>


</body>
</html>
