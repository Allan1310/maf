<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
			
			$("#ciButton").click(function(){
				var handle = $("#handle").val();
				var status;
				if(handle == '0'){
					status='0';
				}else if(handle == '1'){
					status='2';
				}else if(handle == '2'){
					status='6';
				}
				top.$.jBox.open("iframe:${ctx}/cm/cmCiInstance/listView?status="+status, "配置项查询",$(top.document).width()-220,$(top.document).height()-250,{
					opacity: 0.3,persistent: true,buttons:{"确定":true}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
			});
			
			$("#btnSubmit").click(function(){
				if($("#ciId").val()==null || $("#ciId").val()==''){
					 $.jBox.error('配置项不能未空', '错误');
			        	 return false;
				}
				
				if($("#comment").val()==null || $("#comment").val()==''){
					 $.jBox.error('请填写审批意见', '错误');
			        	 return false;
				}
				$("#inputForm").submit();
			});
		});
		
		function ciSelectAddOrDel(id,title,type){
			if(type == 'add'){
				$("#ciId").val(id);
				$("#ciNumber").val(title);
			}else if(type == 'del'){
				var idValue = $("#ciId").val();
				var titleValue = $("#ciNumber").val();
				if(idValue.indexOf(";")>-1){
					if(idValue.indexOf(id) == 0){
						$("#ciId").val(idValue.replace(id+";",""));
						$("#ciNumber").val(titleValue.replace(title+";",""));
					}else{
						$("#ciId").val(idValue.replace(";"+id,""));
						$("#ciNumber").val(titleValue.replace(";"+title,""));
					}
				}else{
					$("#ciId").val("");
					$("#ciNumber").val("");
				}
				
			}
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiApply/">变更申请列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiApply/form?id=${cmCiApply.id}">变更申请<shiro:hasPermission name="cm:cmCiApply:edit"></shiro:hasPermission><shiro:lacksPermission name="cm:cmCiApply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiApply" action="${ctx}/cm/cmCiApply/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="handle" path="handle"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<form:hidden  id="ciId" path="ciId" />
		
		<sys:message content="${message}"/>		
		<fieldset>
			<legend>${cmCiApply.act.taskName}</legend>
			<table class="table-form">
				<tr>
					<td class="tit">申请人</td>
					<td>${cmCiApply.user.name }</td>
				</tr>
				<tr>
					<td class="tit">所在部门</td>
					<td>${cmCiApply.office.name }</td>
				</tr>
				<tr>
					<td class="tit">配置项变更类型</td>
					<td>
						<c:if test="${cmCiApply.handle == '0' }">配置项新增</c:if>
						<c:if test="${cmCiApply.handle == '1' }">配置项修改</c:if>
						<c:if test="${cmCiApply.handle == '2' }">配置项删除</c:if>
					</td>
				</tr>
				<c:if test="${taskDefKey == 'InformationSubmit' }">
				<tr>
					<td class="tit">配置项</td>
					<td>
						<div id="ciIdDiv" class="input-append">
							<form:input  id="ciNumber" path="ciNumber" htmlEscape="false"  maxlength="1000"  readonly="true" />
							<a id="ciButton" href="javascript:" class="btn btn-primary ">&nbsp;<i class="icon-search icon-white"></i>&nbsp;</a>
						</div>	
					</td>
				</tr>
				</c:if>
				<c:if test="${taskDefKey != 'InformationSubmit' }">
				<tr>
					<td class="tit">配置项</td>
					<td>
						<table class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th width="15%">配置项编号</th>
								<th width="15%">配置项名称</th>
								<th width="10%">配置项分类</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${instances}" var="cmCiInstance">
							<tr>
								<td><a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}&view=view">${cmCiInstance.ciNumber}</a></td>
								<td>${cmCiInstance.ciName}</td>
								<td>${cmCiInstance.cmCiGroup.groupName}</td>
							</tr>
						</c:forEach>
						</tbody>
						</table>
					</td>
				</tr>
				</c:if>
				<tr>
					<td class="tit">您的意见</td>
					<td colspan="5">
						<form:textarea id="comment" path="act.comment" rows="5" maxlength="20" cssStyle="width:500px"/>
					</td>
				</tr>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmCiApply:edit">
				<c:if test="${taskDefKey == 'InformationSubmit'}">
					<input id="btnSubmit" class="btn btn-primary" type="button" value="提  交" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnPass" class="btn btn-primary" type="submit" value="终  止" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
				<c:if test="${taskDefKey != 'InformationSubmit'}">
					<input id="btnSubmit" class="btn btn-primary" type="button" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<act:histoicFlow procInsId="${cmCiApply.act.procInsId}" procDefId="${cmCiApply.act.procDefId}"/>
	</form:form>
</body>
</html>