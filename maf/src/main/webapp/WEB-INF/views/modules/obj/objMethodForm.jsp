<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>对象方法管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
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
		<li><a href="${ctx}/obj/objMethod/">对象方法管理列表</a></li>
		<li class="active"><a href="${ctx}/obj/objMethod/form"><shiro:hasPermission name="obj:objMethod:edit">对象方法添加</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="objMethod" action="${ctx}/obj/objMethod/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
			
		<div class="control-group">
			<label class="control-label">对象类型:</label>
			<div class="controls">
				<form:select path="objType" style="width:140px" class="required">
					<option value="">请选择</option>
					<form:options items="${fns:getDictList('obj_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">方法名称:</label>
			<div class="controls">
				<form:input path="methodName" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">默认值:</label>
			<div class="controls">
				<form:input path="defaultVal" htmlEscape="false" maxlength="50" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">方法Code:</label>
			<div class="controls">
				<form:textarea path="methodCode" htmlEscape="false" rows="10" cssStyle="width:40%;" class="input-xlarge required"></form:textarea>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="obj:objMethod:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>