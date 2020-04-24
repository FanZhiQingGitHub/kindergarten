<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-12
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具"/>
    <meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图"/>

    <title>智慧幼儿园-电子围栏主页</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>

    <!--引用百度地图API-->
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=Q9U1Y53LM1WDwF2qNUYAraf9qEbQ7w58"></script>
    <!--加载计算工具-->
    <script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>


    <script type="text/javascript"
            src="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css"/>
    <!--加载检索信息窗口-->
    <script type="text/javascript"
            src="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css"/>

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="kinder" value="${kindername}">


<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">电子围栏</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" style="margin-left: 5.5%">

        <div class="layui-inline">
            <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                <label class="layui-form-label">宝宝名称：</label>
                <div class="layui-input-block">
                    <select name="stuname" id="stuname" style="width:200px;height: 5.3%"></select>
                </div>
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label" style="font-size: 16px;">幼儿园名称</label>
            <div class="layui-input-inline">
                <input class="layui-input" id="kindername" value="${kindername}" style="width: 250px"
                       readonly>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="font-size: 16px;">当前时间：</label>
            <div class="layui-input-inline">
                <p id="dateinfo"
                   style="width: 200px;height:35px ; margin-top:4% ;text-align: center;font-size: 16px"></p>
            </div>
        </div>

        <div class="layui-inline" style="margin-left: 5%">
            <div class="layui-input-inline">
                <button type="button" class="layui-btn layui-btn-radius alarmLogInfo"
                        style="width: 120px">报警信息
                </button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-normal addStuLngLatInfo"
                        style="width: 120px">添加宝宝轨迹
                </button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-warm addElectricFence"
                        style="width: 120px" id="bu">绘制电子围栏
                </button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-danger updateElectricFence"
                        style="width: 120px;">修改电子围栏
                </button>
            </div>
        </div>
    </div>
    <div id="allmap"
         style="overflow:hidden;zoom:1;position:relative;width: 90%;height: 73%;margin-top: 2%;margin-left: 5%">
        <div id="map"
             style="height:100%;-webkit-transition: all 0.5s ease-in-out;transition: all 0.5s ease-in-out;"></div>
    </div>
</div>

<div style="margin-left: 30%;margin-top: 0.3%">
    <div class="layui-inline" style="width: 100px;height: 20px;font-size: 16px">
        宝宝：
        <input type="button" id="studentname" style="background-color: transparent;border: none;pointer-events: none">
    </div>
    <div class="layui-inline" style="width: 200px;height: 20px;font-size: 16px;margin-left: 8%">
        坐标Y位置:
        <input type="button" id="studentlng" style="background-color: transparent;border: none;pointer-events: none">
    </div>
    <div class="layui-inline" style="width: 200px;height: 20px;font-size: 16px;margin-left: 8%">
        坐标X位置:
        <input type="button" id="studentlat" style="background-color: transparent;border: none;pointer-events: none">
    </div>
</div>

</div>
<script>

    layui.use(['jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
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


        //电子围栏---------------------------------------------------------------------------------------------------------
        // 百度地图API功能
        var map = new BMap.Map('map');
        var poi = new BMap.Point(118.1932, 24.4886);
        map.centerAndZoom(poi, 21);
        map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
        map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
        map.enableScrollWheelZoom();                            //启用滚轮放大缩小
        map.addControl(new BMap.MapTypeControl());          //添加地图类型控件

        //从数据库获取到绘制得到的区域坐标
        var polArry = [];
        var polygon;
        $.ajax({
            url: path + '/security/findCoordinate',
            async: true,
            type: 'post',
            datatype: 'text',
            success: function (msg) {
                if (msg == "error") {
                    layer.msg("您好，电子围栏不存在，请先绘制该幼儿园的电子围栏！", {icon: 2});
                } else if (msg == "notkindername") {
                    layer.msg("您好，需要登录幼儿园客户端才可以显示电子围栏！", {icon: 2});
                } else {
                    var info = JSON.parse(msg);
                    var styleOptions = {
                        strokeColor: "deepskyblue",    //边线颜色。
                        fillColor: "lightcyan",      //填充颜色。当参数为空时，圆形将没有填充效果。
                        strokeWeight: 3,       //边线的宽度，以像素为单位。
                        strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
                        fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
                        strokeStyle: 'solid' //边线的样式，solid或dashed。
                    }
                    for (var i in info) {
                        var p = new BMap.Point(info[i].lng, info[i].lat);
                        polArry.push(p);
                    }
                    polygon = new BMap.Polygon(polArry, styleOptions);
                    map.addOverlay(polygon);

                    $("#bu").css("background", "white");
                    $("#bu").css("color", "darkgrey");
                    $("#bu").attr("disabled", true);
                }
            }, error: function (msg) {
                layer.msg("网络繁忙！", {icon: 2});
            }
        });


        //添加地图点击监听
        map.addEventListener("click", function (e) {
            console.log(e.point.lng + "," + e.point.lat);
        });

        //2.查出给每个孩子默认的显示位置（即学校位置）
        var studentid;
        var studentname;
        var studentbrith;
        var timer;
        //3.根据下拉框选中的宝宝名称进行添加红色标注点
        $(function () {
            $("#stuname").change(function () {
                var path = $("#path").val();
                var studentInfo = $("#stuname option:selected").val();
                studentid = studentInfo.split("&")[0];
                studentname = studentInfo.split("&")[1];
                studentbrith = studentInfo.split("&")[2];
                $.ajax({
                    url: path + '/security/findStuTrack',
                    async: true,
                    type: 'post',
                    data: {"studentid": studentid, "studentname": studentname, "studentbrith": studentbrith},
                    datatype: 'text',
                    success: function (data) {
                        if (data == "error") {
                            layer.alert("宝宝没有活动轨迹哦，在学校里！", {icon: 6});
                        } else {
                            var info = JSON.parse(data);
                            var polArry = [];
                            var styleOptions = {
                                strokeColor: "red",    //边线颜色。
                                fillColor: "red",      //填充颜色。当参数为空时，圆形将没有填充效果。
                                strokeWeight: 3,       //边线的宽度，以像素为单位。
                                strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
                                fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
                                strokeStyle: 'solid' //边线的样式，solid或dashed。
                            }

                            $("#studentname").val(studentname);
                            for (var i = 0; i < info.length; i++) {
                                (function (e) {
                                    timer = setTimeout(function () {
                                        var lngLatNum = new BMap.Point(info[e].lng, info[e].lat);
                                        $("#studentlng").val(info[e].lng);
                                        $("#studentlat").val(info[e].lat);
                                        // if(e == 0 || e == info.length-1 ){
                                        addMarker([lngLatNum]);
                                        // }
                                        polArry.push(lngLatNum);
                                        var polyline = new BMap.Polyline(polArry, styleOptions);
                                        map.addOverlay(polyline);
                                    }, i * 1000);
                                })(i);
                            }

                        }
                    }, error: function (data) {
                        layer.msg("网络繁忙！", {icon: 2});
                    }
                });
            });
        });

        //添加标注点
        function addMarker(points) {
            for (var i = 0, pointsLen = points.length; i < pointsLen; i++) {
                var marker = new BMap.Marker(points[i]);
                map.addOverlay(marker);
                // marker.setAnimation(BMAP_ANIMATION_BOUNCE);  //增加点的弹跳动画
                marker.enableDragging();
                var thePoint = points[i];
                showInfo(marker, thePoint);
            }
        }

        //地图上展示
        function showInfo(thismarker, point) {
            if (BMapLib.GeoUtils.isPointInPolygon(point, polygon)) {
                // layer.msg('在圆形区域内');
                var infoWindow = new BMap.InfoWindow(studentname + "        在学校电子围栏区域内");
                thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
            } else {
                // layer.msg('不在圆形区域内');
                var infoWindow = new BMap.InfoWindow(studentname + "        不在学校电子围栏区域内");
                thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
                var lnginfo = point.lng;
                var latinfo = point.lat;
                $.ajax({
                    url: path + '/security/addAlarmLogInfo',
                    async: true,
                    type: 'post',
                    data: {"lnginfo": lnginfo, "latinfo": latinfo, "studentid": studentid, "studentname": studentname},
                    datatype: 'text',
                    success: function (msg) {
                        if (msg == "error") {
                            layer.msg('报警日志新增失败', {icon: 2});
                        } else {
                            layer.msg('已触发警铃', {icon: 6});
                        }
                    }, error: function (msg) {
                        layer.msg('网络繁忙', {icon: 2});
                    }
                });
                clearInterval(timer);
            }
        }

        //按钮监听-------------------------------------------------------------------------------------------------------------------
        //报警信息页面弹出
        $('body').on('click', '.alarmLogInfo', function () {
            layer.open({
                type: 2,
                area: ['80%', '75%'],
                offset: ['10%', '9.5%'],
                title: '报警日志详细信息',
                content: path + '/security/path/alarmLogInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                }
            });
        });

        $('body').on('click', '.addStuLngLatInfo', function () {
            var kindername = $("#kinder").val();
            if (kindername.length == 0) {
                layer.msg('对不起，您必须登录幼儿园账号才可以进行此操作！', {icon: 2});
            } else {
                layer.open({
                    type: 2,
                    area: ['80%', '75%'],
                    offset: ['10%', '9.5%'],
                    title: '添加宝宝运动轨迹',
                    content: path + '/security/path/addStuLngLatInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                        var body = layer.getChildFrame("body", index);
                    }
                });
            }
        });

        //绘制电子围栏
        $('body').on('click', '.addElectricFence', function () {
            var kindername = $("#kinder").val();
            if (kindername.length == 0) {
                layer.msg('对不起，您必须登录幼儿园账号才可以进行此操作！', {icon: 2});
            } else {
                layer.open({
                    type: 2,
                    area: ['100%', '100%'],
                    offset: ['0%', '0%'],
                    title: '绘制电子围栏',
                    content: path + '/security/path/addElectricFence' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                        var body = layer.getChildFrame("body", index);
                    }
                });
            }
        });

        //修改电子围栏
        $('body').on('click', '.updateElectricFence', function () {
            var kindername = $("#kinder").val();
            if (kindername.length == 0) {
                layer.msg('对不起，您必须登录幼儿园账号才可以进行此操作！', {icon: 2});
            } else {
                layer.open({
                    type: 2,
                    area: ['100%', '80%'],
                    offset: ['0%', '0%'],
                    title: '修改' + kindername + '电子围栏',
                    content: path + '/security/path/updateLngLatInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    , success: function (layero, index) {
                        var body = layer.getChildFrame("body", index);
                        body.find("#kinder").val(kindername);
                    }
                });
            }
        });
    });

</script>

</body>
</html>
