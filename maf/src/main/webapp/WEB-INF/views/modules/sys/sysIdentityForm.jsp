<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>流水号管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				rules: {
				 	alias: {remote: "${ctx}/sys/sysIdentity/checkAlias?oldAlias=" + encodeURIComponent('${sysIdentity.alias}')}
				},
				messages: {
					alias: {remote: "流水号已存在"},
				},
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
		<li><a href="${ctx}/sys/sysIdentity/">流水号列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysIdentity/form?id=${sysIdentity.id}">流水号<shiro:hasPermission name="sys:sysIdentity:edit">${not empty sysIdentity.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysIdentity:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysIdentity" action="${ctx}/sys/sysIdentity/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">流水号名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="20" class="required"/>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">别名:</label>
			<div class="controls">
				<form:input path="alias" htmlEscape="false" maxlength="10" class="required"/>
				<span class="help-inline"><font color="red">*</font> 英文，必须唯一</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生成规则:</label>
			<div class="controls">
				<form:input path="rule" htmlEscape="false" maxlength="50"  placeholder="" class="required"/>
				<span class="help-inline"><font color="red">*</font> 特殊表达式：{yyyy}{MM}{dd}{NO}</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生成类型:</label>
			<div class="controls">
				<form:select path="genEveryDay" >
					<form:options items="${fns:getDictList('sys_identity_create')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">序号长度:</label>
			<div class="controls">
				<form:input path="noLength" htmlEscape="false" maxlength="11" class="required"/>
				<span class="help-inline"><font color="red">*</font> {NO},如果长度为5，当前流水号为5，则在流水号前补4个0，表示为00005</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">初始值:</label>
			<div class="controls">
				<form:input path="initValue" htmlEscape="false" maxlength="11" class="required number"/>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">增长步长:</label>
			<div class="controls">
				<form:input path="step" htmlEscape="false" maxlength="11" class="required number"/>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">当前值:</label>
			<div class="controls">
				<form:input path="curValue" htmlEscape="false" maxlength="11" class=""/>
				<span class="help-inline">不建议修改</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysIdentity:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>