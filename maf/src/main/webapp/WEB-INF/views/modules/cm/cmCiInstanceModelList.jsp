<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项模型</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			function modelExport(data){
				alert(data);
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cm/cmCiInstance/model">模型列表</a></li>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li><a href="${ctx}/cm/cmCiInstance/modelForm">模型添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/model" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模型名称：</label>
				<form:input path="ciName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label style="width: 100px;">所属分类：</label>
				<sys:treeselect id="parent" name="cmCiGroup" value="${cmCiInstance.cmCiGroup.id}" labelName="parent.name" labelValue="${cmCiInstance.cmCiGroup.groupName}"
					title="配置项分类" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="input-small" allowClear="true" notAllowSelectParent="true" />
			</li>	
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="25px">#</th>
				<th width="360px">模型名称</th>
				<th width="360px">所属分类</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiInstance" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${cmCiInstance.ciName }</td>
				<td>${cmCiInstance.cmCiGroup.groupName }</td>
				<td><a href="${ctx}/cm/cmCiInstance/modelDetail?id=${cmCiInstance.id}">查看 </a>
				<shiro:hasPermission name="cm:cmCiInstance:edit">
    				<a href="${ctx}/cm/cmCiInstance/modelForm?id=${cmCiInstance.id}">修改</a>
					<a href="${ctx}/cm/cmCiInstance/delete?id=${cmCiInstance.id}" onclick="return confirmx('确认要删除该配置项管理吗？', this.href)">删除</a>
					<a href="${ctx}/cm/cmCiInstance/modelExport?id=${cmCiInstance.id}" class="btn btn-mini btn-primary"><i class="icon-download icon-white "></i> 导出</a>
				</shiro:hasPermission></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>