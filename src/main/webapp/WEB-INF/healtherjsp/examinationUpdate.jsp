<%--
  Created by IntelliJ IDEA.
  User: Mr.Fan
  Date: 2020-3-21
  Time: 21:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>智慧幼儿园-体检信息修改界面</title>
    <%String path = request.getContextPath(); %>
    <link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
    <script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<form class="layui-form" onsubmit="return false;">
    <h1 style="margin-left: 29%">修改体检信息</h1>
    <hr style="color: whitesmoke">

    <div class="layui-form-item" style="margin-top: 10px;display: none">
        <label class="layui-form-label">体检ID</label>
        <div class="layui-input-inline">
            <input type="text" id="te0" name="examinationid" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item" style="margin-top: 10px;display: none">
        <label class="layui-form-label">宝宝ID</label>
        <div class="layui-input-inline">
            <input type="text" id="te1" name="studentid" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">宝宝名称</label>
        <div class="layui-input-block">
            <input type="text" id="te2" name="studentname" required lay-verify="required" placeholder="请输入宝宝姓名" autocomplete="off"
                   class="layui-input" readonly>
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝身高</label>
            <div class="layui-input-inline">
                <input type="text" id="te3" name="height" required lay-verify="height" placeholder="请输入宝宝身高" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝体重</label>
            <div class="layui-input-inline">
                <input type="text" id="te4" name="weight" required lay-verify="weight" placeholder="请输入宝宝体重" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝视力</label>
            <div class="layui-input-inline">
                <input type="text" id="te5" name="vision" required lay-verify="vision" placeholder="请输入宝宝视力" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝体温</label>
            <div class="layui-input-inline">
                <input type="text" id="te6" name="temperature" required lay-verify="temperature" placeholder="请输入宝宝体温" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">宝宝皮肤</label>
            <div class="layui-input-inline">
                <input type="text" id="te7" name="skin" required lay-verify="skin" placeholder="请输入宝宝皮肤" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" >健康状况</label>
            <div class="layui-input-inline">
                <input type="text" id="te8" name="healthstatus" required lay-verify="healthstatus" placeholder="请输入宝宝健康状况" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-btn-container" style="margin-left: 38%">
        <button type="button" class="layui-btn layui-btn-normal" lay-submit lay-filter="updateInfo">确认修改</button>
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
            height: function (value) {
                if (value > 200) {
                    return '您好，身高数据不得高于200cm！';
                }
            },
            weight: function (value) {
                if (value > 100) {
                    return '您好，体重数据不得高于100kg！';
                }
            },
            vision: function (value) {
                if (value > 5) {
                    return '您好，视力数据不得高于5！';
                }
            },
            temperature: function (value) {
                if (value > 45) {
                    return '您好，体温数据不得高于45℃！';
                }
            },
            skin: function (value) {
                if (value.length > 3) {
                    return '您好，皮肤不得大于3个字符！';
                }
            },
            healthstatus: function (value) {
                if (value.length > 3) {
                    return '您好，健康状况不得大于3个字符！';
                }
            }
            , content: function (value) {
                layedit.sync(editIndex);
            }

        });

        form.on('submit(updateInfo)', function (data) {
            var path = $("#path").val();
            $.ajax({
                url: path + "/healther/updateExaminationInfo",
                async: true,
                type: "post",
                data: data.field,
                datatype: "text",
                success: function (msg) {
                    if(msg == "success"){
                        layer.alert("修改成功！", {icon: 6},function (index) {
                            window.parent.location.reload();
                        });
                    }else {
                        layer.alert("修改失败！", {icon: 2});
                    }
                }, error: function (msg) {
                    layer.alert("网络繁忙！", {icon: 2});
                }
            })
        });

    });

</script>

</body>
</html>
