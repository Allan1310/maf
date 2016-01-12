<%@page import="com.allinfnt.idc.modules.sys.entity.User"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息管理管理</title>
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
		<li class="active"><a href="${ctx}/msg/msgMsginfo/">消息列表</a></li>
		<shiro:hasPermission name="msg:msgMsginfo:edit"><li><a href="${ctx}/msg/msgMsginfo/form">消息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="msginfo" action="${ctx}/msg/msgMsginfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>接收人：</label>
				<form:input path="receiverName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="msgType" class="input-medium">
					<form:option value="" label="全部类型"/>
					<form:options items="${fns:getDictList('msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>发送人</th>
				<th>接收人名称</th>
				<th>计划发送时间</th>
				<th>实际发送时间</th>
				<th>消息类型</th>
				<th>发送状态</th>
				<shiro:hasPermission name="msg:msgMsginfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="msgMsginfo">
			<tr>
			<c:if test="${msgMsginfo.senderId==0 }">
				<td>系统</td>
			</c:if>
			<c:if test="${msgMsginfo.senderId==1 }">
				<td>${msgMsginfo.sendName }</td>
			</c:if>
				<td>${msgMsginfo.receiverName }</td>
				<td>
					<fmt:formatDate value="${msgMsginfo.planTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${msgMsginfo.actualTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(msgMsginfo.msgType, 'msg_type', '')}
				</td>
				<td>${fns:getDictLabel(msgMsginfo.backFlag, 'msg_status', '无')}</td>
				
				<c:if test="${msgMsginfo.backFlag!=0 }">
					<td><a href="${ctx}/msg/msgMsginfo/form?id=${msgMsginfo.id}">查看</a></td>
				</c:if>
				<c:if test="${msgMsginfo.backFlag==0 }">
					<shiro:hasPermission name="msg:msgMsginfo:edit"><td>
    				<a href="${ctx}/msg/msgMsginfo/form?id=${msgMsginfo.id}">修改</a>
					<a href="${ctx}/msg/msgMsginfo/cancel?id=${msgMsginfo.id}" onclick="return confirmx('确认要取消发送吗？', this.href)">取消</a>
				</td></shiro:hasPermission>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>