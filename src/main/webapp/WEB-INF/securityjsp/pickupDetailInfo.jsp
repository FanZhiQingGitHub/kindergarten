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
<input type="hidden" id="studentid">
<input type="hidden" id="start" value="1">
<input type="hidden" id="end" value="7">

<div class="layui-fluid">


    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 43%">宝宝详细接送信息</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" style="margin-left: 19%">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝名称</label>
            <div class="layui-input-inline">
                <input class="layui-input" id="studentname" autocomplete="off" placeholder="请输入宝宝名称" readonly>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">宝宝性别</label>
            <div class="layui-input-inline">
                <input class="layui-input" id="studentsex" autocomplete="off" placeholder="请输入宝宝名称" readonly>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">所在班级</label>
            <div class="layui-input-inline">
                <input class="layui-input" id="classname" autocomplete="off" placeholder="请输入宝宝名称" readonly>
            </div>
        </div>
    </div>

    <div class="layui-fluid" id="searchTable" style="margin-left:33%;top:15px">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <div style="padding-bottom: 10px;">
                <button type="button" class="layui-btn layui-btn-normal" id="reload1" style="width: 200px"><i
                        class="layui-icon">&#xe615;</i>上一周
                </button>
                <button type="button" class="layui-btn layui-btn-normal" id="reload2" style="width: 200px;"><i
                        class="layui-icon">&#xe615;</i>下一周
                </button>
            </div>
        </div>
    </div>


    <table class="layui-table" id="ta1">
        <thead id="thd">
        </thead>
        <tbody id="tbo">
        </tbody>
    </table>


</div>

<script>

    layui.use(['jquery', 'layer', 'table', 'laydate'], function () {
        var form = layui.form, $ = layui.$, table = layui.table, laydate = layui.laydate,layer = layui.layer;
        var sid = $("#studentid").val();
        var path = $("#path").val();

        //上一周
        $(function () {
            $("#reload1").click(function () {
                var mondaydate;//1
                var sundaydate;//7
                //上周
                mondaydate = $("#start").val();//1
                sundaydate = $("#end").val();//7
                mondaydate -= parseInt(7);
                sundaydate -= parseInt(7);
                $("#start").val(mondaydate);
                $("#end").val(sundaydate);

                var studentid = $("#studentid").val();
                var startdate = $("#start").val();
                var enddate = $("#end").val();

                $.ajax({
                    url: path + '/security/showPickUpDetailInfo',
                    async: true,
                    type: 'post',
                    data: {'studentid': studentid,'startdate':startdate,'enddate':enddate},
                    datatype: 'text',
                    success:function (msg) {
                        if(msg == "error"){
                            //删除所有tr节点
                            var table = document.getElementById("tbo");
                            var rowNum = table.rows.length;
                            if (rowNum > 0) {
                                for (i = 0; i < rowNum; i++) {
                                    table.deleteRow(i);
                                    rowNum = rowNum - 1;
                                    i = i - 1;
                                }
                                var erroroption;
                                erroroption +="<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
                                $("#tbo").html(erroroption);
                                $("#tbo").show();
                            }

                            var table1 = document.getElementById("thd");
                            var rowNum1 = table1.rows.length;
                            if (rowNum1 > 0) {
                                for (i = 0; i < rowNum1; i++) {
                                    table1.deleteRow(i);
                                    rowNum1 = rowNum1 - 1;
                                    i = i - 1;
                                }
                            }
                        }else {
                            layer.msg('查询成功');
                            var info = JSON.parse(msg);
                            var option;
                            var tblhead;

                            //------------------------表头--------------------------------------------
                            tblhead += "<tr><th style='text-align: center'>项目</th>";
                            for (var j in info) {
                                tblhead += "<th style='text-align: center'>" + info[j].weekinfo + "</td>"
                            }
                            $("#thd").html(tblhead);
                            $("#thd").show();


                            //--------------------------上午接送信息------------------------------------
                            option += "<tr><td style='text-align: center'>日期</td>";
                            for (var j in info) {
                                option += "<td style='text-align: center'>" + info[j].timeamdate + "</td>"
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>上午</td>";
                            for (var j in info) {
                                if (info[j].timeam > '08:30') {
                                    option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timeam + "</td>"
                                } else if (info[j].timeam == '请假') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timeam + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].timeam + "</td>"
                                }
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>接送人</td>";
                            for (var j in info) {
                                if (info[j].pnameam == '无') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnameam + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].pnameam + "</td>"
                                }
                            }
                            option += "</tr>";


                            //--------------------------下午接送信息------------------------------------

                            option += "<tr><td style='text-align: center'>下午</td>";
                            for (var j in info) {
                                if (info[j].timepm < '17:30') {
                                    option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timepm + "</td>"
                                } else if (info[j].timepm == '请假') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timepm + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].timepm + "</td>"
                                }
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>接送人</td>";
                            for (var j in info) {
                                if (info[j].pnamepm == '无') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnamepm + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].pnamepm + "</td>"
                                }
                            }
                            option += "</tr>";
                            $("#tbo").html(option);
                            $("#tbo").show();
                        }
                    },error:function () {
                        layer.msg('网络繁忙');
                    }
                });
            })
        });

        //下一周
        $(function () {
            $("#reload2").click(function () {
                var mondaydate;//1
                var sundaydate;//7
                //下周
                var start = $("#start").val();
                var end = $("#end").val();
                mondaydate = parseInt(start) + 7;
                sundaydate = parseInt(end) + 7;

                $("#start").val(mondaydate);
                $("#end").val(sundaydate);

                var studentid = $("#studentid").val();
                var startdate = $("#start").val();
                var enddate = $("#end").val();

                $.ajax({
                    url: path + '/security/showPickUpDetailInfo',
                    async: true,
                    type: 'post',
                    data: {'studentid': studentid,'startdate':startdate,'enddate':enddate},
                    datatype: 'text',
                    success:function (msg) {
                        if(msg == "error"){
                            //删除所有tr节点
                            var table = document.getElementById("tbo");
                            var rowNum = table.rows.length;
                            if (rowNum > 0) {
                                for (i = 0; i < rowNum; i++) {
                                    table.deleteRow(i);
                                    rowNum = rowNum - 1;
                                    i = i - 1;
                                }
                                var erroroption;
                                erroroption +="<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
                                $("#tbo").html(erroroption);
                                $("#tbo").show();
                            }

                            var table1 = document.getElementById("thd");
                            var rowNum1 = table1.rows.length;
                            if (rowNum1 > 0) {
                                for (i = 0; i < rowNum1; i++) {
                                    table1.deleteRow(i);
                                    rowNum1 = rowNum1 - 1;
                                    i = i - 1;
                                }
                            }
                        }else {
                            layer.msg('查询成功');
                            var info = JSON.parse(msg);
                            var option;
                            var tblhead;

                            //------------------------表头--------------------------------------------
                            tblhead += "<tr><th style='text-align: center'>项目</th>";
                            for (var j in info) {
                                tblhead += "<th style='text-align: center'>" + info[j].weekinfo + "</td>"
                            }
                            $("#thd").html(tblhead);
                            $("#thd").show();
                            //--------------------------上午接送信息------------------------------------
                            option += "<tr><td style='text-align: center'>日期</td>";
                            for (var j in info) {
                                option += "<td style='text-align: center'>" + info[j].timeamdate + "</td>"
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>上午</td>";
                            for (var j in info) {
                                if (info[j].timeam > '08:30') {
                                    option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timeam + "</td>"
                                } else if (info[j].timeam == '请假') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timeam + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].timeam + "</td>"
                                }
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>接送人</td>";
                            for (var j in info) {
                                if (info[j].pnameam == '无') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnameam + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].pnameam + "</td>"
                                }
                            }
                            option += "</tr>";


                            //--------------------------下午接送信息------------------------------------

                            option += "<tr><td style='text-align: center'>下午</td>";
                            for (var j in info) {
                                if (info[j].timepm < '17:30') {
                                    option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timepm + "</td>"
                                } else if (info[j].timepm == '请假') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timepm + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].timepm + "</td>"
                                }
                            }
                            option += "</tr>";

                            option += "<tr><td style='text-align: center'>接送人</td>";
                            for (var j in info) {
                                if (info[j].pnamepm == '无') {
                                    option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnamepm + "</td>"
                                } else {
                                    option += "<td style='text-align: center'>" + info[j].pnamepm + "</td>"
                                }
                            }
                            option += "</tr>";
                            $("#tbo").html(option);
                            $("#tbo").show();
                        }
                    },error:function () {
                        layer.msg('网络繁忙');
                    }
                });

            })
        });


        //默认显示本周
        $.ajax({
            url: path + '/security/showPickUpDetailInfo',
            async: true,
            type: 'post',
            data: {'sid': sid},
            datatype: 'text',
            success: function (msg) {
                if(msg == "error"){
                    var erroroption;
                    erroroption +="<tr><td style='text-align: center' colspan='6'>亲，目前暂无数据</td>";
                    $("#tbo").html(erroroption);
                    $("#tbo").show();

                    var table1 = document.getElementById("thd");
                    var rowNum1 = table1.rows.length;
                    if (rowNum1 > 0) {
                        for (i = 0; i < rowNum1; i++) {
                            table1.deleteRow(i);
                            rowNum1 = rowNum1 - 1;
                            i = i - 1;
                        }
                    }
                }else {
                    var info = JSON.parse(msg);
                    var option;
                    var tblhead;

                    //------------------------表头--------------------------------------------
                    tblhead += "<tr><th style='text-align: center'>项目</th>";
                    for (var j in info) {
                        tblhead += "<th style='text-align: center'>" + info[j].weekinfo + "</td>"
                    }
                    $("#thd").html(tblhead);
                    $("#thd").show();
                    //--------------------------上午接送信息------------------------------------
                    option += "<tr><td style='text-align: center'>日期</td>";
                    for (var j in info) {
                        option += "<td style='text-align: center'>" + info[j].timeamdate + "</td>"
                    }
                    option += "</tr>";

                    option += "<tr><td style='text-align: center'>上午</td>";
                    for (var j in info) {
                        if (info[j].timeam > '08:30') {
                            option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timeam + "</td>"
                        } else if (info[j].timeam == '请假') {
                            option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timeam + "</td>"
                        } else {
                            option += "<td style='text-align: center'>" + info[j].timeam + "</td>"
                        }
                    }
                    option += "</tr>";

                    option += "<tr><td style='text-align: center'>接送人</td>";
                    for (var j in info) {
                        if (info[j].pnameam == '无') {
                            option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnameam + "</td>"
                        } else {
                            option += "<td style='text-align: center'>" + info[j].pnameam + "</td>"
                        }
                    }
                    option += "</tr>";


                    //--------------------------下午接送信息------------------------------------

                    option += "<tr><td style='text-align: center'>下午</td>";
                    for (var j in info) {
                        if (info[j].timepm < '17:30') {
                            option += "<td bgcolor='yellow' style='text-align: center'>" + info[j].timepm + "</td>"
                        } else if (info[j].timepm == '请假') {
                            option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].timepm + "</td>"
                        } else {
                            option += "<td style='text-align: center'>" + info[j].timepm + "</td>"
                        }
                    }
                    option += "</tr>";

                    option += "<tr><td style='text-align: center'>接送人</td>";
                    for (var j in info) {
                        if (info[j].pnamepm == '无') {
                            option += "<td bgcolor='darkturquoise' style='text-align: center'>" + info[j].pnamepm + "</td>"
                        } else {
                            option += "<td style='text-align: center'>" + info[j].pnamepm + "</td>"
                        }
                    }
                    option += "</tr>";
                    $("#tbo").html(option);
                    $("#tbo").show();
                }
            }, error: function (data) {
                layer.alert("网络繁忙！", {icon: 2});
            }
        })

    });

</script>

</body>
</html>
