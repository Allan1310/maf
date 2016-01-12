<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分类管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			
			$("#iconButton").click(function(){
				top.$.jBox.open("iframe:${ctx}/cm/cmGraphIcon?view=view", "图标选择",350,350,{
					opacity: 0.3,persistent: true,buttons:{"确定":true}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
			});
		});
		
		/*
		 * 校验属性
		 */
		function checkGroup(){
			
			var parentId = $("#parentId").val();
			var groupName = $("#groupName").val();
			if($("#id").val() == null || $("#id").val() == ''){
				$.ajax({
					type : 'POST',
					async:false,
					url : '${ctx}/cm/cmCiGroup/check',  
					data : 'parentId='+parentId+'&groupName='+groupName,  
					success : function(data) {
						
						if(data!='ok'){
							$.jBox.error(data, '错误');
							flag = false;
							$("#groupName").val("");
						}	
					} 
				});
			}
		} 
		
		
		 function selectGroupIcon(iconId,iconName){
			$("#iconId").val(iconId);
			$("#iconName").val(iconName);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiGroup/list">分类列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiGroup/form?id=${cmCiGroup.id}&parent.id=${cmCiGroupparent.id}">分类<shiro:hasPermission name="cm:cmCiGroup:edit">${not empty cmCiGroup.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmCiGroup:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiGroup" action="${ctx}/cm/cmCiGroup/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<c:if test="${not empty cmCiGroup.id }">
		<c:if test="${cmCiGroup.status == '1' }">
			<div class="control-group">
				<label class="control-label">上级分类：</label>
				<div class="controls">
					<sys:treeselect id="parent" name="parent.id" value="${cmCiGroup.parent.id}" labelName="parent.name" labelValue="${cmCiGroup.parent.groupName}"
						title="父编号" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="" allowClear="true"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类名称：</label>
				<div class="controls">
					<form:input path="groupName" onchange="checkGroup();" htmlEscape="false" maxlength="10" class="required input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类编号：</label>
				<div class="controls">
					<form:input path="groupNumber" htmlEscape="false" maxlength="50" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类描述：</label>
				<div class="controls">
					<form:input path="groupDesc" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类排序：</label>
				<div class="controls">
					<form:input path="sort" htmlEscape="false" maxlength="50" class="required input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
			<label class="control-label">图标选择*：</label>
			<div class="controls">
				<div class="input-append">
				<form:hidden id="iconId" path="cmGraphIcon.id"/>
				<form:input id="iconName" path="cmGraphIcon.iconName" htmlEscape="false" class="required" maxlength="50" readonly="true"/>
				<a id="iconButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
				</div>
			</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类状态：</label>
				<div class="controls">
					<form:select path="status"  class="input-xlarge ">
						<form:option value="0">启用</form:option>
						<form:option value="1">停用</form:option>
					</form:select>
				</div>
			</div>
		</c:if>
		<c:if test="${cmCiGroup.status == '0' }">
			<div class="control-group">
				<label class="control-label">分类名称：</label>
				<div class="controls">
					<form:input path="groupName" onchange="checkGroup();" htmlEscape="false" maxlength="10" class="required input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类编号：</label>
				<div class="controls">
					<form:input path="groupNumber" htmlEscape="false" maxlength="50" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类描述：</label>
				<div class="controls">
					<form:input path="groupDesc" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类排序：</label>
				<div class="controls">
					<form:input path="sort" htmlEscape="false" maxlength="50" class="required input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
			<label class="control-label">图标选择*：</label>
			<div class="controls">
				<div class="input-append">
				<form:hidden id="iconId" path="cmGraphIcon.id"/>
				<form:input id="iconName" path="cmGraphIcon.iconName" htmlEscape="false" class="required" maxlength="50" readonly="true"/>
				<a id="iconButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
				</div>
			</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类状态：</label>
				<div class="controls">
					<form:select path="status" htmlEscape="false"  class="input-xlarge ">
						<form:option value="0">启用</form:option>
						<form:option value="1">停用</form:option>
					</form:select>
				</div>
			</div>
		</c:if>
		</c:if>
		<c:if test="${empty cmCiGroup.id }">
		<div class="control-group">
			<label class="control-label">上级分类：</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${cmCiGroup.parent.id}" labelName="parent.name" labelValue="${cmCiGroup.parent.groupName}"
					title="父编号" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类名称*：</label>
			<div class="controls">
				<form:input path="groupName" onchange="checkGroup();" htmlEscape="false" maxlength="10" class="required "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类编号：</label>
			<div class="controls">
				<form:input path="groupNumber" htmlEscape="false" maxlength="50"/>
				<span style="color: red;">&nbsp;&nbsp;&nbsp;为空时系统默认取分类名称中文大写首字母</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类描述：</label>
			<div class="controls">
				<form:input path="groupDesc" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类排序*：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图标选择*：</label>
			<div class="controls">
				<div class="input-append">
				<form:hidden id="iconId" path="cmGraphIcon.id"/>
				<form:input id="iconName" path="cmGraphIcon.iconName" htmlEscape="false" class="required" maxlength="50" readonly="true"/>
				<a id="iconButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
				</div>
			</div>
		</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiGroup:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>