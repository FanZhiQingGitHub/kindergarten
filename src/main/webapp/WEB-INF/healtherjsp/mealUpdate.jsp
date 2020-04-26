<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-9
  Time: 21:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-食谱信息修改界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>

<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="mealid">

<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 47%">修改膳食</h2>
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

    //用户管理数据表格
    layui.use(['table', 'jquery', 'layer', 'laydate', 'form'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var laydate = layui.laydate;
        var path = $("#path").val();
        var mealid = $("#mealid").val();
        var tblRecipeList;
        table.render({
            elem: '#layui_table'
            , url: path + '/healther/showAllRecipeInfo?mealid=' + mealid //数据接口
            , cols: [[ //表头
                {field: 'recipeid', title: '食谱id', width: 130, align: 'center',hide:true}
                ,{field: 'recipename', title: '餐别', width: 158, align: 'center'}
                , {field: 'monday', title: '星期一', width: 250, edit: 'text', align: 'center'}
                , {field: 'tuesday', title: '星期二', width: 250, edit: 'text', align: 'center'}
                , {field: 'wednesday', title: '星期三', width: 250, edit: 'text', align: 'center'}
                , {field: 'thursday', title: '星期四', width: 250, edit: 'text', align: 'center'}
                , {field: 'friday', title: '星期五', width: 250, edit: 'text', align: 'center'}
                , {field: 'mid', title: '膳食id', width: 250, edit: 'text', align: 'center',hide:true}
            ]]
            ,done : function(res, curr, count){
                tblRecipeList = res.data;
            }
        });

        $(function () {
            $("#bu1").click(function () {
                if(tblRecipeList.length == 0){
                    layer.alert("您必须选择一行数据进行修改！", {icon: 2});
                }else {
                    var msg = {"tblRecipeList": tblRecipeList};
                    msg = JSON.stringify(msg);
                    $.ajax({
                        url: path + "/healther/updateMealInfo",
                        async: true,
                        type: "post",
                        data: "TblRecipe=" + msg,
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
