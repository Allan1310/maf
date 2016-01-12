<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置管理操作日志管理</title>
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
		
		function reportExport(){
			$.jBox.confirm('确定要导出日志数据吗？', '提示', function (v, h, f) {
				if (v == 'ok') {
					location.href = "${ctx}/cm/cmHandleLog/export?startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val();
				}
			});
		}
		
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cmHandleLog" action="${ctx}/cm/cmHandleLog/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>操作人：</label>
				<form:input path="handler" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li><label>操作日期：</label>
				<input id="startTime" name="startTime" type="text" value="${startTime }" class="Wdate required input-medium"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});">-<input id="endTime" name="endTime" type="text" value="${endTime }"  class="Wdate required input-medium"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});">
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><a href="#" class="btn btn-primary"  onclick="reportExport();"><i class="icon-download icon-white "></i>导出</a></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>操作日期</th>
				<th>操作人</th>
				<th>实体</th>
				<!-- <th>工单编号</th> -->
				<th>描述</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmHandleLog">
			<tr>
				<td style="width: 140px">${cmHandleLog.handleTime }</td>
				<td style="width: 120px">${cmHandleLog.handler }</td>
				<td style="width: 260px">${cmHandleLog.entityId }</td>
				<%-- <td>${cmHandleLog.ciApplyId }</td> --%>
				<td>${cmHandleLog.remarks }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>