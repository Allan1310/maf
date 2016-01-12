<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项图标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmGraphIcon/">配置项图标列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmGraphIcon/form?id=${cmGraphIcon.id}">配置项图标<shiro:hasPermission name="cm:cmGraphIcon:edit">${not empty cmGraphIcon.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmGraphIcon:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmGraphIcon" action="${ctx}/cm/cmGraphIcon/save" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">图标名称：</label>
			<div class="controls">
				${cmGraphIcon.iconName }
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传图标：</label>
			<div class="controls">
				<img src="${cmGraphIcon.iconFile }"  style="max-width:60px;max-height:60px;_height:60px;border:0;padding:3px;">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				${cmGraphIcon.remarks }
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>