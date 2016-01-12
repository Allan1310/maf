<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
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
		<li class="active"><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li><a href="${ctx}/cm/cmCiInstance/form">配置项添加</a></li></shiro:hasPermission>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li><a href="${ctx}/cm/cmCiInstance/batchImport">批量导入</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<table>
			<tr>
				<td width="85">配置项名称：</td><td><form:input path="ciName" htmlEscape="false" maxlength="50" class="input-medium"/></td>
				<td width="90">&nbsp;&nbsp;&nbsp;运行状态：</td>
				<td>
					<form:select path="ciStatusA" maxlength="1" cssStyle="width:180px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_a')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
				<td width="90">&nbsp;&nbsp;&nbsp;使用状态：</td>
				<td>
					<form:select path="ciStatusB" maxlength="1" cssStyle="width:180px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_b')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>配置项分类：</td>
				<td>
					<sys:treeselect id="parent" name="cmCiGroup.id" value="${cmCiInstance.cmCiGroup.id}" labelName="parent.name" labelValue="${cmCiInstance.cmCiGroup.groupName}"
						title="配置项分类" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="input-small" allowClear="true" notAllowSelectParent="true" />
				</td>
				<td width="90">&nbsp;&nbsp;&nbsp;状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
				<td>
					<form:select path="status" maxlength="1" cssStyle="width:180px;">
						<form:option value="">--请选择--</form:option>
						<form:option value="1">未变更</form:option>
						<form:option value="3">正在审批</form:option>
						<form:option value="0">新增变更,未审批</form:option>
						<form:option value="2">修改变更,未审批</form:option>
						<form:option value="5">删除变更,未审批</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;创建人：</td>
				<td><form:input path="createBy.name" htmlEscape="false" maxlength="10" class="input-medium"/></td>
				<td>&nbsp;&nbsp;
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				</td>
			</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th class="sort-column ci_number" width="15%">配置项编号</th>
				<th class="sort-column ci_version" width="5%">配置项版本</th>
				<th class="sort-column ciName" width="15%">配置项名称</th>
				<th class="sort-column b.group_name" width="10%">配置项分类</th>
				<th class="sort-column ciStatusA" width="7%">运行状态</th>
				<th class="sort-column ciStatusB" width="7%">使用状态</th>
				<th class="sort-column u.login_name" width="13%">创建人</th>
				<th class="sort-column updateDate" width="13%">更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiInstance" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${cmCiInstance.ciNumber}</td>
				<td>${cmCiInstance.ciVersion}</td>
				<td>${cmCiInstance.ciName}</td>
				<td>${cmCiInstance.cmCiGroup.groupName}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusA, "ci_status_a", cmCiInstance.ciStatusA)}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusB, "ci_status_b", cmCiInstance.ciStatusB)}</td>
				<td>${cmCiInstance.createBy.name}</td>
				<td><fmt:formatDate value="${cmCiInstance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<c:if test="${cmCiInstance.ext1 == '1' }">
						<shiro:hasPermission name="cm:cmCiInstance:edit">
						<a href="${ctx}/cm/cmCiInstance/list?id=${cmCiInstance.id}">修改</a>
						</shiro:hasPermission>
						<shiro:hasPermission name="cm:cmCiInstance:edit">
						<a href="${ctx}/cm/cmCiInstance/delete?id=${cmCiInstance.id}" onclick="return confirmx('确认要删除该配置项吗？', this.href)">删除</a>
						</shiro:hasPermission>
					</c:if>
					<c:if test="${cmCiInstance.ext1 == '2' }">
						<a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}&view=view">查看</a>
						<c:if test="${cmCiInstance.status == '0' or cmCiInstance.status == '2' or cmCiInstance.status == '6'}">
							<shiro:hasPermission name="cm:cmCiApply:edit">
							<c:if test="${cmCiInstance.status == '0'}">
								<a href="${ctx}/cm/cmCiApply/save?handle=0" onclick="return confirmx('确认要发起变更申请吗？', this.href)">变更申请</a>
							</c:if>
							<c:if test="${cmCiInstance.status == '2'}">
								<a href="${ctx}/cm/cmCiApply/save?handle=1" onclick="return confirmx('确认要发起变更申请吗？', this.href)">变更申请</a>
								<shiro:hasPermission name="cm:cmCiInstance:edit">
								<a href="${ctx}/cm/cmCiInstance/update?id=${cmCiInstance.id}" onclick="return confirmx('确认要重置数据？', this.href)">重置</a>
								</shiro:hasPermission>
							</c:if>
							<c:if test="${cmCiInstance.status == '6'}">
								<a href="${ctx}/cm/cmCiApply/save?handle=2" onclick="return confirmx('确认要发起变更申请吗？', this.href)">变更申请</a>
								<shiro:hasPermission name="cm:cmCiInstance:edit">
								<a href="${ctx}/cm/cmCiInstance/update?id=${cmCiInstance.id}" onclick="return confirmx('确认要重置数据？', this.href)">重置</a>
								</shiro:hasPermission>
							</c:if>
							<c:if test="${cmCiInstance.status != '6' and cmCiInstance.status != '2'}">
							<shiro:hasPermission name="cm:cmCiInstance:edit">
							<a href="${ctx}/cm/cmCiInstance/delete?id=${cmCiInstance.id}" onclick="return confirmx('确认要删除该配置项吗？', this.href)">删除</a>
							</shiro:hasPermission>
							</c:if>
							</shiro:hasPermission>
						</c:if>
						<c:if test="${cmCiInstance.status == '3' }">
							<span style="color:red;">审批中...</span>
						</c:if>
						<c:if test="${cmCiInstance.status == '1' }">
							<shiro:hasPermission name="cm:cmCiInstance:edit">
							<a href="${ctx}/cm/cmCiInstance/delete?id=${cmCiInstance.id}" onclick="return confirmx('确认要删除该配置项？', this.href)">删除</a>
							<a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}&view=update">修改</a>
							</shiro:hasPermission>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>