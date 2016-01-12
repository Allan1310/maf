<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分类管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiGroup/list">分类列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiGroup/form?id=${cmCiGroup.id}&parent.id=${cmCiGroupparent.id}">分类<shiro:hasPermission name="cm:cmCiGroup:edit">${not empty cmCiGroup.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmCiGroup:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiGroup" action="${ctx}/cm/cmCiGroup/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">上级分类：</label>
			<div class="controls">
				${cmCiGroup.parent.groupName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类名称：</label>
			<div class="controls">
				${cmCiGroup.groupName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类编号：</label>
			<div class="controls">
				${cmCiGroup.groupNumber}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类描述：</label>
			<div class="controls">
				${cmCiGroup.groupDesc}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类排序：</label>
			<div class="controls">
				${cmCiGroup.sort}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图片选择：</label>
			<div class="controls">
				<img src="${cmCiGroup.cmGraphIcon.iconFile }"  style="max-width:60px;max-height:60px;_height:60px;border:0;padding:3px;">
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiGroup:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>