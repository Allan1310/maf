<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新闻管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
		});
		function showImage(){
			$.jBox($("#activityBox").html(), {title:"主题图片", width: 800,buttons:{"关闭":true}});
		}
		jQuery.validator.addMethod("image", function(value, element) {
			if(value == "") return true;  
			var opath = value;
			var ext = opath.slice(opath.indexOf(".")).toLowerCase();
			if(ext!='.jpg' && ext!='.png'){
				return false;
			}
			return true;  
		}, "只能上传图片(jpg/png)");

		function reUploadFile(obj){
			$(obj).parent().remove();
			$("#fileUploadName_imageInfo").show();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/site/siteNews/">新闻列表</a></li>
		<li class="active"><a href="${ctx}/site/siteNews/form?id=${siteNews.id}">新闻管理<shiro:hasPermission name="site:siteNews:edit">${not empty siteNews.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="site:siteNews:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="siteNews" action="${ctx}/site/siteNews/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('site_new_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新闻简介：</label>
			<div class="controls">
				<form:textarea path="introduction" htmlEscape="false" maxlength="200" rows="4" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">发布时间：</label>
			<div class="controls">
				<input name="newsDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${siteNews.newsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">内容：</label>
			<div class="controls">
					<form:textarea id="content" htmlEscape="true" path="content" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/test/test" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="files" path="files" htmlEscape="false" maxlength="2000" class="input-xlarge"/>
				<sys:ckfinder input="files" type="files" uploadPath="/site/siteNews" selectMultiple="true"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('post_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="site:siteNews:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>