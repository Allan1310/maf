<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务委托申请管理</title>
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
		<li><a href="${ctx}/sys/bpmDelegateApply/">任务委托申请列表</a></li>
		<li class="active"><a href="${ctx}/sys/bpmDelegateApply/form?id=${bpmDelegateApply.id}">任务委托申请<shiro:hasPermission name="sys:bpmDelegateApply:edit">${not empty bpmDelegateApply.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:bpmDelegateApply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bpmDelegateApply" action="${ctx}/sys/bpmDelegateApply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">委托人*：</label>
			<div class="controls">
				<sys:treeselect id="user" name="assigneeUser.id" value="${bpmDelegateApply.assigneeUser.id}" labelName="user.name" labelValue="${bpmDelegateApply.assigneeUser.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required"  allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托开始时间*：</label>
			<div class="controls">
				<input id="startTime" name="startTime" type="text" maxlength="20" readonly="readonly" class="Wdate required input-large" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托结束时间*：</label>
			<div class="controls">
				<input name="endTime" type="text" maxlength="20" readonly="readonly" class="Wdate required input-large" onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:bpmDelegateApply:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>