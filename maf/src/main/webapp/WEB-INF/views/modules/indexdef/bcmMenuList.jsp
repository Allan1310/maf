<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首页自定义配置管理</title>
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
		<li class="active"><a href="${ctx}/indexdef/bcmMenu/">首页模块列表</a></li>
		<shiro:hasPermission name="indexdef:bcmMenu:edit"><li><a href="${ctx}/indexdef/bcmMenu/form">首页模块添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bcmMenu" action="${ctx}/indexdef/bcmMenu/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模块名称：</label>
				<form:input path="menu.name" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模块名称</th>
				<th>是否显示</th>
				<shiro:hasPermission name="indexdef:bcmMenu:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bcmMenu">
			<tr>
				<td style="background-color: ${bcmMenu.modelColor};"><a href="${ctx}/indexdef/bcmMenu/form?id=${bcmMenu.id}">
					<span style="color:#fff;">${bcmMenu.menu.name}</span>
				</a></td>
				<td>
					${fns:getDictLabel(bcmMenu.menuShow, 'yes_no', '')}
				</td>
				<shiro:hasPermission name="indexdef:bcmMenu:edit"><td>
    				<a href="${ctx}/indexdef/bcmMenu/form?id=${bcmMenu.id}">修改</a>
					<a href="${ctx}/indexdef/bcmMenu/delete?id=${bcmMenu.id}" onclick="return confirmx('确认要删除该首页自定义配置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>