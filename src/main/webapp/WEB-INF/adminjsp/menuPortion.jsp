<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-18
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>智慧幼儿园-权限分配</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
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
    <input type="hidden" id="rid" value="">
    <div class="layui-btn-container">
        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal showTree" style="margin-left: 20%;margin-top: 3%">
            显示所有菜单
        </button>
        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary confirm" style="margin-top: 3%;" id="bu1" disabled="true">确定修改权限</button>
        <hr style="color: whitesmoke">
    </div>

    <div id="menuTree" class="demo-tree-more"></div>

<script>
    layui.use(['tree', 'util','jquery','layer','layedit','laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate
            , tree = layui.tree;
        $ = layui.jquery;
        var path = $("#path").val();
        var rid = null;
        $('body').on('click', '.showTree', function () {
            rid = $("#rid").val();
            alert(rid);
            var MenuId = [];
            $.ajax({
                url: path + '/admin/findAllMenuInfo',
                async:true,
                type: 'post',
                data: {'roleid':rid},
                success: function (data) {
                    console.log(data);
                    if (data == "error") {
                        layer.alert("菜单信息异常！",{icon:2});
                    } else {

                        for(var i = 0;i<data["mid"].length;i++){
                            MenuId.push(data["mid"][i].id);
                        }
                        //树形组件渲染
                        tree.render({
                            elem: '#menuTree'
                            , data: data["menu"]
                            , showCheckbox: true  //是否显示复选框
                            , showLine:false
                            , id: 'checkId'
                        });
                        tree.setChecked('checkId', MenuId); //批量勾选 id 为 2、3 的节点
                        $("#bu1").css("background","darkorange");
                        $("#bu1").css("color","white");
                        $("#bu1").attr("disabled", false);
                    }
                }, error: function (data) {
                    layer.alert("网络繁忙！",{icon:2});
                }
            });
        });

        $('body').on('click', '.confirm', function () {//确认修改按钮监听
            var checkData = tree.getChecked('checkId');//获取选中的id
            console.log(checkData);
            var fatherNodeId = [];//定义父级菜单id数组
            var objectData = [];//定义object数组拿来装选中id的其它值，因为checkData里面包含有选中的子id，需要先装一下这个子id的数组
            var sonNodeId = [];//定义子级菜单id数组
            var checkedId = [];//定义选中的id数组，拿来装选中的父级id和子id，这里面没有其它值，只有id。
            for(var i = 0;i<checkData.length;i++){//循环选中的id 得到父id的数组添加到装父级id的数组中，
                fatherNodeId.push(checkData[i].id);
                objectData.push(checkData[i].children);//将剩下的子id信息加入到objectDate里面
            }
            for(var j = 0;j<objectData.length;j++){//循环这个数组
                for(var k in objectData[j]){
                    sonNodeId.push(objectData[j][k].id);//获取到子id值装进去
                }
            }
            checkedId.push(fatherNodeId);
            checkedId.push(sonNodeId);

            layer.confirm('您确定要修改吗?', {icon: 3, title:'提示'}, function(index){
                if(0 != checkedId.length){
                    var msg = {'fatherNodeId':fatherNodeId,'sonNodeId':sonNodeId,'rid':rid};//在menuT实体类中定义两个集合和角色id属性，便于在servlet里面拿值
                    msg = JSON.stringify(msg);
                    $.ajax({
                        url: path + '/admin/updateMenu',
                        async:true,
                        type: 'post',
                        data: msg,
                        contentType : 'application/json;charset=utf-8',//指定传送json格式数据，并指定编码
                        datatype:'text',
                        success:function (data) {
                            if (data == "success"){
                                layer.alert("菜单配置成功，请重新登录！",{icon:6},function (index) {
                                    layer.close(index);
                                    window.parent.location.reload();
                                    parent.layer.close(index);
                                });
                            }else {
                                layer.alert("菜单配置失败！",{icon:2},function (index) {
                                    layer.close(index);
                                });
                            }
                        },error:function (data) {
                            layer.alert("网络异常！",{icon:2},function (index) {
                                layer.close(index);
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
