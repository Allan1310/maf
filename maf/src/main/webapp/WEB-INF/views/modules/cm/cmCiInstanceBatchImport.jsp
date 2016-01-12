<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		<li><a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}">配置项添加<shiro:hasPermission name="cm:cmCiInstance:edit"></shiro:hasPermission><shiro:lacksPermission name="cm:cmCiInstance:edit">查看</shiro:lacksPermission></a></li>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li class="active"><a href="${ctx}/cm/cmCiInstance/batchImport">批量导入</a></li></shiro:hasPermission>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/batchSave" method="post" enctype="multipart/form-data" class="form-horizontal">
		<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">上传文件：</label>
			<div class="controls">
				<input type="file" name="multipartFile" class="required"/>
			</div>
		</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiInstance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="批量导入"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>