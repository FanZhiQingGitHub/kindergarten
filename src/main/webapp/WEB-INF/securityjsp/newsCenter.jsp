<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-17
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-新闻详细信息</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<form class="layui-form">
    <input type="hidden" id="path" value="<%=path%>">
    <input type="hidden" id="name">

    <h1 style="margin-left: 36%" id="headInfo"></h1>
    <hr style="color: whitesmoke">

    <textarea style="color: black;width: 100%;height: 100%;resize:none;border: none;font-size: 18px"
              id="te1"></textarea>

</form>

<script>

    layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        $ = layui.jquery;
        var path = $("#path").val();




        //
        // function findNewsInfo() {
        //
        //     var name = $("#name").val();
        //     console.log(name);
        //     // $.ajax({
        //     //     url: path + '/security/findNewsInfo',
        //     //     async: true,
        //     //     type: 'post',
        //     //     data: {"campusinfoname": campusinfoname},
        //     //     datatype: 'text',
        //     //     success: function (data) {
        //     //         if (data == "error") {
        //     //             layer.alert("您好，该条新闻已被删除！", {icon: 2});
        //     //         } else {
        //     //             var info = JSON.parse(data);
        //     //             var msg;
        //     //             for(var i in info){
        //     //                 msg = info[i].campusinfodetail;
        //     //             }
        //     //             $("#te1").val(msg);
        //     //         }
        //     //     }, error: function (data) {
        //     //         layer.alert("网络繁忙！", {icon: 2});
        //     //     }
        //     // });
        // }


    });

    window.onload=function findNewsInfo(){
        var name = $("#name").val();
        console.log(name);
    }


</script>

</body>
</html>
