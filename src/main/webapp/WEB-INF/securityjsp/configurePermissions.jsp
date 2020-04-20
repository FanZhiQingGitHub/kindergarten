<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-20
  Time: 12:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>智慧幼儿园-配置权限页面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html, body {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="classid" value="">
<div class="layui-fluid">
    <div class="layui-inline" style="margin-top: 1%">
        <label class="layui-form-label" style="font-size: 16px;">角色名称</label>
        <div class="layui-input-inline">
            <input class="layui-input" id="classname" readonly style="width: 220px;height: 35px;font-size: 15px">
        </div>
    </div>

    <div class="layui-btn-container">
        <button type="button" class="layui-btn layui-btn-radius showTree"
                style="margin-left: 20%;margin-top: 3%">
            显示所有监控
        </button>
        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary confirm" style="margin-top: 3%;"
                id="bu1" disabled="true">确定监控配置
        </button>
        <hr style="color: whitesmoke">
    </div>

    <div id="menuTree" class="demo-tree-more"></div>
</div>
<script>
    layui.use(['tree', 'util', 'jquery', 'layer', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate
            , tree = layui.tree;
        $ = layui.jquery;
        var path = $("#path").val();
        var classid = null;
        $('body').on('click', '.showTree', function () {
            classid = $("#classid").val();
            var MenuId = [];
            $.ajax({
                url: path + '/security/findAllMonitorCP',
                async: true,
                type: 'post',
                data: {'classid': classid},
                success: function (data) {
                    if (data == "error") {
                        layer.alert("菜单信息异常！", {icon: 2});
                    } else {

                        //基本演示
                        tree.render({
                            elem: '#menuTree'
                            , data: data["menu"]
                            , showCheckbox: true  //是否显示复选框
                            , showLine: false
                            , id: 'checkId'
                            , checked: false
                        });

                        for (var i = 0; i < data["mid"].length; i++) {
                            MenuId.push(data["mid"][i].id);
                        }

                        tree.setChecked('checkId', MenuId); //批量勾选节点
                        $("#bu1").css("background", "darkorange");
                        $("#bu1").css("color", "white");
                        $("#bu1").attr("disabled", false);
                    }
                }, error: function (data) {
                    layer.alert("网络繁忙！", {icon: 2});
                }
            });
        });

        $('body').on('click', '.confirm', function () {
            var checkData = tree.getChecked('checkId');
            var tblMonitornameList = [];

            for (var i = 0; i < checkData.length; i++) {
                tblMonitornameList.push(checkData[i].id);
            }
            layer.confirm('您确定要修改吗?', {icon: 3, title: '提示'}, function (index) {
                if (0 != tblMonitornameList.length) {
                    var msg = {'tblMonitornameList': tblMonitornameList,'classid': classid};
                    msg = JSON.stringify(msg);
                    $.ajax({
                        url: path + '/security/updateMonitorCP',
                        async: true,
                        type: 'post',
                        data: 'TblMonitorname=' + msg,
                        datatype: 'text',
                        success: function (data) {
                            if (data == "success") {
                                layer.alert("直播权限配置成功！", {icon: 6}, function (index) {
                                    layer.close(index);
                                    window.parent.location.reload();
                                    parent.layer.close(index);
                                });

                            } else {
                                layer.alert("直播权限配置失败！", {icon: 2}, function (index) {
                                    layer.close(index);
                                });
                            }
                        }, error: function (data) {
                            layer.alert("网络异常！", {icon: 2}, function (index) {
                                layer.close(index);
                            });
                        }
                    })
                }else {
                    layer.msg('您没有选中任何区域的直播监控！',{icon:3});
                }
            });
        });

    });
</script>

</body>
</html>
