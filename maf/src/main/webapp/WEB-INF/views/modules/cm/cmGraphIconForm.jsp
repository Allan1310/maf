<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项图标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!iconFiledCheckfrom())return false;
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
		
		function iconFiledCheckfrom(){
			var isBalnk = true;
			
			$("#inputForm input[name='iconFile']").each(function(){
	        	 if($(this).val() == ''){
	        	 $.jBox.error('请选择图标！', '错误');
	        	 isBalnk = false;
	        	 return false;
			 	}
			});
			
			if(!isBalnk) return false;
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmGraphIcon/">配置项图标列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmGraphIcon/form?id=${cmGraphIcon.id}">配置项图标<shiro:hasPermission name="cm:cmGraphIcon:edit">${not empty cmGraphIcon.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cm:cmGraphIcon:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmGraphIcon" action="${ctx}/cm/cmGraphIcon/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">图标名称*：</label>
			<div class="controls">
				<form:input path="iconName" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上传图标*：</label>
			<div class="controls">
				<form:hidden id="nameImage" path="iconFile" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="nameImage" type="images"  uploadPath="/test/test" selectMultiple="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmGraphIcon:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>