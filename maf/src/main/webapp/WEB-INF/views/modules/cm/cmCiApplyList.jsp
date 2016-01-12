<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更申请管理</title>
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
		<li class="active"><a href="${ctx}/cm/cmCiApply/">变更申请列表</a></li>
		<shiro:hasPermission name="cm:cmCiApply:edit"><li><a href="${ctx}/cm/cmCiApply/form">变更申请</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiApply" action="${ctx}/cm/cmCiApply/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li>申请编号：<form:input path="applyNumber" htmlEscape="false"/>&nbsp;&nbsp;</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th class="sort-column applyNumber" width="20%">申请编号</th>
				<th class="sort-column u.login_name" width="10%">申请人</th>
				<th class="sort-column o.name" width="10%">所在部门</th>
				<th class="sort-column createDate" width="12%">申请日期</th>
				<shiro:hasPermission name="cm:cmCiApply:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiApply" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td><a href="${ctx}/cm/cmCiApply/form?id=${cmCiApply.id}">${cmCiApply.applyNumber}</a></td>
				<td>${cmCiApply.user.name}</td>
				<td>${cmCiApply.office.name}</td>
				<td><fmt:formatDate value="${cmCiApply.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="cm:cmCiApply:edit"><td>
					<a href="${ctx}/cm/cmCiApply/delete?id=${cmCiApply.id}" onclick="return confirmx('确认要删除该变更申请吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>