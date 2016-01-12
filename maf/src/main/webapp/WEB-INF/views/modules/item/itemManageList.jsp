<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
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
		<li class="active"><a href="${ctx}/item/itemManage/">项目管理列表</a></li>
		<shiro:hasPermission name="item:itemManage:edit"><li><a href="${ctx}/item/itemManage/form">项目添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="itemManage" action="${ctx}/item/itemManage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label><input type="text" name="name" value="${itemManage.name}" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>项目全称</th>
				<th>项目版本</th>
				<th>创建时间</th>
				<shiro:hasPermission name="item:itemManage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="itemManage" varStatus="vs">
		<tr>
			<td>${vs.index+1}</td>
			<td>${itemManage.name}</td>
			<td>${itemManage.version}</td>
			<td><fmt:formatDate value="${itemManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<a href="${ctx}/item/itemManage/form?id=${itemManage.id}">修改</a>
				<a href="${ctx}/item/itemManage/delete?id=${itemManage.id}" onclick="return confirmx('确认要删除该项目吗？', this.href)">删除</a>
				<!-- a href="${ctx}/item/itemManage/detailInfo?id=${itemManage.id}">详情</a>   -->
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>