<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-18
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-添加请假信息</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<form class="layui-form" onsubmit="return false;">
    <h1 style="margin-left: 29%">新增请假信息</h1>
    <hr style="color: whitesmoke">


    <div class="layui-form-item">
        <label class="layui-form-label">宝宝名称</label>
        <div class="layui-input-block">
            <input type="text" id="te2" name="studentname" required lay-verify="required" placeholder="请输入宝宝姓名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">家长名称</label>
            <div class="layui-input-inline">
                <input type="text" id="te3" name="parentname" required lay-verify="required" placeholder="请输入家长姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 180px">请假时间段（当日有效）</label>
        <div class="layui-input-block" style="color: black;">
            <input type="radio" name="time" value="上午" title="上午">
            <input type="radio" name="time" value="下午" title="下午">
        </div>
    </div>

    <div class="layui-btn-container" style="margin-left: 38%">
        <button type="button" class="layui-btn layui-btn-normal" lay-submit lay-filter="addInfo">确认请假</button>
    </div>

</form>

<script>

    layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        $ = layui.jquery;

        form.verify({
            required: function (value) {
                if (value.length == 0) {
                    return '您好，这是必填项！';
                }
            },
            studentname: function (value) {
                if (value.length > 4) {
                    return '您好，姓名不得大于4个字！';
                }
            },
            parentname: function (value) {
                if (value.length > 4) {
                    return '您好，姓名不得大于4个字！';
                }
            },
            content: function (value) {
                layedit.sync(editIndex);
            }

        });

        form.on('submit(addInfo)', function (data) {
            var path = $("#path").val();
            var studentname = $("#te2").val();
            var parentname = $("#te3").val();
            var time = $("input[name='time']:checked").val();

            $.ajax({
                url: path + "/parent/addLeaveInfo",
                async: true,
                type: "post",
                data: {"studentname":studentname,"parentname":parentname,"time":time},
                datatype: "text",
                success: function (msg) {
                    if(msg == "success"){
                        layer.alert("请假成功！", {icon: 6},function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);//关闭当前页
                        });
                    }else {
                        layer.alert("请假失败！", {icon: 2},function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);//关闭当前页
                        });
                    }
                }, error: function (msg) {
                    layer.alert("网络繁忙！", {icon: 2},function () {
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);//关闭当前页
                    });
                }
            })
        });
    });

</script>
</body>
</html>
