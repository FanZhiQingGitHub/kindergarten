<%--
  Created by IntelliJ IDEA.
  User: LXC
  Date: 2020-4-10
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%String path = request.getContextPath();%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<script src=<%=path + "/layui/layui.js"%>></script>
</head>
<body>
<input type="hidden" id="path" value="<%=path%>">
	<div class="layui-row" style="margin-top: 20px;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">菜单名称：</label>
				<div class="layui-inline">
					<input type="text" id="menuName" name="menuName" placeholder="请输入菜单名称" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">上级菜单：</label>
				<div class="layui-inline">
					<select name="supNam" id="supName" lay-filter="selectName" lay-verify="required" >
						<option value="请选择">请选择</option>
						<c:if test="${not empty kinderList}">
							<c:forEach items="${kinderList}" var="u">
								<option value="${u.kindername}">${u.kindername}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">URL：</label>
				<div class="layui-inline">
					<input type="text" id="menuUrl" name="menuUrl" placeholder="请输入URL" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">排序号：</label>
				<div class="layui-inline">
					<input type="text" id="sort" name="sort" placeholder="请输入菜单排序号" value=""
					       autocomplete="off" class="layui-input" style="width: 120%" lay-verify="required">
				</div>
			</div>
		</form>
	</div>
</body>
<script>
	layui.use(['form', 'layer', 'jquery', 'layedit', 'laydate', 'element', 'tree','table'], function () {
		var form = layui.form
			, layer = layui.layer
			, layedit = layui.layedit
			, laydate = layui.laydate
			, element = layui.element
			, tree = layui.tree
			, table = layui.table
			, $ = layui.jquery;
		var path = $("#path").val();
		form.verify({
			menuName: function(value, item){ //value：表单的值、item：表单的DOM对象
				if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
					return '菜单名不能有特殊字符';
				}
				if(/(^\_)|(\__)|(\_+$)/.test(value)){
					return '菜单名首尾不能出现下划线\'_\'';
				}
				if(/^\d+\d+\d$/.test(value)){
					return '菜单名不能全为数字';
				}
			}
			,supName:function(value, item){ //value：表单的值、item：表单的DOM对象
				if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
					return '上级菜单名不能有特殊字符';
				}
				if(/(^\_)|(\__)|(\_+$)/.test(value)){
					return '上级菜单名首尾不能出现下划线\'_\'';
				}
				if(/^\d+\d+\d$/.test(value)){
					return '上级菜单名不能全为数字';
				}
			}
			,menuUrl:function(value){
				if(value.split("/") != 'admin'){
					return 'URL不合法，请输入如格式：admin/**';
				}
			}
			// ,pass: [/^[\S]{6,12}$/,'密码必须6到12位，且不能出现空格']

		});
		var tableIns = table.render({
			elem: '#kinder'
			, height: 312
			, url: path + "/admin/logMgrInfo"//数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				{field: 'syslogid', title: '序号', align: 'center', width: 80, sort: true, fixed: 'left'}
				, {field: 'operateor', title: '操作人', align: 'center', width: 120}
				, {
					field: 'operatetime', title: '操作时间', align: 'center', width: 180
					, templet: "<div>{{layui.util.toDateString(d.operatetime,'yyyy-MM-dd HH:mm:ss')}}</div>"
				}
				, {field: 'operatetype', title: '操作事项', align: 'center', width: 120}
			]]
			, id: 'demotable'
			, parseData: function (res) { //res 即为原始返回的数据
				return {
					"code": res.code, //解析接口状态
					"msg": res.msg, //解析提示文本
					"count": res.count, //解析数据长度
					"data": res.data //解析数据列表
				};
			}
		});

		//搜索功能的实现
		$('.demoTable .layui-btn').on('click', function () {
			var type = $(this).data('type');
			active[type] ? active[type].call(this) : '';
		});

		var $ = layui.$, active = {
			reload: function () {
				//执行重载
				table.reload('demotable', {
					where: {
						time1: $('#time1').val()
						, time2: $('#time2').val()
					}
					, page: {
						curr: 1
					}
				});
			}
		};

		// 刷新表格
		$('#btn-refresh').on('click', function () {
			tableIns.reload();
		});
	});
</script>
</html>
