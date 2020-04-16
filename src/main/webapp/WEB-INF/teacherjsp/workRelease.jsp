<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/9
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>发布作业</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden" id="classid" value="<%=path%>">
<h1 style="margin-left: 17%;font-size: 40px;color: coral">发布作业</h1>
<div class="layui-upload">

	<%--选择班级--%>
	<div class="layui-form-item">
		<button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>

		<div class="layui-input-block">
			<label class="layui-form-label" >选择班级：</label>
			<select name="selectClass" id="selectClass" lay-verify="required" style="width: 100px">
				<option value="" selected>请选择班级</option>

			</select>
		</div>
	</div>



	<div class="layui-upload-list">
		<table class="layui-table">
			<thead>
			<tr>
				<th>作业内容</th>
				<th>大小</th>
				<th>状态 </th>
				<th>操作</th>
			</tr></thead>
			<tbody id="demoList"></tbody>
		</table>
	</div>
	<button type="button" class="layui-btn" id="testListAction">开始上传</button>
</div>

</body>
<script>
	layui.use(['upload','form'], function(){
		var $ = layui.jquery
			,upload = layui.upload
			// ,classname=$("#selectClass").val()
			// ,classname = $("#selectClass option:selected").text()
			,path = $("#path").val();
		// console.log("classname="+classname);

		$(function () {
			$.ajax({
               //提交数据的类型 POST GET
				type:"POST",
               //提交的网址
			    url:path + '/teacher/selectClass',
               //提交的数据
               //返回数据的格式
			   datatype:"json",//“xml”, “html”, “script”, “json”, “jsonp”, “text”.
			//成功返回之后调用的函数
			success: function (data) {
                  console.log(data);
				var list = "";
				for(var i=0;i<data.length;i++){
					list = data[i].classname ;
					console.log("list="+list);
					$('#selectClass').append(new Option(list));// 下拉菜单里添加元素
				}

			}, error:function () {
				alert("查询班级失败！！！")
			}
		});
		});

		//多文件列表示例
		var demoListView = $('#demoList')
			,uploadListIns = upload.render({
			elem: '#testList'//指定选择文件的容器
			,url:path+ '/teacher/workRelease' //改成您自己的上传接口
			,accept: 'file' //可上传所有文件
			,multiple: true //是否允许多文件上传
			,auto: false    //不自动上传
			,bindAction: '#testListAction'  //指定上传的容器
			,data: {
				classname: function () {
					return $("#selectClass option:selected").text();
				}
			    }
				,choose: function(obj){
				var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
				//读取本地文件
				obj.preview(function(index, file, result){
					var tr = $(['<tr id="upload-'+ index +'">'
						,'<td>'+ file.name +'</td>'
						,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
						,'<td>等待上传</td>'
						,'<td>'
						,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
						,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
						,'</td>'
						,'</tr>'].join(''));

					//单个重传
					tr.find('.demo-reload').on('click', function(){
						obj.upload(index, file);
					});

					//删除
					tr.find('.demo-delete').on('click', function(){
						delete files[index]; //删除对应的文件
						tr.remove();
						uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
					});

					demoListView.append(tr);
				});
			}
			,done: function(res, index, upload){
				if(res.code==0){ //上传成功
					alert("上传成功");
					var tr = demoListView.find('tr#upload-'+ index)
						,tds = tr.children();
					tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
					tds.eq(3).html(''); //清空操作
					return delete this.files[index]; //删除文件队列已经上传成功的文件
				}
				this.error(index, upload);
			}
			,error: function(index, upload){
				var tr = demoListView.find('tr#upload-'+ index)
					,tds = tr.children();
				tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
				tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
			}
		});

	});
</script>

</html>
