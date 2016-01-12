<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/cm/cm.property.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmPropertyManage/">属性列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmPropertyManage/form?id=${cmPropertyManage.id}">属性<shiro:hasPermission name="cm:cmPropertyManage:edit">${not empty cmPropertyManage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmPropertyManage:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmPropertyManage" action="${ctx}/cm/cmPropertyManage/save" method="post" class="form-horizontal">
		<form:hidden id="id" path="id"/>
		<div class="row">
			<div class="control-group span6">
				<label class="control-label">属性名称：</label>
				<div class="controls">
					${cmPropertyManage.propertyName }
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">属性描述：</label>
				<div class="controls">
					${cmPropertyManage.propertyDesc }
				</div>
			</div>
		</div>
		<div class="row">
			<div class=" control-group span6">
				<label class="control-label">属性类型：</label>
				<div class="controls">
					<c:if test="${cmPropertyManage.propertyType == 'TYSX'}">通用属性</c:if>
					<c:if test="${cmPropertyManage.propertyType == 'ZYSX'}">专有属性</c:if>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">是否必填：</label>
				<div class="controls">
					<c:if test="${cmPropertyManage.isNull == '0'}">必填</c:if>
					<c:if test="${cmPropertyManage.isNull == '1'}">非必填</c:if>
				</div>
			</div> 
		</div>
		<div class="row">
			<div class="control-group span6">
				<label class="control-label">数据类型：</label>
				<div class="controls">
					${fns:getDictLabel(cmPropertyManage.dataType,'cm_property_data',cmPropertyManage.dataType)}
				</div>
			</div>
			<c:if test="${cmPropertyManage.dataType == '2' }">
				<div id="selectType" class="control-group span6">
					<label class="control-label">下拉信息：</label>
					<div class="controls">
						${fns:getDictName('cmPropertyManage。ext1')}
					</div>
				</div>
			</c:if>
			<c:if test="${cmPropertyManage.dataType == '3' }">
				<div id="widgetType" class="control-group span6">
					<label class="control-label">控件类型：</label>
					<div class="controls">
						${fns:getDictLabel(cmPropertyManage.ext2,'cm_property_widget',cmPropertyManage.ext2)}
					</div>
				</div>
			</c:if>
		</div>
		<div class="row">
			<div class="control-group span6">
				<label class="control-label">排序：</label>
				<div class="controls">
					${cmPropertyManage.sort }
				</div>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>