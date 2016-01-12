<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作日设置管理</title>
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
		<li class="active"><a href="${ctx}/sys/setWeekday/">工作日设置列表</a></li>
		<shiro:hasPermission name="sys:setWeekday:edit"><li><a href="${ctx}/sys/setWeekday//form">工作日添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="setWeekday" action="${ctx}/sys/setWeekday/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>工作日：</label>
				<input id="day" name="day" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="${setWeekday.day}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>工作日日期</th>
				<th>是否有效</th>
				<!-- <th>创建时间</th>
				<th>更新时间</th> -->
				<th>备注</th>
				<shiro:hasPermission name="sys:setWeekday:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="setWeekday">
			<tr>
				<td>${setWeekday.day }</td>
				<td>${fns:getDictLabel(setWeekday.delFlag, 'del_flag', '') }</td>
				<%-- <td><fmt:formatDate value="${setWeekday.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${setWeekday.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
				<td>${setWeekday.remarks}</td>
				<shiro:hasPermission name="sys:setWeekday:edit"><td>
    				<a href="${ctx}/sys/setWeekday/form?id=${setWeekday.id}">修改</a>
					<a href="${ctx}/sys/setWeekday/delete?id=${setWeekday.id}" onclick="return confirmx('确认要删除该工作日设置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>