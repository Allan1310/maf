<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>流水号管理</title>
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
		<li class="active"><a href="${ctx}/sys/sysIdentity/">流水号列表</a></li>
		<shiro:hasPermission name="sys:sysIdentity:edit"><li><a href="${ctx}/sys/sysIdentity/form">流水号添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysIdentity" action="${ctx}/sys/sysIdentity/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>别名：</label>
				<form:input path="alias" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>别名</th>
				<th>生成规则</th>
				<th>生成类型</th>
				<th>长度</th>
				<th>初始值</th>
				<th>增长步长</th>
				<th>当前值</th>
				<shiro:hasPermission name="sys:sysIdentity:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysIdentity">
			<tr>
				<td><a href="${ctx}/sys/sysIdentity/form?id=${sysIdentity.id}">
					${sysIdentity.name}
				</a></td>
				<td>
					${sysIdentity.alias}
				</td>
				<td>
					${sysIdentity.rule}
				</td>
				<td>${fns:getDictLabel(sysIdentity.genEveryDay, 'sys_identity_create', '无')}</td>
				<td>${sysIdentity.noLength}</td>
				<td>${sysIdentity.initValue}</td>
				<td>${sysIdentity.step}</td>
				<td>${sysIdentity.curValue}</td>
				
				<shiro:hasPermission name="sys:sysIdentity:edit"><td>
					<a href="${ctx}/sys/sysIdentity/next?id=${sysIdentity.id}" onclick="return confirmx('确认要增长该流水号吗？', this.href)">增长</a>
    				<a href="${ctx}/sys/sysIdentity/form?id=${sysIdentity.id}">修改</a>
					<a href="${ctx}/sys/sysIdentity/delete?id=${sysIdentity.id}" onclick="return confirmx('确认要删除该流水号吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>