<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<form:form id="searchForm" modelAttribute="bcmMenu" action="${ctx}/indexdef/bcmMenu/bcmMenuTest" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>菜单名称：</label>
				<form:input path="menu.name" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询" onclick="clickSearchFn(this)"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>菜单名称</th>
				<th>默认显示</th>
				<th>链接地址</th>
				<th>是否显示</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bcmMenu">
			<tr>
				<td><a href="${ctx}/indexdef/bcmMenu/form?id=${bcmMenu.id}">
					${bcmMenu.menu.name}
				</a></td>
				<td>
					${fns:getDictLabel(bcmMenu.menuShow, 'yes_no', '')}
				</td>
				<td>
					${bcmMenu.menu.href}
				</td>
				<td>
					${fns:getDictLabel(bcmMenu.menuShowType, 'yes_no', '')}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>