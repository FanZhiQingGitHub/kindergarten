<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-20
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-直播权限管理</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">直播权限管理</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px;margin-left: 3%">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">

                <div class="layui-inline">
                    <label class="layui-form-label" style="font-size: 16px">幼儿园名称</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" id="kindername" value="${kindername}"
                               style="width: 300px;border: none"
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

                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <p style="width: 700px;height:35px ; margin-top:1% ;text-align: center;font-size: 16px;color: #f37d25">温馨提醒：您可以在配置权限当中新增权限，如果未分配的班级，则默认不会选中任何权限！</p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal updatePowerManager"><i class="layui-icon">&#xe642;</i>配置权限
        </button>

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
            , height: 550
            , url: path + '/security/showClassInfo' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'classid', title: '班级ID', width: 200, fixed: 'left', align: 'center'}
                , {field: 'classname', title: '班级名称', width: 200, align: 'center'}
                , {
                    field: 'classregtime',
                    title: '创建时间',
                    width: 200,
                    align: 'center',
                    templet: "<div>{{layui.util.toDateString(d.classregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"
                }
                , {field: '', title: '操作', toolbar: "#butdiv", width: 200, align: 'center'}
            ]],
        });

        //修改权限管理
        $('body').on('click', '.updatePowerManager', function () {
            var classid = $(this).parents('tr').children('td').eq(0).text();
            var classname = $(this).parents('tr').children('td').eq(1).text();
            layer.open({
                type: 2,
                area: ['420px', '620px'],
                offset: ['8%', '40%'],
                title: '修改直播权限',
                content: path + '/security/path/configurePermissions' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                    body.find("#classid").val(classid);
                    body.find("#classname").val(classname+'家长');
                }
            });
        });
    });

</script>
</body>
</html>
