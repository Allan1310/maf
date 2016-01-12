<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项模型</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!checkInfo())return false;
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
			/* 
			$("#btnSave").click(function(){
				$.post("${ctx}/cm/cmCiInstance/model", { groupId: $("#parentId").val() });
			}); */
		});
		
		function checkInfo(){
			var ciName = $("#ciName").val();
			var isBalnk = true;
			$("#inputForm input[name='ciName']").each(function(){
				if(ciName == ''){
					$.jBox.error('请输入模型名称', '错误');
	       			isBalnk = false;
	       			return false;
				}
			});
			if($("#parentId").val() == ''){
				$.jBox.error('请选择模型分类', '错误');
       			isBalnk = false;
       			return false;
			}
			if(!isBalnk) return false;
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiInstance/model">模型列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiInstance/modelForm">模型添加</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/modelSave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="row">
			<div class="control-group span6">
				<label class="control-label">模型名称：</label>
				<div class="controls">
					<form:input path="ciName" htmlEscape="false" maxlength="50" class="input-large " id="ciName"/>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6">
				<label class="control-label">所属分类：</label>
				<div class="controls">
					<sys:treeselect id="parent" name="cmCiGroup" value="${cmCiInstance.cmCiGroup.id}" labelName="parent.name" labelValue="${cmCiInstance.cmCiGroup.groupName}"
						title="配置项分类" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="input-larget" allowClear="true" notAllowSelectParent="true" />
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="remarks" htmlEscape="false" maxlength="50" class="input-large "/>
				</div>
			</div>
		</div>
		
		<div class="form-actions" id="form-actions">
			<shiro:hasPermission name="cm:cmCiInstance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>