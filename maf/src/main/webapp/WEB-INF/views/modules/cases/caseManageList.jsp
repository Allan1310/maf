<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用例集管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
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
		<li class="active"><a href="${ctx}/cases/caseManage/">用例管理列表</a></li>
		<shiro:hasPermission name="cases:caseManage:edit"><li><a href="${ctx}/cases/caseManage/form">用例添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="caseManage" action="${ctx}/cases/caseManage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label><input type="text" name="caseName" value="${caseManage.caseName}" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>用例名称</th>
				<th>创建时间</th>
				<shiro:hasPermission name="cases:caseManage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="caseManage" varStatus="vs">
		<tr>
			<td>${vs.index+1}</td>
			<td>${caseManage.caseName}</td>
			<td><fmt:formatDate value="${caseManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<a href="${ctx}/cases/caseManage/makeCase?id=${caseManage.id}">生成用例</a>
				<a href="${ctx}/cases/caseManage/delete?id=${caseManage.id}" onclick="return confirmx('确认要删除该用例吗？', this.href)">删除</a>
				<!-- a href="${ctx}/item/itemPath/detailInfo?id=${itemManage.id}">详情</a>   -->
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>