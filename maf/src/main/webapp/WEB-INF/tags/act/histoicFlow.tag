<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="procDefId" type="java.lang.String" required="false" description="流程定义ID"%>
<%@ attribute name="procInsId" type="java.lang.String" required="true" description="流程实例ID"%>
<%@ attribute name="startAct" type="java.lang.String" required="false" description="开始活动节点名称"%>
<%@ attribute name="endAct" type="java.lang.String" required="false" description="结束活动节点名称"%>
<fieldset>
	<legend>
	<c:if test="${not empty procDefId}">
	<a target="_blank" title="查看流程图" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${procDefId}&processInstanceId=${procInsId}">
	流转信息
	</a>
	</c:if>
	<c:if test="${empty procDefId}">
	流转信息
	</c:if>
	</legend>
	<div id="histoicFlowList">
		正在加载流转信息...
	</div>
</fieldset>
<script type="text/javascript">
	$.get("${ctx}/act/task/histoicFlow?procInsId=${procInsId}&startAct=${startAct}&endAct=${endAct}&t="+new Date().getTime(), function(data){
		$("#histoicFlowList").html(data);
		console.info(data);
	});
</script>