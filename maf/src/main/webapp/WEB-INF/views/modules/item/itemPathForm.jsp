<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>路径管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
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
			
			$("#itemButton").click(function(){
				top.$.jBox.open("iframe:${ctx}/item/itemManage/selectList?itemId="+$("#itemId").val(), "选择项目",1000,450,
			       {opacity: 0.3,persistent: true,buttons:{"确认":"ok","关闭":"close"},
			       submit:function(v,h,f){
			           	if(v == 'ok'){
			           		var custom = h.find("iframe")[0].contentWindow.$("#tempItemManage").val();
			           		custom = custom.split("||");
			           		if(custom != null && custom.length > 0){
			           			$("#itemId").val(custom[0]);
			           			$("#itemName").val(custom[1]);
			           		}
			           	}else if(v == 'close'){
							return true;
						}
			       $(".jbox-content", top.document).css("overflow-y","hidden");
				}});
			});
			
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/item/itemPath/">路径管理列表</a></li>
		<li class="active"><a href="${ctx}/item/itemPath/form"><shiro:hasPermission name="item:itemPath:edit">路径添加</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="itemPath" action="${ctx}/item/itemPath/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">项目名称:</label>
			<div class="controls">
				<div class="input-append">
					<form:hidden id="itemId" path="itemId"/>
					<form:input id="itemName" path="itemName" htmlEscape="false" class="required" maxlength="50" readonly="true" style="width:160px"/>
					<a id="itemButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
				</div>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">路径名称:</label>
			<div class="controls">
				<form:input path="itemPath" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">路径表达式:</label>
			<div class="controls">
				<form:input path="expression" htmlEscape="false" maxlength="50"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="item:itemPath:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>