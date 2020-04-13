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
    <title>智慧幼儿园-接送管理页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 47.5%">接送信息</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" id="searchTable" style="top:5px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">


                <div class="layui-inline">
                    <label class="layui-form-label">考勤时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="stutimes" placeholder=" ~ " style="width: 200px">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">宝宝名称</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" name="${uStuName}" id="uStuName" autocomplete="off" placeholder="请输入宝宝名称">
                    </div>
                </div>


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


                <button type="button" class="layui-btn layui-btn-normal" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索体检信息</button>

            </div>
        </div>
    </div>


    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal selectPickUpInfo" ><i class="layui-icon">&#xe642;</i>接送信息</button>

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
            ,text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
                none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
            }
            , height: 280
            , url: path + '/security/showPickUpInfo' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'sid', title: '宝宝ID', width: 120,sort: true, fixed: 'left', align: 'center'}
                , {field: 'studentname', title: '宝宝名称', width: 200, align: 'center'}
                , {field: 'studentsex', title: '性别', width: 200, sort: true, align: 'center'}
                , {field: 'classname', title: '所在班级', width: 200, sort: true, align: 'center'}
                , {field: 'teachername', title: '班主任', width: 200, sort: true, align: 'center'}
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
                        key1: $("#stutimes").val(),
                        key2: $("#uStuName").val(),
                        key3: $("#classname").val()

                    }
                });
            }
        });

        //接送信息
        $('body').on('click', '.selectPickUpInfo', function () {
            var path = $("#path").val();
            var studentid = $(this).parents('tr').children('td').eq(0).text();
            var studentname = $(this).parents('tr').children('td').eq(1).text();
            var studentsex = $(this).parents('tr').children('td').eq(2).text();
            var classname = $(this).parents('tr').children('td').eq(3).text();


            layer.open({
                type: 2,
                area: ['80%', '75%'],
                offset: ['10%', '9.5%'],
                title: '宝宝详细接送信息',
                content: path + '/security/path/pickupDetailInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                    body.find("#studentid").val(studentid);
                    body.find("#studentname").val(studentname);
                    body.find("#studentsex").val(studentsex);
                    body.find("#classname").val(classname);
                }
            });
        });

        //日期范围
        laydate.render({
            elem: '#stutimes'
            ,range: '~'
            ,isInitValue: false
        });
    });

</script>

</body>
</html>
