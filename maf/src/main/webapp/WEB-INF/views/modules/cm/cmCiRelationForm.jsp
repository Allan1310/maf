<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项关联管理</title>
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		<li><a href="#">配置项查看<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiInstance/listVersion?id=${ciInstance.id}">配置项版本<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li class="active"><a href="${ctx}/cm/cmCiRelation/form?id=${cmCiRelation.id}">关联添加<shiro:lacksPermission name="cm:cmCiInstance:edit">查看</shiro:lacksPermission></a></li>
		<li><a href="#">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="#">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiRelation" action="${ctx}/cm/cmCiRelation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="ciInstance.id" htmlEscape="false" maxlength="10" class="input-xlarge "/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<label class="control-label">关系配置项编号：</label>
			<div class="controls">
				<sys:treeselect id="groupId" name="reCiInstance.id"  value="${cmCiRelation.reCiInstance.id}" labelName="reCiInstance.ciName" labelValue="${cmCiRelation.reCiInstance.ciName}"
							title="配置项" url="/cm/cmCiGroup/treeData?type=4"  allowClear="true" notAllowSelectParent="true" />
			</div>
		</div>	
		<div class="control-group">
			<label class="control-label">关系类型：</label>
			<div class="controls">
				<form:select path="relationType" htmlEscape="false" maxlength="2" class="input-xlarge ">
					<form:options items="${fns:getDictList('ci_relation_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">配置项名称：</label>
			<div class="controls">
				<input type="text" readonly="readonly" value="${ciInstance.ciName }">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">配置项版本号：</label>
			<div class="controls">
				<form:input path="ciVersion" htmlEscape="false" readonly="true" cssClass="width:270px;" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiInstance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>