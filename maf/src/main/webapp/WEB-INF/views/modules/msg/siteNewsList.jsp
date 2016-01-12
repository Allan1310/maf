<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻管理管理</title>
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
		<li class="active"><a href="${ctx}/site/siteNews/">新闻列表</a></li>
		<shiro:hasPermission name="site:siteNews:edit"><li><a href="${ctx}/site/siteNews/form">新闻添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="siteNews" action="${ctx}/site/siteNews/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label="全部类型"/>
					<form:options items="${fns:getDictList('site_new_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>状态：</label>
				<%-- <form:radiobuttons path="status" items="${fns:getDictList('post_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
				<form:select path="status" class="input-medium">
					<form:option value="" label="全部状态"/>
					<form:options items="${fns:getDictList('post_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>类型</th>
				<th>状态</th>
				<th>发布时间</th>
				<shiro:hasPermission name="site:siteNews:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="siteNews">
			<tr>
				<td>
				<a href="${ctx}/site/siteNews/show?id=${siteNews.id}" target="_blank">
					${fns:abbr(siteNews.title,50)}
				</a></td>
				<td>
					${fns:getDictLabel(siteNews.type, 'site_new_type', '')}
				</td>
				<td>
					${fns:getDictLabel(siteNews.status, 'post_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${siteNews.newsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
					<shiro:hasPermission name="site:siteNews:edit"><td>
    				<a href="${ctx}/site/siteNews/form?id=${siteNews.id}">修改</a>
					<a href="${ctx}/site/siteNews/delete?id=${siteNews.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a>
					</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>