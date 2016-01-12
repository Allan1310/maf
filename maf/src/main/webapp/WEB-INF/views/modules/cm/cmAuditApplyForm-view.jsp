<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项审计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmAuditApply/">审计计划列表</a></li>
		<li class="active"><a href="#">审计计划查看</a></li>
	</ul>
	<form:form class="form-horizontal">
		<sys:message content="${message}"/>
		<table class="table table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:middle; text-align:right;font-size:16px;" colspan="3" >审计申请单</th>
					<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">审计对象*</th>
					<td>
						${cmAuditApply.auditObject }
					</td>
					<th style="text-align:right;" width="11%">审计项目*</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计日期*</th>
					<td>
						${cmAuditApply.auditTime }
					</td>
					<th style="text-align:right;" width="11%">审计人员*</th>
					<td>
						${cmAuditApply.auditUser }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计触发条件*</th>
					<td colspan="4">
						${cmAuditApply.auditCondition }
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table class="table table-bordered ">
							<tr>
								<th style="text-align:right;" width="11%">审计范围</th>
								<td>${cmAuditApply.auditScope }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计数据收集方法</th>
								<td>${cmAuditApply.auditDataMethods }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计方式</th>
								<td>${cmAuditApply.auditMode }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计安排</th>
								<td>${cmAuditApply.auditPlan }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计步骤</th>
								<td>${cmAuditApply.auditSteps }</td>
							</tr>
							<c:if test="${idTrack }">
							<tr>
								<th style="text-align:right;" width="11%">问题及跟踪</th>
								<td colspan="4">
									<table class="table table-striped table-bordered table-condensed">
										<tr>
											<td>配置项编号</td>
											<td>问题</td>
											<td>责任人</td>
											<td>解决状态</td>
											<td>计划解决时间</td>
											<td>实际解决时间</td>
										</tr>
										<c:forEach items="${CmAuditTrackList }" var="cmAuditTrack" varStatus="status">
										<tr>
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
							</c:if>
						</table>
					</td>
				</tr>
				<c:if test="${taskDefKey == 'ciManagerAudit'}">
				<tr>
					<th style="text-align:right;" width="11%">审计报告*</th>
					<td colspan="3">
						<a href="${ctx}/cm/cmAuditApply/report?id=${cmAuditApply.id}">查看审计报告</a>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		<c:if test="${cmAuditApply.status != 0}">
			<act:histoicFlow procInsId="${cmAuditApply.act.procInsId}"  procDefId="${cmAuditApply.act.procDefId}"/>
		</c:if>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<br>
	
</body>
</html>