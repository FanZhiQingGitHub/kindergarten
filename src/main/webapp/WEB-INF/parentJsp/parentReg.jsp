<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-3-16
  Time: 23:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<html>
<head>
    <title>文档管理系统-用户注册界面</title>
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
            background-image: url("${pageContext.request.contextPath}/image/loginreg/Reg.jpg");
            background-size: 100% 100%;
            background-attachment: fixed;
        }

        #alldiv {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        #hh1 {
            color: white;
            font-weight: bold;
            font-size: 55px;
            margin-left: 32.3%;
            margin-top: 3%;
            font-family: 楷体;
        }

        .container {
            position: absolute;
            width: 28%;
            height: 60%;
            min-height: 33%;
            /*max-height: 33%;*/
            top: 15px;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 8px;
            z-index: 130;
            border-radius: 10px;
            background-color: rgba(240, 255, 255, 0.2);
            box-shadow: 0 3px 18px rgba(240, 255, 255, 0.2);
            font-size: 16px;
        }

        .layui-input {
            border-radius: 5px;
            width: 300px;
            height: 38px;
            font-size: 18px;
        }

        .layui-form-item {
            margin-left: 7%;
            margin-top: 3%;
            font-size: 20px;
            color: black;
        }

        .layui-form-label {
            color: white;
        }

        .layui-btn {
            margin-left: -45px;
            border-radius: 5px;
            width: 85%;
            height: 15%;
            font-size: 20px;
        }

        #bu2 {
            height: 8%;
        }

        #bu3 {
            width: 50%;
            height: 8%;
            margin-left: 25%;
            font-size: 13px;
            background-color: transparent;
        }

    </style>
</head>
<body>
<form class="layui-form" method="post">
    <input type="hidden" id="path" value="<%=path%>">
    <div id="alldiv">
        <h1 id="hh1">文档管理系统用户注册界面</h1>
        <hr style="color: white">
        <div class="container">

            <div class="layui-form-item">
                <label class="layui-form-label">用户名称</label>
                <div class="layui-input-block">
                    <input type="text" name="username" id="te1" lay-verify="required" placeholder="请输入用户名" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">用户密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="userpwd" lay-verify="pass" placeholder="请输入6-12位密码"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                    <input type="password" lay-verify="pass|confirmPass" placeholder="请输入6-12位密码"
                           autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block" style="color: white">
                    <input type="radio" name="usersex" value="男" title="男" checked>
                    <input type="radio" name="usersex" value="女" title="女">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学历</label>
                <div class="layui-input-block">
                    <select name="useredu">
                        <option value="博士">博士</option>
                        <option value="硕士">硕士</option>
                        <option value="本科">本科</option>
                        <option value="大专">大专</option>
                        <option value="高中">高中</option>
                        <option value="初中">初中</option>
                        <option value="小学">小学</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" style="color: black">
                <label class="layui-form-label">职业</label>
                <div class="layui-input-block">
                    <select name="userjob">
                        <option value="董事长">董事长</option>
                        <option value="工程师">工程师</option>
                        <option value="助理工程师">助理工程师</option>
                        <option value="白领">白领</option>
                        <option value="蓝领">蓝领</option>
                        <option value="面试官">面试官</option>
                        <option value="总经理">总经理</option>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">手机号码</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="userphone" lay-verify="phone" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-inline">
                        <input type="text" name="useremail" lay-verify="email" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>


            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="button" class="layui-btn layui-btn-normal" id="bu2" lay-submit lay-filter="userReg">
                        立即注册
                    </button>
                </div>
            </div>


            <div id="butdiv">
                <button type="button" class="layui-btn" id="bu3">已有账号？点击这里立即登录</button>
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

        //验证规则
        form.verify({
            required: function (value) {
                if (value.length < 2) {
                    return '您好，用户名至少得2个字符！';
                }
            },
            confirmPass: function (value) {
                if ($('input[name=userpwd]').val() !== value)
                    return '两次密码输入不一致！';
            },
            phone: [
                /^1\d{10}$/
                , '您好，手机号码必须11位，且不能出现空格！'
            ],
            pass: [
                /^[\S]{6,12}$/
                , '您好，密码必须6~12位，且不能出现空格！'
            ]
            , content: function (value) {
                layedit.sync(editIndex);
            }

        });

        $("#te1").blur(function(){
            var path = $("#path").val();
            var username = $(this).val();
            $.ajax({
                url: path + "/parent/parentRegCheck",
                async: true,
                type: "post",
                data: {"username":username},
                datatype: "text",
                success: function (msg) {
                    if(msg == "existYes"){
                        layer.alert("该账号可以使用！", {icon: 6});
                    }else {
                        layer.alert("该账号已被注册！", {icon: 2});
                    }
                }, error: function (msg) {
                    layer.alert("网络繁忙！", {icon: 2});
                }
            });
        });


        form.on('submit(userReg)', function (data) {
            var path = $("#path").val();
            $.ajax({
                url: path + "/parent/parentReg",
                async: true,
                type: "post",
                data: data.field,
                datatype: "text",
                success: function (msg) {
                    if(msg == "success"){
                        layer.alert("注册成功！", {icon: 6},function () {
                            location.href = path + "/parent/login";
                        });
                    }else {
                        layer.alert("注册失败！", {icon: 2});
                    }
                }, error: function (msg) {
                    layer.alert("网络繁忙！", {icon: 2});
                }
            })
        });

        $(function () {
            $("#code").click(function () {
                var path = $("#path").val();
                var code = document.getElementById("code");
                code.src = path + "/parent/loginCode?"+Math.random();
            }), $("#bu1").click(function () {
                var path = $("#path").val();
                var code = document.getElementById("code");
                code.src = path + "/parent/loginCode?"+Math.random();
            }), $("#bu3").click(function () {
                var path = $("#path").val();
                location.href = path + "/parent/login";
            });
        })
    });
</script>
</body>
</html>
