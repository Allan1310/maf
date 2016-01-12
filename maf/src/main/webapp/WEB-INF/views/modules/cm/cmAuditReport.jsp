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
	<style type="text/css">
		.file-box{ position:relative;width:340px} 
		.txt{ height:22px; border:1px solid #cdcdcd; width:180px;} 
		.file{ position:absolute; top:0; right:80px; height:24px; filter:alpha(opacity:0);opacity: 0;width:260px } 
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmAuditApply/">审计计划列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmAuditApply/report">审计报告</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/reportExport" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:right; text-align:center;font-size:16px;" colspan="3" >CMDB审计报告</th>
					<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">报告编号</th>
					<td>
						${cmAuditApply.auditNumber}
					</td>
					<th style="text-align:right;" width="11%">报告日期</th>
					<td>
						${cmAuditApply.auditTime }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">项目名称</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
					<th style="text-align:right;" width="11%">项目编号</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计目的</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
					<th style="text-align:right;" width="11%">审计时间</th>
					<td>
						${cmAuditApply.auditTime }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计组人员</th>
					<td colspan="4">
						${cmAuditApply.auditUser }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计范围</th>
					<td colspan="4">
						${cmAuditApply.auditScope }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">问题及跟踪</th>
					<td colspan="4">
						<table class="table table-striped table-bordered table-condensed">
							<tr>
								<td>编号</td>
								<td>配置项编号</td>
								<td>问题</td>
								<td>责任人</td>
								<td>解决状态</td>
								<td>计划解决时间</td>
								<td>实际解决时间</td>
							</tr>
							<c:forEach items="${CmAuditTrackList }" var="cmAuditTrack" varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>
								<c:forEach items="${cmAuditTrack.maps }" var="map">
								<a href="${ctx}/cm/cmCiInstance/form?id=${map.ciId}&view=view">${map.ciName}</a>
								</c:forEach>
								</td>
								<td>${cmAuditTrack.question }</td>
								<td>${cmAuditTrack.dutyOfficer.name }</td>
								<td>${cmAuditTrack.solveStatus }</td>
								<td>${cmAuditTrack.planSolveTime }</td>
								<td>${cmAuditTrack.realitySolveTime }</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计结果</th>
					<td colspan="3">
						<c:if test="${cmAuditApply.auditResult == 1}">
							<input type="radio" checked="checked" title="通过审计"/>通过审计
						</c:if>
						<c:if test="${cmAuditApply.auditResult == 0}">
							<input type="radio" checked="checked" title="未通过审计"/>未通过审计
						</c:if>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计员签名</th>
					<td colspan="3">
						<input type="text" class="required" value="${cmAuditApply.auditSign }" readonly="readonly"/>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmAuditApply:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="报告导出"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>