<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
</head>
<!-- 这里根据访问该页面类型，控制数据的显示（ ciDetailType=hmCiDetail　代表从作业管理查看配置项，只需显示'配置项查看'菜单） -->
<c:set var="ciDetailType" value="${param.type }"></c:set>
<body>
	<ul class="nav nav-tabs">
		<c:if test="${ciDetailType != 'hmCiDetail' }">
			<li><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		</c:if>
		<li class="active"><a href="#">配置项查看<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<c:if test="${ciDetailType != 'hmCiDetail' }">
			<li><a href="${ctx}/cm/cmCiInstance/listVersion?id=${cmCiInstance.id}">配置项版本<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
			<shiro:hasPermission name="cm:cmCiInstance:view"><li><a href="${ctx}/cm/cmCiRelation?ciInstance.id=${cmCiInstance.id}">关联配置项</a></li></shiro:hasPermission>
			<li><a href="${ctx}/cm/cmRelationOrder/list?ciInstance.id=${cmCiInstance.id}">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
			<li><a href="${ctx}/cm/cmCiRelation/graph?ciInstance.id=${cmCiInstance.id}">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		</c:if>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">配置项名称：</label>
			<div class="controls">
				${cmCiInstance.ciName }
			</div>
		</div>
		<div class="control-group span6">
			<label class="control-label">配置项图标：</label>
			<div class="controls">
				<img src="${cmCiInstance.cmGraphIcon.iconFile }"  style="max-width:60px;max-height:60px;_height:60px;border:0;padding:3px;">
			</div>
		</div>
		</div>
		<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">运行状态：</label>
			<div class="controls">
				${fns:getDictLabel(cmCiInstance.ciStatusA,'ci_status_a',cmCiInstance.ciStatusA)}
			</div>
		</div>
		<div class="control-group span6">
			<label class="control-label">使用状态：</label>
			<div class="controls">
				${fns:getDictLabel(cmCiInstance.ciStatusB,'ci_status_b',cmCiInstance.ciStatusB)}
			</div>
		</div>
		</div>
		<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">配置项版本：</label>
			<div class="controls">
				${cmCiInstance.ciVersion}
			</div>
		</div>
		<div class="control-group span6">
			<label class="control-label">配置项分类：</label>
			<div class="controls">
				${cmCiInstance.cmCiGroup.groupName }
			</div>
		</div>
		</div>
		<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">创建人：</label>
			<div class="controls">
				${cmCiInstance.createBy.name}
			</div>
		</div>
		<div class="control-group span6">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<fmt:formatDate value="${cmCiInstance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		</div>
		<table class="table">
	 		<tr><td>通用属性</td></tr>
	 		<tr><td></td></tr>
		</table>
		<div class="row-fluid">
			<div class="span6">
			<c:forEach items="${TYProperty }" var="ciProperty" varStatus="status">
				<c:if test="${status.count%2!=0}">
				<div class="control-group">
					<label class="control-label">${ciProperty.property.propertyName}：</label>
					<div class="controls">
						${ciProperty.propertyValue}
					</div>
				</div>
				</c:if>
			</c:forEach>
			</div>
			<div class="span6">
			<c:forEach items="${TYProperty }" var="ciProperty" varStatus="status">
				<c:if test="${status.count%2==0}">
				<div class="control-group">
					<label class="control-label">${ciProperty.property.propertyName}：</label>
					<div class="controls">
						${ciProperty.propertyValue}
					</div>
				</div>
				</c:if>
			</c:forEach>
			</div>
		</div>	
		<table class="table">
			<tr><td>专有属性</td></tr>
			<tr><td></td></tr>
		</table>
		<div class="row-fluid">
			<div class="span6">
			<c:forEach items="${ZYProperty }" var="ciProperty" varStatus="status">
				<c:if test="${status.count%2!=0}">
				<div class="control-group">
					<label class="control-label">${ciProperty.property.propertyName}：</label>
					<div class="controls">
						${ciProperty.propertyValue}
					</div>
				</div>
				</c:if>
			</c:forEach>
			</div>
			<div class="span6">
			<c:forEach items="${ZYProperty }" var="ciProperty" varStatus="status">
				<c:if test="${status.count%2==0}">
				<div class="control-group">
					<label class="control-label">${ciProperty.property.propertyName}：</label>
					<div class="controls">
						${ciProperty.propertyValue}
					</div>
				</div>
				</c:if>
			</c:forEach>
			</div>
		</div>
		<div class="form-actions">
			<c:if test="${ciDetailType != 'hmCiDetail' }">
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</c:if>
		</div>
	</form:form>
</body>
</html>