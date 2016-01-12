<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/cm/cm.property.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!checkProperty())return false;
					loading('正在提交，请稍等...');
					form.submit();
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
		});
		/*
		 * 校验属性
		 */
		function checkProperty(){
			var propertyName=$("#propertyName").val();
			var propertyType=$("#propertyType").val();
			var dataType=$("#dataType").val();
			var flag = true;
			if($("#id").val()==''){
				$.ajax({
					type : 'POST',
					async:false,
					url : '${ctx}/cm/cmPropertyManage/check',  
					data : 'propertyName='+propertyName+'&propertyType='+propertyType+'&dataType='+dataType,  
					success : function(data) {  
						if(data!='ok'){
							$.jBox.error(data, '错误');
							flag = false;
						}	
					} 
				});
			}
			if(!flag) return false;
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmPropertyManage/">属性列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmPropertyManage/form?id=${cmPropertyManage.id}">属性<shiro:hasPermission name="cm:cmPropertyManage:edit">${not empty cmPropertyManage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmPropertyManage:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmPropertyManage" action="${ctx}/cm/cmPropertyManage/save" method="post" class="form-horizontal">
		<form:hidden id="id" path="id"/>
		<sys:message content="${message}"/>
		<c:if test="${not empty cmPropertyManage.id}">
			<c:if test="${isRelation == 'false'}">
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">属性名称*：</label>
					<div class="controls">
						<form:input id="propertyName" path="propertyName" htmlEscape="false" maxlength="15"  class="required"/>
					</div>
				</div>
				<div class="control-group span6">
					<label class="control-label">属性描述*：</label>
					<div class="controls">
						<form:input path="propertyDesc" htmlEscape="false" maxlength="100" class="required "/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">是否必填*：</label>
					<div class="controls">
						<form:select path="isNull" htmlEscape="false" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:option value="0">必填</form:option>
							<form:option value="1">非必填</form:option>
						</form:select>
					</div>
				</div> 
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">数据类型*：</label>
					<div class="controls">
						<form:select id="dataType" path="dataType" maxlength="1" cssStyle="width:220px;" class="required " onchange="properTypeSelect()">
							<form:options items="${fns:getDictList('cm_property_data')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<c:if test="${cmPropertyManage.dataType == '2' }">
					<div id="selectType" class="control-group span6">
						<label class="control-label">下拉信息*：</label>
						<div class="controls">
							<form:select id="ext1" path="ext1" maxlength="1" cssStyle="width:220px;" class="required ">
								<form:options items="${fns:findDictType()}" itemLabel="description" itemValue="type" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</c:if>
				<div id="selectType" class="control-group span6" style="display: none;">
					<label class="control-label">下拉信息*：</label>
					<div class="controls">
						<form:select id="ext1" path="ext1" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:options items="${fns:findDictType()}" itemLabel="description" itemValue="type" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<c:if test="${cmPropertyManage.dataType == '3' }">
					<div id="widgetType" class="control-group span6">
						<label class="control-label">控件类型*：</label>
						<div class="controls">
							<form:select id="ext2" path="ext2" maxlength="1" cssStyle="width:220px;" class="required ">
								<form:options items="${fns:getDictList('cm_property_widget')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</c:if>
				<c:if test="${cmPropertyManage.dataType != '3' }">
				<div id="widgetType" class="control-group span6" style="display: none;">
					<label class="control-label">控件类型*：</label>
					<div class="controls">
						<form:select id="ext2" path="ext2" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:options items="${fns:getDictList('cm_property_widget')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				</c:if>
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">排序*：</label>
					<div class="controls">
						<form:input path="sort" htmlEscape="false" maxlength="50"  class="number required"/>
					</div>
				</div>
			</div>
			</c:if>
			<c:if test="${isRelation == 'true'}">
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">属性描述*：</label>
					<div class="controls">
						<form:input path="propertyDesc" htmlEscape="false" maxlength="100" class="required "/>
					</div>
				</div>
				<div class="control-group span6">
					<label class="control-label">是否必填*：</label>
					<div class="controls">
						<form:select path="isNull" htmlEscape="false" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:option value="0">必填</form:option>
							<form:option value="1">非必填</form:option>
						</form:select>
					</div>
				</div> 
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">排序*：</label>
					<div class="controls">
						<form:input path="sort" htmlEscape="false" maxlength="50"  class="number required"/>
					</div>
				</div>
			</div>
			</c:if>
		</c:if>
		<c:if test="${empty cmPropertyManage.id}">
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">属性名称*：</label>
					<div class="controls">
						<form:input id="propertyName" path="propertyName" htmlEscape="false" maxlength="15"  class="required"/>
					</div>
				</div>
				<div class="control-group span6">
					<label class="control-label">属性描述*：</label>
					<div class="controls">
						<form:input path="propertyDesc" htmlEscape="false" maxlength="100" class="required "/>
					</div>
				</div>
			</div>
			<div class="row">
				<div class=" control-group span6">
					<label class="control-label">属性类型*：</label>
					<div class="controls">
						<form:select id="propertyType" path="propertyType" maxlength="4" cssStyle="width:220px;"  class="required">
							<form:option value="TYSX"  htmlEscape="false">通用属性</form:option>
							<form:option value="ZYSX"  htmlEscape="false">专有属性</form:option>
						</form:select>
						<span style="color: red;">保存后不可修改！</span>
					</div>
				</div>
				<div class="control-group span6">
					<label class="control-label">是否必填*：</label>
					<div class="controls">
						<form:select path="isNull" htmlEscape="false" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:option value="0">必填</form:option>
							<form:option value="1">非必填</form:option>
						</form:select>
					</div>
				</div> 
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">数据类型*：</label>
					<div class="controls">
						<form:select id="dataType" path="dataType" maxlength="1" cssStyle="width:220px;" class="required " onchange="properTypeSelect()">
							<form:options items="${fns:getDictList('cm_property_data')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div id="selectType" class="control-group span6" style="display: none;">
					<label class="control-label">下拉信息*：</label>
					<div class="controls">
						<form:select id="ext1" path="ext1" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:options items="${fns:findDictType()}" itemLabel="description" itemValue="type" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div id="widgetType" class="control-group span6" style="display: none;">
					<label class="control-label">控件类型*：</label>
					<div class="controls">
						<form:select id="ext2" path="ext2" maxlength="1" cssStyle="width:220px;" class="required ">
							<form:options items="${fns:getDictList('cm_property_widget')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="control-group span6">
					<label class="control-label">排序*：</label>
					<div class="controls">
						<form:input path="sort" htmlEscape="false" maxlength="50"  class="number required"/>
					</div>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmPropertyManage:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>