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
	<style>
		#hh1 {
			font-weight: bold;
			font-size: 40px;
			margin-top: 2%;
			text-align: center;
			font-family: 楷体;
		}
		body{
			font-size: 140%;
		}

		.layui-input{
			width:180%;
			height: 80%;
			margin: auto;
		}
		.sp{
			font-size: 140%;
			height: 40px;
			line-height: 40px;
		}
		.layui-form-radio * {
			font-size: 24px;
		}
		.layui-form-radio > i {
			margin-right: 8px;
			font-size: 24px;
		}
	</style>
</head>
<body>
	<input type="hidden" id="path" value="<%=path%>">
	<input type="hidden" id="adminid" name="adminid">
	<form class="layui-form" method="post" enctype="multipart/form-data">
		<div id="alldiv">
			<h1 id="hh1">个人信息</h1>
			<hr style="color: white">
			<div class="container" style="margin-top: 3%">
				<div class="layui-form-item" style="height: 8%;line-height: 8%;">
					<label class="layui-form-label" style="width: 10%">我的角色：</label>
					<div class="layui-input-inline">
						<input type="text" name="rolename" id="rolename" lay-verify="rolename" placeholder="" autocomplete="off"
						       class="layui-input" readonly >
					</div>
					<span class="layui-form-label" style="width:18%;margin-left: 8%">当前角色不可更改为其他角色</span>
				</div>

				<div class="layui-form-item" style="height: 8%;line-height: 8%;">
					<label class="layui-form-label" style="width: 10%">用户名：</label>
					<div class="layui-input-inline">
						<input type="text" name="adminname" id="adminname" lay-verify="adminname" placeholder="" autocomplete="off"
						       class="layui-input" readonly >
					</div>
					<span class="layui-form-label" style="width:10%;margin-left: 8.5%">用户名不可更改</span>
				</div>

				<div class="layui-form-item" style="height: 8%;line-height: 8%;">
					<label class="layui-form-label" style="width: 10%">性别：</label>
					<div class="layui-input-inline" style="width: 35%">
						<input type="radio" id="ra1" name="adminsex" class="adminsex" value="男" title="男" >
						<input type="radio" id="ra2" name="adminsex" class="adminsex" value="女" title="女" style="margin-left: 10%;">
					</div>
				</div>

				<div class="layui-form-item" style="height: 8%;line-height: 8%;">
					<label class="layui-form-label" style="width: 10%">头像：</label>
					<div class="layui-input-inline">
						<input type="text" name="adminheadurl" id="adminheadurl" lay-verify="adminheadurl" placeholder="请输入头像url信息" autocomplete="off"
						       class="layui-input" readonly>
					</div>
					<button type="button" class="layui-btn layui-btn-normal" name="file" id="uploadImg" style="margin-left: 10%;" ><i class="layui-icon">&#xe67c;上传图片</i></button>
				</div>

				<div class="layui-form-item" style="height: 8%;line-height: 8%;">
					<label class="layui-form-label" style="width: 10%">手机号：</label>
					<div class="layui-input-inline">
						<input type="tel" name="adminphone" id="adminphone" lay-verify="adminphone" placeholder="请输入11位手机号" autocomplete="off"
						       class="layui-input" >
					</div>
				</div>

				<div class="layui-form-item" style="margin-top: 2%">
					<div class="layui-input-inline" style="margin-left: 10%;">
						<button type="button" class="layui-btn layui-btn-normal" id="bu2" lay-submit lay-filter="updateAdminInfo">
							<span class="sp">确认修改</span>
						</button>
						<button type="button" class="layui-btn layui-btn-primary" id="bu3" style="margin: -20% 80%;"><span class="sp">返回</span></button>
					</div>
				</div>
			</div>
		</div>
	</form>

<script>
    layui.use(['jquery','layer','form','layedit','upload'], function () {
	    var $ = layui.jquery,
		    layer = layui.layer
		    , form = layui.form
		    , layedit = layui.layedit
		    ,upload = layui.upload;
	    var path = $("#path").val();

	    $("#bu2").mouseover(function() {
		    layer.tips('温馨提示：请先点击图片上传按钮选择要上传的图片，再点击确认修改', this, {
			    tips: [1, "#8f9199"]
		    });
	    });

	    //验证规则
	    form.verify({
		    adminheadurl: function (value) {
			    if (value.length < 3) {
				    return '您好，地址不能为空，且至少3个字符！';
			    }
		    },
		    adminphone: [
			    /^1\d{10}$/
			    , '您好，手机号码必须11位，以1开头且不能出现空格！'
		    ],
		    content: function (value) {
			    layedit.sync(editIndex);
		    }
	    });
	    $(function () {
		    $("#adminphone").blur(function () {
			    var adminphone = $("#adminphone").val();
			    if (adminphone == 0) {
				    layer.msg("手机号不能为空", {icon: 2});
				    $('#bu2').attr('disabled',"disabled");
			    } else if (!/^1\d{10}$/.test(adminphone)) {
				    layer.msg("您好，手机号码必须11位，以1开头且不能出现空格！", {icon: 2});
				    $('#bu2').attr('disabled',"disabled");
			    } else {
				    $('#bu2').removeAttr('disabled');
			    }
		    });
	    });

	    upload.render({
		    elem: '#uploadImg' //绑定元素
		    ,url: path+"/admin/uploadAdminHeadImg" //上传接口
		    ,auto: false
		    ,accept: 'images'
		    ,acceptMime: 'image/*'
		    ,bindAction: '#bu2'
		    ,choose:function(obj){//选择文件的回调，obj为选中的文件
			    var files = obj.pushFile();
			    obj.preview(function(index,file,result){
				    $("#adminheadurl").val("image/adminimg/img/"+file.name);
			    });
		    }
		    ,before: function(obj){
			    this.data = {
				    rolename: $("#rolename").val()
				    ,adminname: $("#adminname").val()
				    ,adminheadurl: $("#adminheadurl").val()
				    ,adminsex: $('input[name="adminsex"]:checked').val()
				    ,adminphone:  $("#adminphone").val()
			    }
		    }
		    ,done: function(res){
			    if(res.code > 0){
				    return layer.msg('个人信息修改失败');
			    }
			    layer.alert("个人信息修改成功！",{icon:6});
			    setTimeout(function () {
				    parent.location.href = path + "/admin/toUrl/adminMain"; //再执行关闭
			    }, 3000);
		    }
		    ,error: function(){
			    //请求异常回调
			    layer.alert("个人信息修改失败！",{icon:2});
		    }
	    });


	    $(function () {
		    $("#bu3").click(function () {
			    layer.confirm('您确定返回到后台管理主页面吗?', {icon: 3, title: '温馨提示'}, function (index) {
				    var path = $("#path").val();
				    parent.location.href = path + "/admin/toUrl/adminMain";
				    return true;
			    });
			    return false;
		    });

		    $.ajax({
			    url: path + "/admin/selectAdminInfo",
			    type: 'post',
			    datatype: 'json',
			    success: function (data) {
				    var adminInfo = eval(data);
				    for (i in adminInfo) {
					    $("#rolename").val(adminInfo[i].rolename);
					    $("#adminname").val(adminInfo[i].adminname);
					    $("#adminheadurl").val(adminInfo[i].adminheadurl);
					    $("#adminphone").val(adminInfo[i].adminphone);
					    if (adminInfo[i].adminsex == "男") {
						    $("#ra1").attr("checked", "checked");
					    } else {
						    $("#ra2").attr("checked", "checked");
					    }
					    $("input[name=adminsex][value=男]").attr("checked", adminInfo[i].adminsex == "男" ? true : false);
					    $("input[name=adminsex][value=女]").attr("checked", adminInfo[i].adminsex == "女" ? true : false);
					    form.render();
				    }
			    }, error: function (data) {
				    layer.alert("网络繁忙！", {icon: 2});
			    }
		    })
	    })
    })
</script>
</body>
</html>
