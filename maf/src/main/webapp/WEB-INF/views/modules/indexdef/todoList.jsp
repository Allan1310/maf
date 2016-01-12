<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<div class="new-update clearfix" id="form_info">
	    <div class="search_y">
	        <input class="search_input_y" name="title" placeholder="任务名称" type="text">
	        <button class="search_btn_y" onclick="clickSearchFn(this)">任务查询</button>
	    </div>
	</div>
	<div class="new-update clearfix">
	    <div class="span1 tcenter"></div>
	    <div class="span1 tcenter">序号</div>
	    <div class="span4">任务名称</div>
	    <div class="span3 tcenter">发起时间</div>
	    <div class="span3 tcenter">发起人</div>
	</div>
	<!-- 最好每一个div中加一个title -->
	<c:forEach items="${list}" var="act" varStatus="varstatus">
	<c:set var="task" value="${act.task}" />
	<c:set var="hisProcIns" value="${act.hisProcIns}" />
	<c:set var="vars" value="${act.vars}" />
	<c:set var="procDef" value="${act.procDef}" />
	<c:set var="status" value="${act.status}" />
	<c:if test="${varstatus.index+1 <6 }">
	<div class="new-update clearfix">
	    <div class="span1 tcenter font_zi">■</div>
	    <div class="span1 tcenter">${varstatus.index+1}</div>
	    <div class="span4 ">
	    	<c:if test="${empty task.assignee}">
	    		${fns:getUser().name}
				<a href="javascript:claim('${task.id}');" title="签收任务">${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a>
			</c:if>
			<c:if test="${not empty task.assignee}">
				<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
			</c:if>
	    </div>
	    <div class="span3 tcenter"><fmt:formatDate value="${task.createTime}" type="both"/></div>
	    <div class="span3 tcenter">${fns:getByLoginName(hisProcIns.startUserId).name}</div>
	</div>
	</c:if>
	</c:forEach>
  	<div class="new-update clearfix moreDetail"><a href="${ctx}/act/task/todo/" target="mainFrame">显示更多</a></div>