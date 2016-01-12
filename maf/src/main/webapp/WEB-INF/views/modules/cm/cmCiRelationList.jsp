<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项关联管理</title>
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
		<li class="active"><a href="#">关联配置项<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmRelationOrder/list?ciInstance.id=${ciInstance.id}">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiRelation/graph?ciInstance.id=${ciInstance.id}">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiRelation" action="${ctx}/cm/cmCiRelation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<shiro:hasPermission name="cm:cmCiInstance:edit"><li class="btns"><a href="${ctx}/cm/cmCiRelation/form?ciInstance.id=${cmCiRelation.ciInstance.id}" class="btn btn-primary">关联添加</a></li></shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th width="15%">关联配置项名称</th>
				<th width="15%">关联关系</th>
				<th width="15%">配置项名称</th>
				<shiro:hasPermission name="cm:cmCiInstance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiRelation" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${cmCiRelation.reCiInstance.ciName }</td>
				<td>${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}</td>
				<td>${cmCiRelation.ciInstance.ciName}</td>
				<shiro:hasPermission name="cm:cmCiInstance:edit"><td>
    				<a href="${ctx}/cm/cmCiRelation/form?id=${cmCiRelation.id}">修改</a>
					<a href="${ctx}/cm/cmCiRelation/delete?id=${cmCiRelation.id}" onclick="return confirmx('确认要删除该配置项关联吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>