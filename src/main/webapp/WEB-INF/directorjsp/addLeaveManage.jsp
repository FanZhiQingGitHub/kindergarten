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
    <h1 style="margin-left: 29%">新增请假信息</h1>
    <hr style="color: whitesmoke">

    <div class="layui-fluid">

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">请假日期</label>
                <div class="layui-input-block"> <!-- 注意：这一层元素并不是必须的 -->
                    <input type="text" id="te3" class="layui-input" style="width: 220px">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 150px">时间段（当日有效）</label>
            <div class="layui-input-block" style="color: black;width: 180px">
                <input type="radio" name="time" value="上午" title="上午" checked>上午
                <input type="radio" name="time" value="下午" title="下午">下午
            </div>
        </div>

        <div class="layui-btn-container" style="margin-left: 38%">
            <button type="button" class="layui-btn layui-btn-normal" id="addInfo">确认请假</button>
        </div>
    </div>

<script>

    layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        $ = layui.jquery;
        var path = $("#path").val();


        laydate.render({
            elem: '#te3' //指定元素
            , min: minDate()
        });

        function minDate() {
            var now = new Date();
            return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
        }

        // //1、查出宝宝名称下拉框的值
        // $.ajax({
        //     url: path + '/parent/findAllStuInfo',
        //     async: true,
        //     type: 'post',
        //     datatype: 'text',
        //     success: function (data) {
        //         if (data == "error") {
        //             layer.msg("暂无宝宝信息！", {icon: 2});
        //         } else {
        //             var stuinfo = JSON.parse(data);
        //             var option;
        //             option += "<option value='请选择'>" + "请选择宝宝名称" + "</option>";
        //             for (var i in stuinfo) {
        //                 option += "<option value='" + stuinfo[i].studentid+ "'>" + stuinfo[i].studentname + "</option>";
        //             }
        //             $("#te1").html(option);
        //             $("#te1").show();
        //         }
        //     }, error: function (data) {
        //         layer.msg("网络繁忙！", {icon: 2});
        //     }
        // });


        $(function () {
           $("#addInfo").click(function () {
               // var studentid = $("#te1").val();
               // var parentname = $("#te2").val();
               var leaveDate = $("#te3").val();
               var time = $("input[name='time']:checked").val();

               if(leaveDate.length == 0){
                   layer.msg("请选择请假日期！", {icon: 6});
               }else {
                   $.ajax({
                       url: path + "/director/addLeaveManage",
                       async: true,
                       type: "post",
                       data: {"time": time, "leaveDate": leaveDate},
                       datatype: "text",
                       success: function (msg) {
                           if (msg == "success") {
                               layer.alert("请假成功！", {icon: 6}, function () {
                                   var index = parent.layer.getFrameIndex(window.name);
                                   parent.layer.close(index);//关闭当前页
                               });
                           } else if (msg == "notadd") {
                               layer.msg("今天是周末哦！", {icon: 6}, function () {
                                   var index = parent.layer.getFrameIndex(window.name);
                                   parent.layer.close(index);//关闭当前页
                               });
                           } else {
                               layer.msg("请假失败！", {icon: 2}, function () {
                                   var index = parent.layer.getFrameIndex(window.name);
                                   parent.layer.close(index);//关闭当前页
                               });
                           }
                       }, error: function (msg) {
                           layer.msg("网络繁忙！", {icon: 2}, function () {
                               var index = parent.layer.getFrameIndex(window.name);
                               parent.layer.close(index);//关闭当前页
                           });
                       }
                   })
               }
           });
        });
    });

</script>
</body>
</html>
