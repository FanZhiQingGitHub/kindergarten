<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-2
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-个人信息页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">
    <link rel="stylesheet" type="text/css" href=<%=path+"/image/adminimg/css/main.css"%>>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="adminid" name="adminid">
<div class="header">
    <h1 class="logo">
        <a>
            <span>个人信息</span>
            <img src="${pageContext.request.contextPath}/image/adminimg/img/logo.png">
        </a>
    </h1>
    <div class="nav">
        <a style="font-size: 18px">welcome to <span class="name" style="color: darkorchid">&nbsp;${adminname}&nbsp;</span> home !!!</a>
    </div>
    <p class="welcome-text">
        <button class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal updateAdminpwd" style="margin-top: 48%" >
            修改密码
        </button>
    </p>
</div>

<div class="about-content">
    <div class="w1000">
        <div class="item info">
            <div class="title">
                <h3>我的介绍</h3>
            </div>
            <div class="cont">
                <img src="${pageContext.request.contextPath}/image/adminimg/img/logo.jpg">
                <div class="per-info">
                    <ul style="font-size: 18px">
                        <c:if test="${not empty tblAdminList}">
                            <c:forEach items="${tblAdminList}" var="i" step="1">
                                <li >姓名：${i.adminname}</li><br/>
<%--                                <li >性别：${i.healthersex}</li><br/>--%>
<%--                                <li >年龄：${i.healtherage}</li><br/>--%>
<%--                                <li >地址：${i.healtheradd}</li><br/>--%>
<%--                                <li >电话：${i.healtherphone}</li><br/>--%>
                            </c:forEach>
                        </c:if>
                    </ul>
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

<div id="type-content" style="display: none;">
	<div class="layui-form-item">
		<label class="layui-form-label">旧   密   码</label>
		<div class="layui-inline">
			<input type="text" id="oldadminpwd" placeholder="请输入6-12位旧密码"
			       autocomplete="off" class="layui-input" style="width: 270px" >
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">新   密   码</label>
		<div class="layui-inline">
			<input type="password" id="adminpwd" placeholder="请输入6-12位密码" value=""
			       autocomplete="off" class="layui-input" style="width: 270px">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">确认密码</label>
		<div class="layui-inline">
			<input type="password" id="confrimAdminpwd" placeholder="请确认密码" value=""
			       autocomplete="off" class="layui-input" style="width: 270px">
		</div>
	</div>
</div>

<script>
    layui.use(['jquery','layer'], function () {
        var $ = layui.jquery,
	        layer = layui.layer;
	    var path = $("#path").val();
        $('body').on('click', '.updateAdminpwd', function () {
	        layer.confirm("确定修改密码？",{icon:3,title:'温馨提示'},function (index) {
		        layer.close(index);
	        	layer.open({
			        type: 1,
			        area: ['35%', '55%'],
			        content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
			        title: '修改管理员密码',
			        btn: ['确定', '取消'],
			        offset: '100px',
			        btnAlign: 'c',
			        btn1: function (index) {
				        var oldadminpwd = $("#oldadminpwd").val();
				        var adminpwd = $("#adminpwd").val();
				        var confrimAdminpwd = $("#confrimAdminpwd").val();

				        if (oldadminpwd.length == 0) {
					        layer.alert("请输入旧密码", {icon: 2});
				        } else if (adminpwd.length < 6) {
					        layer.alert("新密码长度低于6位", {icon: 2});
				        } else if (adminpwd.length > 12) {
					        layer.alert("新密码长度大于12位", {icon: 2});
				        } else if (adminpwd.length == 0) {
					        layer.alert("新密码不能为空", {icon: 2});
				        } else if (confrimAdminpwd.length == 0) {
					        layer.alert("请确认密码", {icon: 2});
				        } else if (adminpwd != confrimAdminpwd) {
					        layer.alert("密码输入不一致", {icon: 2});
				        } else {
					        $.ajax({
						        url: path + '/admin/updateAdminpwd',
						        async: true,
						        type: 'post',
						        data: {
						        	"adminid":$("#adminid").val(),
							        "oldadminpwd": oldadminpwd,
							        "adminpwd": adminpwd,
							        "confrimAdminpwd": confrimAdminpwd
						        },
						        datatype: 'text',
						        success: function (data) {
							        if (data == "error") {
								        layer.alert("修改失败！", {icon: 2});
							        } else if (data == "pwderror") {
								        layer.alert("旧密码输入错误", {icon: 2});
							        } else {
								        layer.alert("修改成功", {icon: 6});
								        layer.close(index);
							        }
						        }, error: function (data) {
							        layer.alert("网络繁忙！", {icon: 2});
						        }
					        });
				        }
			        },
		        });
	        });
        });

	    $(function () {
		    $("#oldadminpwd").blur(function () {
			    var reg = /^[\w]{6,12}$/;
			    var oldadminpwd = $(this).val();
			    $.ajax({
				    url:path+"/admin/checkOldPwd",
				    type:'post',
				    dataType:'text',
				    data:{"oldadminpwd": oldadminpwd},
				    //验证旧密码是否输入正确
				    success:function(msg){
					    if (msg == "success" && oldadminpwd != 0 && ($('#oldadminpwd').val().match(reg))) {
						    layer.msg('输入旧密码正确',{icon:1});
					    } else if(oldadminpwd == 0 || !($('#oldadminpwd').val().match(reg)))
					    {
						    layer.msg('请输入6-12位字符! ')
					    }
					    else {
						    layer.msg('输入旧密码错误! ')
					    }
				    }
			    });
		    });
	    })
    })
</script>
</body>
</html>
