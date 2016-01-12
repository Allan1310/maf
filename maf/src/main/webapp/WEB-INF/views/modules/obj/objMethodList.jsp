<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>对象方法管理</title>
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
		<li class="active"><a href="${ctx}/obj/objMethod/">对象方法管理列表</a></li>
		<shiro:hasPermission name="obj:objMethod:edit"><li><a href="${ctx}/obj/objMethod/form">对象方法添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="objMethod" action="${ctx}/obj/objMethod/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>对象类型：</label>
				<form:select path="objType" style="width:140px" class="required">
					<option value="">请选择</option>
					<form:options items="${fns:getDictList('obj_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>方法名称：</label><input type="text" name="methodName" value="${objMethod.methodName}" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>对象类型</th>
				<th>方法名称</th>
				<th>默认值</th>
				<th style="width: 40%">方法Code</th>
				<th>创建时间</th>
				<shiro:hasPermission name="obj:objMethod:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="objMethod" varStatus="vs">
		<tr>
			<td>${vs.index+1}</td>
			<td>${fns:getDictLabel(objMethod.objType, 'obj_type', '') }</td>
			<td>${objMethod.methodName}</td>
			<td>${objMethod.defaultVal}</td>
			<td style="width: 40%;word-break : break-all;">${objMethod.methodCode}</td>
			<td><fmt:formatDate value="${objMethod.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>
				<a href="${ctx}/obj/objMethod/form?id=${objMethod.id}&flag=update">修改</a>
				<a href="${ctx}/obj/objMethod/delete?id=${objMethod.id}" onclick="return confirmx('确认要删除该方法吗？', this.href)">删除</a>
				<!-- a href="${ctx}/item/itemPath/detailInfo?id=${itemManage.id}">详情</a>   -->
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>