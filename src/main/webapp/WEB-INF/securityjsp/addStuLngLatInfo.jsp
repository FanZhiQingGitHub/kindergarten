<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-19
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-新增宝宝运动轨迹</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>

<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="kinder" value="${kindername}">

<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">新增宝宝运动轨迹</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>
    <div class="layui-fluid" style="margin-left: 5.5%">
        <div class="layui-inline">
            <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                <label class="layui-form-label">宝宝名称：</label>
                <div class="layui-input-block">
                    <select name="stuname" id="stuname" style="width:200px;height: 35px"></select>
                </div>
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-normal " id="bu1" style="margin-left: 3%">确认新增</button>
        <p style="color: red;position: absolute;margin-left: 35%;margin-top: -3%">
            温馨提醒：由于轨迹数据为默认数据，请修改后添加；修改时请尽量修改小数点最后两位数，以免超出地图范围，谢谢！</p>
    </div>

    <table class="layui-hide" id="layui_table"></table>

</div>

<script>

    layui.use(['table', 'jquery', 'layer'], function () {
        $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var path = $("#path").val();

        //1、查出宝宝名称下拉框的值
        $.ajax({
            url: path + '/security/findAllStuInfo',
            async: true,
            type: 'post',
            datatype: 'text',
            success: function (data) {
                if (data == "error") {
                    layer.msg("暂无宝宝信息！", {icon: 2});
                } else {
                    var kindername = $("#kinder").val();
                    if (kindername.length == 0) {
                        // layer.msg('对不起，您必须登录幼儿园账号才可以进行此操作！', {icon: 2});
                        var option;
                        option += "<option value='请选择'>" + "您需要登录幼儿园账号显示" + "</option>";
                        $("#stuname").html(option);
                        $("#stuname").show();
                    } else {
                        var stuinfo = JSON.parse(data);
                        var option;
                        option += "<option value='请选择'>" + "请选择宝宝名称" + "</option>";
                        for (var i in stuinfo) {
                            option += "<option value='" + stuinfo[i].studentid + "&" + stuinfo[i].studentname + "&" + stuinfo[i].studentbrith + "'>" + stuinfo[i].studentname + "</option>";
                        }
                        $("#stuname").html(option);
                        $("#stuname").show();
                    }
                }
            }, error: function (data) {
                layer.alert("网络繁忙！", {icon: 2});
            }
        });


        var tblDefaultrackList;
        table.render({
            elem: '#layui_table'
            , url: path + '/security/findDefaultLngLatInfo' //数据接口
            , cols: [[ //表头
                {field: 'detrackid', title: '坐标ID', width: 130, align: 'center'}
                , {field: 'lng', title: '当前经度（Y）', width: 158, edit: 'text', align: 'center'}
                , {field: 'lat', title: '当前纬度（X）', width: 250, edit: 'text', align: 'center'}
            ]]
            , done: function (res, curr, count) {
                tblDefaultrackList = res.data;
            }
        });


        $(function () {
            $("#bu1").click(function () {
                var info = $("#stuname").val();
                if (info == "请选择") {
                    layer.msg("请选择宝宝名称后进行添加", {icon: 6});
                } else {
                    var studentid = info.split("&")[0];
                    layer.confirm('您确定要新增吗?', {icon: 3, title: '提示'}, function (index) {
                        if (tblDefaultrackList.length == 0) {
                            layer.msg("您必须添加相应数据！", {icon: 2});
                        } else {
                            var msg = {"tblDefaultrackList": tblDefaultrackList, "studentid": studentid};
                            msg = JSON.stringify(msg);
                            $.ajax({
                                url: path + "/security/addStuTrack",
                                async: true,
                                type: "post",
                                data: "TblDefaultrack=" + msg,
                                datatype: "text",
                                success: function (msg) {
                                    if (msg == "success") {
                                        layer.alert("新增成功！", {icon: 6}, function (index) {
                                            window.parent.location.reload();
                                            layer.close(index);
                                        });
                                    } else if (msg == "exist") {
                                        layer.msg("该宝宝已存在运动轨迹！", {icon: 6});
                                    } else {
                                        layer.msg("新增失败！", {icon: 2});
                                    }
                                }, error: function (msg) {
                                    layer.msg("网络繁忙！", {icon: 2});
                                }
                            })
                        }
                    });
                }
            });
        })
    });
</script>
</body>
</html>
