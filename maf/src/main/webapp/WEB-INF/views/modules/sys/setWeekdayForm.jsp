<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作日设置管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!checked()){
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
		function checked(){
			var flag = true;
			var day = $("#day").val();
			var file = $("#file").val();
			if(day == '' && file == ''){
				$.jBox.error("请选择工作日日期或者上传工作日文件","提示");
				flag = false;
			}
			if(day != null && day != ''){
				$.ajax({
					type : 'POST',
					async:false,
					url : '${ctx}/sys/setWeekday/isExistDay',  
					data : {day:day},
					dataType:'json',
					success : function(data) {
						if(data[0] != null && data[0] != ''){
							flag = false;
							$.jBox.error(data[0],"提示");
						}
					} 
				});
			}
			if(flag){
				return true;
			}else{
				return false;
			}
			
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/setWeekday/">工作日设置列表</a></li>
		<li class="active"><a href="${ctx}/sys/setWeekday/form?id=${hmSetWeekday.id}">工作日设置<shiro:hasPermission name="sys:setWeekday:edit">${not empty hmSetWeekday.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:setWeekday:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="setWeekday" action="${ctx}/sys/setWeekday/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">工作日日期：</label>
			<div class="controls">
				<form:input path="day" type="text" readonly="true" maxlength="20" class="input-medium Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">快速导入：</label>
			<div class="controls">
				<input type="file" id="file" name="file" />&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/static/hm/workDay.xlsx">点击下载导入模板</a>
				<span><font color="red">(时间格式为：2015-01-01)</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:setWeekday:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>