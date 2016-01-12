<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更申请管理</title>
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
		<li><a href="${ctx}/cm/cmCiApply/">变更申请列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiApply/form?id=${cmCiApply.id}">变更申请<shiro:hasPermission name="cm:cmCiApply:edit"></shiro:hasPermission><shiro:lacksPermission name="cm:cmCiApply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiApply" action="${ctx}/cm/cmCiApply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">配置项变更类型：</label>
			<div class="controls">
				<form:select path="handle" cssClass="input-xlarge ">
					<form:option value="0">配置项新增</form:option>
					<form:option value="1">配置项修改</form:option>
					<form:option value="2">配置项删除</form:option>
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiApply:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="发  起"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>