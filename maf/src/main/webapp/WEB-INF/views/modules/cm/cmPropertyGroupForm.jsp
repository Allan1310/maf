<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分类属性关系管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit()
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			$("#searchButton").click(function(){
				var propertyName = $("#searchInput").val();
				$("#propretyName").val(propertyName);
				$("#searchForm").submit();
			});
		});
		
		function onWaitPropertySelect(index){
			var num = index;
			if($("#waitSelect"+index).is(':checked')){
				var newObject="";
				var id = $("#propertyId"+num).val();
				<c:forEach items="${ZYSXList }" var="property" varStatus="status">
				if("${property.id }" == id){
					var dataType="";
					<c:if test="${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType) == property.dataType}">
					dataType = "${fns:getDictLabel(property.dataType,'cm_property_widget',property.dataType)}";
				  	</c:if>
					<c:if test="${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType) != property.dataType}">
					dataType = "${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType)}";
					</c:if>
			
					newObject="<tr id='selected"+num+"'>"+
				   	"<td>${property.propertyName }<input type='hidden' name='propertyId' value='${property.id }'></td>"+
					"<td>"+dataType+"</td>"+
				   "</tr>";
				}
				</c:forEach>
				
				$("#selected tr:last").after(newObject);
			}else{
				delWaitSelect("selected"+num);
			}
			
		}
		
		function delWaitSelect(objId){
			$("#"+objId).remove();
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiGroup/list">分类列表</a></li>
		<shiro:hasPermission name="cm:cmCiGroup:edit"><li><a href="${ctx}/cm/cmCiGroup/form">分类添加</a></li></shiro:hasPermission>
		<shiro:hasPermission name="cm:cmCiGroup:edit"><li class="active"><a href="${ctx}/cm/cmPropertyGroup/">属性分配</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmPropertyGroup" action="${ctx}/cm/cmPropertyGroup/form?search=true" method="post" class="form-horizontal">
		<form:hidden path="groupId"/>
		<input type="hidden" name="searchInput" id="propretyName"/>
	</form:form>
	<form:form id="inputForm" modelAttribute="cmPropertyGroup" action="${ctx}/cm/cmPropertyGroup/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="groupId"/>
		<sys:message content="${message}"/>
		<div class="container-fluid">
	  	<div class="row-fluid">
	    	<div class="span5">
				<div class="control-group" >
					<label>属性选择：</label>
					<input type="text" id="searchInput"/>
					<input id="searchButton" class="btn btn-primary" type="button" value="查 询"/>
				</div>
				<div class="control-group" style="height: 350px; overflow-y:auto">
					<table class="table">
 						<tr><th width="150px;">属性名称</th><th>数据类型</th></tr>
					</table>
					<c:forEach items="${ZYSXList }" var="property" varStatus="status">
					<table class="table">
						<tr>
						<td width="150px;">
						<input type="hidden" id="propertyId${status.index }" value="${property.id }">
						${property.propertyName }
						</td>
						<td>
							<c:if test="${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType) == property.dataType}">
								${fns:getDictLabel(property.dataType,'cm_property_widget',property.dataType)}
						  	</c:if>
							<c:if test="${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType) != property.dataType}">
								${fns:getDictLabel(property.dataType,'cm_property_data',property.dataType)}
							</c:if>
						</td>
						<td width="30"><input type="checkbox" id="waitSelect${status.index}" onclick="onWaitPropertySelect('${status.index}')"></td>
						</tr>
					</table>
					</c:forEach>
				</div>
	    	</div>
	    	<div class="span5">
	    		<div class="control-group">
					<label>已选属性：</label>
				</div>
				<div class="control-group" id="selected">
					<table class="table">
 						<tr><th>属性名称</th><th>数据类型</th></tr>
					</table>
				</div>
	    	</div>
	  	</div>
		</div>	
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmPropertyGroup:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>