<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>运行的流程</title>
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

    function hasten(title,id,lastHastenTime){
    	var nowDate = new Date();
		var mydate =  new Date(Date.parse(lastHastenTime.replace(/-/g,   "/")));
		if((nowDate.getTime()-mydate.getTime()) < 2*60*60*1000){
			$.jBox.info('催办失败，两次催办时间间隔未超过2小时', '提示');
			return;
		}
    	$.jBox.confirm('此任务'+title+'，确定要催办吗？', '提示', function (v, h, f) {
            if (v == 'ok') {
            	 $.ajax({
                     type: "post",
                     async:false,
                     url: "${ctx}/act/task/hasten",
                     dataType: "json",
                     data:'id='+id,
                     success: function(data){
        	            if(data == true){
        	            	$.jBox.success('催办成功','催办',{buttons:{"确定":'ok'},submit:function (d, b, c){
        	            		if(d == 'ok'){
        	            			location.reload();
        	            		}
        	            	}});
            	        }else{
            	        	$.jBox.error("催办失败，两次催办时间间隔未超过2小时");
                 	    }
        		     }
                 });
            }
            return true;
  		});
       
		
    }
</script>

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/act/task/listRunningProcessInstances">运行的流程</a></li>
		<li><a href="${ctx}/act/task/listCompletedProcessInstances">结束的流程</a></li>
	</ul>

	<sys:message content="${message}"/>
	<form:form id="searchForm" modelAttribute="processDefinition" action="${ctx}/act/task/listRunningProcessInstances" method="post">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<div style="padding-bottom: 8px;">
		<i class="icon-exclamation-sign"></i>若为任务紧急，可点击催办按钮，将及时发送任务催办邮件给当前任务处理人员，每次催办间隔至少需要两个小时
	</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
      <tr>
        <th>任务名称</th>
        <th width=100>申请人</th>
        <th width=140>开始时间</th>
        <th width=100>当前状态</th>
        <th width=130>操作</th>
      </tr>
    </thead>

    <tbody>
      	<c:forEach items="${page.list}" var="act" varStatus="status">
     	<c:set var="task" value="${act.task}" />
		<c:set var="vars" value="${act.vars}" />
		<c:set var="procDef" value="${act.procDef}" />
		<c:set var="status" value="${act.status}" />
			<TR>
				<TD><a href="${ctx}/act/task/form?taskId=&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=view">[${act.procDef.name}]${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a></td>
				<td>${user.name }</td>
				<td><fmt:formatDate value="${act.hisProcIns.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	   			<td>
				<a href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${act.hisProcIns.processDefinitionId}&processInstanceId=${act.hisProcIns.id}"  title="点击查看流程图">查看</a>
				</td>
				<td>
					<a title="将流程处理撤销到重申请节点" onclick="return confirmx('确认要撤销该审批流程吗？', this.href)" href="${ctx}/act/task/withdraw?processInstanceId=${act.procInsId}&type=draw">撤销</a>&nbsp;|&nbsp;
					<a title="终止此流程"  onclick="return confirmx('确认要终止该审批流程吗？', this.href)" href="${ctx}/act/task/withdraw?processInstanceId=${act.procInsId}&type=stop">终止</a>&nbsp;|&nbsp;
					<a title="${act.hastenTask }" href="javascript:hasten('${act.hastenTask}','${act.hisProcIns.id }','${act.hastenTask.lastHastenTime}');" title="${act.hastenTask }">催办</a>
				</td>
	    	</TR>
		</c:forEach>
    </tbody>
	</table>
	
	<div class="pagination">${page}</div>
	
	
</body>
</html>
