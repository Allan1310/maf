<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>对象管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/obj/objManage/">对象管理列表</a></li>
		<shiro:hasPermission name="obj:objManage:edit"><li><a href="${ctx}/obj/objManage/form">对象添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="objManage" action="${ctx}/obj/objManage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label><input type="text" name="itemName" value="${objManage.itemName}" class="input-medium"/></li>
			<li><label>路径名称：</label><input type="text" name="pathName" value="${objManage.pathName}" class="input-medium"/></li>
			<li><label>对象名称：</label><input type="text" name="objName" value="${objManage.objName}" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>项目名称</th>
				<th>路径名称</th>
				<th>对象名称</th>
				<th>xpath表达式</th>
				<th>jquery表达式</th>
				<th>创建时间</th>
				<shiro:hasPermission name="obj:objManage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="objManage" varStatus="vs">
		<tr>
			<td>${vs.index+1}</td>
			<td>${objManage.itemName}</td>
			<td>${objManage.pathName}</td>
			<td>${objManage.objName}</td>
			<td>${objManage.xpathCode}</td>
			<td>${objManage.jqueryCode}</td>
			<td><fmt:formatDate value="${objManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<a href="${ctx}/obj/objManage/form?id=${objManage.id}&flag=update">修改</a>
				<a href="${ctx}/obj/objManage/delete?id=${objManage.id}" onclick="return confirmx('确认要删除该对象吗？', this.href)">删除</a>
				<!-- a href="${ctx}/item/itemPath/detailInfo?id=${itemManage.id}">详情</a>   -->
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>