<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-9
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-新增膳食</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 45%">新增膳食</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-inline" style="margin-left: 25%">
        <label class="layui-form-label">日期范围</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="mealtime" placeholder=" ~ " style="width: 500px">
        </div>
    </div>

    <table class="layui-hide" id="demo"></table>

    <div class="layui-btn-container" style="margin-left: 46%;margin-top: 6%">
        <button type="button" class="layui-btn layui-btn-normal " id="bu1">保存信息</button>
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

        //展示已知数据
        var tableInfo = table.render({
            elem: '#demo'
            , cols: [[ //标题栏
                {field: 'recipename', title: '餐别', width: 173, align: 'center'}
                , {field: 'monday', title: '星期一', width: 247, edit: 'text', align: 'center'}
                , {field: 'tuesday', title: '星期二', width: 247, edit: 'text', align: 'center'}
                , {field: 'wednesday', title: '星期三', width: 247, edit: 'text', align: 'center'}
                , {field: 'thursday', title: '星期四', width: 247, edit: 'text', align: 'center'}
                , {field: 'friday', title: '星期五', width: 247, edit: 'text', align: 'center'}
            ]]
            , data: [{
                "recipename": "早餐"
                , "monday": ""
                , "tuesday": ""
                , "wednesday": ""
                , "thursday": ""
                , "friday": ""
            }, {
                "recipename": "午餐"
                , "monday": ""
                , "tuesday": ""
                , "wednesday": ""
                , "thursday": ""
                , "friday": ""
            }, {
                "recipename": "点心"
                , "monday": ""
                , "tuesday": ""
                , "wednesday": ""
                , "thursday": ""
                , "friday": ""
            }]
        });

        $(function () {
            $("#bu1").click(function () {
                var tblRecipeList = tableInfo.config.data;
                var mealtime = $("#mealtime").val();
                var msg = {"tblRecipeList": tblRecipeList, "mealtime": mealtime};
                msg = JSON.stringify(msg);
                if (mealtime == 0) {
                    layer.msg("您好，需要选择日期区间才能保存信息哦！", {icon: 6});
                } else {
                    $.ajax({
                        url: path + "/healther/addMealInfo",
                        async: true,
                        type: "post",
                        data: "TblRecipe=" + msg,
                        datatype: "text",
                        success: function (msg) {
                            if (msg == "success") {
                                layer.alert("添加成功！", {icon: 6}, function (index) {
                                    window.parent.location.reload();
                                });
                            } else if (msg == "notkinder") {
                                layer.msg("您需要登录幼儿园后才能进行此操作！", {icon: 2});
                            } else if (msg == "existMealDate") {
                                layer.msg("已经存在这个日期啦，不能进行添加，请修改！", {icon: 2});
                            } else {
                                layer.msg("添加失败！", {icon: 2});
                            }
                        }, error: function (msg) {
                            layer.msg("网络繁忙！", {icon: 2});
                        }
                    })
                }
            });
        });

        //日期范围
        laydate.render({
            elem: '#mealtime'
            , range: '~'
            , isInitValue: false
            , min: minDate()
            , max: maxDate()
        });

        function minDate() {
            var now = new Date();
            var today = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
            return today;
            // var now = new Date();
            // var nowTime = now.getTime() ;
            // var day = now.getDay();
            // var oneDayTime = 24*60*60*1000 ;
            // var MondayTime = nowTime - (day-1)*oneDayTime ;//显示周一
            // console.log(new Date(MondayTime));
            // return MondayTime;

        }

        function maxDate() {
            // var now = new Date();
            // var day = now.getDay();
            // var fridaydate = new Date((5 - day) * (3600 * 24 * 1000) + now.getTime()).getDate();
            // var friday = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + fridaydate;
            // return friday;

            var now = new Date();
            var nowTime = now.getTime();
            var day = now.getDay();
            var oneDayTime = 24 * 60 * 60 * 1000;
            var SundayTime = nowTime + (5 - day) * oneDayTime;//显示周日
            console.log(new Date(SundayTime));
            return SundayTime;
        }

    });

</script>

</body>
</html>
