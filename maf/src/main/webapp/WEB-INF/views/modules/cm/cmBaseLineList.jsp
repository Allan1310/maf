<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项基线管理</title>
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
		<li class="active"><a href="${ctx}/cm/cmBaseLine/">配置项基线列表</a></li>
		<shiro:hasPermission name="cm:cmBaseLine:edit"><li><a href="${ctx}/cm/cmBaseLine/save">生成配置项基线</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmBaseLine" action="${ctx}/cm/cmBaseLine/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>基线版本：</label><form:input path="baseVersion" maxlength="10" htmlEscape="false"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>基线版本</th>
				<th>创建时间</th>
				<shiro:hasPermission name="cm:cmBaseLine:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmBaseLine" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${cmBaseLine.baseVersion}</td>
				<td><fmt:formatDate value="${cmBaseLine.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="${ctx}/cm/cmBaseLine/ciList?ciVersion=${cmBaseLine.baseVersion}" >查看</a>
				<shiro:hasPermission name="cm:cmBaseLine:edit">
					<a href="${ctx}/cm/cmBaseLine/delete?id=${cmBaseLine.id}" onclick="return confirmx('确认要删除该配置项基线吗？', this.href)">删除</a>
				</shiro:hasPermission></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>