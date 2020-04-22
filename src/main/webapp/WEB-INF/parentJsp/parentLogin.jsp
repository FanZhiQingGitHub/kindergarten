<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-3-9
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-用户登录界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        html {
            width: 100%;
            height: 100%;
        }

        body {
            width: 100%;
            height: 100%;
            background-image: url("${pageContext.request.contextPath}/image/loginreg/Login.jpg");
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        #alldiv {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        #hh1 {
            color: black;
            font-weight: bold;
            font-size: 30px;
            margin-left: 16%;
            margin-top: 3%;
            font-family: 楷体;
        }

        .container {
            position: absolute;
            width: 28%;
            height: 39%;
            min-height: 33%;
            max-height: 50%;
            top: -20%;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 20px;
            z-index: 130;
            border-radius: 10px;
            background-color: rgba(240, 255, 255, 0.2);
            box-shadow: 0 3px 18px rgba(240, 255, 255, 0.2);
            font-size: 16px;
            border: 1px solid darkgray;
        }

        .layui-input {
            border-radius: 5px;
            width: 260px;
            height: 50px;
            font-size: 18px;
        }

        .layui-form-item {
            margin-left: 7%;
            margin-top: 3%;
            font-size: 20px;
            color: black;
        }

        .layui-btn {
            margin-left: -45px;
            border-radius: 5px;
            width: 85%;
            height: 15%;
            font-size: 20px;
        }

        .verity {
            width: 150px;
        }

        #bu3 {
            width: 30%;
            height: 8%;
            margin-left: 15%;
            font-size: 13px;
            background-color: transparent;
            color: black;
        }

        #bu5 {
            position: absolute;
            width: 30%;
            height: 8%;
            font-size: 13px;
            margin-left: 9%;
            background-color: transparent;
            color: black;
        }

        #bu1 {
            color: black;
        }

        #bu1:hover {
            color: red;
        }

        #bu3:hover {
            color: cyan;
        }

        #bu5:hover {
            color: cyan;
        }


        #codediv {
            position: absolute;
            background-color: transparent;
            margin-left: 47%;
            width: 35%;
            height: 12.5%;
        }

        #code {
            width: 45%;
            height: 100%;
            border-radius: 10px;
        }

        #bu1 {
            position: absolute;
            width: 55%;
            height: 50%;
            margin-left: 1%;
            margin-top: 13%;
            border: none;
            font-size: 13px;
            background-color: transparent;
        }

        .admin-icon {
            position: absolute;
            margin-left: 280px;
            margin-top: 10px;
            font-size: 30px;
            color: black;
        }

    </style>

</head>
<body>
<form class="layui-form" method="post">
    <input type="hidden" id="path" value="<%=path%>">
    <div id="alldiv">
        <div class="container">
            <h1 id="hh1">智慧幼儿园家长登录界面</h1>
            <hr style="color: white">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <i class="layui-icon layui-icon-username admin-icon admin-icon-username"></i>
                    <input type="text" name="parentName" lay-verify="required" placeholder="请输入用户名" value="张飞妈妈"
                           autocomplete="off" class="layui-input" id="te1">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密 &nbsp;&nbsp;码</label>
                <div class="layui-input-inline">
                    <i class="layui-icon layui-icon-password admin-icon admin-icon-password"></i>
                    <input type="password" name="parentPwd" required lay-verify="pass" placeholder="请输入6-12位密码"
                           value="123456"
                           autocomplete="off" class="layui-input" id="te2">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">验证码</label>
                <div class="layui-input-inline">
                    <input type="text" name="code" lay-verify="code" placeholder="请输入验证码"
                           autocomplete="off" class="layui-input verity" value="">
                </div>

                <div id="codediv">
                    <img src="${pageContext.request.contextPath}/parent/loginCode" id="code">
                    <input type="button" id="bu1" value="看不清？换一张"></td>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="button" class="layui-btn layui-btn-normal" id="bu2" lay-submit lay-filter="formDemo">
                        立即登录
                    </button>
                </div>
            </div>

            <div id="butdiv">
                <button type="button" class="layui-btn" id="bu3">忘记密码？重置一下</button>
                <button type="button" class="layui-btn" id="bu5">点击此处返回首页</button>
            </div>
        </div>
    </div>

    <div id="type-content" style="display: none;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <input type="text" id="parentname" placeholder="请输入您的登录用户名"
                       autocomplete="off" class="layui-input" style="width: 332px;margin-top: 8%">
            </div>
            <div class="layui-inline">
                <input type="text" id="parentphone" placeholder="请输入11位手机号码"
                       autocomplete="off" class="layui-input" style="width: 332px;margin-top: 8%">
            </div>
        </div>
    </div>

</form>

<script>

    layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        $ = layui.jquery;
        var path = $("#path").val();
        form.verify({
            required: function (value) {
                if (value.length < 2) {
                    return '您好，用户名至少得2个字符！';
                }
            },
            pass: [
                /^[\S]{6,12}$/
                , '您好，密码必须6~12位，且不能出现空格！'
            ],
            code: function (value) {
                if (value.length != 4) {
                    return '您好，验证码是4位数！';
                }
            }
            , content: function (value) {
                layedit.sync(editIndex);
            }

        });
        form.on('submit(formDemo)', function (data) {
            var path = $("#path").val();
            $.ajax({
                url: path + "/parent/Login",
                async: true,
                type: "post",
                data: data.field,
                success: function (result) {
                    if (result.msg == "codeError") {
                        //验证码错误
                        layer.msg("啊哦，验证码输入错误", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/parent/loginCode?" + Math.random();
                    } else if (result.msg == "loginFailed") {
                        //登陆失败
                        layer.msg("登陆失败，请检查您输入的账号密码！多次登陆失败请联系园长", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/parent/loginCode?" + Math.random();
                    } else if (result.success) {
                        //    登陆成功
                        layer.alert("登录成功！", {icon: 6}, function () {
                            location.href = path + result.data;
                        });
                    }
                }, error: function () {
                    layer.msg("网络繁忙！", {icon: 2});
                    var code = document.getElementById("code");
                    code.src = path + "/security/loginCode?" + Math.random();
                }
            });
        });

        $(function () {
            $("#code").click(function () {
                var path = $("#path").val();
                var code = document.getElementById("code");
                code.src = path + "/parent/loginCode?" + Math.random();
            }), $("#bu1").click(function () {
                var path = $("#path").val();
                var code = document.getElementById("code");
                code.src = path + "/parent/loginCode?" + Math.random();
            }), $("#bu3").click(function () {
                layer.open({
                    type: 1,
                    content: $("#type-content"), //数组第二项即吸附元素选择器或者DOM
                    title: '个人密码重置',
                    btn: ['确定', '取消'],
                    area: ['20%', '35%'],
                    offset: ['30%'],
                    btnAlign: 'c',
                    btn1: function (index) {
                        var parentname = $("#parentname").val();
                        var parentphone = $("#parentphone").val();
                        var num = /^1\d{10}$/;
                        if (parentname.length == 0) {
                            layer.msg("您好，用户名不能为空！", {icon: 2});
                        } else if (!num.test(parentphone)) {
                            layer.msg("您好，手机号码必须11位，且不能出现空格！", {icon: 2});
                        } else {
                            $.ajax({
                                url: path + '/parent/resetParentpwd',
                                async: true,
                                type: 'post',
                                data: {
                                    "parentname": parentname,
                                    "parentphone": parentphone
                                },
                                datatype: 'text',
                                success: function (data) {
                                    if (data == "error") {
                                        layer.msg("重置失败！", {icon: 2});
                                    } else {
                                        layer.alert("重置成功，新密码为：'123456' ", {icon: 6});
                                        $("#parentname").val("");
                                        $("#parentphone").val("");
                                        layer.close(index);
                                    }
                                }, error: function (data) {
                                    layer.msg("网络繁忙！", {icon: 2});
                                }
                            });
                        }
                    }
                });
            }), $("#bu5").click(function () {
                var path = $("#path").val();
                location.href = path + "/main/path/main";
            }), $("#parentname").blur(function () {
                var parentname = $("#parentname").val();
                $.ajax({
                    url: path + '/parent/resetParentpwd',
                    async: true,
                    type: 'post',
                    data: {
                        "parentname": parentname
                    },
                    datatype: 'text',
                    success: function (data) {
                        if (data == "notmen") {
                            layer.msg("对不起，不存在该用户！", {icon: 2});
                        }else {
                            layer.msg("存在该用户！", {icon: 6});
                        }
                    }, error: function (data) {
                        layer.msg("网络繁忙！", {icon: 2});
                    }
                });
            });
        })
    });
</script>

</body>
</html>
