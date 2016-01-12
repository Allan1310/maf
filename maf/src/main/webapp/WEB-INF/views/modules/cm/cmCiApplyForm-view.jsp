<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更申请管理</title>
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
		<li><a href="${ctx}/cm/cmCiApply/">变更申请列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiApply/form?id=${cmCiApply.id}">变更申请</a></li>
	</ul><br/>
	<form:form class="form-horizontal">
		<sys:message content="${message}"/>		
		<fieldset>
			<table class="table-form">
				<tr>
					<td class="tit" style="width: 200px;">申请人</td>
					<td>${cmCiApply.user.name }</td>
				</tr>
				<tr>
					<td class="tit">所在部门</td>
					<td>${cmCiApply.office.name }</td>
				</tr>
				<tr>
					<td class="tit">配置项变更类型</td>
					<td colspan="5">
						<c:if test="${cmCiApply.handle == '0' }">配置项新增</c:if>
						<c:if test="${cmCiApply.handle == '1' }">配置项修改</c:if>
					</td>
				</tr>
				<tr>
					<td class="tit">配置项</td>
					<td colspan="5">${cmCiApply.ciNumber}</td>
				</tr>
			</table>
		</fieldset>
		<act:histoicFlow procInsId="${cmCiApply.act.procInsId}"  procDefId="${cmCiApply.act.procDefId}"/>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>