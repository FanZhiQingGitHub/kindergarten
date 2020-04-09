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
    <title>智慧幼儿园-膳食信息页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 48%">膳食管理</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">

                <button type="button" class="layui-btn add"><i class="layui-icon">&#xe654;</i>新增膳食信息</button>
            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal update"><i class="layui-icon">&#xe642;</i>编辑</button>

    </script>




</div>

<script>
    //用户管理数据表格
    layui.use(['table', 'jquery','layer','form'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();
        //第一个实例
        table.render({
            elem: '#dataTable'
            ,text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
                none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
            }
            , height: 280
            , url: path + '/healther/showAllMealInfo' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'mealid', title: '膳食编号', width: 200, align: 'center'}
                , {field: 'mealstarttime', title: '起始时间', width: 300, align: 'center',templet:"<div>{{layui.util.toDateString(d.mealstarttime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
                , {field: 'mealendtime', title: '结束时间', width: 300, align: 'center',templet:"<div>{{layui.util.toDateString(d.mealendtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
                , {field: '', title: '操作', toolbar: "#butdiv", width: 200, align: 'center'}
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
                        key: $("#classname").val(),
                    }
                });
            }
        });

        //编辑
        $('body').on('click', '.update', function () {
            var path = $("#path").val();
            var mealid = $(this).parents('tr').children('td').eq(0).text();
            layer.open({
                type: 2,
                area: ['80%', '68%'],
                offset: ['10%', '9.5%'],
                title: '修改膳食信息',
                content: path + '/healther/path/mealUpdate' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                    body.find("#mealid").val(mealid);
                }
            });
        });

        //新增
        $('body').on('click', '.add', function () {
            var path = $("#path").val();
            layer.open({
                type: 2,
                area: ['80%', '68%'],
                offset: ['10%', '9.5%'],
                title: '新增食谱信息',
                content: path + '/healther/path/addMeal' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                }
            });
        });
    });

</script>

</body>
</html>
