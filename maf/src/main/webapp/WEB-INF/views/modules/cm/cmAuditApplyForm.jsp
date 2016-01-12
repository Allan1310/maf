<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项审计管理</title>
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
		<li><a href="${ctx}/cm/cmAuditApply/">审计计划列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmAuditApply/form?id=${cmAuditApply.id}">审计计划<shiro:hasPermission name="cm:cmAuditApply:edit">${not empty cmAuditApply.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmAuditApply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="flag" name="flag" value="0"/>
		<sys:message content="${message}"/>		
		<table class="table  table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:middle; text-align:center;font-size:16px;" colspan="3" >审计申请单</th>
					<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">审计对象*</th>
					<td>
						<form:input path="auditObject" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" />
					</td>
					<th style="text-align:right;" width="11%">审计编号*</th>
					<td>
						<span id="companyWorkYear" class="uneditable-input">系统自动计算</span>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计项目*</th>
					<td>
						<form:input path="auditProject" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" />
					</td>
					<th style="text-align:right;" width="11%">审计日期*</th>
					<td>
						<form:input path="auditTime" htmlEscape="false" maxlength="20" readonly="readonly" class="Wdate required input-large"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计人员*</th>
					<td>
						<form:input path="auditUser" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" />
					</td>
					<th style="text-align:right;" width="11%">审计目的*</th>
					<td>
						<form:input path="auditPurpose" htmlEscape="false" maxlength="20" class="required" style="width:210px;" />
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计触发条件*</th>
					<td colspan="3">
						<form:input path="auditCondition" htmlEscape="false" maxlength="20" class="required" style="width:210px;" />
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table class="table  table-bordered ">
							<tr>
								<th style="text-align:right;" width="11%">审计范围* </th>
								<td><textarea name="auditScope" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditScope }</textarea></td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计数据收集方法* </th>
								<td><textarea name="auditDataMethods" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditDataMethods }</textarea></td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计方式* </th>
								<td><textarea name="auditMode" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditMode }</textarea></td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计安排* </th>
								<td><textarea name="auditPlan" rows="5" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditPlan }</textarea></td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计步骤* </th>
								<td><textarea name="auditSteps" rows="5" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditSteps }</textarea></td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmAuditApply:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('1')"/>&nbsp;</shiro:hasPermission>
			<shiro:hasPermission name="cm:cmAuditApply:edit"><input id="btnSave" class="btn btn-primary" type="submit" value="保存草稿" onclick="$('#flag').val('0')"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>