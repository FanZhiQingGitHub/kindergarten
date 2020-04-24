<%--
  Created by IntelliJ IDEA.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-新增课程信息</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="text" id="classid" name="classid">

<div class="layui-fluid">
    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 45%">新增课程信息</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-inline" style="margin-left: 25%">
        <label class="layui-form-label">日期范围</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="mealtime" placeholder=" ~ " style="width: 500px">
        </div>
        <span style="color: #ff4400">注意：请选择最近的一整周的日期（星期一到星期日之间）</span>
    </div>

    <table class="layui-hide" id="demo"></table>

    <div class="layui-btn-container" style="margin-left: 46%;margin-top: 1%">
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
        var classid = $("#classid").val();

        //展示已知数据
        var tableInfo = table.render({
            elem: '#demo'
            , cols: [[ //标题栏
                {field: 'coursenum', title: '课节', width: 173, align: 'center'}
                , {field: 'coursename1', title: '周一', width: 200, edit: 'text', align: 'center'}
                , {field: 'coursename2', title: '周二', width: 200, edit: 'text', align: 'center'}
                , {field: 'coursename3', title: '周三', width: 200, edit: 'text', align: 'center'}
                , {field: 'coursename4', title: '周四', width: 200, edit: 'text', align: 'center'}
                , {field: 'coursename5', title: '周五', width: 200, edit: 'text', align: 'center'}
            ]]
            , data: [{
                "coursenum": "1"
                , "coursename1": ""
                , "coursename2": ""
                , "coursename3": ""
                , "coursename4": ""
                , "coursename5": ""
            }, {
                "coursenum": "2"
                , "coursename1": ""
                , "coursename2": ""
                , "coursename3": ""
                , "coursename4": ""
                , "coursename5": ""
            }, {
                "coursenum": "3"
                , "coursename1": ""
                , "coursename2": ""
                , "coursename3": ""
                , "coursename4": ""
                , "coursename5": ""
            }, {
                "coursenum": "4"
                , "coursename1": ""
                , "coursename2": ""
                , "coursename3": ""
                , "coursename4": ""
                , "coursename5": ""
            },{
                "coursenum": "5"
                , "coursename1": ""
                , "coursename2": ""
                , "coursename3": ""
                , "coursename4": ""
                , "coursename5": ""
            }]
        });

        $(function () {
            $("#bu1").click(function () {
                var tblCourseList = tableInfo.config.data;
                var mealtime = $("#mealtime").val();
                // var msg = {"tblRecipeList": tblRecipeList, "mealtime": mealtime};
                // msg = JSON.stringify(msg);
                //对应的选择的日期一周的时间
                var msg = {"tblCourseList": tblCourseList, "mondaydate": mealtime,"cid":classid};
                msg = JSON.stringify(msg);
                if (mealtime == 0) {
                    layer.alert("您好，需要选择日期区间才能保存信息哦！", {icon: 6});
                } else {
                    $.ajax({
                        url: path + "/director/addCourseInfo",
                        async: true,
                        type: "post",
                        data: "TblCourse=" + msg,
                        datatype: "text",
                        success: function (msg) {
                            if (msg == "success") {
                                layer.alert("添加课程成功！", {icon: 6}, function (index) {
                                    window.parent.location.reload();
                                });
                            } else {
                                layer.alert("添加课程失败！", {icon: 2});
                            }
                        }, error: function (msg) {
                            layer.alert("网络繁忙！", {icon: 2});
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
            // , max: maxDate()
        });

        function minDate() {
            var now = new Date();
            return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
        }

        // function maxDate() {
        //     var date = new Date();
        //     // 将字符串转为标准时间格式
        //     var w = date.getDay();//周几
        //     if (w === 0) {
        //         w = 7;
        //     }
        //     var week = Math.ceil((date.getDate() + 6 - w) / 7) - 1;
        //     console.log(week);
        //     return week;
        // }

    });

</script>

</body>
</html>
