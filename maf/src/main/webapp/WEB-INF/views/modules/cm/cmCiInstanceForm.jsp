<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					if(!checkoutFaile())return false;
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
		
		function checkoutFaile(){
			var isBalnk = true;
			if($("#groupIdId").val() == null || $("#groupIdId").val() == ''){
				if($("#ciId").val() == null || $("#ciId").val() == ''){
					$.jBox.error('请选择配置项分类', '错误');
		        	 isBalnk = false;
		        	 return false;
				}
			}
			
			if(!isBalnk) return false;
			return true;
		}
		
		function getPhysicalLocation(){
			
			top.$.jBox.open("iframe:${ctx}/rm/rmRmInformation/show?init=1&editShow="+$("#PhysicalLocation").val(), "物理位置",990,500,{
				opacity: 0.3,persistent: true,buttons:{"确定":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function getUserName(m){
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=3")+"&module=&checked=&extId=&isAll=true", "选择用户", 300, 420, {
				ajaxData:{selectIds: $("#userId"+m).val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
					if (v=="ok"){
						var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
						var ids = [], names = [], nodes = [];
						if ("" == "true"){
							nodes = tree.getCheckedNodes(true);
						}else{
							nodes = tree.getSelectedNodes();
						}
						for(var i=0; i<nodes.length; i++) {//
							if (nodes[i].isParent){
								top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
								return false;
							}//
							ids.push(nodes[i].id);
							names.push(nodes[i].name);//
							break; // 如果为非复选框选择，则返回第一个选择  
						}
						$("#userId"+m).val(ids.join(",").replace(/u_/ig,""));
						$("#userName"+m).val(names.join(","));
					}//
					else if (v=="clear"){
						$("#userId"+m).val("");
						$("#userName"+m).val("");
	                }//
					if(typeof userTreeselectCallBack == 'function'){
						userTreeselectCallBack(v, h, f);
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		
		function getoffice(m){
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=2")+"&module=&checked=&extId=&isAll=true", "选择部门", 300, 420, {
				ajaxData:{selectIds: $("#officeId"+m).val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
					if (v=="ok"){
						var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
						var ids = [], names = [], nodes = [];
						if ("" == "true"){
							nodes = tree.getCheckedNodes(true);
						}else{
							nodes = tree.getSelectedNodes();
						}
						for(var i=0; i<nodes.length; i++) {//
							/* if (nodes[i].isParent){
								top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
								return false;
							}// */
							ids.push(nodes[i].id);
							names.push(nodes[i].name);//
							break; // 如果为非复选框选择，则返回第一个选择  
						}
						$("#officeId"+m).val(ids.join(",").replace(/u_/ig,""));
						$("#officeName"+m).val(names.join(","));

						
					
					}//
					else if (v=="clear"){
						$("#officeId"+m).val("");
						$("#officeName"+m).val("");
	                }//
					if(typeof officeTreeselectCallBack == 'function'){
						officeTreeselectCallBack(v, h, f);
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}">配置项添加<shiro:hasPermission name="cm:cmCiInstance:edit"></shiro:hasPermission><shiro:lacksPermission name="cm:cmCiInstance:edit">查看</shiro:lacksPermission></a></li>
		<shiro:hasPermission name="cm:cmCiInstance:edit"><li><a href="${ctx}/cm/cmCiInstance/batchImport">批量导入</a></li></shiro:hasPermission>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/save" method="post" class="form-horizontal">
		<form:hidden id="ciId" path="id"/>
		<sys:message content="${message}"/>
		<c:if test="${cmCiInstance.ext1 == null }">
			<div class="row-fluid">
			<div class="control-group span6" style="display: block;">
				<label class="control-label">配置项分类*：</label>
				<div class="controls">
					<sys:treeselect id="groupId" name="cmCiGroup.id"  value="${cmCiGroup.parent.id}" labelName="parent.name" labelValue="${cmCiGroup.parent.groupName}"
							title="叶子分类" url="/cm/cmCiGroup/treeData" extId="${cmCiGroup.id}" allowClear="true" notAllowSelectParent="true"/>
				</div>
			</div>
			</div>
			<div class="row-fluid">	
			<div class="control-group span6">
				<label class="control-label">运行状态：</label>
				<div class="controls">
					<form:select path="ciStatusA" maxlength="1" cssStyle="width:220px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_a')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">使用状态：</label>
				<div class="controls">
					<form:select path="ciStatusB" maxlength="2" cssStyle="width:220px;">
						<form:option value="">--请选择--</form:option>
						<form:options items="${fns:getDictList('ci_status_b')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			</div>
			
			<div class="form-actions">
				<shiro:hasPermission name="cm:cmCiInstance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</c:if>
		<c:if test="${cmCiInstance.ext1 == '1' }">
			<table class="table">
		 		<tr><td>通用属性</td></tr>
		 		<tr><td></td></tr>
			</table>
			<div class="row-fluid">
				<div class="span6">
				<c:forEach items="${newpropertyManages }" var="property" varStatus="status">
					<c:if test="${status.count%2!=0}">
					<div class="control-group">
						<c:if test="${property.isNull == '0'}">
							<label class="control-label">${property.propertyName}*：</label>
						</c:if>
						<c:if test="${property.isNull == '1'}">
							<label class="control-label">${property.propertyName}：</label>
						</c:if>
						<div class="controls">
							${property.remarks}
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
				<div class="span6">
				<c:forEach items="${newpropertyManages }" var="property" varStatus="status">
					<c:if test="${status.count%2==0}">
					<div class="control-group">
						<c:if test="${property.isNull == '0'}">
							<label class="control-label">${property.propertyName}*：</label>
						</c:if>
						<c:if test="${property.isNull == '1'}">
							<label class="control-label">${property.propertyName}：</label>
						</c:if>
						<div class="controls">
							${property.remarks}
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
			</div>	
			<table class="table">
				<tr><td>专有属性</td></tr>
				<tr><td></td></tr>
			</table>
			<div class="row-fluid">
				<div class="span6">
				<c:forEach items="${newPropertyGroups }" var="propertyGroup" varStatus="status">
					<c:if test="${status.count%2!=0}">
					<div class="control-group">
						<c:if test="${propertyGroup.cmPropertyManage.isNull == '0'}">
							<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}*：</label>
						</c:if>
						<c:if test="${propertyGroup.cmPropertyManage.isNull == '1'}">
							<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
						</c:if>
						<div class="controls">
							${propertyGroup.cmPropertyManage.remarks}
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
				<div class="span6">
				<c:forEach items="${newPropertyGroups }" var="propertyGroup" varStatus="status">
					<c:if test="${status.count%2==0}">
					<div class="control-group">
						<c:if test="${propertyGroup.cmPropertyManage.isNull == '0'}">
							<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}*：</label>
						</c:if>
						<c:if test="${propertyGroup.cmPropertyManage.isNull == '1'}">
							<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
						</c:if>
						<div class="controls">
							${propertyGroup.cmPropertyManage.remarks}
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="cm:cmCiInstance:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保  存" />&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回"
					onclick="history.go(-1)" />
			</div>
		</c:if>
	</form:form>
</body>
</html>