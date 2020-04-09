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
    <title>智慧幼儿园-</title>
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

    <table class="layui-hide" id="layui_table" lay-filter="checkData"></table>

    <div class="layui-btn-container" style="margin-left: 46.5%;margin-top: 6%">
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
        table.render({
            elem: '#layui_table'
            , text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
                none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
            }
            , height: 220
            , url: path + '/healther/showAllRecipeInfo?mealid=' + mealid //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {type: 'checkbox',fixed: 'left'}
                ,{field: 'recipeid', title: '食谱id', width: 130, align: 'center',hide:true}
                ,{field: 'recipename', title: '餐别', width: 135, align: 'center'}
                , {field: 'monday', title: '星期一', width: 245, edit: 'text', align: 'center'}
                , {field: 'tuesday', title: '星期二', width: 245, edit: 'text', align: 'center'}
                , {field: 'wednesday', title: '星期三', width: 245, edit: 'text', align: 'center'}
                , {field: 'thursday', title: '星期四', width: 245, edit: 'text', align: 'center'}
                , {field: 'friday', title: '星期五', width: 245, edit: 'text', align: 'center'}
                , {field: 'mid', title: '膳食id', width: 245, edit: 'text', align: 'center',hide:true}
            ]]
        });

        $(function () {
            $("#bu1").click(function () {
                var tblRecipeList = layui.table.checkStatus('searchTable').data;

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
                                layer.alert("修改失败！", {icon: 2});
                            }
                        }, error: function (msg) {
                            layer.alert("网络繁忙！", {icon: 2});
                        }
                    })
                }
            });
        })

    });


</script>

</body>
</html>
