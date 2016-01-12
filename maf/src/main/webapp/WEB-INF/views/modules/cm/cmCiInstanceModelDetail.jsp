<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项模型</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiInstance/model">模型列表</a></li>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li><a href="${ctx}/cm/cmCiInstance/modelForm">模型添加</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/cm/cmCiInstance/modelDetail">模型信息</a></li>
	</ul>
	<form:form modelAttribute="cmPropertyGroup" class="form-horizontal">
	<sys:message content="${message}"/>
	<table class="table">
 		<tr><td>模型信息：</td></tr>
 		<tr><td></td></tr>
	</table>
	<div class="row-fluid">
		<div class="span6">
			<div class="control-group">
				<label class="control-label">模型名称：</label>
				<label class="control-label">${cmCiInstance.ciName}</label>
			</div>
		</div>
		<div class="span6">
			<div class="control-group">
				<label class="control-label">模型所属分类：</label>
				<label class="control-label">${cmCiInstance.ext2}</label>
			</div>
		</div>
	</div>
	<table class="table">
 		<tr><td>该模型的通用属性：</td></tr>
 		<tr><td></td></tr>
	</table>
	<div class="row-fluid">
		<div class="span6">
		<c:forEach items="${newTYPropertyGroups }" var="property" varStatus="status">
			<c:if test="${status.count%2!=0}">
			<div class="control-group">
				<label class="control-label">${property.propertyName}：</label>
				<div class="controls">
					${property.remarks}
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<div class="span6">
		<c:forEach items="${newTYPropertyGroups }" var="property" varStatus="status">
			<c:if test="${status.count%2==0}">
			<div class="control-group">
				<label class="control-label">${property.propertyName}：</label>
				<div class="controls">
					${property.remarks}
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
	</div>
	<table class="table">
 		<tr><td>该模型的专有属性：</td></tr>
 		<tr><td></td></tr>
	</table>
	<div class="row-fluid">
		<div class="span6">
		<c:forEach items="${newPropertyGroups }" var="propertyGroup" varStatus="status">
			<c:if test="${status.count%2!=0}">
			<div class="control-group">
				<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
				<div class="controls">
					${propertyGroup.cmPropertyManage.remarks}<%-- <a class="btn" href="${ctx}/cm/cmPropertyGroup/delete?id=${propertyGroup.id}" onclick="return confirmx('确认要删除该属性吗？', this.href)"><i class="icon-remove"></i></a> --%>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<div class="span6">
		<c:forEach items="${newPropertyGroups }" var="propertyGroup" varStatus="status">
			<c:if test="${status.count%2==0}">
			<div class="control-group">
				<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
				<div class="controls">
					${propertyGroup.cmPropertyManage.remarks}<%-- <a class="btn" href="${ctx}/cm/cmPropertyGroup/delete?id=${propertyGroup.id}" onclick="return confirmx('确认要删除该属性吗？', this.href)"><i class="icon-remove"></i></a> --%>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
	</div>
	<div class="form-actions">
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
</body>
</html>