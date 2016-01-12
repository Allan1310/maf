<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性管理管理</title>
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
	<script src="${ctxStatic }/js/jquery-1.8.2.min.js"></script>
	<link href="${ctxStatic }/css/theme.default.css" rel="stylesheet">
	<script src="${ctxStatic }/jquery/jquery.tablesorter.min.js"></script>
	<script src="${ctxStatic }/jquery/jquery.tablesorter.widgets.min.js"></script>
	<script>
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cm/cmPropertyManage/">属性列表</a></li>
		<shiro:hasPermission name="cm:cmPropertyManage:edit"><li><a href="${ctx}/cm/cmPropertyManage/form">属性添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmPropertyManage" action="${ctx}/cm/cmPropertyManage/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>属性名称：</label>
				<form:input path="propertyName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>属性类型：</label>
				<form:select path="propertyType" maxlength="4" cssStyle="width:220px;"  class="required">
					<form:option value="">--请选择--</form:option>
					<form:option value="TYSX"  htmlEscape="false">通用属性</form:option>
					<form:option value="ZYSX"  htmlEscape="false">专有属性</form:option>
				</form:select>
			</li>	
			<li><label>数据类型：</label>
				<form:select id="dataType" path="dataType" maxlength="1" cssStyle="width:220px;" class="required" onchange="properTypeSelect()">
					<form:option value="">--请选择--</form:option>
					<form:options items="${fns:getDictList('cm_property_data')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th width="3%">#</th>
				<th class="sort-column propertyName" width="18%">属性名称</th>
				<th class="sort-column property_type" width="15%">属性类型</th>
				<th class="sort-column dataType" width="18%">数据类型</th>
				<shiro:hasPermission name="cm:cmPropertyManage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmPropertyManage" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td><a href="${ctx}/cm/cmPropertyManage/form?id=${cmPropertyManage.id}&view=view">${cmPropertyManage.propertyName }</a></td>
				<td>
					<c:if test="${cmPropertyManage.propertyType == 'TYSX'}">通用属性</c:if>
					<c:if test="${cmPropertyManage.propertyType == 'ZYSX'}">专有属性</c:if>
				</td>
				<td>
					<c:if test="${fns:getDictLabel(cmPropertyManage.dataType,'cm_property_data',cmPropertyManage.dataType) == cmPropertyManage.dataType}">
						${fns:getDictLabel(cmPropertyManage.dataType,'cm_property_widget',cmPropertyManage.dataType)}
					</c:if>
					<c:if test="${fns:getDictLabel(cmPropertyManage.dataType,'cm_property_data',cmPropertyManage.dataType) != cmPropertyManage.dataType}">
						${fns:getDictLabel(cmPropertyManage.dataType,'cm_property_data',cmPropertyManage.dataType)}
					</c:if>
				</td>
				<shiro:hasPermission name="cm:cmPropertyManage:edit"><td>
					<c:if test="${cmPropertyManage.id != 'cm_1' and cmPropertyManage.id != 'cm_2'}">
    				<a href="${ctx}/cm/cmPropertyManage/form?id=${cmPropertyManage.id}">修改</a>
					<a href="${ctx}/cm/cmPropertyManage/delete?id=${cmPropertyManage.id}" onclick="return confirmx('确认要删除该属性吗？', this.href)">删除</a>
					</c:if>
					<c:if test="${cmPropertyManage.status == '0' }"><a href="${ctx}/cm/cmPropertyManage/update?id=${cmPropertyManage.id}" onclick="return confirmx('确认要停用该属性吗？', this.href)">停用</a></c:if>
					<c:if test="${cmPropertyManage.status == '1' }"><a href="${ctx}/cm/cmPropertyManage/update?id=${cmPropertyManage.id}" onclick="return confirmx('确认要启用该属性吗？', this.href)">启用</a></c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>