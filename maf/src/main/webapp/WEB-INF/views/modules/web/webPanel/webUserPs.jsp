<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#oldPassword").focus();
			$("#inputForm").validate({
				rules: {
				},
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
				/* 	form.submit(); */
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
			$("#btnSubmit").click(function(){
				var valdateBol=true;
				$("#inputForm").find("label.error").each(function(i,o){
					if($(o).css("display")!="none"){
						valdateBol=false;
						return false;
					}
				});
				if(!valdateBol){
					return false;
				}
				var param={};
				param["id"]=$("input[name='id']").val();
				param["oldPassword"]=$("input[name='oldPassword']").val();
				param["newPassword"]=$("input[name='newPassword']").val();
				param["confirmNewPassword"]=$("input[name='confirmNewPassword']").val();
				
				$.ajax({
					type: "post",
			        url: '${ctx}/sys/user/m/modifyPwd',
			        data:param,
			        dataType: "json",
			        ContentType:'application/x-www-form-urlencoded',
			        global:false,
			        success: function(data){ 
			        	if(data.code=="0"){
			        		$.jBox.success(data.message);
			        	//	history.go("-1")
			        	}
			        	else{
			        		$.jBox.error(data.message);
			        	}
			        }
				});
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/webPanel/webUserForm">个人信息</a></li>
		<li class="active"><a href="${ctx}/webPanel/webUserPs">修改密码</a></li>
	</ul><br/>
	<c:if test="${fns:getUser().loginType == '1' }">
	<div  class="">您使用AD域账户访问系统，需要通过AD域<a href="https://mail.allinfnt.com/ecp/?rfr=owa&p=PersonalSettings/Password.aspx" target="_blank">修改密码</a></div> 
	</c:if>
	<c:if test="${fns:getUser().loginType == '0' }">
	<form id="inputForm" class="form-horizontal">
		<input type="hidden" name="id" value="${fns:getUser().id}"/>
		<div class="control-group">
			<label class="control-label">旧密码:</label>
			<div class="controls">
				<input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认新密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required" equalTo="#newPassword"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>
		</div>
	</form>
	</c:if>
</body>
</html>