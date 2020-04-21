<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>园所审批界面</title>
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
            font-weight: bold;
            font-size: 35px;
            margin-top: 0%;
            text-align: center;
            font-family: 楷体;
        }

        .container {
            position: relative;
            width: 38%;
            min-height: 33%;
            top: 5px;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 3px;
            z-index: 130;
            border-radius: 10px;
            background-color: rgba(82, 108, 108, 0.2);
            box-shadow: 0 3px 18px rgba(240, 255, 255, 0.2);
            font-size: 16px;
        }

        .layui-form-item .layui-input-inline {
            width: 300px;
            left: 80px;
        }

        .layui-form-label {
            width: 140px;
            left: 80px;
        }

        /*.layui-form-item{*/
        /*    width: 50%;*/
        /* }*/
    </style>
</head>
<body>
<form class="layui-form" method="post">
    <input type="hidden" id="path" value="<%=path%>">
    <div id="alldiv">
        <div class="container">
            <h1 id="hh1">园所资格审批界面</h1>
            <hr style="color: white">
            <div class="layui-form-item">
                <label class="layui-form-label">账号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderacount" id="kinderacount" lay-verify="kinderacount"
                           placeholder="请输入账号" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">密码：</label>
                <div class="layui-input-inline">
                    <input type="password" name="kinderpwd" id="kinderpwd" lay-verify="kinderpwd" placeholder="请输入密码"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">幼儿园名称：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kindername" id="kindername" lay-verify="kindername" placeholder="请输入幼儿园名称"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">法人：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlp" id="kinderlp" lay-verify="kinderlp" placeholder="请输入法人信息"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">法人身份证：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlpid" id="kinderlpid" lay-verify="kinderlpid" placeholder="请输入18位身份证"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">地址：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlpadd" id="kinderlpadd" lay-verify="kinderlpadd"
                           placeholder="请输入可用地址" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="kinderlpphone" id="kinderlpphone" lay-verify="kinderlpphone"
                               placeholder="请输入11位联系电话" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">办学许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="schoolpermit" id="schoolpermit" lay-verify="schoolpermit|license"
                               placeholder="请输入办学许可证" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">卫生许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="healthpermit" id="healthpermit" lay-verify="healthpermit|license"
                               placeholder="请输入卫生许可证" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">消防许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="firepermit" id="firepermit" lay-verify="firepermit|license"
                               placeholder="请输入消防许可证" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">组织代码证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="grouppermit" id="grouppermit" lay-verify="grouppermit|license"
                               placeholder="请输入组织代码证" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">税务登记证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="registrationpermit" id="registrationpermit"
                               lay-verify="registrationpermit|license" placeholder="请输入税务登记证" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">园所规模：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderscale" id="kinderscale" lay-verify="kinderscale"
                               placeholder="请输入申请规模(单位：㎡)" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">注册资金：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderfunds" id="kinderfunds" lay-verify="kinderfunds"
                               placeholder="请输入注册资金(单位：元)" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-inline" style="margin-left: 25%;">
                    <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal" id="bu2"
                            lay-submit lay-filter="approval">
                        申请审批
                    </button>
                    <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-primary" id="bu3">
                        返回主页
                    </button>
                </div>
            </div>
        </div>
    </div>

</form>

<script>
    layui.use(['form', 'layer', 'jquery', 'layedit'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit,
            $ = layui.jquery;

        //验证规则
        form.verify({
            kinderacount: function (value) {
                if (value.length == 0) {
                    return '您好，账号不能为空！';
                }
                if (!new RegExp("^[a-zA-Z]([-_a-zA-Z0-9]{6,10})$").test(value)) {
                    return '账号不能有特殊字符，并且只能7—10个字符';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '账号名称不能全为数字';
                }
            },
            kinderpwd: [
                /^[\S]{6,12}$/
                , '您好，密码必须6~12位，且不能出现空格！'
            ],
            kindername: function (value) {
                if (value.length < 2) {
                    return '您好，幼儿园名称至少得4个字符！';
                }
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '幼儿园名称不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '幼儿园名称首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '幼儿园名称不能全为数字';
                }
            },
            kinderlp: function (value) {
                if (value.length < 2) {
                    return '您好，法人至少2个汉字！';
                }
            },
            kinderlpid: [
                /^\d{15}|\d{18}$/
                , '您好，身份证为15位或者18位，且不能出现空格！'
            ],

            kinderlpadd: function (value) {
                if (value.length < 3) {
                    return '您好，地址不能为空，且至少3个字符！';
                }
            },
            kinderlpphone: [
                /^1\d{10}$/
                , '您好，手机号码必须11位，且不能出现空格！'
            ],
            //组织机构代码证
            license: [
                /^[a-zA-Z0-9]{10,20}$/
                , '您好，许可证必须10~20位，且不能出现空格！'
            ],
            kinderscale: function (value) {
                //规模
                if (value.length == 0) {
                    return '您好，请输入园所规模！';
                } else if (value > 3200) {
                    return '您好，幼儿园规模不得大于3200 m²！';
                }
            }, kinderfunds: function (value) {
                //注册资金
                if (value < 30000) {
                    return '您好，注册资金不得低于30000元！';
                }
            },
            content: function (value) {
                layedit.sync(editIndex);
            }
        });

        form.on('submit(approval)', function (data) {
            var path = $("#path").val();
            $.ajax({
                url: path + "/director/directorReg",
                async: true,
                type: "post",
                data: data.field,
                datatype: "text",
                success: function (msg) {
                    if (msg == "success") {
                        layer.alert("申请审批成功！", {icon: 6}, function () {
                            location.href = path + "/director/toUrl/directorMain";
                        });
                    } else {
                        layer.alert("申请审批失败！", {icon: 2});
                    }
                }, error: function (msg) {
                    layer.alert("网络繁忙！", {icon: 2});
                }
            })
        });

        //

        $(function () {
            $("#bu3").click(function () {
                layer.confirm('您确定退出到园长端登录界面吗?', {icon: 3, title: '温馨提示'}, function (index) {
                    var path = $("#path").val();
                    location.href = path + "/director/toUrl/directorMain";
                    return true;
                });
                return false;
            });
            //幼儿园名字判断是不是重复
            $("#kindername").on('blur', function () {
                var kindername = $("#kindername").val();
                var path = $("#path").val();
                $.ajax({
                    url: path + "/director/selectKinderName",
                    async: true,
                    type: "post",
                    data: {"kindername": kindername},
                    dataType: "text",
                    success: function (msg) {
                        if (msg === "success") {
                            layer.msg("幼儿园名称已存在，请更改！");
                            $("#kindername").focus();
                        }
                    },
                    error: function () {
                        layer.alert("网络繁忙");
                    }
                });
            });


            //园所账号判断是不是重复
            $("#kinderacount").on('blur', function () {
                var kinderacount = $("#kinderacount").val();
                var path = $("#path").val();
                $.ajax({
                    url: path + "/director/selectKinderAccount",
                    async: true,
                    type: "post",
                    data: {"kinderacount": kinderacount},
                    dataType: "text",
                    success: function (msg) {
                        if (msg === "success") {
                            layer.msg("幼儿园账号已存在，请更改！");
                            $("#kinderacount").focus();
                        }
                    },
                    error: function () {
                        layer.alert("网络繁忙");
                    }
                });
            });
        })
    });
</script>
</body>
</html>
