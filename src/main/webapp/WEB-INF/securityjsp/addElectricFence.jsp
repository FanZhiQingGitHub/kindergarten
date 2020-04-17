<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-4-16
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html {
            width: 100%;
            height: 100%;
            margin: 0;
            font-family: "微软雅黑";
        }

        #allmap {
            width: 100%;
            height: 500px;
            overflow: hidden;
        }

        #result {
            width: 100%;
            font-size: 12px;
        }

        dl, dt, dd, ul, li {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        p {
            font-size: 12px;
        }

        dt {
            font-size: 14px;
            font-family: "微软雅黑";
            font-weight: bold;
            border-bottom: 1px dotted #000;
            padding: 5px 0 5px 5px;
            margin: 5px 0;
        }

        dd {
            padding: 5px 0 0 5px;
        }

        li {
            line-height: 28px;
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=Q9U1Y53LM1WDwF2qNUYAraf9qEbQ7w58"></script>
    <!--加载鼠标绘制工具-->
    <script type="text/javascript"
            src="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css"/>
    <!--加载检索信息窗口-->
    <script type="text/javascript"
            src="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css"/>

    <title>智慧幼儿园-安防员电子围栏绘制</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">绘制电子围栏</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" style="margin-left: 13%">

        <div class="layui-inline" style="margin-left: 15%">
            <div class="layui-input-inline">
                <button type="button" class="layui-btn layui-btn-radius"
                        style="width: 200px" id="bu1">获取绘制的覆盖物个数
                </button>

                <button type="button" class="layui-btn layui-btn-radius layui-btn-normal"
                        style="width: 200px" id="bu2">清除所有覆盖物
                </button>

                <button type="button" class="layui-btn layui-btn-radius layui-btn-warm"
                        style="width: 200px" id="bu3">开启绘制工具
                </button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-danger"
                        style="width: 200px" id="bu4">关闭绘制工具
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


<script type="text/javascript">

    layui.use(['jquery', 'layer', 'form'], function () {
        $ = layui.jquery;
        var form = layui.form;
        var layer = layui.layer;
        var path = $("#path").val();

        // 百度地图API功能
        var map = new BMap.Map('map');
        var poi = new BMap.Point(118.1932, 24.4886);
        map.centerAndZoom(poi, 20);
        map.enableScrollWheelZoom();
        var overlays = [];
        var coordinatelist = [];//保存绘制得到的区域坐标
        var polygon;

        var overlaycomplete = function (e) {
            overlays.push(e.overlay);
            coordinatelist = overlays[0].getPath();
            polygon = new BMap.Polygon(coordinatelist, {
                strokeColor: "deepskyblue ",
                fillColor: "lightcyan ",
                strokeWeight: 2,
                strokeOpacity: 0.5
            });  //创建多边形
            map.addOverlay(polygon);
            console.log(coordinatelist)
            if(coordinatelist.length == 0 ){
                layer.alert("请绘制围栏",{icon:2});
            }else {
                var msg = {"coordinatelist":coordinatelist};
                msg = JSON.stringify(msg);
                $.ajax({
                    url: path + '/security/addCoordinate',
                    async: true,
                    type: 'post',
                    data: "TblCoordinate="+msg,
                    datatype: 'text',
                    success:function (msg) {
                        if(msg == "error"){
                            layer.alert("绘制失败！", {icon: 2});
                        }else {
                            layer.alert("绘制成功！", {icon: 6});
                            window.parent.location.reload();
                        }
                    },error:function (msg) {
                        layer.alert("网络繁忙！", {icon: 2});
                    }
                });
            }
        };


        $(function () {
            $("#bu1").click(function () {
                var num = overlays.length;
                layer.alert(num,{icon:2});
            }),$("#bu2").click(function () {
                for (var i = 0; i < overlays.length; i++) {
                    map.removeOverlay(overlays[i]);
                }
                overlays.length = 0;
            }),$("#bu3").click(function () {
                var styleOptions = {
                    strokeColor: "red",    //边线颜色。
                    fillColor: "white",      //填充颜色。当参数为空时，圆形将没有填充效果。
                    strokeWeight: 3,       //边线的宽度，以像素为单位。
                    strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
                    fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
                    strokeStyle: 'solid' //边线的样式，solid或dashed。
                }

                var DrawingType = [BMAP_DRAWING_POLYLINE, BMAP_DRAWING_RECTANGLE];
                //实例化鼠标绘制工具
                myDrawingManagerObject = new BMapLib.DrawingManager(map, {
                    isOpen: true, //是否开启绘制模式
                    enableDrawingTool: true, //是否显示工具栏
                    drawingToolOptions: {
                        anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
                        offset: new BMap.Size(5, 5), //偏离值
                        drawingModes: DrawingType
                    },
                    circleOptions: styleOptions, //圆的样式
                    polylineOptions: styleOptions, //线的样式
                    polygonOptions: styleOptions, //多边形的样式
                    rectangleOptions: styleOptions //矩形的样式
                });
                //添加鼠标绘制工具监听事件，用于获取绘制结果
                myDrawingManagerObject.addEventListener('overlaycomplete', overlaycomplete);
            }),$("#bu4").click(function () {
                myDrawingManagerObject.close();
            });
        });
    });
</script>


</body>
</html>
