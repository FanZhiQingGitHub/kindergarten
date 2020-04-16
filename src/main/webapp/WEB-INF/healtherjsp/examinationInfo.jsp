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
    <title>智慧幼儿园-体检信息页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 43%">体检管理</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">
                <div class="layui-inline">
                    <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                        <label class="layui-form-label">班级名称：</label>
                        <div class="layui-input-block">
                            <select name="class" id="classname" style="width:160px;height: 5.3%">
                                <option value="请选择">请选择</option>
                                <c:if test="${not empty tblClassList}">
                                    <c:forEach items="${tblClassList}" var="i" step="1">
                                        <option value="${i.classname}">${i.classname}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
                    </div>
                </div>


                <button type="button" class="layui-btn layui-btn-normal" data-type="reload"><i class="layui-icon">&#xe615;</i>查询体检信息
                </button>
                <button type="button" class="layui-btn add"><i class="layui-icon">&#xe654;</i>新增体检信息</button>
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
    layui.use(['table', 'jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();
        //第一个实例
        table.render({
            elem: '#dataTable'
            , height: 280
            , url: path + '/healther/showALLExamination' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'examinationid', title: '体检ID', width: 120, align: 'center', hide: 'true'}
                , {field: 'studentid', title: '宝宝ID', width: 120, sort: true, fixed: 'left', align: 'center'}
                , {field: 'studentname', title: '宝宝名称', width: 120, align: 'center'}
                , {field: 'height', title: '身高', width: 120, sort: true, align: 'center'}
                , {field: 'weight', title: '体重', width: 120, sort: true, align: 'center'}
                , {field: 'vision', title: '视力', width: 120, sort: true, align: 'center'}
                , {field: 'temperature', title: '体温', width: 160, sort: true, align: 'center'}
                , {field: 'skin', title: '皮肤状况', width: 160, sort: true, align: 'center'}
                , {field: 'healthstatus', title: '健康状况', width: 180, sort: true, align: 'center'}
                , {
                    field: 'examinationtime',
                    title: '体检时间',
                    width: 180,
                    sort: true,
                    align: 'center',
                    templet: "<div>{{layui.util.toDateString(d.examinationtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
                }
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

        //编辑
        $('body').on('click', '.update', function () {
            var path = $("#path").val();
            var examinationid = $(this).parents('tr').children('td').eq(0).text();
            var studentid = $(this).parents('tr').children('td').eq(1).text();
            var studentname = $(this).parents('tr').children('td').eq(2).text();
            var height = $(this).parents('tr').children('td').eq(3).text();
            var weight = $(this).parents('tr').children('td').eq(4).text();
            var vision = $(this).parents('tr').children('td').eq(5).text();
            var temperature = $(this).parents('tr').children('td').eq(6).text();
            var skin = $(this).parents('tr').children('td').eq(7).text();
            var healthstatus = $(this).parents('tr').children('td').eq(8).text();

            layer.open({
                type: 2,
                area: ['400px', '580px'],
                offset: ['50px', '650px'],
                title: '修改体检信息',
                content: path + '/healther/path/examinationUpdate' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                    body.find("#te0").val(examinationid);
                    body.find("#te1").val(studentid);
                    body.find("#te2").val(studentname);
                    body.find("#te3").val(height);
                    body.find("#te4").val(weight);
                    body.find("#te5").val(vision);
                    body.find("#te6").val(temperature);
                    body.find("#te7").val(skin);
                    body.find("#te8").val(healthstatus);
                }
            });
        });

        //新增
        $('body').on('click', '.add', function () {
            var path = $("#path").val();
            layer.open({
                type: 2,
                area: ['400px', '610px'],
                offset: ['50px', '650px'],
                title: '新增体检信息',
                content: path + '/healther/path/addExamination' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                }
            });
        });
    });

</script>

</body>
</html>
