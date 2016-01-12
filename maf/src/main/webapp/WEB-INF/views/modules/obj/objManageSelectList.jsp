<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>对象管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function() {
		
	});
	
	function checkedVals(){
		var str = '';
		$("input[name='objCheckbox']:checked").each(function(i){
			if(i==0){
				str = $(this).val();
			}else{
				str += ","+$(this).val();
			}
        });
		$.ajax({
			type : 'POST',
			async:false,
			url : '${ctx}/obj/objManage/getCheckedIds',  
			data : {tempCheckedIds:str},
			//dataType:'json',
			success : function(data) {
				//alert(data);
				$("#tempObjManage").val(data);
			} 
		});
	}
	
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
		<li class="active"><a href="#">选择路径列表</a></li>
	</ul>
	<input type="hidden" id="tempObjManage" value=""/>
	<form:form id="searchForm" modelAttribute="objManage" action="${ctx}/obj/objManage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label><input type="text" name="itemName" value="${objManage.itemName}" class="input-medium"/></li>
			<li><label>路径名称：</label><input type="text" name="pathName" value="${objManage.pathName}" class="input-medium"/></li>
			<li><label>对象名称：</label><input type="text" name="objName" value="${objManage.objName}" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>#</th>
				<th>项目名称</th>
				<th>路径名称</th>
				<th>对象名称</th>
				<th>xpath表达式</th>
				<th>jquery表达式</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="objManage" varStatus="vs">
		<tr>
			<td>
				<input type="checkBox" id="${objManage.id}" name="objCheckbox" value="${objManage.id}" onclick="checkedVals();"/>
			</td>
			<td>${objManage.itemName}</td>
			<td>${objManage.pathName}</td>
			<td>${objManage.objName}</td>
			<td>${objManage.xpathCode}</td>
			<td>${objManage.jqueryCode}</td>
			<td><fmt:formatDate value="${objManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>