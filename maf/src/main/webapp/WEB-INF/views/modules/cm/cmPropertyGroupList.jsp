<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分类属性关系管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#officeButton, #officeName").click(function(){
				// 是否限制选择，如果限制，设置为disabled
				if ($("#officeButton").hasClass("disabled")){
					return true;
				}
				// 正常打开	
				top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=2")+"&module=&checked=&extId=&isAll=true", "选择部门", 300, 420, {
					ajaxData:{selectIds: $("#officeId").val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
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
							$("#officeId").val(ids.join(",").replace(/u_/ig,""));
							$("#officeName").val(names.join(","));

							
						
						}//
						else if (v=="clear"){
							$("#officeId").val("");
							$("#officeName").val("");
		                }//
						if(typeof officeTreeselectCallBack == 'function'){
							officeTreeselectCallBack(v, h, f);
						}
					}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
			});

		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function groupPropertyView(groupId){
			top.$.jBox.open("iframe:${ctx}/cm/cmPropertyGroup/form?groupId="+groupId, "分类属性",$(top.document).width()-220,$(top.document).height()-250,{
				opacity: 0.3,persistent: true, buttons:{"确定分配":"ok"},submit:function(v, h, f){
					if(v == 'ok'){
						return true;
					}
					
				},loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function getPhysicalLocation(){
			top.$.jBox.open("iframe:${ctx}/rm/rmRmInformation/show?init=1", "物理位置",990,500,{
				opacity: 0.3,persistent: true,buttons:{"确定":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function getUserName(m){
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=3")+"&module=&checked=&extId=&isAll=true", "选择用户", 300, 420, {
				ajaxData:{selectIds: $("#userId").val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiGroup/list">分类列表</a></li>
		<shiro:hasPermission name="cm:cmCiGroup:edit"><li><a href="${ctx}/cm/cmCiGroup/form">分类添加</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/cm/cmPropertyGroup/?groupId=${groupId}">属性分配</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cmPropertyGroup" action="${ctx}/cm/cmPropertyGroup/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<a href="${ctx}/cm/cmPropertyGroup/form?groupId=${groupId}" class="btn btn-primary">属性分配</a>
	</form:form>
	<form:form  modelAttribute="cmPropertyGroup" class="form-horizontal">
	<sys:message content="${message}"/>
	<table class="table">
 		<tr><td>通用属性</td></tr>
 		<tr><td></td></tr>
	</table>
	<div class="row-fluid">
		<div class="span6">
		<c:forEach items="${newTYPropertyGroups }" var="property" varStatus="status">
			<c:if test="${status.count%2!=0}">
			<div class="control-group">
				<label class="control-label">${property.propertyName}：</label>
				<div class="controls">
					${property.remarks}
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<div class="span6">
		<c:forEach items="${newTYPropertyGroups }" var="property" varStatus="status">
			<c:if test="${status.count%2==0}">
			<div class="control-group">
				<label class="control-label">${property.propertyName}：</label>
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
				<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
				<div class="controls">
					${propertyGroup.cmPropertyManage.remarks}<a class="btn" href="${ctx}/cm/cmPropertyGroup/delete?id=${propertyGroup.id}" onclick="return confirmx('确认要删除该属性吗？', this.href)"><i class="icon-remove"></i></a>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
		<div class="span6">
		<c:forEach items="${newPropertyGroups }" var="propertyGroup" varStatus="status">
			<c:if test="${status.count%2==0}">
			<div class="control-group">
				<label class="control-label">${propertyGroup.cmPropertyManage.propertyName}：</label>
				<div class="controls">
					${propertyGroup.cmPropertyManage.remarks}<a class="btn" href="${ctx}/cm/cmPropertyGroup/delete?id=${propertyGroup.id}" onclick="return confirmx('确认要删除该属性吗？', this.href)"><i class="icon-remove"></i></a>
				</div>
			</div>
			</c:if>
		</c:forEach>
		</div>
	</div>
	</form:form>
	<div class="pagination">${page}</div>
</body>
</html>