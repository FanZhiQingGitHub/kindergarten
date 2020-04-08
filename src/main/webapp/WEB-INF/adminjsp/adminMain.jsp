<%@ page import="com.great.kindergarten.commons.entity.TblAdmin" %><%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-7
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>智慧幼儿园-平台端</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
	<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<style>
		#exit{
			background: #040404;
		}
	</style>
</head>

<body class="layui-layout-body">
	<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">智慧幼儿园平台端管理系统</div>
				<ul class="layui-nav layui-layout-right">
					<li class="layui-nav-item">
						<a href="javascript:;">
							<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
							<%
								String adminname = (String) request.getSession().getAttribute("adminname");
								String rolename = (String) request.getSession().getAttribute("rolename");
							%>欢迎你,<%=adminname%><%=rolename%>
						</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:void(0);" id = "perInfo">个人信息</a></dd>
							<dd><a href="">安全设置</a></dd>
						</dl>
					</li>
<%--					<li class="layui-nav-item"><a href="" id="exit">退出</a></li>--%>
					<button type="button" class="layui-btn layui-btn-normal" style="background-color: transparent" id="exit" lay-submit lay-filter="logout">
						退出
					</button>
				</ul>
		</div>

		<div id="index-commonmenu" class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<ul class="layui-nav layui-nav-tree" lay-filter="demo" ></ul>
			</div>
		</div>

		<!--tab标签-->
<%--		<div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin-left: 200px;">--%>
<%--			<ul class="layui-tab-title"></ul>--%>
<%--			<div class="layui-tab-content"></div>--%>
<%--		</div>--%>

		<!-- 内容主体区域 -->
		<div class="layui-body">
			<iframe id="iframeMain" name="iframeMain" src="" style="width: 100%" height="100%" ></iframe>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			@ 2020
		</div>
	</div>

	<script>
		layui.use(['element', 'layer', 'jquery'], function(){
			var $ = layui.jquery,
				element = layui.element,
				path = $("#path").val(),
				layer = layui.layer;
			var num = 0;
			var m = 0;
			//获取所有的菜单
			$.ajax({
				type:"post",
				url:path+"/admin/treeMenu",
				dataType:"json",
				success:function(data){
					console.log(data);
					//先添加所有的主菜单
					$.each(data,function(i,obj){
						// num += obj.count;
						var content='<li class="layui-nav-item" >';
						content+='<a href="javascript:;">'+obj.menuname+'</a>';
						//这里是添加所有的子菜单
						content+=loadchild(obj);
						content+='</li>';
						$(".layui-nav-tree").append(content);
					});
					//存放总子单数量
					for(var a = 0; a < num; a++)
					{
						m = a+1;
					}
					element.init();
				},
				error:function(jqXHR){
					alert("发生错误："+ jqXHR.status);
				}

			});

			//组装子菜单的方法
			function loadchild(obj){
				if(obj==null){
					return;
				}
				var content='';
				if(obj.childrenList!=null && obj.childrenList.length>0){
					content+='<dl class="layui-nav-child">';
				}else{
					content+='<dl>';
				}
				if(obj.childrenList!=null && obj.childrenList.length>0){
					$.each(obj.childrenList,function(i,note){
						content+='<dd>';
						if(note.menuurl==null)
						{
							content+='<a href="javascript:void(0)" data-id="'+m+'" data-title="'+note.menuname+'" data-url="" class="site-demo-active" data-type="tabAdd">'+note.menuname+'</a>';
						}else{
							content+='<a href="javascript:void(0)" title="'+path+'/'+note.menuurl+'" onclick="changeSrc(this)" class="site-demo-active" data-type="tabAdd" data-id="'+m+'" data-title="'+note.menuname+'" data-url="'+note.menuurl+'">'+note.menuname+'</a>';
						}
						if(note.childrenList==null){
							return;
						}
						content+=loadchild(note);
						content+='</dd>';
					});
					content+='</dl>';
				}
				return content;
			}

			// 配置tab实践在下面无法获取到菜单元素
			$('.site-demo-active').on('click', function () {
				var dataid = $(this);
				//这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
				if ($(".layui-tab-title li[lay-id]").length <= 0) {
					//如果比零小，则直接打开新的tab项
					active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
				} else {
					//否则判断该tab项是否以及存在
					var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
					$.each($(".layui-tab-title li[lay-id]"), function () {
						//如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
						if ($(this).attr("lay-id") == dataid.attr("data-id")) {
							isData = true;
						}
					});
					if (isData == false) {
						//标志为false 新增一个tab项
						active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
					}
				}
				//最后不管是否新增tab，最后都转到要打开的选项页面上
				active.tabChange(dataid.attr("data-id"));
			});

			var active = {
				//在这里给active绑定几项事件，后面可通过active调用这些事件
				tabAdd: function (url, id, name) {
					//新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
					//关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
					element.tabAdd('demo', {
						title: name,
						content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' +
							url + '" style="width:100%;height:99%;"></iframe>',
						id: id //规定好的id
					});
					FrameWH();  //计算ifram层的大小
				},
				tabChange: function (id) {
					//切换到指定Tab项
					element.tabChange('demo', id); //根据传入的id传入到指定的tab项
				},
				tabDelete: function (id) {
					element.tabDelete("demo", id);//删除
				}
			};

			function FrameWH() {
				var h = $(window).height();
				$("iframe").css("height", h + "px");
			}

			$(function () {
				$("#exit").click(function () {
					layer.confirm("您确定要退出？",{icon:3,title: '温馨提示'},function (index) {
						layer.close(index);
						location.href = path+"/admin/logout";
					})
				});
				$("#perInfo").click(function () {
					layer.open({
						type: 2,
						area: ['95%', '80%'],
						offset: ['10%', '3%'],
						title:"智慧幼儿园-管理员个人信息页",
						btn1: function (index, layero) {
							//layer.getChildFrame("form", index)获取iframe的表单
							//serializeArray jquery方法，将表单对象序列化为数组
							layer.close(index);
						},
						content: path + '/admin/toUrl/adminInfo' //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
						, success: function (layero, index) {
						}
					});
				});
			})
			});

		var src;
		function changeSrc(node)
		{
			var iframeNode = document.getElementById('iframeMain');
			console.log(iframeNode);
			iframeNode.src = node.title;
		}
	</script>
</body>
</html>
