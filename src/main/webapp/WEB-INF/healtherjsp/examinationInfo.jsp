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
    <title>智慧幼儿园-</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">

<div class="layui-fluid">
    <!-- 增加搜索条件 -->
    <div class="layui-fluid" id="searchTable" style="top:5px">

        <div class="layui-inline">
            <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                <label class="layui-form-label">班级名称：</label>
                <div class="layui-input-block">
                    <select name="class" id="classname" >
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

        <button type="button" class="layui-btn" data-type="reload">搜索</button>
    </div>



    <table id="dataTable" lay-filter="test"></table>

    <script type="text/html" id="butdiv">

        <button class="layui-btn layui-btn-sm layui-btn-normal update">编辑</button>

    </script>


</div>

<script>
    //用户管理数据表格
    layui.use(['table', 'jquery','layer'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var path = $("#path").val();
        //第一个实例
        table.render({
            elem: '#dataTable'
            ,text: { //自定义文本，此处用法--》当返回数据为空时的异常提示
                none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
            }
            , height: 280
            , url: path + '/healther/showALLExamination' //数据接口
            , page: true //开启分页
            , id: 'searchTable'
            , limit: 5
            , limits: [5, 10, 15, 20]
            , cols: [[ //表头
                {field: 'studentid', title: '宝宝ID', width: 120, sort: true, fixed: 'left', align: 'center'}
                , {field: 'studentname', title: '宝宝名称', width: 120, align: 'center'}
                , {field: 'height', title: '身高', width: 120, sort: true, align: 'center'}
                , {field: 'weight', title: '体重', width: 120, sort: true, align: 'center'}
                , {field: 'vision', title: '视力', width: 120, sort: true, align: 'center'}
                , {field: 'temperature', title: '体温', width: 160, align: 'center'}
                , {field: 'healthstatus', title: '健康状况', width: 180, sort: true, align: 'center'}
                , {field: 'examinationtime', title: '体检时间', width: 180, sort: true, align: 'center',templet:"<div>{{layui.util.toDateString(d.kinderregtime,'yyyy-MM-dd HH:mm:ss')}}</div>"}
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
            var userid = $(this).parents('tr').children('td').eq(0).text();
            var username = $(this).parents('tr').children('td').eq(1).text();
            var userphone = $(this).parents('tr').children('td').eq(5).text();
            var useremail = $(this).parents('tr').children('td').eq(6).text();
            layer.open({
                type: 2,
                area: ['400px', '500px'],
                offset: ['120px', '650px'],
                title: '修改用户信息',
                btn: ['确定', '取消'],
                btnAlign: 'c',
                btn1: function (index, layero) {
                    //layer.getChildFrame("form", index)获取iframe的表单
                    //serializeArray jquery方法，将表单对象序列化为数组

                    layer.confirm('您确定要修改该用户信息吗?', {icon: 3, title:'提示'},function(index){
                        var formData = serializeObject($, layer.getChildFrame("form", index).serializeArray());
                        $.ajax({
                            url: path + '/user/updateUserInfo',
                            async:true,
                            type: 'post',
                            data: formData,
                            datatype:'text',
                            success: function (data) {
                                if (data == "error") {
                                    layer.alert("修改失败！",{icon:2});
                                } else {
                                    layer.close(index);
                                    layer.alert("修改成功", {icon: 6}, function () {
                                        window.parent.location.reload();
                                    });
                                }

                            }, error: function (data) {
                                layer.alert("网络繁忙！", {icon: 2});
                            }
                        });
                        layer.close(index);
                    });

                },
                content: path + '/user/usermag' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                    body.find("#te0").val(userid);
                    body.find("#te1").val(username);
                    body.find("#te2").val(userphone);
                    body.find("#te3").val(useremail);
                }
            });
        });

    });


    //将表单转为js对象数据
    function serializeObject($, array) {
        var obj = new Object();
        $.each(array, function (index, param) {
            if (!(param.name in obj)) {
                obj[param.name] = param.value;
            }
        });
        return obj;
    };

</script>

</body>
</html>
