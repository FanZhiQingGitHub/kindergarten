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
<input type="hidden" id="studentid">
<input type="hidden" id="studentbrith" value="<%=path%>">


<div class="layui-fluid">

    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2 style="margin-left: 46%">电子围栏</h2>
    </div>
    <div class="layui-inline" style="width:100%;">
        <hr>
    </div>

    <div class="layui-fluid" style="margin-left: 13%">

        <div class="layui-inline">
            <div class="layui-form-item" style="color: black;width: 300px;margin-top: 5%">
                <label class="layui-form-label">宝宝名称：</label>
                <div class="layui-input-block">
                    <select name="stuname" id="stuname" style="width:180px;height: 5.3%">
                    </select>
                </div>
            </div>
        </div>

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
                <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal alarmLogInfo"
                        style="width: 200px">报警信息
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


        //电子围栏---------------------------------------------------------------------------------------------------------

        // 创建Map
        var map = new BMap.Map("map");
        var dafaultpoint;//给定默认的显示地点经纬度
        var dafpoint = [];


        // map.addEventListener("click", function (e) {
        //     // console.log(e.point.lng + "," + e.point.lat);
        //     lngnum = e.point.lng;
        //     latnum = e.point.lat;
            // alert(lngnum,latnum);
            // drawpoint = new BMap.Point(lngnum, latnum);
            // point2s.push(drawpoint);
            // addMarker(point2s);
            // point2s.shift();
            // dafpoint.shift();
        // });
        //创建一个圆

        //地图上画圆
        var circle = new BMap.Circle(new BMap.Point(118.1932, 24.4886), 35, {
            fillColor: "white",
            strokeWeight: 3,
            fillOpacity: 0.5,
            strokeOpacity: 0.5
        });

        //1、查出宝宝名称下拉框的值
        $.ajax({
            url: path + '/security/findAllStuInfo',
            async: true,
            type: 'post',
            datatype: 'text',
            success: function (data) {
                if (data == "error") {
                    layer.alert("暂无宝宝信息！", {icon: 2});
                } else {
                    var stuinfo = JSON.parse(data);
                    var option;
                    option = "<option value='请选择'>" + "请选择宝宝名称" + "</option>";
                    for (var i in stuinfo) {
                        option += "<option value='" + stuinfo[i].studentid + "&" + stuinfo[i].studentname + "&" + stuinfo[i].studentbrith + "'>" + stuinfo[i].studentname + "</option>";
                    }
                    $("#stuname").html(option);
                    $("#stuname").show();
                }
            }, error: function (data) {
                layer.alert("网络繁忙！", {icon: 2});
            }
        })

        //2.查出给每个孩子默认的显示位置（即学校位置）
        var lnginfo;
        var latinfo;
        var studentid;
        var studentname;
        var studentbrith;
        var timer;
        //3.根据下拉框选中的宝宝名称进行添加红色标注点
        $(function () {
            $("#stuname").change(function () {
                var path = $("#path").val();
                studentInfo = $("#stuname option:selected").val();
                studentid = studentInfo.split("&")[0];
                studentname = studentInfo.split("&")[1];
                studentbrith = studentInfo.split("&")[2];
                $.ajax({
                    url: path + '/security/findStuLngLatInfo',
                    async: true,
                    type: 'post',
                    data: {"studentid": studentid, "studentname": studentname, "studentbrith": studentbrith},
                    datatype: 'text',
                    success: function (data) {
                        if (data == "error") {
                            // deletePoint();
                            // new BMap.Circle(new BMap.Point(118.1932, 24.4886), 35, {
                            //     fillColor: "white",
                            //     strokeWeight: 3,
                            //     fillOpacity: 0.5,
                            //     strokeOpacity: 0.5
                            // });
                            layer.alert("请选择宝宝名称！", {icon: 2});
                        } else {
                            var stuLngLatinfo = JSON.parse(data);
                            for (var i in stuLngLatinfo) {
                                lnginfo = stuLngLatinfo[i].studentlng;
                                latinfo = stuLngLatinfo[i].studentlat;
                            }

                            $("#studentlng").val(lnginfo);
                            $("#studentlat").val(latinfo);
                            $("#studentname").val(studentname);

                            var addtime = function add() {
                                var lngnum = $("#studentlng").val();
                                var latnum = $("#studentlat").val();
                                var addnum = 0.00001;
                                //西+
                                var Y = lessLngAdd(lngnum, addnum);
                                // var X = lessLatAdd(latnum, addnum);

                                //东+
                                // var Y = numLngAdd(lngnum, addnum);
                                // var X = lessLatAdd(latnum, addnum);

                                //北+
                                // var Y = numLngAdd(lngnum, addnum);
                                // var X = numLatAdd(latnum, addnum);

                                //南+
                                // var Y = numLngAdd(lngnum, addnum);
                                // var X = lessLatAdd(latnum, addnum);

                                //左右移动
                                $("#studentlng").val(Y);
                                $("#studentlat").val(latnum);

                                //上下移动
                                // $("#studentlng").val(lngnum);
                                // $("#studentlat").val(X);


                                //用作默认显示一个点（左右移动）
                                dafaultpoint = new BMap.Point(Y, latnum);
                                dafpoint = [dafaultpoint];
                                addMarker(dafpoint);

                                //用作默认显示一个点（上下移动）
                                // dafaultpoint = new BMap.Point(lngnum, X);
                                // dafpoint = [dafaultpoint];
                                // addMarker(dafpoint);

                            }

                            timer = setInterval(addtime,1000);

                        }
                    }, error: function (data) {
                        layer.alert("网络繁忙！", {icon: 2});
                    }
                })
            })


        })


        function numLngAdd (lngnum, addnum) {//要相加的两个数
            var baseNum, baseNum1, baseNum2;
            try {
                baseNum1 = lngnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum1 = 0;
            }
            try {
                baseNum2 = addnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum2 = 0;
            }
            baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
            return (lngnum * baseNum + addnum * baseNum) / baseNum;
        };

        function numLatAdd(latnum, addnum) {//要相加的两个数
            var baseNum, baseNum1, baseNum2;
            try {
                baseNum1 = latnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum1 = 0;
            }
            try {
                baseNum2 = addnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum2 = 0;
            }
            baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
            return (latnum * baseNum + addnum * baseNum) / baseNum;
        };

        function lessLngAdd (lngnum, addnum) {//要相减的两个数
            var baseNum, baseNum1, baseNum2;
            try {
                baseNum1 = lngnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum1 = 0;
            }
            try {
                baseNum2 = addnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum2 = 0;
            }
            baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
            return (lngnum * baseNum - addnum * baseNum) / baseNum;
        };

        function lessLatAdd(latnum, addnum) {//要相减的两个数
            var baseNum, baseNum1, baseNum2;
            try {
                baseNum1 = latnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum1 = 0;
            }
            try {
                baseNum2 = addnum.toString().split(".")[1].length;
            } catch (e) {
                baseNum2 = 0;
            }
            baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
            return (latnum * baseNum - addnum * baseNum) / baseNum;
        };

        // function deletePoint(){
        //     var allOverlay = map.getOverlays();
        //     for (var i = 0; i < allOverlay.length; i++){
        //         map.removeOverlay(allOverlay[i]);
        //     }
        // }
        //

        //添加标注点
        function addMarker(points) {
            for (var i = 0, pointsLen = points.length; i < pointsLen; i++) {
                var marker = new BMap.Marker(points[i]);
                map.addOverlay(marker);
                // marker.setAnimation(BMAP_ANIMATION_BOUNCE);  //增加点的弹跳动画
                marker.enableDragging();
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

        //地图上展示
        function showInfo(thismarker, point) {
            if (BMapLib.GeoUtils.isPointInCircle(point, circle)) {
                // layer.msg('在圆形区域内');
                var infoWindow = new BMap.InfoWindow(studentname + "在圆形区域内");
                thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
            } else {
                // layer.msg('不在圆形区域内');
                var infoWindow = new BMap.InfoWindow(studentname + "不在圆形区域内");
                thismarker.openInfoWindow(infoWindow); //图片加载完后重绘infoWindow
                var lnginfo = point.lng;
                var latinfo = point.lat;
                $.ajax({
                    url: path + '/security/addAlarmLogInfo',
                    async: true,
                    type: 'post',
                    data: {"lnginfo": lnginfo, "latinfo": latinfo,"studentid":studentid,"studentname":studentname},
                    datatype: 'text',
                    success:function (msg) {
                        if(msg == "error"){
                            layer.alert('报警日志新增失败',{icon:2});
                        }else {
                            // layer.alert('报警日志新增成功',{icon:6});
                        }
                    },error:function (msg) {
                        layer.alert('网络繁忙',{icon:2});
                    }
                })
                clearInterval(timer);
            }
        }

        //初始化地图
        function initialize() {
            map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
            map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
            map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
            map.enableScrollWheelZoom();                            //启用滚轮放大缩小
            map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
            var point = new BMap.Point(118.1930, 24.4885);    // 创建点坐标
            map.centerAndZoom(point, 20);                // 初始化地图,设置中心点坐标和地图级别。
            map.addOverlay(circle);

        }
        initialize();//初始化地图数据

        // map.addTileLayer(new BMap.PanoramaCoverageLayer());
        // var stCtrl = new BMap.PanoramaControl(); //构造全景控件
        // stCtrl.setOffset(new BMap.Size(35, 35));
        // map.addControl(stCtrl);//添加全景控件

        //报警信息页面弹出
        $('body').on('click', '.alarmLogInfo', function () {
            layer.open({
                type: 2,
                area: ['80%', '62%'],
                offset: ['10%', '9.5%'],
                title: '报警日志详细信息',
                content: path + '/security/path/alarmLogInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                , success: function (layero, index) {
                    var body = layer.getChildFrame("body", index);
                }
            });
        });


    });

</script>

</body>
</html>
