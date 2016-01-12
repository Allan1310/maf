<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		$("input[name=itemRadio]").each(function(){
			$(this).click(function(){
				var selectedValue = $(this).val();
                $("#tempItemManage").val(selectedValue);
			});
		});
		var spId = '${param.spId}';
		if(spId != null && spId != ''){
			$("#"+spId).attr("checked",true);
		}
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
		<li class="active"><a href="${ctx}/item/itemManage/">选择项目</a></li>
	</ul>
	<input type="hidden" id="tempItemManage" value=""/>
	<form:form id="searchForm" modelAttribute="itemManage" action="${ctx}/item/itemManage/selectList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label><form:input path="name" value="${itemManage.name}" class=""/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>项目名称</th>
				<th>项目版本</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="itemManage">
			<tr>
				<td>
				<input type="radio" id="${itemManage.id}" name="itemRadio" value="${itemManage.id}||${itemManage.name}"/>
				</td>
				<td>${itemManage.name}</td>
				<td>${itemManage.version}</td>
				<td><fmt:formatDate value="${itemManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>