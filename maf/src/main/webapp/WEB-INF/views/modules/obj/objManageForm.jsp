<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>对象管理</title>
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
			
			$("#objButton").click(function(){
				top.$.jBox.open("iframe:${ctx}/item/itemPath/selectList?pathId="+$("#pathId").val(), "选择路径 ",1000,450,
			       {opacity: 0.3,persistent: true,buttons:{"确认":"ok","关闭":"close"},
			       submit:function(v,h,f){
			           	if(v == 'ok'){
			           		var custom = h.find("iframe")[0].contentWindow.$("#tempItemPath").val();
			           		custom = custom.split("||");
			           		if(custom != null && custom.length > 0){
			           			$("#itemId").val(custom[0]);
			           			$("#itemName").val(custom[1]);
			           			$("#pathId").val(custom[2]);
			           			$("#pathName").val(custom[3]);
			           		}
			           	}else if(v == 'close'){
							return true;
						}
			       $(".jbox-content", top.document).css("overflow-y","hidden");
				}});
			});
			
		});
		
		function addObjContent(type){
			var htmlObject ="<tr>"+
								"<td><input name=\"objName\" type=\"text\" style=\"width: 250px;\" ></td>"+
								"<td><input name=\"xpathCode\" type=\"text\" style=\"width: 250px;\" ></td>"+
								"<td><input name=\"jqueryCode\" type=\"text\" style=\"width: 250px;\" ></td>"+
								"<td>"+
								" <a class=\"btn\" href=\"javascript:void(0);\" onclick=\"deleteObjContant(this);\"><i class=\"icon-minus\"></i></a>"+
								"</td>"+
							"</tr>";
			
			if(type == 'obj'){
				$("#objDiv tr:last").after(htmlObject);
			}
		}
		
		function deleteObjContant(obj){
			$(obj).parent().parent().remove();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/obj/objManage/">对象管理列表</a></li>
		<li class="active"><a href="${ctx}/obj/objManage/form"><shiro:hasPermission name="obj:objManage:edit">对象添加</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="objManage" action="${ctx}/obj/objManage/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
			<div class="control-group">
				<label class="control-label">路径名称:</label>
				<div class="controls">
					<div class="input-append">
						<form:hidden id="itemId" path="itemId" />
						<form:hidden id="itemName" path="itemName" />
						<form:hidden id="pathId" path="pathId" />
						<form:input id="pathName" path="pathName" htmlEscape="false" class="required" maxlength="50" readonly="true"/>
						<a id="objButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
					</div>
						<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		<div class="control-group" id="objDiv">
			<label class="control-label">对象内容:</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed" style="width:80%">
					<tr>
						<td width="20%;">对象名称</td>
						<td width="20%;">xpath表达式</td>
						<td width="20%;">jquery表达式</td>
						<td width="4%;">操作</td>
					</tr>
					<tr>
						<td><input type="text" name="objName" style="width: 250px;" class="required"/><span class="help-inline"><font color="red">*</font> </span></td>
						<td><input type="text" name="xpathCode" style="width: 250px;" /><span class="help-inline"></td>
						<td><input type="text" name="jqueryCode" style="width: 250px;" /><span class="help-inline"></td>
						<td>
						<a class="btn" href="javascript:void(0);" onclick="addObjContent('obj');"><i class="icon-plus"></i></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="obj:objManage:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>