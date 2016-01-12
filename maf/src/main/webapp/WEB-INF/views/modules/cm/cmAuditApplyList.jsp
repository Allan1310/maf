<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项审计管理</title>
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
		<li class="active"><a href="${ctx}/cm/cmAuditApply/">审计计划列表</a></li>
		<shiro:hasPermission name="cm:cmAuditApply:edit"><li><a href="${ctx}/cm/cmAuditApply/form">审计计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>审计对象：</label>
				<form:input path="auditObject" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>审计项目：</label>
				<form:input path="auditProject" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>审计日期：</label>
				<form:input path="auditTime" htmlEscape="false" maxlength="20" readonly="readonly" class="Wdate required input-medium"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th class="sort-column auditNumber" width="22%">审计编号</th>
				<th class="sort-column u.login_name" width="15%">申请人</th>
				<th class="sort-column auditObject" width="15%">审计对象</th>
				<th class="sort-column auditProject" width="15%">审计项目</th>
				<th class="sort-column auditTime" width="15%">审计日期</th>
				<shiro:hasPermission name="cm:cmAuditApply:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmAuditApply" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td><a href="${ctx}/cm/cmAuditApply/form?id=${cmAuditApply.id}">${cmAuditApply.auditNumber}</a></td>
				<td>${cmAuditApply.createBy.name}</td>
				<td>${cmAuditApply.auditObject}</td>
				<td>${cmAuditApply.auditProject}</td>
				<td>
					${cmAuditApply.auditTime}
				</td>
				<shiro:hasPermission name="cm:cmAuditApply:edit"><td>
					<c:if test="${cmAuditApply.status == 0 }">
						<a href="${ctx}/cm/cmAuditApply/form?id=${cmAuditApply.id}&flag=2">修改</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>