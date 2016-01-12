<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>路径管理</title>
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
		<li class="active"><a href="${ctx}/item/itemPath/">路径管理列表</a></li>
		<shiro:hasPermission name="item:itemPath:edit"><li><a href="${ctx}/item/itemPath/form">路径添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="itemPath" action="${ctx}/item/itemPath/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>路径名称：</label><input type="text" name="itemPath" value="${itemPath.itemPath}" class="input-medium"/></li>
			<li><label>路径表达式：</label><input type="text" name="expression" value="${itemPath.expression}" class="input-medium"/></li>
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
				<th>路径表达式</th>
				<th>创建时间</th>
				<shiro:hasPermission name="item:itemPath:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="itemPath" varStatus="vs">
		<tr>
			<td>${vs.index+1}</td>
			<td>${itemPath.itemName}</td>
			<td>${itemPath.itemPath}</td>
			<td>${itemPath.expression}</td>
			<td><fmt:formatDate value="${itemPath.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<a href="${ctx}/item/itemPath/form?id=${itemPath.id}">修改</a>
				<a href="${ctx}/item/itemPath/delete?id=${itemPath.id}" onclick="return confirmx('确认要删除该路径吗？', this.href)">删除</a>
				<!-- a href="${ctx}/item/itemPath/detailInfo?id=${itemManage.id}">详情</a>   -->
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>