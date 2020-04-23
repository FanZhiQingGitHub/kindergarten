<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-3-9
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-登录界面</title>
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
            background-image: url("${pageContext.request.contextPath}/loginres/images/bk-login.jpg");
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        #alldiv {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        .container {
            position: absolute;
            width: 63%;
            height: 48%;
            min-height: 33%;
            max-height: 50%;
            top: -19%;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 30px;
            z-index: 130;
            border-radius: 10px;
            background-color: rgba(240, 255, 255, 0.2);
            box-shadow: 0 3px 18px rgba(240, 255, 255, 0.2);
            font-size: 16px;
        }

        .layui-input {
            border-radius: 5px;
            width: 260px;
            height: 50px;
            font-size: 18px;
        }

        .layui-form-item {
            margin-left: 7%;
            margin-top: 6%;
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

        #codediv {
            position: absolute;
            background-color: transparent;
            margin-left: 21%;
            width: 17%;
            height: 10%;
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
            color: red;
        }

        #a1{
            color: #9F9F9F
        }
        #a2{
            color: #9F9F9F
        }

        #a1:hover{
           color: #f37d25;
        }
        #a2:hover{
            color: #f37d25;
        }

        .admin-icon {
            position: absolute;
            margin-left: 280px;
            margin-top: 10px;
            font-size: 30px;
            color: black;
        }
        .main_left{ float:left; width:600px; position:relative}
        .main_left img{ position:absolute}
        .theimg{ top:90px; left:220px}
        .secimg{top:90px; left:180px}
        .firimg{top:90px; left:50px}

        .main_right{ width:456px; height:386px; float:right; padding-right:36px;}
        .main_r_up{ height:74px;padding-top:20px;}
        .main_r_up img{ float:left}
        .main_r_up .pp{ float:left;height:74px; line-height:74px; font-size:18px; color:#333; padding-left:20px;letter-spacing:9px;}

        .footer{ width:100%; height:60px; line-height:60px; position:fixed; bottom:0; background:url(${pageContext.request.contextPath}/loginres/images/footerBg.png);background-color: transparent;}
        .footer0{ width:1200px; height:60px; margin:0 auto; font-size:14px; color: #9F9F9F}
        .footer_l{ float:left}
        .footer_r{ float:right}

    </style>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<form class="layui-form" method="post">

    <div id="alldiv">
        <div class="container">

            <div style="margin-left: 3%;margin-top: -10%">
                <img src="${pageContext.request.contextPath}/image/logo/hs-word.png"/>
            </div>

            <div class="main_left">
                <img src="${pageContext.request.contextPath}/loginres/images/login-image-3.png" class="theimg"/>
                <img src="${pageContext.request.contextPath}/loginres/images/login-image-2.png" class="secimg"/>
                <img src="${pageContext.request.contextPath}/loginres/images/login-image-1.png" class="firimg"/>
            </div>

            <div class="main_right">

                <div class="main_r_up">
                    <img src="${pageContext.request.contextPath}/loginres/images/head.png" />
                    <div class="pp"><img src="${pageContext.request.contextPath}/loginres/images/welcome.png" style="width: 300px;height: 95px"/></div>
                </div>

            <hr style="color: white;">
            <div class="layui-form-item">
                <label class="layui-form-label">幼儿园</label>
                <div class="layui-input-block">
                    <i class="layui-icon layui-icon-username admin-icon admin-icon-username"></i>
                    <input type="text" name="kindername" lay-verify="required" placeholder="请输入用户名" value=""
                           autocomplete="off" class="layui-input" id="te1">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密 &nbsp;&nbsp;码</label>
                <div class="layui-input-inline">
                    <i class="layui-icon layui-icon-password admin-icon admin-icon-password"></i>
                    <input type="password" name="kinderpwd" required lay-verify="pass" placeholder="请输入6-12位密码"
                           value=""
                           autocomplete="off" class="layui-input" id="te2">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">验证码</label>
                <div class="layui-input-inline">
                    <input type="text" name="kindercode" lay-verify="code" placeholder="请输入验证码"
                           autocomplete="off" class="layui-input verity">
                </div>

                <div id="codediv">
                    <img src="${pageContext.request.contextPath}/main/LoginCode" id="code">
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
            </div>

        </div>
    </div>

    <div class="footer">
        <div class="footer0">
            <div class="footer_l"><a href="javascript:void(0);" id="a1">使用条款</a> | <a href="javascript:void(0);" id="a2">隐私保护</a></div>
            <div class="footer_r">@2020 最后#的小组 版权所有© &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-MAIL:kindergarten@outlook.com </div>
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
            code :function (value) {
                if (value.length != 4) {
                    return '您好，验证码是4位数！';
                }
            }
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                url: path + "/main/mainLogin",
                async: true,
                type: "post",
                data: data.field,
                datatype: "text",
                success: function (msg) {
                    if (msg == "success") {
                        layer.alert("登录成功！", {icon: 6}, function () {
                            location.href = path + "/main/path/main";
                        });
                    } else if (msg == "error") {
                        layer.msg("登录失败！", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/main/LoginCode?" + Math.random();
                    } else if (msg == "codeerror") {
                        layer.msg("验证码错误！", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/main/LoginCode?" + Math.random();
                    } else if (msg == "notmen") {
                        layer.msg("该幼儿园已被禁用或者不存在！", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/main/LoginCode?" + Math.random();

                    }else if (msg == "notpass") {
                        layer.msg("该幼儿园未通过审批！", {icon: 2});
                        var code = document.getElementById("code");
                        code.src = path + "/main/LoginCode?" + Math.random();
                    }
                }, error: function (msg) {
                    layer.msg("网络繁忙！", {icon: 2});
                }
            });
        });

        $(function () {
            $("#code").click(function () {
                var code = document.getElementById("code");
                code.src = path + "/main/LoginCode?" + Math.random();

            }), $("#bu1").click(function () {
                var code = document.getElementById("code");
                code.src = path + "/main/LoginCode?" + Math.random();
            }), $("#a1").click(function () {
                layer.open({
                    title: '使用条款'
                    ,content: '本应用深知个人信息对您的重要性，并会尽全力保护您的个人信息安全可靠。我们致力于维持您对我们的信任，恪守以下原则，保护您的个人信息：权责一致原则、目的明确原则、选择同意原则、最少够用原则、确保安全原则、主体参与原则、公开透明原则等。同时，我们承诺，我们将按业界成熟的安全标准，采取相应的安全保护措施来保护您的个人信息。 请在使用我们的产品（或服务）前，仔细阅读并了解本《隐私权政策》。\n' +
                        '\n' +
                        '作者：最后#的小组\n' +
                        '著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。'
                });
            }), $("#a2").click(function () {
                layer.open({
                    title: '隐私保护'
                    ,content: '' +
                        '感谢您的支持，我们会重视您在体验中的个人隐私。同时您在使用我们的产品时，我们可能会收集和使用您的相关信息。我们希望通过本《隐私政策》向您说明，在使用我们的服务时，我们如何收集、使用、储存这些信息，以及我们为您提供的访问、更新、控制和保护这些信息的方式。本《隐私政策》与您所使用的本产品服务息息相关，希望您仔细阅读，在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》中涉及的相关技术词汇，我们尽量以简明扼要的表述，以便您的理解。\n' +
                        '\n' +
                        '如对本《隐私政策》或相关事宜有任何问题，请通过kindergarten@outlook.com与我们联系。\n' +
                        '\n' +
                        '作者：最后#的小组\n' +
                        '著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。'
                });
            });
        });
    });
</script>

</body>
</html>
