<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<html>
<head>
    <title>平台端-园所详情</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <style type="text/css">
        /** {*/
        /*    margin: 0;*/
        /*    padding: 0;*/
        /*}*/
        /*html {*/
        /*    width: 100%;*/
        /*    height: 100%;*/
        /*}*/
        body {
            /*width: 100%;*/
            /*height: 100%;*/
            /*background-size: 100% 100%;*/
            /*background-attachment: fixed;*/
            font-size: 140%;
        }
        /*#alldiv {*/
        /*    position: absolute;*/
        /*    width: 100%;*/
        /*    height: 100%;*/
        /*}*/
        /*#hh1 {*/
        /*    font-weight: bold;*/
        /*    margin-top: 1%;*/
        /*    text-align: center;*/
        /*    font-family: 楷体;*/
        /*}*/

        .container {
            position: relative;
            width: 36%;
            min-height: 33%;
            top: 1%;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 10px;
            z-index: 130;
            border-radius: 10px;
            /*background-color: rgba(82, 108, 108, 0.2);*/
            /*box-shadow: 0 3px 18px rgba(240, 255, 255, 0.2);*/
        }
        .layui-form-item .layui-input-inline{
            width: 300px;
        }
        .layui-form-label {
            width: 140px;
        }

        label{
            margin-left: -75%;
        }
    </style>
</head>
<body >
    <form class="layui-form" method="post">
        <input type="hidden" id="path" value="<%=path%>">
        <div id="alldiv">
            <div class="container">
                <div class="layui-form-item" >
                    <label class="layui-form-label">幼儿园名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kindername" id="kindername" lay-verify="kindername" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">账号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderacount" id="kinderacount" lay-verify="kinderacount" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label" >法人：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderlp" id="kinderlp" lay-verify="kinderlp" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label" >法人身份证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderlpid" id="kinderlpid" lay-verify="kinderlpid" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">地址：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderlpadd" id="kinderlpadd" lay-verify="kinderlpadd" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">联系电话：</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="kinderlpphone" id="kinderlpphone" lay-verify="kinderlpphone" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">办学许可证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="schoolpermit" id="schoolpermit" lay-verify="schoolpermit|license" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">卫生许可证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="healthpermit" id="healthpermit" lay-verify="healthpermit|license" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">消防许可证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="firepermit" id="firepermit" lay-verify="firepermit|license" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item" >
                    <label class="layui-form-label">组织代码证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="grouppermit" id="grouppermit" lay-verify="grouppermit|license" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">税务登记证：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="registrationpermit" id="registrationpermit" lay-verify="registrationpermit|license" placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">园所规模：</label>
                    <div class="layui-input-inline" readonly>
                        <input type="text" name="kinderscale" id="kinderscale" lay-verify="kinderscale"
                               placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label" >注册资金：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderfunds" id="kinderfunds" lay-verify="kinderfunds"
                               placeholder="" autocomplete="off"
                               class="layui-input" readonly>
                    </div>
                </div>

<%--                <div class="layui-form-item">--%>
<%--                    <label class="layui-form-label" >审批时间：</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" name="kinderapptime" id="kinderapptime" lay-verify="kinderfunds"--%>
<%--                               placeholder="" autocomplete="off"--%>
<%--                               class="layui-input" readonly>--%>
<%--                    </div>--%>
<%--                </div>--%>

                <div class="layui-form-item">
                    <label class="layui-form-label" >审批状态：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="kinderstatus" id="kinderstatus" lay-verify="kinderfunds"
                               placeholder="" autocomplete="off"
                               class="layui-input" readonly>
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
    });
</script>
</body>
</html>
