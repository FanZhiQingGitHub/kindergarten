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
    <title>智慧幼儿园-新增宝宝运动轨迹</title>
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
        <h2 style="margin-left: 46%">新增宝宝运动轨迹</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>
    <div class="layui-fluid" style="margin-left: 5.5%">

        <div class="layui-inline">
            <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                <label class="layui-form-label">宝宝名称：</label>
                <div class="layui-input-block">
                    <select name="stuname" id="stuname" style="width:200px;height: 5.3%"></select>
                </div>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="layui_table"></table>

    <div class="layui-btn-container" style="margin-left: 46.5%;margin-top: 5%">
        <button type="button" class="layui-btn layui-btn-normal " id="bu1">确认新增</button>
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
                layer.confirm('您确定要修改吗?', {icon: 3, title:'提示'},function (index) {
                    if(coordinatelist.length == 0){
                        layer.msg("您必须添加相应数据！", {icon: 2});
                    }else {
                        var msg = {"coordinatelist": coordinatelist};
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
                                    layer.close(index)
                                } else {
                                    layer.msg("修改失败！", {icon: 2});
                                }
                            }, error: function (msg) {
                                layer.msg("网络繁忙！", {icon: 2});
                            }
                        })
                    }
                });

            });
        })

    });
</script>
</body>
</html>
