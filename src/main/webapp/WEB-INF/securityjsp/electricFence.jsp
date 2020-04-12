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


    <script type="text/javascript" src="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
    <!--加载检索信息窗口-->
    <script type="text/javascript" src="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="//api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">


<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 43%">电子围栏</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" style="margin-left: 19%">
        <div class="layui-inline">
            <label class="layui-form-label" style="font-size: 16px">幼儿园名称</label>
            <div class="layui-input-inline">
                <input class="layui-input" id="kindername" value="${kindername}厦门市传一信息科技有限公司" style="width: 300px"
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

        <div class="layui-inline" style="margin-left: 5%">
            <div class="layui-input-inline">
                <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal" id="bu1"
                        style="width: 200px">报警信息
                </button>
            </div>
        </div>
    </div>

        <div id="allmap" style="overflow:hidden;zoom:1;position:relative;width: 90%;height: 73%;margin-top: 2%;margin-left: 5%">
            <div id="map" style="height:100%;-webkit-transition: all 0.5s ease-in-out;transition: all 0.5s ease-in-out;"></div>
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
        }

        setInterval(function () {
            timeTimer()
        }, 1000);//这个方法可以这样写吗 。。。


        //电子围栏---------------------------------------------------------------------------------------------------------

        // 创建Map
        var map = new BMap.Map("map");
        var lngnum ;
        var latnum ;
        var drawpoint;
        var point2s = [];

        var dafaultpoint;
        var point3s = [];



        map.addEventListener("click",function(e){
            // console.log(e.point.lng + "," + e.point.lat);
            lngnum = e.point.lng;
            latnum = e.point.lat;
            drawpoint =  new BMap.Point(lngnum, latnum);
            point2s.push(drawpoint);
            addMarker(point2s);
            point2s.shift();
            point3s.shift();
        });
        //创建一个圆
        var circle = new BMap.Circle(new BMap.Point(118.1932, 24.4886), 35, {
            fillColor: "white",
            strokeWeight: 3,
            fillOpacity: 0.5,
            strokeOpacity: 0.5
        });

        //用作默认显示一个点
        dafaultpoint =  new BMap.Point(118.1932, 24.48854);
        point3s = [dafaultpoint];
        addMarker(point3s);

        function addMarker(points) {
            console.log(points.length);
            for (var i = 0, pointsLen = points.length; i < pointsLen; i++) {
                var marker = new BMap.Marker(points[i]);
                map.addOverlay(marker);
                marker.setAnimation(BMAP_ANIMATION_BOUNCE);  //增加点的弹跳动画
                var thePoint = points[i];
                showInfo(marker, thePoint);

                // //添加监听事件
                // (function () {
                //     var thePoint = points[i];
                //     marker.addEventListener("click",
                //         function () {
                //             showInfo(this, thePoint);
                //         });
                // })();
            }
        }

        function showInfo(thismarker, point) {
            if (BMapLib.GeoUtils.isPointInCircle(point, circle)) {
                layer.msg('在圆形区域内');
                // var infoWindow = new BMap.InfoWindow("在圆形区域内");
                // thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
            } else {
                layer.msg('不在圆形区域内');
                // var infoWindow = new BMap.InfoWindow("不在圆形区域内");
                // thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
            }
        }

        function initialize() {
            // alert("点击标注点可以显示是否在区域内");
            map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
            map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
            map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
            map.enableScrollWheelZoom();                            //启用滚轮放大缩小
            map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
            var point = new BMap.Point(118.1930, 24.4885);    // 创建点坐标
            map.centerAndZoom(point, 20);                // 初始化地图,设置中心点坐标和地图级别。
            map.addOverlay(circle);

        }

        initialize();

        map.addTileLayer(new BMap.PanoramaCoverageLayer());
        var stCtrl = new BMap.PanoramaControl(); //构造全景控件
        stCtrl.setOffset(new BMap.Size(35, 35));
        map.addControl(stCtrl);//添加全景控件


    });

</script>

</body>
</html>
