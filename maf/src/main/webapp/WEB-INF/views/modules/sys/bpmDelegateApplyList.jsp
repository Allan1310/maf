<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务委托申请管理</title>
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
		<li class="active"><a href="${ctx}/sys/bpmDelegateApply/">任务委托申请列表</a></li>
		<shiro:hasPermission name="sys:bpmDelegateApply:edit"><li><a href="${ctx}/sys/bpmDelegateApply/form">任务委托申请添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpmDelegateApply" action="${ctx}/sys/bpmDelegateApply/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>状态：</label><form:select path="status" htmlEscape="false" cssStyle="width:180px;">
									<form:option value="">--请选择--</form:option>
									<form:option value="0">可执行</form:option>
									<form:option value="1">已注销</form:option>
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
				<th>申请人</th>
				<th>被委托人</th>
				<th>状态</th>
				<th>委托开始时间</th>
				<th>委托结束时间</th>
				<shiro:hasPermission name="sys:bpmDelegateApply:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpmDelegateApply" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${bpmDelegateApply.applyUser.name}</td>
				<td>${bpmDelegateApply.assigneeUser.name}</td>
				<td>
				<c:if test="${bpmDelegateApply.status == '0'}">
					可执行
				</c:if>
				<c:if test="${bpmDelegateApply.status == '1'}">
					已注销
				</c:if>
				</td>
				<td>${bpmDelegateApply.startTime}</td>
				<td>${bpmDelegateApply.endTime}</td>
				<shiro:hasPermission name="sys:bpmDelegateApply:edit"><td>
    				<a href="${ctx}/sys/bpmDelegateApply/form?id=${bpmDelegateApply.id}">修改</a>
    				<c:if test="${bpmDelegateApply.status == '0'}">
					<a href="${ctx}/sys/bpmDelegateApply/delete?id=${bpmDelegateApply.id}" onclick="return confirmx('确认要删除该任务委托申请吗？', this.href)">删除</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>