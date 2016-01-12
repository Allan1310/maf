<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项关联工单管理</title>
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
		<li><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		<li><a href="${ctx}/cm/cmCiInstance/form?id=${ciInstance.id}&view=view">配置项查看<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiInstance/listVersion?id=${ciInstance.id}">配置项版本<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiRelation?ciInstance.id=${ciInstance.id}">关联配置项<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li class="active"><a href="#">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiRelation/graph?ciInstance.id=${ciInstance.id}">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cmRelationOrder" action="${ctx}/cm/cmRelationOrder/?ciInstance.id=${ciInstance.id}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>工单类型：<form:select path="orderType">
						<form:option value="">--请选择--</form:option>
						<form:option value="1">变更工单</form:option>
						<form:option value="2">事件工单</form:option>
						<form:option value="3">问题工单</form:option>
					   </form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>配置项编号</th>
				<th>工单编号</th>
				<th>工单类型</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmRelationOrder" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${cmRelationOrder.ciInstance.ciNumber}</td>
				<td>${cmRelationOrder.orderId}</td>
				<td>
				<c:if test="${cmRelationOrder.orderType == '1'}">变更工单</c:if>
				<c:if test="${cmRelationOrder.orderType == '2'}">事件工单</c:if>
				<c:if test="${cmRelationOrder.orderType == '3'}">问题工单</c:if>
				</td>
				<td>
					<fmt:formatDate value="${cmRelationOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>