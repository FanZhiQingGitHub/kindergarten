<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-19
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-修改电子围栏界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>

<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="kinder">

<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">修改电子围栏</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <table class="layui-hide" id="layui_table"></table>

    <div class="layui-btn-container" style="margin-left: 46.5%;margin-top: 5%">
        <button type="button" class="layui-btn layui-btn-normal " id="bu1">确认修改</button>
    </div>


</div>

<script>

    layui.use(['table', 'jquery', 'layer'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var path = $("#path").val();
        var kindername = $("#kinder").val()
        var coordinatelist;
        table.render({
            elem: '#layui_table'
            , url: path + '/security/findLngLatInfo?kindername=' + kindername //数据接口
            , cols: [[ //表头
                {field: 'coordinateid', title: '坐标ID', width: 130, align: 'center'}
                ,{field: 'lng', title: '当前经度（Y）', width: 158, edit: 'text',align: 'center'}
                , {field: 'lat', title: '当前纬度（X）', width: 250, edit: 'text', align: 'center'}
            ]]
            ,done : function(res, curr, count){
                coordinatelist = res.data;
            }
        });

        $(function () {
            $("#bu1").click(function () {
                if(coordinatelist.length == 0){
                    layer.msg("您必须添加相应数据！", {icon: 2});
                }else {
                    var msg = {"coordinatelist": coordinatelist};
                    console.log(coordinatelist);
                    msg = JSON.stringify(msg);
                    $.ajax({
                        url: path + "/security/updateMealInfo",
                        async: true,
                        type: "post",
                        data: "TblCoordinate=" + msg,
                        datatype: "text",
                        success: function (msg) {
                            if (msg == "success") {
                                layer.alert("修改成功！", {icon: 6}, function (index) {
                                    window.parent.location.reload();
                                });
                            } else {
                                layer.msg("修改失败！", {icon: 2});
                            }
                        }, error: function (msg) {
                            layer.msg("网络繁忙！", {icon: 2});
                        }
                    })
                }
            });
        })

    });
</script>
</body>
</html>
