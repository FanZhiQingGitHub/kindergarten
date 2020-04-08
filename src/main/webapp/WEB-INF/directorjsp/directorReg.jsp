<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
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
            <%--background-image: url("${pageContext.request.contextPath}/image/loginreg/Reg.jpg");--%>
            background-size: 100% 100%;
            background-attachment: fixed;
        }
        #alldiv {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        #hh1 {
            /*color: white;*/
            font-weight: bold;
            font-size: 55px;
            /*margin-left: 32.3%;*/
            margin-top: 3%;
            text-align: center;
            font-family: 楷体;
        }

        .container {
            position: absolute;
            width: 38%;
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

        /*.layui-input {*/
        /*    border-radius: 5px;*/
        /*    width: 300px;*/
        /*    height: 38px;*/
        /*    font-size: 18px;*/
        /*}*/

        /*.layui-form-item {*/
        /*    margin-left: 7%;*/
        /*    margin-top: 3%;*/
        /*    font-size: 20px;*/
        /*    color: black;*/
        /*    width: 140px;*/
        /*}*/

        .layui-input-inline{
            width: 300px;
        }
        .layui-form-label {
            /*color: white;*/
            width: 140px;
        }

        /*.layui-btn {*/
        /*    margin-left: -45px;*/
        /*    border-radius: 5px;*/
        /*    width: 85%;*/
        /*    height: 15%;*/
        /*    font-size: 20px;*/
        /*}*/
        /*#bu2 {*/
        /*    height: 8%;*/
        /*}*/

    </style>
</head>
<body>
<form class="layui-form" method="post">
    <input type="hidden" id="path" value="<%=path%>">
    <div id="alldiv">
        <h1 id="hh1">园所资格审批界面</h1>
        <hr style="color: white">
        <div class="container">

            <div class="layui-form-item">
                <label class="layui-form-label">幼儿园名称：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kindername" id="kindername" lay-verify="kindername" placeholder="请输入幼儿园名称" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">法人：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlp" id="kinderlp" lay-verify="kinderlp" placeholder="请输入法人信息" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">法人身份证：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlpid" id="kinderlpid" lay-verify="kinderlpid" placeholder="请输入18位身份证" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">地址：</label>
                <div class="layui-input-inline">
                    <input type="text" name="kinderlpadd" id="kinderlpadd" lay-verify="kinderlpadd" placeholder="请输入可用地址" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="kinderlpphone" id="kinderlpphone" lay-verify="kinderlpphone" placeholder="请输入11位联系电话" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">办学许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="schoolpermit" id="schoolpermit" lay-verify="schoolpermit|license" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">卫生许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="healthpermit" id="healthpermit" lay-verify="healthpermit|license" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">消防许可证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="firepermit" id="firepermit" lay-verify="firepermit|license" placeholder="请输入11位联系电话" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">组织代码证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="grouppermit" id="grouppermit" lay-verify="grouppermit|license" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">税务登记证：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="registrationpermit" id="registrationpermit" lay-verify="registrationpermit|license" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="button" class="layui-btn layui-btn-normal" id="bu2" lay-submit lay-filter="approval">
                        申请审批
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary" id="bu3">返回</button>
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
            kindername: function (value) {
                if (value.length < 2) {
                    return '您好，幼儿园名称至少得4个字符！';
                }
                if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
                    return '幼儿园名称不能有特殊字符';
                }
                if(/(^\_)|(\__)|(\_+$)/.test(value)){
                    return '幼儿园名称首尾不能出现下划线\'_\'';
                }
                if(/^\d+\d+\d$/.test(value)){
                    return '幼儿园名称不能全为数字';
                }
            },
            kinderlp: function (value) {
                if (value.length < 2) {
                    return '您好，法人至少2个汉字！';
                }
            },
            kinderlpid:[
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
            ///^[a-zA-Z0-9]{10,20}$/, //组织机构代码证
            license: [
                /^[a-zA-Z0-9]{10,20}$/
                , '您好，许可证必须10~20位，且不能出现空格！'
            ],
                content: function (value) {
                layedit.sync(editIndex);
            }

        });

        // $("#te1").blur(function(){
        //     var path = $("#path").val();
        //     var username = $(this).val();
        //     $.ajax({
        //         url: path + "/parent/parentRegCheck",
        //         async: true,
        //         type: "post",
        //         data: {"username":username},
        //         datatype: "text",
        //         success: function (msg) {
        //             if(msg == "existYes"){
        //                 layer.alert("该账号可以使用！", {icon: 6});
        //             }else {
        //                 layer.alert("该账号已被注册！", {icon: 2});
        //             }
        //         }, error: function (msg) {
        //             layer.alert("网络繁忙！", {icon: 2});
        //         }
        //     });
        // });


        form.on('submit(approval)', function (data) {
            var path = $("#path").val();
            $.ajax({
                url: path + "/director/directorReg",
                async: true,
                type: "post",
                data: data.field,
                datatype: "text",
                success: function (msg) {
                    if(msg == "success"){
                        layer.alert("申请审批成功！", {icon: 6},function () {
                            location.href = path + "/director/toUrl/directorMain";
                        });
                    }else {
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
        })
    });
</script>
</body>
</html>
