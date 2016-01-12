<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项审计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var arrayNum = new Array();
		var k = 0;
		$(document).ready(function() {
			//$("#name").focus();
			$("#btnSubmit").click(function(){
				$("#inputForm").validate({
					submitHandler: function(form){
						if(!auditFiledCheckfrom())return false;
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
			
			var f = 1;
			$("#insertOtherProblemBtn").click(function(){
				arrayNum[k] = f; 
				var message = "<div class='input-append'><input id='ciId"+f+
				"' name='ciId' class='problem-id' type='hidden' value=''/>"+
				"<input id='ciName"+f+
				"' name='ciName' readonly='readonly' type='text' value='' data-msg-required='' class='problem-name' style='width:90px;'/>"+
				"<a id='groupIdButton' href='javascript:' onclick='openCI(" + f +")' class='btn  ' style=''>&nbsp;<i class='icon-search'></i>&nbsp;</a>&nbsp;&nbsp;</div>";
				
				var newObject="<tr>"+
				"<td>"+message+"</td>"+
				"<td>"+"<input type='text' id='question"+f+"' name='question' style='width:140px;' />"+"</td>"+
				"<td>"+"<input id='userId"+ f +"' name='dutyOfficerId'  type=\"hidden\" value=\"\"/>"
					  +"<input id=\"dutyOfficerName"+ f +"\" name=\"dutyOfficerName\" readonly=\"readonly\" type=\"text\" value=\"\" data-msg-required=\"\" "
					  +"class=\"\" onclick='getUserName(" + f +")' style='width:70px;' /><a id=\"userButton\" href=\"javascript:\" onclick='getUserName(" + f +")' class=\"btn  \" ><i class=\"icon-search\"></i>&nbsp;</a></td>"+
				"<td>"+
					  "<select id='solveStatus"+f+"' name='solveStatus' style='width:90px;'>"+
						"<option value='已解决'>已解决</option>"+
						"<option value='未解决'>未解决</option>"+
					"</select>"+
				"</td>"+
				"<td>"+"<input type='text' id='planSolveTime"+f+"' name='planSolveTime' style='width: 130px;' class='Wdate ' onclick='getTime()' class=' input-small'/>"+"</td>"+
				"<td>"+"<input type='text' id='realitySolveTime"+f+"' name='realitySolveTime' style='width: 130px;' class='Wdate ' onclick='getTime()' class=' input-small'/>"+"</td>"+
				"<td>"+"<a href='javascript:()' onclick='deleteProblem(this,"+f+")' class='btn btn-small btn-primary'>删除</a>"+"</td>"
			 	"</tr>";
				
			 	 $("#otherProblem tr:last").after(newObject);
			 	f++;
			 	k++;
			 });
			
		});
		
		
		
		function getUserName(num){
			if ($("#userButton").hasClass("disabled")){
				return true;
			}
			// 正常打开	
			top.$.jBox.open("iframe:${ctx}/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=3")+"&module=&checked=&extId=&isAll=true", "选择用户", 300, 420, {
				ajaxData:{selectIds: $("#userId"+num).val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
					if (v=="ok"){
						var tree = h.find("iframe")[0].contentWindow.tree;
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
						$("#userId"+num).val(ids.join(",").replace(/u_/ig,""));
						$("#dutyOfficerName"+num).val(names.join(","));
					}//
					else if (v=="clear"){
						$("#userId"+num).val("");
						$("#dutyOfficerName"+num).val("");
	                }//
					if(typeof userTreeselectCallBack == 'function'){
						userTreeselectCallBack(v, h, f);
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		function getTime(){
			WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});
		}
		
		function deleteProblem(obj,num){
			for(var i = 0;i<arrayNum.length;i++){
				if(arrayNum[i] == num){
					arrayNum.splice(i,1);
					break;
				}
			}
			
			$(obj).parent().parent().remove();
		}
		
		function openCI(m) {
			top.$.jBox
					.open(
							"iframe:${ctx}/tag/treeselect?url="
									+ encodeURIComponent("/cm/cmCiGroup/treeData?type=4")
									+ "&module=&checked=true&extId=&isAll=",
							"选择配置项",
							300,
							420,
							{
								ajaxData : {
									selectIds : $("#ciId" + m).val()
								},
								buttons : {
									"确定" : "ok",
									"清除" : "clear",
									"关闭" : true
								},
								submit : function(v, h, f) {
									if (v == "ok") {
										var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
										var ids = [], names = [], nodes = [];
										if ("true" == "true") {
											nodes = tree.getCheckedNodes(true);
										} else {
											nodes = tree.getSelectedNodes();
										}
										for ( var i = 0; i < nodes.length; i++) {//
											if (nodes[i].isParent) {
												continue; // 如果为复选框选择，则过滤掉父节点
											}
											if (nodes[i].isParent) {
												top.$.jBox.tip("不能选择父节点（"+ nodes[i].name+ "）请重新选择。");
												return false;
											}
											ids.push(nodes[i].id);
											names.push(nodes[i].name);//
										}
										
										$("#ciId" + m).val(ids.join(",").replace(/u_/ig,""));
										$("#ciName" + m).val(names.join(","));
									} else if (v == "clear") {
										$("#ciId" + m).val("");
										$("#ciName" + m).val("");
									}
									if (typeof groupIdTreeselectCallBack == 'function') {
										groupIdTreeselectCallBack(v, h, f);
									}
								},
								loaded : function(h) {
									$(".jbox-content", top.document).css("overflow-y", "hidden");
								}
							});
		}
		
		function auditFiledCheckfrom(){
			var isBalnk = true;
			
			$("#inputForm input[name='ciName']").each(function(){
				if($(this).val() != ''){
			 		
		        	 $("#inputForm input[name='dutyOfficerName']").each(function(){
		 	         	if($(this).val() == ''){
		 	        	 $.jBox.error('请选择责任人！', '错误');
		 	        	 isBalnk = false;
		 	        	 return false;
		 			 	}
		 			});
		        	 
		        	 $("#inputForm input[name='question']").each(function(){
		 	         	if($(this).val() == ''){
		 	        	 $.jBox.error('请填写问题内容！', '错误');
		 	        	 isBalnk = false;
		 	        	 return false;
		 			 	}
		 			});
		        	 
		        	 $("#inputForm input[name='planSolveTime']").each(function(){
		 				if($(this).val() == ''){
		         			 $.jBox.error('请选择计划解决时间！', '错误');
		         			 isBalnk = false;
		         			 return false;
		 		 		}
		 			});
		        	 
		        	 $("#inputForm input[name='realitySolveTime']").each(function(){
		 				if($(this).val() == ''){
		         			 $.jBox.error('请选择实际解决时间！', '错误');
		         			 isBalnk = false;
		         			 return false;
		 		 		}
		 			});
	        	 
			 	}
			});
			
			if(!isBalnk) return false;
			return true;
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cm/cmAuditApply/">审计计划列表</a></li>
		<li class="active"><a href="${ctx}/cm/cmAuditApply/form?id=${cmAuditApply.id}">审计计划审批</a></li>
	</ul>
	<!-- 查看审计申请单 -->
	<c:if test="${taskDefKey != 'ciAdminAudit' and taskDefKey != 'ciManagerAudit' and taskDefKey != 'ReApplyAudit'}">
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>	
		
		<table class="table table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:middle; text-align:left;font-size:16px;" colspan="3" >审计申请单</th>
					<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">审计对象*</th>
					<td>
						${cmAuditApply.auditObject }
					</td>
					<th style="text-align:right;" width="11%">审计项目*</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计日期*</th>
					<td>
						${cmAuditApply.auditTime }
					</td>
					<th style="text-align:right;" width="11%">审计人员*</th>
					<td>
						${cmAuditApply.auditUser }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计目的*</th>
					<td>
						${cmAuditApply.auditPurpose }
					</td>
					<th style="text-align:right;" width="11%">审计触发条件*</th>
					<td>
						${cmAuditApply.auditCondition }
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table class="table  table-bordered ">
							<tr>
								<th style="text-align:right;" width="11%">审计范围</th>
								<td>${cmAuditApply.auditScope }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计数据收集方法</th>
								<td>${cmAuditApply.auditDataMethods }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计方式</th>
								<td>${cmAuditApply.auditMode }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计安排</th>
								<td>${cmAuditApply.auditPlan }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">审计步骤</th>
								<td>${cmAuditApply.auditSteps }</td>
							</tr>
							<tr>
								<th style="text-align:right;" width="11%">您的意见</th>
								<td>
									<textarea name="act.comment" rows="4" maxlength="1000" class="required" style="width: 80%"></textarea>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmAuditApply:edit">
				<c:if test="${taskDefKey == 'ciManagerPlan'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="$('#flag').val('yes')"/>&nbsp;
				</c:if>
				<c:if test="${taskDefKey != 'ciManagerPlan'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes');"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</c:if>
	
	<!-- 配置管理员填写审计报告 -->
	<c:if test="${taskDefKey == 'ciAdminAudit'}">
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/saveAudit" method="post" class="form-horizontal">
		<input type="hidden" id="questions-hidden" name="questions" />
		<form:hidden path="id" />
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<form:hidden id="comment" path="act.comment"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:right; text-align:center;font-size:16px;" colspan="3" >审计报告</th>
					<th style="vertical-align:middle; text-align:center;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">报告编号</th>
					<td>
						<form:input path="auditNumber" htmlEscape="false"  maxlength="20" class="required " style="width:210px;" readonly="true"/>
					</td>
					<th style="text-align:right;" width="11%">报告日期</th>
					<td>
						<form:input path="auditReport" htmlEscape="false" maxlength="20" class="Wdate required" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">项目名称</th>
					<td>
						<form:input path="auditCondition" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" readonly="true"/>
					</td>
					<th style="text-align:right;" width="11%">审计日期</th>
					<td>
						<form:input path="auditTime" htmlEscape="false" maxlength="20" readonly="true" class=" input-large"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计目的</th>
					<td colspan="3">
						<form:input path="auditPurpose" htmlEscape="false"  maxlength="20" readonly="true" class="required" style="width:210px;"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计组人员</th>
					<td colspan="4">
						<form:textarea path="auditUser" rows="2" maxlength="1000" style="width: 80%" readonly="true"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计范围</th>
					<td colspan="4">
						<form:textarea path="auditScope" rows="3" maxlength="1000" style="width: 80%" readonly="true"/>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">问题及跟踪</th>
					<td id="otherProblem" colspan="4">
					<c:if test="${idTrack }">
						<table class="table table-striped table-bordered table-condensed">
							<tr>
								<td>配置项编号</td>
								<td>问题</td>
								<td>责任人</td>
								<td>解决状态</td>
								<td>计划解决时间</td>
								<td>实际解决时间</td>
							</tr>
							<c:forEach items="${CmAuditTrackList }" var="track">
							<tr>
								<td><sys:treeselect id="ci" name="ciId" value="${track.ciId}" labelName="ciName" labelValue="${track.ciName}"
									title="父编号" url="/cm/cmCiGroup/treeData?type=4"  allowClear="true" notAllowSelectParent="true" checked="true" cssStyle="width:90px;" cssClass=" problem-id"/></td>
								<td><input id="question" name="question" type="text" value="${track.question }" style="width:140px;" /></td>
								<td><sys:treeselect id="dutyOfficer" name="dutyOfficerId" value="${track.dutyOfficer.id}" labelName="dutyOfficerName" labelValue="${track.dutyOfficer.name}"
										title="用户" url="/sys/office/treeData?type=3" cssClass="" cssStyle="width:70px;" isAll="true" allowClear="true" notAllowSelectParent="true"/>
								<td>
									<select id="solveStatus" name="solveStatus" onselect="${track.solveStatus }" style="width:90px;">
										<option value="已解决">已解决</option>
										<option value="未解决">未解决</option>
									</select>
								</td>
								<td><input id="planSolveTime" name="planSolveTime" type="text" style="width: 130px;" value="${track.planSolveTime }" class="Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class=" input-small"/></td>
								<td><input id="realitySolveTime" name="realitySolveTime" type="text" style="width: 130px;"value="${track.realitySolveTime }" class="Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class=" input-small"/></td>
							</tr>
							</c:forEach>
							<!-- <tr id="miss"></tr> -->
						</table>
					</c:if>
					<c:if test="${!idTrack }">
						<table class="table table-striped table-bordered table-condensed">
							<tr>
								<td>配置项编号</td>
								<td>问题</td>
								<td>责任人</td>
								<td>解决状态</td>
								<td>计划解决时间</td>
								<td>实际解决时间</td>
								<td></td>
							</tr>
							<tr>
								<td><sys:treeselect id="ci" name="ciId" value="${cmCiRelation.reCiInstance.id}" labelName="ciName" labelValue="${cmCiRelation.reCiInstance.ciName}"
									title="父编号" url="/cm/cmCiGroup/treeData?type=4" checked="true"  allowClear="true" notAllowSelectParent="true" cssStyle="width:90px;" cssClass=" problem-id"/></td>
								<td><input id="question" name="question" type="text" class=" " style="width:140px;" /></td>
								<td><sys:treeselect id="dutyOfficer" name="dutyOfficerId" value="" labelName="dutyOfficerName" labelValue=""
										title="用户" url="/sys/office/treeData?type=3" isAll="true" cssStyle="width:70px;" allowClear="true" notAllowSelectParent="true"/>
								<td>
									<select id="solveStatus" name="solveStatus" style="width:90px;">
										<option value="已解决">已解决</option>
										<option value="未解决">未解决</option>
									</select>
								</td>
								<td><input id="planSolveTime" name="planSolveTime" type="text" style="width: 130px;" class="Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class=" input-small"/></td>
								<td><input id="realitySolveTime" name="realitySolveTime" type="text" style="width: 130px;"  class="Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class=" input-small"/></td>
								<td><a id="insertOtherProblemBtn" href="javascript:void(0)" class="btn btn-small btn-primary">添加</a></td>
							</tr>
							<!-- <tr id="miss"></tr> -->
						</table>
					</c:if>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计结果</th>
					<td colspan="3">
						<form:select path="auditResult" htmlEscape="false" cssStyle="width:220px;">
							<form:option value="1">通过审计</form:option>
							<form:option value="0">未通过审计</form:option>
						</form:select>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计员签名*</th>
					<td colspan="3">
						
						<form:input path="auditSign" type="text" class="required "/>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmAuditApply:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提   交" onclick="$('#flag').val('yes'),$('#comment').val('填写审计报告');"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</c:if>
	<!-- ******************************************************************************************************************************************** -->
	<!-- ******************************************************************************************************************************************** -->
	<!-- ******************************************************************************************************************************************** -->
	<!-- ******************************************************************************************************************************************** -->
	<!-- ******************************************************************************************************************************************** -->
	
	<!-- 配置经理查看审计报告 -->
	<c:if test="${taskDefKey == 'ciManagerAudit'}">
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered ">
			<thead>
				<tr>
					<th style="vertical-align:right; text-align:right;font-size:16px;" colspan="3" >审计报告</th>
					<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<th style="text-align:right;" width="11%">报告编号</th>
					<td>${cmAuditApply.auditNumber }</td>
					<th style="text-align:right;" width="11%">报告日期</th>
					<td>${cmAuditApply.auditReport }</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">项目名称</th>
					<td>${cmAuditApply.auditCondition }</td>
					<th style="text-align:right;" width="11%">审计时间</th>
					<td>${cmAuditApply.auditTime }</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计目的</th>
					<td colspan="3">${cmAuditApply.auditPurpose }</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计组人员</th>
					<td colspan="4">${cmAuditApply.auditUser }</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计范围</th>
					<td colspan="4">${cmAuditApply.auditScope }</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">问题及跟踪</th>
					<td colspan="4">
						<table class="table table-striped table-bordered table-condensed">
							<tr>
								<td>配置项编号</td>
								<td>问题</td>
								<td>责任人</td>
								<td>解决状态</td>
								<td>计划解决时间</td>
								<td>实际解决时间</td>
							</tr>
							<c:forEach items="${CmAuditTrackList }" var="cmAuditTrack" varStatus="status">
							<tr>
								<td>
								<c:forEach items="${cmAuditTrack.maps }" var="map">
								<a href="${ctx}/cm/cmCiInstance/form?id=${map.ciId}&view=view">${map.ciName}</a>
								</c:forEach>
								</td>
								<td>${cmAuditTrack.question }</td>
								<td>${cmAuditTrack.dutyOfficer.name }</td>
								<td>${cmAuditTrack.solveStatus }</td>
								<td>${cmAuditTrack.planSolveTime }</td>
								<td>${cmAuditTrack.realitySolveTime }</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计结果</th>
					<td colspan="3">
						<c:if test="${cmAuditApply.auditResult == 1}">
							通过审计
						</c:if>
						<c:if test="${cmAuditApply.auditResult == 0}">
							未通过审计
						</c:if>
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">审计员签名*</th>
					<td colspan="3">
						${cmAuditApply.auditSign }
					</td>
				</tr>
				<tr>
					<th style="text-align:right;" width="11%">您的意见*</th>
					<td colspan="3">
						<textarea name="act.comment" rows="4" maxlength="1000" class="required" style="width: 80%"></textarea>
					</td>
				</tr>
				
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="cm:cmAuditApply:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="同    意" onclick="$('#flag').val('yes')"/>&nbsp;
				<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳    回" onclick="$('#flag').val('no')"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</form:form>
	</c:if>
	<c:if test="${taskDefKey == 'ReApplyAudit'}">
	<form:form id="inputForm" modelAttribute="cmAuditApply" action="${ctx}/cm/cmAuditApply/saveAudit" method="post" class="form-horizontal">
	<form:hidden path="id" />
	<form:hidden path="act.taskId"/>
	<form:hidden path="act.taskName"/>
	<form:hidden path="act.taskDefKey"/>
	<form:hidden path="act.procInsId"/>
	<form:hidden path="act.procDefId"/>
	<form:hidden id="flag" path="act.flag"/>
	<form:hidden id="comment" path="act.comment" />
	<sys:message content="${message}"/>
	<table class="table  table-bordered ">
		<thead>
			<tr>
				<th style="vertical-align:middle; text-align:center;font-size:16px;" colspan="3" >审计申请单</th>
				<th style="vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
			</tr>
		<thead>
		<tbody>
			<tr>
				<th style="text-align:right;" width="11%">审计对象*</th>
				<td>
					<form:input path="auditObject" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" />
				</td>
				<th style="text-align:right;" width="11%">审计编号*</th>
				<td>
					<form:input path="auditNumber" htmlEscape="false" readonly="readonly"  class="required" style="width:210px;" />
				</td>
			</tr>
			<tr>
				<th style="text-align:right;" width="11%">审计项目*</th>
				<td>
					<form:input path="auditProject" htmlEscape="false"  maxlength="50" class="required" style="width:210px;" />
				</td>
				<th style="text-align:right;" width="11%">审计日期*</th>
				<td>
					<form:input path="auditTime" htmlEscape="false" maxlength="20" readonly="readonly" class="Wdate required input-large"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</td>
			</tr>
			<tr>
				<th style="text-align:right;" width="11%">审计人员*</th>
				<td>
					<form:input path="auditUser" htmlEscape="false"  maxlength="20" class="required" style="width:210px;" />
				</td>
				<th style="text-align:right;" width="11%">审计目的*</th>
				<td>
					<form:input path="auditPurpose" htmlEscape="false" maxlength="20" class="required" style="width:210px;" />
				</td>
			</tr>
			<tr>
				<th style="text-align:right;" width="11%">审计触发条件*</th>
				<td colspan="3">
					<form:input path="auditCondition" htmlEscape="false" maxlength="50" class="required" style="width:210px;" />
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table class="table  table-bordered ">
						<tr>
							<th style="text-align:right;" width="11%">审计范围 </th>
							<td><textarea name="auditScope" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditScope }</textarea></td>
						</tr>
						<tr>
							<th style="text-align:right;" width="11%">审计数据收集方法 </th>
							<td><textarea name="auditDataMethods" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditDataMethods }</textarea></td>
						</tr>
						<tr>
							<th style="text-align:right;" width="11%">审计方式 </th>
							<td><textarea name="auditMode" rows="3" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditMode }</textarea></td>
						</tr>
						<tr>
							<th style="text-align:right;" width="11%">审计安排 </th>
							<td><textarea name="auditPlan" rows="5" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditPlan }</textarea></td>
						</tr>
						<tr>
							<th style="text-align:right;" width="11%">审计步骤 </th>
							<td><textarea name="auditSteps" rows="5" maxlength="1000" style="width: 80%" class="required">${cmAuditApply.auditSteps }</textarea></td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="form-actions">
	<shiro:hasPermission name="cm:cmAuditApply:edit">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="重申请" onclick="$('#flag').val('yes'),$('#comment').val('重申请')"/>&nbsp;
		<input id="btnSubmit" class="btn btn-inverse" type="submit" value="终  止" onclick="$('#flag').val('no'),$('#comment').val('终止')" />&nbsp;
	</shiro:hasPermission>
	<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
	</c:if>
	<act:histoicFlow procInsId="${cmAuditApply.act.procInsId}" procDefId="${cmAuditApply.act.procDefId}"/>
</body>
</html>