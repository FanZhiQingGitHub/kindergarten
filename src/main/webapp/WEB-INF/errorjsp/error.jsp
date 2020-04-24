<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-3-31
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>智慧幼儿园-服务器开小差了</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <style>
        html,
        body {
            height: 100%;
        }

        body {
            background-color: #f2f2f2;
            color: #444;
            font: 12px/1.5 'Helvetica Neue', Arial, Helvetica, sans-serif;
            background: url("${pageContext.request.contextPath}/image/error/blueprint.png") repeat 0 0;
        }

        div.da-wrapper {
            width: 100%;
            height: auto;
            min-height: 100%;
            position: relative;
            min-width: 320px
        }

        div.da-wrapper .da-container {
            width: 96%;
            margin: auto
        }

        div.da-content {
            clear: both;
            padding-bottom: 58px
        }

        @media only screen and (max-width:480px) {
            div.da-content {
                margin-top: auto
            }
        }

        div.da-error-wrapper {
            width: 320px;
            padding: 30px 0;
            margin: auto;
            position: relative
        }

        div.da-error-wrapper .da-error-heading {
            color: #e15656;
            text-align: center;
            font-size: 24px;
            font-family: Georgia, "Times New Roman", Times, serif
        }

        @-webkit-keyframes error-swing {
            0% {
                -webkit-transform: rotate(1deg)
            }

            100% {
                -webkit-transform: rotate(-2deg)
            }
        }

        @-moz-keyframes error-swing {
            0% {
                -moz-transform: rotate(1deg)
            }

            100% {
                -moz-transform: rotate(-2deg)
            }
        }

        @keyframes error-swing {
            0% {
                transform: rotate(1deg)
            }

            100% {
                transform: rotate(-2deg)
            }
        }

        div.da-error-wrapper .da-error-code {
            width: 285px;
            height: 170px;
            padding: 127px 16px 0 16px;
            position: relative;
            margin: auto;
            margin-bottom: 20px;
            z-index: 5;
            line-height: 1;
            font-size: 32px;
            text-align: center;
            background: url("${pageContext.request.contextPath}/image/error/error-hanger.png") no-repeat center center;
            -webkit-transform-origin: center top;
            -moz-transform-origin: center top;
            transform-origin: center top;
            -webkit-animation: error-swing infinite 2s ease-in-out alternate;
            -moz-animation: error-swing infinite 2s ease-in-out alternate;
            animation: error-swing infinite 2s ease-in-out alternate
        }

        div.da-error-wrapper .da-error-code .tip {
            padding-top: 2px;
            color: #e15656;
        }

        div.da-error-wrapper .da-error-code .tip2 {
            padding-top: 15px;
        }

        div.da-error-wrapper .da-error-code .tip3 {
            padding-top: 20px;
            font-size: 16px;
            color: #e15656;
        }

        div.da-error-wrapper .da-error-pin {
            width: 38px;
            height: 38px;
            display: block;
            margin: auto;
            margin-bottom: -27px;
            z-index: 10;
            position: relative;
            background: url("${pageContext.request.contextPath}/image/error/error-pin.png") no-repeat center center
        }

        p {
            margin: 0;
            padding: 0;
        }
    </style>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="da-wrapper">
    <div class="da-content">
        <div class="da-container clearfix">
            <div class="da-error-wrapper">
                <div class="da-error-pin"></div>
                <div class="da-error-code">
                    <p class="tip">STATUS:404</p>
                    <p class="tip2">服务器开小差了</p>
                    <p class="tip3">You don't have permission to access the URL on this server.</p>
                </div>
                <h1 class="da-error-heading">Sorry, 请稍后再试 !!!</h1>
<%--                <a class="da-error-heading" href="javascript:void(0);" id="a1">点击此处返回登录界面</a>--%>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        $ = layui.jquery;

    });
</script>

</body>
</html>
