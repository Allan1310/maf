<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分类管理管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row,status:((row.status=='0')?'停用':'启用')
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cm/cmCiGroup/list">分类列表</a></li>
		<shiro:hasPermission name="cm:cmCiGroup:edit"><li><a href="${ctx}/cm/cmCiGroup/form">分类添加</a></li></shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>分类名称</th>
				<th>分类编号</th>
				<th>分类描述</th>
				<th>分类排序</th>
				<shiro:hasPermission name="cm:cmCiGroup:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/cm/cmCiGroup/form?id={{row.id}}&view=view">
				{{row.groupName}}
			</a></td>
			<td>
				{{row.groupNumber}}
			</td>
			<td>
				{{row.groupDesc}}
			</td>
			<td>
				{{row.sort}}
			</td>
			<shiro:hasPermission name="cm:cmCiGroup:edit"><td>
   				<a href="${ctx}/cm/cmCiGroup/form?id={{row.id}}">修改</a>
				<%--  <a href="${ctx}/cm/cmCiGroup/delete?id={{row.id}}" onclick="return confirmx('确认要删除该分类管理及所有子分类管理吗？', this.href)">删除</a> --%>
				<a href="${ctx}/cm/cmCiGroup/update?id={{row.id}}" onclick="return confirmx('确认要{{status}}该分类吗？', this.href)">{{status}}</a>
				<a href="${ctx}/cm/cmPropertyGroup?groupId={{row.id}}">属性分配</a>
				<a href="${ctx}/cm/cmCiGroup/form?parent.id={{row.id}}">添加下级分类</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>