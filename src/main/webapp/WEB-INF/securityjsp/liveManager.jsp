<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-19
  Time: 18:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-监控直播管理</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">直播管理</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px;margin-left: 20%">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">

                <div class="layui-inline">
                    <label class="layui-form-label" style="font-size: 16px">幼儿园名称</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="kindername" value="${kindername}" style="width: 300px;border: none"
                               readonly>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="font-size: 16px">当前时间：</label>
                    <div class="layui-input-inline">
                        <p id="dateinfo"
                           style="width: 200px;height:35px ; margin-top:4% ;text-align: center;font-size: 16px"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal play"><i class="layui-icon">&#xe652;</i>播放</button>

    </script>


</div>

<script>
    //用户管理数据表格
    layui.use(['table', 'jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();


        function timeTimer() {
            var d = new Date();//实例化日期对象
            var a = d.toLocaleTimeString();//获取日期
            var b = d.toLocaleDateString();//获取时间
            document.getElementById("dateinfo").innerHTML = b + "&nbsp" + "&nbsp" + "&nbsp" + a;//.innerHTML是dom里面的方法（获取对象的内容  或  向对象插入内容，可以直接在网页上显示）
        }//系统时间显示
        setInterval(function () {
            timeTimer()
        }, 1000);//时间显示


        //第一个实例
        table.render({
            elem: '#dataTable'
            , height: 280
            , url: path + '/security/showMonitorInfo' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'monitorid', title: '监控位置ID', width: 200,fixed: 'left', align: 'center'}
                , {field: 'monitorname', title: '监控区域', width: 200, align: 'center'}
                , {field: 'monitorimgurl', title: '监控图片', width: 200, align: 'center',templet:'<div><img src="${pageContext.request.contextPath}/{{d.monitorimgurl}}"></div>'}
                , {field: 'monitormvurl', title: '视频地址', width: 200, align: 'center', hide: 'true'}
                , {field: 'kid', title: '园所ID', width: 200, align: 'center', hide: 'true'}
                , {field: '', title: '操作', toolbar: "#butdiv", width: 200, align: 'center'}
            ]],
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
                        key: $("#classname").val(),
                    }
                });
            }
        });
    });

</script>

</body>
</html>
