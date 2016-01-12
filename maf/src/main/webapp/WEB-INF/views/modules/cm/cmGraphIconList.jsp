<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项图标管理</title>
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
		<li class="active"><a href="${ctx}/cm/cmGraphIcon/">配置项图标列表</a></li>
		<shiro:hasPermission name="cm:cmGraphIcon:edit"><li><a href="${ctx}/cm/cmGraphIcon/form">配置项图标添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmGraphIcon" action="${ctx}/cm/cmGraphIcon/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>图标名称：</label><form:input path="iconName" htmlEscape="false"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th class="sort-column iconName" >图标名称</th>
				<th class="sort-column updateDate" >更新时间</th>
				<shiro:hasPermission name="cm:cmGraphIcon:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmGraphIcon" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td><a href="${ctx}/cm/cmGraphIcon/form?id=${cmGraphIcon.id}&view=view">${cmGraphIcon.iconName }</a></td>
				<td class="sort-column updateDate"><fmt:formatDate value="${cmGraphIcon.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="cm:cmGraphIcon:edit"><td>
    				<a href="${ctx}/cm/cmGraphIcon/form?id=${cmGraphIcon.id}">修改</a>
					<a href="${ctx}/cm/cmGraphIcon/delete?id=${cmGraphIcon.id}" onclick="return confirmx('确认要删除该配置项图标吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>