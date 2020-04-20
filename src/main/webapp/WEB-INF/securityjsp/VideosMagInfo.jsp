<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-8
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>智慧幼儿园-视频管理界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 47.5%">视频管理</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px">
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
                    <label class="layui-form-label">视频时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="videotimes" placeholder=" ~ " style="width: 200px">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">视频名称</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" name="${videoName}" id="videoName" autocomplete="off" placeholder="请输入视频名称">
                    </div>
                </div>


                <button type="button" class="layui-btn layui-btn-normal" data-type="reload"><i class="layui-icon">&#xe615;</i>查询视频信息</button>

            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal play"><i class="layui-icon">&#xe652;</i>播放视频</button>

    </script>


</div>

<script>
    //用户管理数据表格
    layui.use(['table', 'jquery','layer','form','laydate'], function () {
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
            , url: path + '/security/showMonitorInfoMag' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'monitorid', title: '视频编号', width: 120,sort: true, fixed: 'left', align: 'center'}
                , {field: 'monitormvname', title: '视频名称', width: 200, align: 'center'}
                , {field: 'monitorname', title: '监控位置', width: 200, align: 'center'}
                , {field: 'monitormvtime', title: '视频日期', width: 200, sort: true, align: 'center',templet: "<div>{{layui.util.toDateString(d.monitormvtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
                , {field: 'monitormvurl', title: '视频路径', width: 200, sort: true, align: 'center',hide:'true'}
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
                        key1: $("#videotimes").val(),
                        key2: $("#videoName").val(),
                    }
                });
            }
        });

        //打开监控视频
        $('body').on('click', '.play', function () {
            var monitorname = $(this).parents('tr').children('td').eq(1).text();
            var videoUrl = $(this).parents('tr').children('td').eq(4).text();
            layer.open({
                //打开一个窗口播放视频
                type: 1,
                area: ['100%', '100%'],
                offset:['0%','0%'],
                title:monitorname,
                content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop">' +
                    '<source src="${pageContext.request.contextPath}/'+videoUrl+'" type="video/mp4"></source></video>'
                //直接跳出一个标签播放视频
            });
        });

        //日期范围
        laydate.render({
            elem: '#videotimes'
            ,range: '~'
            ,isInitValue: false
        });
    });

</script>

</body>
</html>
