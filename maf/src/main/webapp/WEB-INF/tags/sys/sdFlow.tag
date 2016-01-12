<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="groupId" type="java.lang.String" required="false" description="分类ID"%>
<%@ attribute name="serviceApplyId" type="java.lang.String" required="false" description="服务需求ID"%>

<div id="serviceDemand">
	正在获取服务需求内容...
</div>
<script type="text/javascript">
	$.get("${ctx}/sd/sdServiceApply/serviceDemandForm?id=${serviceApplyId}&sdGroup.id=${groupId}&view=view", function(data){
		$("#serviceDemand").html(data);
	});
</script>