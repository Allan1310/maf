<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>办结的流程</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/dialog.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".activityId").click(function(){
			$("#activityNodeImg").attr("src","${ctx }/sys/workflow/process/trace/auto/"+$(this).attr('pid'));
			$.jBox($("#activityBox").html(), {title:"当前节点", width: 700,buttons:{"关闭":true}});
		});
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
	<div id="activityBox" class="hide" >
		<img id="activityNodeImg" alt="当前节点"  src="${ctxStatic }/images/loading.gif">
	</div>
	
	<ul class="nav nav-tabs">
		<li ><a href="${ctx}/act/task/listRunningProcessInstances">运行的流程</a></li>
		<li class="active"><a href="${ctx}/act/task/listCompletedProcessInstances">结束的流程</a></li>
	</ul>

	<sys:message content="${message}"/>
	<form:form id="searchForm" modelAttribute="processDefinition" action="${ctx}/act/task/listCompletedProcessInstances" method="post">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
      <tr>
        <th>任务名称</th>
        <th width=100>申请人</th>
        <th width=140>开始时间</th>
        <th width=140>结束时间</th>
        <th width=120>当前状态</th>
      </tr>
    </thead>

    <tbody>
      	<c:forEach items="${page.list}" var="act" varStatus="status">
      	<c:set var="task" value="${act.hisProcIns}" />
		<c:set var="vars" value="${act.vars}" />
		<c:set var="procDef" value="${act.procDef}" />
		<c:set var="status" value="${act.status}" />
			<TR>
				<TD><a href="${ctx}/act/task/form?taskId=&taskName=&taskDefKey=&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=view">[${act.procDef.name}]${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a></td>
				<td>${user.name }</td>
				<td><fmt:formatDate value="${act.hisProcIns.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	   			<td><fmt:formatDate value="${act.hisProcIns.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	   			<td>已结束</td>
				
	   			
	    	</TR>
		</c:forEach>
    </tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
