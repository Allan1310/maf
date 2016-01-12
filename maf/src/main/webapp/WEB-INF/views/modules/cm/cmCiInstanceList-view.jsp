<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var oldIdValue = top.mainFrame.$("#ciId").val();
			var oldNumberValue = top.mainFrame.$("#ciNumber").val();
			var titleValue="";
			var idValue="";
			var i=0;
			if(oldIdValue!=''){
				idValue=oldIdValue;
				titleValue=oldNumberValue;
				i=1;
			}
			$("input[name=id]").each(function(){
				$(this).click(function(){
					var id = $(this).val(), title = $(this).attr("title");
					if($(this).attr("checked")){
						if(i==0){
							idValue = id;
							titleValue = title;
						}else{
							idValue = idValue+";"+id;
							titleValue = titleValue+";"+title;
						}
						top.mainFrame.ciSelectAddOrDel(idValue, titleValue,"add");
						i++;
					}else{
						if(idValue.indexOf(";")>-1){
							if(idValue.indexOf(id) == 0){
								idValue = idValue.replace(id+";","");
								titleValue = titleValue.replace(title+";","");
							}else{
								idValue = idValue.replace(";"+id,"");
								titleValue = titleValue.replace(";"+title,"");
							}
						}else{
							idValue = idValue.replace(id,"");
							titleValue = titleValue.replace(title,"");
						}
						top.mainFrame.ciSelectAddOrDel(id, title,"del");
						if(idValue == ''){
							i=0;
						}
					}
					
				});
				
			});
			
			if(oldIdValue.indexOf(";")>-1){
				var oldIdValues = oldIdValue.split(";");
				for(var j=0;j<oldIdValues.length;j++){
					$("input[name=id]").each(function(){
						var id = $(this).val();
						if(oldIdValues[j]==id){
							$(this).attr("checked",true);
						}
					});
				}
			}else{
				$("input[name=id]").each(function(){
					var id = $(this).val();
					if(oldIdValue==id){
						$(this).attr("checked",true);
					}
				});
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
		<li class="active"><a href="#">配置项列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/listView?status=${cmCiInstance.status }" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table>
			<tr>
				<td width="85">配置项名称 ：</td><td><form:input path="ciName" htmlEscape="false" maxlength="50" class="input-medium"/></td>
				<td width="90">&nbsp;&nbsp;&nbsp;运行状态：</td>
				<td>
					<form:select path="ciStatusA" maxlength="1" cssStyle="width:180px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_a')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
				<td width="90">&nbsp;&nbsp;&nbsp;使用状态：</td>
				<td>
					<form:select path="ciStatusB" maxlength="1" cssStyle="width:180px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_b')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<td>配置项分类：</td>
				<td>
					<sys:treeselect id="parent" name="cmCiGroup.id" value="${cmCiInstance.cmCiGroup.id}" labelName="parent.name" labelValue="${cmCiInstance.cmCiGroup.groupName}"
						title="配置项分类" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
				</td>
				<td>&nbsp;&nbsp;
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				</td>
			</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th width="15%">配置项编号</th>
				<th width="15%">配置项版本</th>
				<th width="15%">配置项名称</th>
				<th width="7%">运行状态</th>
				<th width="7%">使用状态</th>
				<th width="12%">配置项分类</th>
				<th width="15%">创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmCiInstance" varStatus="status">
			<tr>
				<td><input type="checkbox" name="id" value="${cmCiInstance.id}" title="${cmCiInstance.ciNumber}"/></td>
				<td>${cmCiInstance.ciNumber}</td>
				<td>${cmCiInstance.ciVersion}</td>
				<td>${cmCiInstance.ciName}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusA, "ci_status_a", cmCiInstance.ciStatusA)}</td>
				<td>${fns:getDictLabel(cmCiInstance.ciStatusB, "ci_status_b", cmCiInstance.ciStatusB)}</td>
				<td>${cmCiInstance.cmCiGroup.groupName}</td>
				<td><fmt:formatDate value="${cmCiInstance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>