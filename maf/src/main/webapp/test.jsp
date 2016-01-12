<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>作业定义管理管理</title>
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
			//是否关键作业
			if($("#isHinge").val() == '1'){
				$("#overtimeDivId").show();
			}else if($("#isHinge").val() == '0'){
				$("#overtimeDivId").hide();
			}
			//优先级
			if($("#priority").val() != '0'){
				$("#advanceTimeDivId").show();
			}else{
				$("#advanceTimeDivId").hide();
			}
			//是否开启提醒
			if($("#isRemind").val() == '1'){
				$("#fashionRemindDivId").show();
				$("#remindTypeDivId").show();
			}else if($("#isRemind").val() == '0'){
				$("#fashionRemindDivId").hide();
				$("#remindTypeDivId").hide();
			}
			$("#selOther").click(function(){
				/* var param = "dialogWidth:910px;dialogHeight:500px;scroll:no;status:no;resizable:no;center:1";
	            return window.showModalDialog("${pageContext.request.contextPath}/static/hmCron/createCron.htm", window, param); */
	            top.$.jBox.open("iframe:${ctx}/hm/hmDefinedManage/selectCron", "作业执行规则选择",910,450,
            		{opacity: 0.3,persistent: true,buttons:{"确认":"ok","关闭":"close"},
	            	submit:function(v,h,f){
	            	if(v == 'ok'){
	            		var cronValue = $("#tempCron").val();
	        			cronValue = cronValue.replace(/(^\s*)|(\s*$)/g,'');
	        			var cronValueStrs = cronValue.split(" ");
	        			if(cronValueStrs[0] == '*' || cronValueStrs[1] == '*' || cronValueStrs[2] == '*'){
	        				alert("请指定具体时间，至少指定到秒、分钟和小时！");
	        				return false;
	        			}
	        			if(cronNextDate(cronValue,'')){
	        				return true;
	        			}else{
	        				return false;
	        			}
	            	}else if(v == 'close'){
						return true;
					}
	            	$(".jbox-content", top.document).css("overflow-y","hidden");
				}});
			});
			$("#btnButtonDefined").click(function(){
				var tempHmId = $("#tempHmId").val();
				var hmId = $("#id").val();//用来判断是新增还是修改
				var operateType = '';
				if(hmId != null && hmId != ''){
					operateType = 'edit';
				}else{
					operateType = 'add';
				}
				$("#operateType").val(operateType);
				top.$.jBox.open("iframe:${ctx}/hm/hmSonInfo/list?dmId="+tempHmId+"&operateType="+operateType, "自定义表单管理",950,620,
	            		{opacity: 0.3,persistent: true,buttons:{"确 定":true},
						loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
				}});
			});
			var editId = $("#id").val();
			if(editId != ''){
				var hmPreposeId = $("#hmPreposeId").val();
				var hmFatherId = $("#hmFatherId").val();
				if(hmPreposeId != '' || hmFatherId != ''){
					//$("#executeRule").attr("readonly",true);
					$("#executeDivId").hide();
					$("#cronNextDateSpan").hide();
				}
			}
			//是否关键作业
			$("#isHinge").click(function(){
				if($(this).val() == '1'){
					$("#overtimeDivId").show();
				}else if($(this).val() == '0'){
					$("#overtimeDivId").hide();
				}
			});
			//优先级
			$("#priority").click(function(){
				if($(this).val() != '0'){
					$("#advanceTimeDivId").show();
				}else{
					$("#advanceTimeDivId").hide();
				}
			});
			//是否开启提醒
			$("#isRemind").click(function(){
				if($(this).val() == '1'){
					$("#fashionRemindDivId").show();
					$("#remindTypeDivId").show();
				}else if($(this).val() == '0'){
					$("#fashionRemindDivId").hide();
					$("#remindTypeDivId").hide();
				}
			});
		});
		function dynamicSetValue(values){
			var vals = values.split('||');
			var tempId = $("#tempId").val();
			if(vals != null && vals.length >0){
				$("#"+tempId).val(vals[0]);
				$("#temp"+tempId).val(vals[1]);
			}
			/*如果选择前置作业或者父作业，那么该作业的执行时间不可填，以前置作业或者父作业为准*/
			if(tempId == 'hmPreposeId' || tempId == 'hmFatherId'){
				$("#executeRule").val('');
				$("#executeRuleMemo").val('');
				//$("#executeRule").attr("readonly",true);
				$("#executeDivId").hide();
				$("#cronNextDateSpan").hide();
			}
		}
		function openWindow(objs){
			$("#tempId").val(objs);
			var titleStr = '';
			if(objs == 'hmPreposeId'){
				titleStr = '选择前置作业';
			}else if(objs == 'hmFatherId'){
				titleStr = '选择父作业';
			}else if(objs == 'hmSonId'){
				titleStr = '选择子作业';
			}
			/* var param = "dialogWidth:950px;dialogHeight:600px;scroll:no;status:no;resizable:no;center:1";
            return window.showModalDialog("${ctx}/hm/hmDefinedManage/selectHm", window, param); */
		 	top.$.jBox.open("iframe:${ctx}/hm/hmDefinedManage/selectHm", titleStr,950,620,{opacity: 0.3,persistent: true,buttons:{"清除":"clear","确定":"ok"}, submit:function(v,h,f){
		 		if(v == 'clear'){
		 			clearSelect(objs);
		 		}
		 		if(v == "ok"){
		 			var tempWorkStrs = $("#tempWorkStrs").val();
		 			if(tempWorkStrs != null && tempWorkStrs != ''){
		 				dynamicSetValue(tempWorkStrs);
		 			}
		 		}
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}}); 
		}
		function openHwGroup(){
			top.$.jBox.open("iframe:${ctx}/hm/hmDefinedManage/selectHwGroup", "选择作业相关组",600,500,{opacity: 0.3,persistent: true,buttons:{"确定":"ok"}, submit:function(v,h,f){
				if(v == 'ok'){
				}
				$(".jbox-content", top.document).css("overflow-y","hidden");
			}}); 
		}
		function selExecuteRule(objs){
			var selVal = $("#"+objs).val();
			var selText = $("#"+objs).find("option:selected").text();
			cronNextDate(selVal,selText);
		}
		function checkedVals(){
			var str = '';
			$("input[name='fashionRemindCheck']:checked").each(function(i){
				if(i==0){
					str = $(this).val();
				}else{
					str += ","+$(this).val();
				}
            });
			$("#fashionRemind").val(str);
		}
		
		function clearSelect(objs){
			$("#"+objs).val('');
 			$("#temp"+objs).val('');
 			if(objs == 'hmPreposeId'){
				if($("#hmFatherId").val() == ''){
					$("#executeDivId").show();
					$("#cronNextDateSpan").show();
				}
			}
			if(objs == 'hmFatherId'){
				if($("#hmPreposeId").val() == ''){
					$("#executeDivId").show();
					$("#cronNextDateSpan").show();
				}
			}
		}
		
		function cronNextDate(executeRule,executeRuleMemo){
			var flag;
			$.ajax({
				type : 'POST',
				async:false,
				url : '${ctx}/hm/hmDefinedManage/cronNextDate',  
				data : {executeRule:executeRule},
				dataType:'json',
				success : function(data) {
					//alert('data[0]='+data[0])
					if(data[0] == 'false'){
						alert("作业执行规则表达式不正确，请重新选择或者重新填写！");
						flag = false;
					}else if(data[0] == 'true'){
						$("#executeRule").val(executeRule);
						$("#executeRuleMemo").val(executeRuleMemo);
						var strs = "&nbsp;&nbsp;下一次执行时间：<select id='cronNextDate' name='cronNextDate' >";
						$.each(data[1],function(i){ 
							strs += "<option>"+ $.trim(data[1][i])+"</option>";
						});
						strs += "</select>";
						$("#cronNextDateSpan").html(strs);
						$("#nextExecuteDate").val(data[3]);
						if(data[2] != null && data[2] != ''){
							alert(data[2]);
						}
						flag = true;
					}
				} 
			});
			if(flag){return true;}else{return false;}
		}
		function checked(){
			var hmPreposeId = $("#hmPreposeId").val();
			var hmFatherId = $("#hmFatherId").val();
			var executeRule = $("#executeRule").val();
			if(hmPreposeId == '' && hmFatherId == ''){
				if(executeRule == ''){
					$.jBox.error("请选择作业执行规则!","提示");
					return false;
				}
			}
			var tempVals = $("#isRemind").val();
			if(tempVals != null && tempVals == '1'){
				tempVals = $("#fashionRemind").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择提醒方式!","提示");
					return false;
				}
				tempVals = $("#remindType").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择提前多久提醒类型!","提示");
					$("#remindType").focus();
					return false;
				}
				tempVals = $("#remindDate").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择提醒方式的数值!","提示");
					$("#remindDate").focus();
					return false;
				}
			}
			tempVals = $("#priority").val();
			if(tempVals != null && tempVals != '0'){
				tempVals = $("#advanceTime").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择提前执行时间!","提示");
					$("#advanceTime").focus();
					return false;
				}
			}
			tempVals = $("#isHinge").val();
			if(tempVals != null || tempVals != ''){
				if(tempVals == '1'){
					tempVals = $("#overtime").val();
					if(tempVals == null || tempVals == ''){
						$.jBox.error("请选择超时时间!","提示");
						return false;
					}
				}
			}
			var hwPerson = $("#hwPersonId").val();
			var hwGroup = $("#hwGroup").val();
			if((hwPerson =='') && (hwGroup =='')){
				$.jBox.error("请选择作业人员或者作业相关组","提示");
				return false;
			}else if(hwPerson != '' && hwGroup != ''){
				$.jBox.error("作业人员和作业组只能指定其中一个，不能全部指定！","提示");
				return false;
			}
			if(hwPerson != null && hwPerson != ''){
				tempVals = $("#checkPersonId").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择复核人!","提示");
					$("#checkPersonName").focus();
					return false;
				}
				if(tempVals.indexOf(hwPerson) > -1){
					$.jBox.error("复核人中不能选择你所选的作业人员!","提示");
					$("#checkPersonName").focus();
					return false;
				}
			}
			
			tempVals = $("#isMfConsult").val();
			if(tempVals != null && tempVals == '1'){
				tempVals = $("#manufacturer").val();
				if(tempVals == null || tempVals == ''){
					$.jBox.error("请选择服务厂商!","提示");
					return false;
				}
			}
			tempVals = $("#executeRule").val();
			tempVals = tempVals.replace(/(^\s*)|(\s*$)/g,'');
			var cronValueStrs = tempVals.split(" ");
			if(cronValueStrs[0] == '*' || cronValueStrs[1] == '*' || cronValueStrs[2] == '*'){
				alert("请指定具体时间，至少指定到秒、分钟和小时！");
				return false;
			}
			if(cronNextDate(tempVals,$("#executeRuleMemo").val())){
				return true;
			}
			
			var nextExecuteDate = $("#nextExecuteDate").val();
 			if(nextExecuteDate != null && nextExecuteDate != ''){
				var hwGroup = $("#hwGroup").val();
				$.ajax({
					type : 'POST',
					async:false,
					url : '${ctx}/hm/hmDefinedManage/checkThatDayIsExistPerson',  
					data : {nextExecuteDate:nextExecuteDate,hwGroup:hwGroup},
					dataType:'json',
					success : function(data) {
						if(data[0] != null && data[0] != ''){
							$.jBox.error(data[0],"提示");
						}
					} 
				});
 			}
 			return true;
		}
		function hwGroupOnchange(obj){
			var hwgroup = $(obj).val();
			if(hwgroup != null && hwgroup != ''){
				$("#checkPersonDiv").hide();
			}else{
				$("#checkPersonDiv").show();
			}
		}
	
	</script>
</head>
<body>
	<input type="hidden" id="tempId"  name="tempId" value=""/>
	<input type="hidden" id="tempWorkStrs"  name="tempWorkStrs" value=""/>
	<input type="hidden" id="operateType"  name="operateType" value=""/>
	<input type="hidden" id="nextExecuteDate" name="nextExecuteDate" value=""/>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hm/hmDefinedManage/list">作业定义管理列表</a></li>
		<li class="active"><a href="${ctx}/hm/hmDefinedManage/form?id=${hmDefinedManage.id}">作业定义<shiro:hasPermission name="hm:hmDefinedManage:edit">${not empty hmDefinedManage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="hm:hmDefinedManage:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hmDefinedManage" action="${ctx}/hm/hmDefinedManage/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" id="tempHmId"  name="tempHmId" value="${hmDefinedManage.id != null && hmDefinedManage.id != '' ? hmDefinedManage.id : hmDefinedManage.tempHmId }"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden path="act.flag"/>
		<form:hidden path="editType"/>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">计划作业编号：</label>
			<div class="controls">
				<form:input path="hwNumber" htmlEscape="false" maxlength="20" class="input-xlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">计划作业名称：</label>
				<div class="controls">
					<form:input path="hwName" htmlEscape="false" maxlength="50" class="required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">前置作业：</label>
				<div class="controls">
					<input type="hidden" id="hmPreposeId" name="hmPreposeId" value="${hmDefinedManage.prepose.id }"/>
					<div class="input-append">
						<input type="text" id="temphmPreposeId" style="width:200px;" name="temphmPreposeId" class="span2"  maxlength="20" value="${hmDefinedManage.prepose.hwName }" disabled="disabled"/>
						<button type="button" id="hmPreposeIdBut" name="hmPreposeIdBut" onclick="openWindow('hmPreposeId');" class="btn btn-primary">选择</button>
					</div>
					<button type="button" id="hmPreposeIdBut" name="hmPreposeIdBut" onclick="clearSelect('hmPreposeId')" class="btn btn-primary">清除</button>
					<%-- <form:input path="hmPreposeId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/> --%>
					<%-- <sys:treeselect id="user" name="createBy.id" value="${hmDefinedManage.createBy.id}" labelName="createBy.name" labelValue="${hmDefinedManage.createBy.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required"  allowClear="true" notAllowSelectParent="true"/>
					<sys:hmtreeselect url="/hm/hmDefinedManage/treeData?type=3" id="hmTree" name="hmPreposeId" value="${hmDefinedManage.hmPreposeId }" labelName="hmPreposeId" labelValue="" title="" ></sys:hmtreeselect> --%>
					
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">父作业：</label>
				<div class="controls">
					<input type="hidden" id="hmFatherId" name="hmFatherId" value="${hmDefinedManage.father.id }"/>
					<div class="input-append">
						<input type="text" id="temphmFatherId"  name="temphmFatherId"  maxlength="20"  value="${hmDefinedManage.father.hwName }" disabled="disabled"/>
						<button type="button" id="hmFatherIdBut" name="hmFatherIdBut" onclick="openWindow('hmFatherId');" class="btn btn-primary">选择</button>
					</div>
					<button type="button" id="hmPreposeIdBut" name="hmPreposeIdBut" onclick="clearSelect('hmFatherId')" class="btn btn-primary">清除</button>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">子作业：</label>
				<div class="controls">
					<input type="hidden" id="hmSonId" name="hmSonId" value="${hmDefinedManage.son.id }"/>
					<div class="input-append">
						<input type="text" id="temphmSonId" style="width:185px;" name="temphmSonId"  maxlength="20"  value="${hmDefinedManage.son.hwName }" disabled="disabled"/>
						<button type="button" id="hmSonIdBut" name="hmSonIdBut" onclick="openWindow('hmSonId');" class="btn btn-primary">选择</button>
					</div>
					<button type="button" id="hmPreposeIdBut" name="hmPreposeIdBut" onclick="clearSelect('hmSonId')" class="btn btn-primary">清除</button>
				</div>
			</div>
		</div>
		<div class="row-fluid" >
			<div class="control-group span6" id="executeDivId">
				<label class="control-label">作业执行规则：</label>
				<div class="controls">
					<form:hidden path="executeRule" htmlEscape="false" readonly="true" maxlength="20"/>
					<%-- <form:select id="fastExecuteRule" path="fastExecuteRule" class="required" cssStyle="width:220px;" >
						<option value="">
						<form:options items="${fns:getDictList('execute_rule')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select> --%>
					<span>
						<select id="fastExecuteRule" name="fastExecuteRule" class="input-medium" style="width: 215px;" onchange="selExecuteRule('fastExecuteRule');">
							<option value="">请选择</option>
							<c:forEach items="${fns:getDictList('execute_rule')}" var="dic">
								<option value="${dic.value }">${dic.label }</option>
							</c:forEach>
						</select>
						<input id="selOther" class="btn btn-primary" type="button" value="自定义规则"/>
						<span class="help-inline"><font color="red">提示：作业执行时间至少指定到秒、分钟和小时。</font> </span>
					</span>
				</div>
			</div>
		</div>
		<div class="control-group">
				<label class="control-label">作业执行规则说明：</label>
				<div class="controls">
					<input type="hidden" id="tempCron" name = "tempCron" value="0 * * * * ?"/> 
					<form:input id="executeRuleMemo" path="executeRuleMemo" class="required" htmlEscape="false" maxlength="50"/>
					<span class="help-inline"><font color="red">*</font> </span>
					<span id="cronNextDateSpan"></span>
				</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">是否工作日执行：</label>
					<div class="controls">
						<form:select path="isDay" class="input-medium">
							<!-- <option value="">请选择</option> -->
							<c:choose>
								<c:when test="${hmDefinedManage.isDay == null || hmDefinedManage.isDay == '' }">
									<option value="1">是</option>
									<option value="0" selected="selected">否</option>
								</c:when>
								<c:otherwise>
									<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</c:otherwise>
							</c:choose>
						</form:select>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">作业类型：</label>
				<div class="controls">
					<%-- <form:select path="type" class="required" cssStyle="width:220px;">
						<option value=""/>
						<form:options items="${fns:getDictList('hm_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select> --%>
					<select id="type" name="type" class="input-medium required" >
						<option value="">请选择</option>
						<c:forEach items="${typeMap}" var="map">
							<option value="${map.key}" <c:if test="${hmDefinedManage.type == map.key }">selected="selected"</c:if>>${map.value }</option>
						</c:forEach>
					</select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">配置项：</label>
				<div class="controls">
					<%-- <form:input path="ciId" htmlEscape="false" maxlength="64"/> --%>
					<sys:treeselect id="hmDefinedManage" name="ciId"  value="${hmDefinedManage.ciId}" labelName="ciNames" labelValue="${hmDefinedManage.ciNames}"
					title="配置项" url="/cm/cmCiGroup/treeData?type=4"  allowClear="true" notAllowSelectParent="true" checked="true"/>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">是否关键作业：</label> 
				<div class="controls">
					<form:select path="isHinge" class="input-medium">
						<%-- <option value="">请选择</option>
						<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
						<c:choose>
							<c:when test="${hmDefinedManage.isHinge == null || hmDefinedManage.isHinge == '' }">
								<option value="1">是</option>
								<option value="0" selected="selected">否</option>
							</c:when>
							<c:otherwise>
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</c:otherwise>
						</c:choose>
					</form:select>
				</div>
			</div>
			<div class="control-group span6" id="overtimeDivId" style="display: none;">
				<label class="control-label">超时时间：</label>
				<div class="controls">
					<form:select path="overtime" class="input-medium">
						<option value="">请选择</option>
						<form:options items="${fns:getDictList('overtime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">作业优先级：</label>
				<div class="controls">
					<form:select path="priority" class="input-medium required" >
						<form:options items="${fns:getDictList('priority')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group span6" id="advanceTimeDivId" style="display: none;">
				<label class="control-label">提前执行时间：</label>
				<div class="controls">
					<form:select path="advanceTime" class="input-medium">
						<option value="">请选择</option>
						<form:options items="${fns:getDictList('overtime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">是否开启提醒：</label>
				<div class="controls">
					<form:select path="isRemind" class="input-medium required" >
						<!-- <option value="">请选择</option> -->
						<c:choose>
							<c:when test="${hmDefinedManage.isRemind == null || hmDefinedManage.isRemind == '' }">
								<option value="1">是</option>
								<option value="0" selected="selected">否</option>
							</c:when>
							<c:otherwise>
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</c:otherwise>
						</c:choose>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group span6" id="fashionRemindDivId" style="display: none;">
				<label class="control-label">提醒方式：</label>
				<div class="controls">
					<input id="fashionRemind" type="hidden" name="fashionRemind" value="${hmDefinedManage.fashionRemind }" maxlength="64"/>
					<%-- <form:select path="fashionRemind" class="required" cssStyle="width:220px;">
						<option value="">请选择</option>
						<form:options items="${fns:getDictList('fashion_remind')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select> --%>
					<c:forEach items="${fns:getDictList('fashion_remind') }" var="dic">
						<input type="checkbox" id="fashionRemindCheck"  name="fashionRemindCheck" value="${dic.value } " 
						 onclick="checkedVals();" <c:if test="${fn:indexOf(hmDefinedManage.fashionRemind,dic.value) > -1 }">checked="checked"</c:if>/>${dic.label }
					</c:forEach>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</div>
		<div class="row-fluid" id="remindTypeDivId" style="display: none;">
			<div class="control-group span6">
				<label class="control-label">提前多久提醒类型：</label>
				<div class="controls">
					<form:select path="remindType" class="input-medium" style="width: 100px;">
						<option value="">请选择</option>
						<form:options items="${fns:getDictList('remind_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select><!-- <span class="help-inline"><font color="red">*</font> </span> -->
					数值：<form:input path="remindDate" htmlEscape="false" maxlength="5" class="number" style="width: 50px;"/>
					<!-- <span class="help-inline"><font color="red">*</font> </span> -->
				</div>
			</div>
			<div class="control-group span6" style="display: none;">
				<label class="control-label">重复提醒次数：</label>
				<div class="controls">
					<%-- <form:input path="remindNum" htmlEscape="false" maxlength="2"  class="number"/> --%>
					<input type="text" id="remindNum" name="remindNum" readonly="readonly" maxlength="2" class="number" value="1"/>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">作业人员：</label>
				<div class="controls">
					<%-- <form:input path="hwPerson" htmlEscape="false" maxlength="200" class="required"/> cssClass="required"--%>
					<sys:treeselect id="hwPerson" name="hwPerson" value="${hmDefinedManage.hwPerson}" labelName="hwPersonName" labelValue="${hmDefinedManage.hwPersonNames}"
					title="作业人员" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
					<span class="help-inline"><font color="red">提示：作业人员和作业组只能指定一个，不能全部指定。</font> </span>
					
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">作业组：</label>
				<div class="controls">
					<%-- <form:hidden path="hwGroup" htmlEscape="false" maxlength="50" />
					<div class="input-append">
						<input type="text" id="temphwGroup"  name="temphwGroup"  maxlength="20"  value="${hmDefinedManage.hwGroupNames }" disabled="disabled"/>
						<button type="button" id="hwGroupBut" name="hwGroupBut" onclick="openHwGroup();" class="btn btn-primary">选择</button>
					</div>
					<button type="button" id="hmPreposeIdBut" name="hmPreposeIdBut" onclick="clearSelect('hwGroup')" class="btn btn-primary">清除</button> --%>
					<form:select path="hwGroup" class="input-medium" onchange="hwGroupOnchange(this);">
						<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('team_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				 </form:select>
				 <span class="help-inline"><font color="red">提示: 如果选择组那么复核人不可选，默认是当天值班小组的组长</font> </span>
				</div>
			</div>
		</div>
		<div class="row-fluid" id="checkPersonDiv">
			<%-- <div class="control-group span6">
				<label class="control-label">是否复核：</label>
				<div class="controls">
					<form:select path="isChecked" class="input-medium">
						<option value="">请选择</option>
						<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						<c:choose>
							<c:when test="${hmDefinedManage.isChecked == null || hmDefinedManage.isChecked == '' }">
								<option value="1">是</option>
								<option value="0" selected="selected">否</option>
							</c:when>
							<c:otherwise>
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</c:otherwise>
						</c:choose>
					</form:select>
				</div>
			</div> --%>
			<div id="checkPersonDiv" class="control-group span6">
				<label class="control-label">复核人：</label>
				<div class="controls">
					<%-- <form:input path="checkPerson" htmlEscape="false" maxlength="100" /> --%>
					<sys:treeselect id="checkPerson" name="checkPerson" value="${hmDefinedManage.checkPerson}" labelName="checkPersonName" labelValue="${hmDefinedManage.checkPersonName}"
					title="复核人" url="/sys/office/treeData?type=3" allowClear="true"  notAllowSelectParent="true" checked="true"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划作业步骤：</label>
			<div class="controls">
				<%-- <form:input path="hmDescribe" htmlEscape="false" maxlength="500" class="required"/> --%>
				<form:textarea path="hmDescribe" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">计划作业说明：</label>
			<div class="controls">
				<form:textarea path="hmExplain" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div> --%>
		<div class="row-fluid">
			<div class="control-group span6">
				<label class="control-label">是否需厂商支持：</label>
				<div class="controls">
					<form:select path="isMfConsult" class="input-medium">
						<%-- <option value="">请选择</option>
						<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
						<c:choose>
							<c:when test="${hmDefinedManage.isMfConsult == null || hmDefinedManage.isMfConsult == '' }">
								<option value="1">是</option>
								<option value="0" selected="selected">否</option>
							</c:when>
							<c:otherwise>
								<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</c:otherwise>
						</c:choose>
					</form:select>
				</div>
			</div>
			<div class="control-group span6">
				<label class="control-label">厂商：</label>
				<div class="controls">
					<form:input path="manufacturer" htmlEscape="false" maxlength="50" />
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<%-- <div class="control-group span6">
				<label class="control-label">是否启用：</label>
				<div class="controls">
					<form:select path="isOn" class="input-medium">
						<!-- <option value="">请选择</option> -->
						<option value="1" selected="selected">是</option>
						<option value="0">否</option>
					</form:select>
				</div>
			</div> --%>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="nameFiles" path="attachIds" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="nameFiles" type="files" uploadPath="/hmAttach" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group" style="margin-left: 120px;color: red"><input id="btnButtonDefined" class="btn btn-primary" type="button" value="添加自定义表单信息"/></div>
		<div class="form-actions">
			<shiro:hasPermission name="hm:hmDefinedManage:edit">
				<c:choose>
					<c:when test="${hmDefinedManage.editType == null || hmDefinedManage.editType == '' }">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
						<c:if test="${not empty hmDefinedManage.id}">
							<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
						</c:if>
					</c:when>
					<c:otherwise>
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
					</c:otherwise>
				</c:choose>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${hmDefinedManage.editType == null || hmDefinedManage.editType == '' }">
			<act:histoicFlow procInsId="${hmDefinedManage.act.procInsId}" procDefId="${hmDefinedManage.act.procDefId}"/>
		</c:if>
	</form:form>
</body>
</html>