<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#showdiv").hide();
			var infoIds = $("#tempIds").val();
			if(infoIds !=""){
				if(infoIds=="1"){
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").hide();
					$("#div4").show();
					$('#msgtype').attr('readonly',true);
					$('#sendName').attr('readonly',true);
					$('#receiverId').attr('readonly',true);
					$('#receiverName').attr('readonly',true);
					$('#message').attr('readonly',true);
					$('#planTime').attr('readonly',true);
					$('#remarks').attr('readonly',true);
				}
				if(infoIds=="3"){
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").hide();
					$("#div4").hide();
					$('#msgtype').attr('readonly',true);
					$('#sendName').attr('readonly',true);
					$('#receiverId').attr('readonly',true);
					$('#receiverName').attr('readonly',true);
					$('#message').attr('readonly',true);
					$('#planTime').attr('readonly',true);
					$('#remarks').attr('readonly',true);
				}
				if(infoIds=="2"){
					$("#div1").show();
					$("#div2").show();
					$("#div3").show();
					$("#div4").hide();
					if($("#time").val()==4){
						$("#divhtml").show();
						$("#showdiv").hide();
					}else{
						$("#divhtml").hide();
						$("#showdiv").show();
						var message = $("#message").val();
						$("#showdiv").html(message);
					}
					$('#msgtype').attr('readonly',true);
					$('#sendName').attr('readonly',true);
					$('#receiverId').attr('readonly',true);
					$('#receiverName').attr('readonly',true);
					$('#ccopyerId').attr('readonly',true);
					$('#msgTitle').attr('readonly',true);
					$('#blinderId').attr('readonly',true);
					$('#message').attr('readonly',true);
					$('#planTime').attr('readonly',true);
					$('#remarks').attr('readonly',true);
				}
			}
			$("#div4").hide();
			$("#spd").hide();
			$("#spy").hide();
			$("#spw").hide();
			$("#spms").hide();
			$("#spcs").hide();
			$("#selectName").hide();
			$("#msgtype").change(function(){
				var msytype = $("#msgtype").find("option:selected").text();
				$("#selectName").hide();
				$("#showdiv").hide();
				$("#reName").show();
				if(msytype=="邮件"){
					$("#div1").show();
					$("#div2").show();
					$("#div3").show();
					$("#spy").show();
					$("#spm").hide();
					$("#spd").hide();
					$("#spw").hide();
					$("#spms").show();
					$("#spcs").show();
					$("#div4").hide();
				}else if(msytype=="站内信"){
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").show();
					$("#div4").hide();
					$("#spd").hide();
					$("#spy").hide();
					$("#spw").hide();
					$("#reName").hide();
					$("#selectName").show();
				}else if(msytype=="短信"){
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").hide();
					$("#spm").hide();
					$("#spd").show();
					$("#spy").hide();
					$("#spw").hide();
					$("#div4").show();
				}else{
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").hide();
					$("#div4").hide();
					$("#spw").show();
					$("#spm").hide();
					$("#spd").hide();
					$("#spy").hide();
				}
			});		
			//文本框验证
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!checkform()){
						return false;
					}
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
		function checkform(){
			var msgtype = $("#msgtype").find("option:selected").text();
			var re;
			var receId = $("#receiverId").val();
			if(msgtype==""){
				alert("请选择信息类型");
			}else if(msgtype=="短信"){
				re = /^1[3|5|7|8|][0-9]{9}$/;
				if(!re.test(receId)){
					$.jBox.error("请输入正确的手机号","错误");
					return false;
				}
			}else if(msgtype=="邮件"){
				re= /\w@\w*\.\w/;
				if(!re.test(receId)){
					$.jBox.error("请输入正确的邮箱地址","错误");
					return false;
				}
			}
			return true;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/msg/msgMsginfo/">消息列表</a></li>
		<li class="active"><a href="${ctx}/msg/msgMsginfo/form?id=${msgMsginfo.id}">消息<shiro:hasPermission name="msg:msgMsginfo:edit">${not empty msgMsginfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="msg:msgMsginfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="msginfo" action="${ctx}/msg/msgMsginfo/save" method="post" class="form-horizontal">
		<input id="tempIds" type="hidden" value="${msginfo.msgType}"/>
		<input id="time" type="hidden" value="${msginfo.readFlag}"/>
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		
		<%--目前当前模块不会提供给用户，默认发送方式为系统，发送人为系统 --%>
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:select id="msgtype" path="msgType" class="input-xlarge required" cssStyle="width:230px;">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('msg_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发送人姓名：</label>
			<div class="controls">
				<%-- <sys:treeselect id="receiverId" name="receiverId" value="${msgMsginfo.receiverId}" labelName="receiverName" labelValue="${msgMsginfo.receiverId}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true"/> --%>
					<form:input path="sendName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div id="reName">
		<div class="control-group">
			<label class="control-label">接收人：</label>
			<div class="controls">
				<%-- <sys:treeselect id="receiverId" name="receiverId" value="${msgMsginfo.receiverId}" labelName="receiverName" labelValue="${msgMsginfo.receiverId}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true"/> --%>
					<form:input path="receiverId" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline" id="spd"><font color="red">*</font>请输入手机号码</span>
					<span class="help-inline" id="spy"><font color="red">*</font>请输入邮箱地址</span>
					<span class="help-inline" id="spw"><font color="red">*</font>请输入微信账号</span>
					<span class="help-inline" id="spm"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">接收人姓名：</label>
			<div class="controls">
					<form:input path="receiverName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		</div>
		<div id="selectName">
			<div class="control-group">
			<label class="control-label">接收人：</label>
			<div class="controls">
				<sys:treeselect id="receiverId" name="receiverId" value="${msgMsginfo.receiverId}" labelName="receiverName" labelValue="${msgMsginfo.receiverId}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true" cssStyle="width:230px;"/>
					<%-- <form:input path="receiverId" htmlEscape="false" maxlength="100" class="input-xlarge required"/> --%>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		</div>
		<div class="control-group" id="div1">
			<label class="control-label">抄送人：</label>
			 <div class="controls">
			 <form:input path="ccopyerId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			 <span class="help-inline" id="spcs">请输入邮箱地址</span>
			</div>
		</div>
		<div class="control-group"  id="div2">
			<label class="control-label">密送人：</label>
			 <div class="controls">
			 <form:input path="blinderId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			 <span class="help-inline" id="spms">请输入邮箱地址</span>
			</div> 
		</div>
		<div class="control-group" id="div3">
			<label class="control-label">消息标题：</label>
			<div class="controls">
				<form:input path="msgTitle" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">信息内容：</label>
			<div class="controls" id="divhtml">
				<form:textarea id="message" path="message" htmlEscape="false" rows="3" maxlength="1000" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<div class="controls" id="showdiv" style="width:470px;border:1px solid #eee">
			
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划发送时间：</label>
			<div class="controls">
				<input name="planTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${msgMsginfo.planTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">实际发送时间：</label>
			<div class="controls">
				<input name="actualTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${msgMsginfo.actualTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<c:if test="${empty msgMsginfo.backFlag || msgMsginfo.backFlag eq '0'}">
			<shiro:hasPermission name="msg:msgMsginfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>