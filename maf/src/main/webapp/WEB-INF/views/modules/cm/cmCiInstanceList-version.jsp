<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contrastBtn").click(function(){
				
				var num1 = $("#hidden1").val();
				var num2 = $("#hidden2").val();
				if(num1 == '' || num2 == ''){
					$.jBox.error('必须选满两个配置才能对比', '错误');
					return;
				}
				
				var ciId = $("#checkbox"+num1).val()+","+$("#checkbox"+num2).val();
				var civersion = $("#selectSpan2").text()+","+$("#selectSpan4").text();
				
				var oldOrNew="";
				if(num1 == '0'){
					oldOrNew="1"
				}else if(num2 == '0'){
					oldOrNew="2"
				}
				
				top.$.jBox.open("iframe:${ctx}/cm/cmCiInstance/contrast?ciId="+ciId+"&ciVersion="+civersion+"&oldOrNew="+oldOrNew, "配置项对比",$(top.document).width()-220,$(top.document).height()-100,{
					opacity: 0.3,persistent: true,buttons:{"确定":true}, loaded:function(h){
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
		
		function onmouseoverCheckBox(num){
			$("#span"+num).css({ "color": "red"});
		}
		
		function onmouseoutCheckBox(num){
			if($("#checkbox"+num).attr("checked")){
				$("#span"+num).css({ "color": "red"});
			}else{
				$("#span"+num).css({ "color": "black"});
			}
		}
		
		function onclickCheckBox(num){
			$("#contrastList").show();
			var id = $("#checkbox"+num).val(), title = $("#checkbox"+num).attr("title");
			if($("#checkbox"+num).attr("checked")){
				var titles = title.split(",");
				if($("#selectSpan1").text()==''){
					$("#selectSpan1").text(titles[0]);
					$("#selectSpan2").text(titles[1]);
					$("#hidden1").val(num);
				}else if($("#selectSpan3").text()==''){
					$("#selectSpan3").text(titles[0]);
					$("#selectSpan4").text(titles[1]);
					$("#hidden2").val(num);
				}else{
					$.jBox.error('对比栏已满，你可以删除不需要的配置项再继续添加！', '错误');
					$("#checkbox"+num).attr("checked",false);
				}
			}else{
				if($("#hidden1").val() == num){
					if($("#selectSpan3").text() != ''){
						$("#selectSpan1").text($("#selectSpan3").text());
						$("#selectSpan2").text($("#selectSpan4").text());
						$("#hidden1").val($("#hidden2").val());
						$("#selectSpan3").text("");
						$("#selectSpan4").text("");
						$("#hidden2").val("");
					}else{
						$("#selectSpan1").text("");
						$("#selectSpan2").text("");
						$("#hidden1").val("");
					}
				}else if($("#hidden2").val() == num){
					$("#selectSpan3").text("");
					$("#selectSpan4").text("");
					$("#hidden2").val("");
				}
			}
		}
		
		function hideDiv(){
			$("#contrastList").hide();
		}
		
		function delSelectSpan(hidId){
			var boxId = $("#"+hidId).val();
			if(hidId == 'hidden1'){
				if($("#selectSpan3").text() != ''){
					$("#selectSpan1").text($("#selectSpan3").text());
					$("#selectSpan2").text($("#selectSpan4").text());
					$("#hidden1").val($("#hidden2").val());
					$("#selectSpan3").text("");
					$("#selectSpan4").text("");
					$("#hidden2").val("");
				}else{
					$("#selectSpan1").text("");
					$("#selectSpan2").text("");
					$("#hidden1").val("");
				}
			}else if(hidId == 'hidden2'){
				$("#selectSpan3").text("");
				$("#selectSpan4").text("");
				$("#hidden2").val("");
			}
			
			$("#checkbox"+boxId).attr("checked",false);
			onmouseoutCheckBox(boxId);
		}
		
		function delShowOrHide(id,type){
			if(type == 'over'){
				$("#"+id).show();
			}else if(type == 'out'){
				$("#"+id).hide();
			}
		}
	</script>
	<style type="text/css">
		#contrastList{ 
			position:fixed; 
			top:35%; 
			left:85%; 
			width:15%;
			height:300px;
			background-color:white; 
			z-index:1002; 
			overflow:auto;
			box-shadow: 0 0 3px #000;
			}
		.contrastLi{
			font-size: 12px;
			color: #666;
			font-family: tahoma, arial, "Hiragino Sans GB", "宋体", sans-serif;
			font-style: normal;
			line-height: 35px;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
		<li><a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstance.id}&view=view">配置项查看<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li class="active"><a href="#">配置项版本<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiRelation?ciInstance.id=${cmCiInstance.id}">关联配置项<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmRelationOrder/list?ciInstance.id=${cmCiInstance.id}">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
		<li><a href="${ctx}/cm/cmCiRelation/graph?ciInstance.id=${cmCiInstance.id}">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="searchForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	</form:form>
	<sys:message content="${message}"/>
	<div id="contrastList" style="display: none;">
		<div class="control-group">
			<div class="controls">
				<a href="javascript:void(0)" onclick="hideDiv()">隐藏</a>
			</div>
		</div>
		<div class="control-group">
			<div class="controls" style="height: 65px; text-align: left;padding-top: 15px;" onmouseover="delShowOrHide('del1','over')" onmouseout="delShowOrHide('del1','out')">
				名称： <span id="selectSpan1"></span><br>
				版本： <span id="selectSpan2"></span><br>
				<input type="hidden" id="hidden1">
				<a href="javascript:void(0)" id="del1" style="display: none;" onclick="delSelectSpan('hidden1')">删除</a>
			</div>
		</div>
		<div class="control-group">
			<div class="controls" style="height: 65px; text-align: left;padding-top: 15px;" onmouseover="delShowOrHide('del2','over')" onmouseout="delShowOrHide('del2','out')">
				名称： <span id="selectSpan3"></span><br>
				版本： <span id="selectSpan4"></span><br>
				<input type="hidden" id="hidden2">
				<a href="javascript:void(0)" id="del2" style="display: none;" onclick="delSelectSpan('hidden2')">删除</a>
			</div>
		</div>
		<div class="control-group">
			<div class="controls" style="height: 50px; text-align: center;padding-top: 30px;">
				<a id="contrastBtn" href="#" class="btn btn-danger">对  比</a>
			</div>
		</div>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">#</th>
				<th width="15%">配置项编号</th>
				<th width="15%">配置项版本</th>
				<th width="15%">配置项名称</th>
				<th width="12%">配置项分类</th>
				<th width="15%">更新时间</th>
				<shiro:hasPermission name="cm:cmCiInstance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<tr><th colspan="7">当前版本</th></tr>
		<tr>
			<td>0</td>
			<td>${instance.ciNumber}</td>
			<td>${instance.ciVersion}</td>
			<td>${instance.ciName}</td>
			<td>${instance.cmCiGroup.groupName}</td>
			<td><fmt:formatDate value="${instance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<shiro:hasPermission name="cm:cmCiInstance:edit"><td>
				<a href="${ctx}/cm/cmCiInstance/form?id=${instance.id}&view=view">查看</a>
				<input type="checkbox" id="checkbox0" title="${instance.ciName},${instance.ciVersion}" value="${instance.id}" onclick="onclickCheckBox('0')" onmouseout="onmouseoutCheckBox('0')" onmouseover="onmouseoverCheckBox('0')"><span id="span0">对比</span>
			</td></shiro:hasPermission>
		</tr>
		<tr><th colspan="7">历史版本</th></tr>
		<c:forEach items="${page.list}" var="cmCiInstanceHi" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${cmCiInstanceHi.ciNumber}</td>
				<td>${cmCiInstanceHi.ciVersion}</td>
				<td>${cmCiInstanceHi.ciName}</td>
				<td>${cmCiInstanceHi.cmCiGroup.groupName}</td>
				<td><fmt:formatDate value="${cmCiInstanceHi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="cm:cmCiInstance:edit"><td>
					<a href="${ctx}/cm/cmCiInstance/form?id=${cmCiInstanceHi.id}&view=view&his=${cmCiInstanceHi.ciVersion}">查看</a>
					<input type="checkbox" id="checkbox${status.index+(page.pageNo-1)*30+1}" title="${cmCiInstanceHi.ciName},${cmCiInstanceHi.ciVersion}" value="${cmCiInstanceHi.id}" onclick="onclickCheckBox('${status.index+(page.pageNo-1)*30+1}')" onmouseout="onmouseoutCheckBox('${status.index+(page.pageNo-1)*30+1}')" onmouseover="onmouseoverCheckBox('${status.index+(page.pageNo-1)*30+1}')"><span id="span${status.index+(page.pageNo-1)*30+1}">对比</span>
					<a href="${ctx}/cm/cmCiInstance/versionRollback?id=${instance.id}&ciVersion=${cmCiInstanceHi.ciVersion}" onclick="return confirmx('确认要回退到当前版本吗（${cmCiInstanceHi.ciVersion}）？', this.href)">版本回退</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>