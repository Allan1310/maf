<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			$("#check").click(function(){
				if($(this).attr("checked")){
					$("input[name=ciCheck]").each(function(){
						$(this).attr("checked",true);
					});
				}else{
					$("input[name=ciCheck]").each(function(){
						$(this).attr("checked",false);
					});
				}
			});
			
			
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function reportExport(){
			var ids = "";
			$('input[name="ciCheck"]:checked').each(function(){
                var id=$(this).val();
                ids = id + "," + ids;
            });
			location.href = "${ctx}/cm/cmCiInstance/reportExport?ids=" + ids;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cm/cmCiInstance/report">报表导出</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/report?status=1" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table>
			<tr>
				<td width="85">配置项名称 ：</td><td><form:input path="ciName" htmlEscape="false" maxlength="50" class="input-medium"/></td>
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
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;创建人：</td>
				<td><form:input path="createBy.name" htmlEscape="false" maxlength="10" class="input-medium"/></td>
				<td>&nbsp;&nbsp;
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				</td>
				<td>
					<a href="javascript:()" class="btn btn-primary" onclick="reportExport()"><i class="icon-download icon-white "></i> 报表导出</a>
				</td>
			</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%"><input type="checkbox" name="check" id="check" /></th>
				<th width="15%">配置项编号</th>
				<th width="10%">配置项版本</th>
				<th width="15%">配置项名称</th>
				<th width="7%">运行状态</th>
				<th width="7%">使用状态</th>
				<th width="15%">配置项分类</th>
				<th width="13%">创建人</th>
				<th width="13%">更新时间</th>
				<th width="10%">操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiInstance" varStatus="status">
			<tr>
				<td><input type="checkbox" name="ciCheck" id="ciCheck" value="${cmCiInstance.id}"/></td>
				<td>${cmCiInstance.ciNumber}</td>
				<td>${cmCiInstance.ciVersion}</td>
				<td>${cmCiInstance.ciName}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusA, "ci_status_a", cmCiInstance.ciStatusA)}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusB, "ci_status_b", cmCiInstance.ciStatusB)}</td>
				<td>${cmCiInstance.cmCiGroup.groupName}</td>
				<td>${cmCiInstance.createBy.name}</td>
				<td><fmt:formatDate value="${cmCiInstance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}&view=view">查看</a>
				</td>
				<%-- <shiro:hasPermission name="cm:cmCiInstance:edit"><td>
					<a href="${ctx}/cm/cmCiInstance/reportExport?id=${cmCiInstance.id}" class="btn btn-mini btn-primary"><i class="icon-download icon-white "></i> 报表导出</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>