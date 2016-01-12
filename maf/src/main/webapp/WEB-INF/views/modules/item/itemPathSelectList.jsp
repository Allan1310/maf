<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>路径管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		$("input[name=pathRadio]").each(function(){
			$(this).click(function(){
				var selectedValue = $(this).val();
                $("#tempItemPath").val(selectedValue);
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
		<li class="active"><a href="${ctx}/item/itemPath/">选择路径</a></li>
	</ul>
	<input type="hidden" id="tempItemPath" value=""/>
	<form:form id="searchForm" modelAttribute="itemPath" action="${ctx}/item/itemPath/selectList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label><form:input path="itemName" value="${itemPath.itemName}" class=""/></li>
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
				<th>路径名称</th>
				<th>路径表达式</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="itemPath">
			<tr>
				<td>
				<input type="radio" id="${itemPath.id}" name="pathRadio" value="${itemPath.itemId}||${itemPath.itemName}||${itemPath.id}||${itemPath.itemPath}"/>
				</td>
				<td>${itemPath.itemName}</td>
				<td>${itemPath.itemPath}</td>
				<td>${itemPath.expression}</td>
				<td><fmt:formatDate value="${itemPath.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>