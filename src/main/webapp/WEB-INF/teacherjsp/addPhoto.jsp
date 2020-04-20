<%--
  Created by IntelliJ IDEA.
  User: MI
  Date: 2020/4/14
  Time: 22:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>新增安全教育视频</title>
	<%String path = request.getContextPath(); %>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/mainres/css/main.css">

</head>
<body>

<input type="hidden" id="path" value="<%=path%>">

<h1 style="margin-left: 17%;font-size: 40px;color: coral">新增图片</h1>
<div class="layui-upload">

	<%--选择视频文件--%>
	<div class="layui-form-item">
		<label class="layui-form-label">上传图片：</label>
		<div class="layui-input-inline">
			<button type="button" class="layui-btn layui-btn-normal" id="testList">上传</button>
		</div>
	</div>
	<div class="layui-upload-list">
		<table class="layui-table">
			<thead>
			<tr>
				<th>照片名称</th>
				<th>大小 </th>
				<th>状态 </th>
				<th>操作</th>
			</tr></thead>
			<tbody id="demoList"></tbody>
		</table>
	</div>

	<div class="layui-form-item">
		<label class="layui-form-label">照片描述：</label>
		<div class="layui-input-inline">
			<textarea type="text" class="layui-input" id="photoDetail" name="photoDetail" style="width: 250px;height: 100px"></textarea>
		</div>
	</div>
	<button type="button" class="layui-btn" id="testListAction">开始上传</button>

</div>

</body>
<script>
	layui.use(['upload','form','laydate'], function(){
		var laydate = layui.laydate;
		var $ = layui.jquery
			,upload = layui.upload
			,path = $("#path").val();
		// 多文件列表示例
		var demoListView = $('#demoList')
			,uploadListIns = upload.render({
			elem: '#testList'//指定选择文件的容器
			,url:path+ '/teacher/addClassPhoto' //改成您自己的上传接口
			,accept: 'images' //可上传视频文件
			,multiple: true //是否允许多文件上传
			,auto: false    //不自动上传
			,bindAction: '#testListAction'  //指定上传的容器
			// 上传前的回调
			,before: function () {
				this.data = {
					photoDetail: $('textarea[name="photoDetail"]').val()
				}
			}
			//选择文件后的回调
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
			//操作成功的回调
			,done: function(res, index, upload){
				if(res.code==0){ //上传成功
					alert("上传成功");//+res.data.src
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
