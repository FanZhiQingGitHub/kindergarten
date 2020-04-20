<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-15
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-报警日志页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 48%">报警日志</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">
                <label class="layui-form-label">查询条件</label>
                <div class="layui-inline">
                    <label class="layui-form-label">报警时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="alarmtime" placeholder=" ~ " style="width: 200px">
                    </div>
                </div>

                <button type="button" class="layui-btn layui-btn-normal" data-type="reload"><i class="layui-icon">&#xe615;</i>查询体检信息
                </button>
            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>


</div>

<script>

    layui.use(['table', 'jquery', 'layer', 'form', 'laydate'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var laydate = layui.laydate;
        var path = $("#path").val();
        //第一个实例
        table.render({
            elem: '#dataTable'
            , height: 550
            , url: path + '/security/showAlarmInfo' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'alarmlogid', title: '日志编号', width: 120, sort: true, fixed: 'left', align: 'center'}
                , {field: 'alarmlogname', title: '日志名称', width: 200, align: 'center'}
                , {field: 'studentname', title: '宝宝名称', width: 200, sort: true, align: 'center'}
                , {field: 'alarmlogarea', title: '报警区域', width: 200, sort: true, align: 'center'}
                , {
                    field: 'alarmlogtime',
                    title: '报警时间',
                    width: 200,
                    sort: true,
                    align: 'center',
                    templet: "<div>{{layui.util.toDateString(d.alarmlogtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
                }
            ]]
        });

        $('#searchTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            if (type == 'reload') {
                //执行重载
                table.reload('searchTable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        key1: $("#alarmtime").val(),
                    }
                });
            }
        });

        //日期范围
        laydate.render({
            elem: '#alarmtime'
            , range: '~'
            , isInitValue: false
        });
    });


</script>


</body>
</html>
