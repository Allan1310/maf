<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			
			setValue();
			$(".input-small").each(function(i,o){
				$(o).attr("disabled",true);
			});
			if($("#receive_").find("tr").length==0){
				$("#receive_div").hide();
			}
			if($("#rmVsBring_Table").find("tr").length==0){
				$("#tool_div").hide();
			}
			if($("#rmVsBring_large_Table").find("tr").length==0){
				$("#move_div").hide();
			}
		});
		
		function loadArea(dataArr){
			 dataArr=dataArr?dataArr:[];
			 $("#area_").find("tr").find("td:last").children("div").each(function(i,o){
				 var paramData={};
				 paramData["regionalType"]=$(o).attr("name").substr(10);
				 if(paramData["regionalType"]=="3") return; //机房数据区通过showArea方法查询数据
				 /* $.ajax({
					 type: "post",
					 url: '${ctx}/rm/rmRmInformation/findRegionsByType',
					 data:paramData,
					 dataType: "json",
					 ContentType:'application/x-www-form-urlencoded',
					 global:false,
					 success: function(data){
					 	$(o).empty();
					 	$.each(data,function(datai,datao){
					 		if(dataArr.length>0){
					 			var equal=false;
					 			$.each(dataArr,function(dataArri,dataArro){
					 				if(datao.regionalId==dataArro) equal=true;
					 			});
					 			$(o).append('<div class="check-group"><input type="checkbox" name="information_id" disabled="disabled" '+(equal?"checked":"")+'><span>'+datao.regionalId+'</span></div>');
					 		}else{
					 			$(o).append('<div class="check-group"><input type="checkbox" name="information_id" disabled="disabled"><span>'+datao.regionalId+'</span></div>');
					 		}
					 	});
					 }
				 }); */
			 });
		 }
		function showArea(dataArr){
			 loadArea();
			 var paramData={};
				dataArr=dataArr?dataArr:[];
				paramData["startTime"]=$("#approachDate").val();
				paramData["id"]=$("input[name='applicationInformationId']").val();
				paramData["endTime"]=$("#appearancesDate").val();
				 $.ajax({
					type: "post",
			        url:  '${ctx}/rm/rmRmInformation/findRegions',
			        data:paramData,
			        dataType: "json",
			        ContentType:'application/x-www-form-urlencoded',
			        global:false,
			        success: function(data){ 
			        	var nowDom=$("div[name='regionType3']"); 
			        	var nowDom1=$("div[name='regionType1']"); 
			        	var nowDom2=$("div[name='regionType2']"); 
			        	var nowDom4=$("div[name='regionType4']"); 
			        	var nowDom5=$("div[name='regionType5']"); 
			        	nowDom.empty();
			        	nowDom1.empty();
			        	nowDom2.empty();
			        	nowDom4.empty();
			        	nowDom5.empty();
			        	$.each(data,function(i,o){
			        		var regional_id = new Array(); //定义一数组 
			        		regional_id = o.regionalId.split(","); //字符分割 
			        		if(dataArr.length>0){
			        			var equlbol=false;
			        			$.each(dataArr,function(i_,o_){
			        				if(o.regionalId==o_){
			        					equlbol=true;
			        				}
			        			});
			        			for(i=0;i<regional_id.length;i++){
			        				if(o.regionalType==1)
			        					nowDom1.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
			        				if(o.regionalType==2)
				        				nowDom2.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
				        			if(o.regionalType==3)
					        			nowDom.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="area_name" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
					        		if(o.regionalType==4)
						        		nowDom4.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
						        	if(o.regionalType==5)
							        	nowDom5.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
							        				
			        			}
			        		}
			        		else{
			        			for(i=0;i<regional_id.length;i++){
			        				if(o.regionalType==1)
			        					nowDom1.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id"><span>'+regional_id[i]+'</span></div>');
			        				if(o.regionalType==2)
			        					nowDom2.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id"><span>'+regional_id[i]+'</span></div>');
			        				if(o.regionalType==3)
			        					nowDom.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="area_name"><span>'+regional_id[i]+'</span></div>');
			        				if(o.regionalType==4)
			        					nowDom4.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id"><span>'+regional_id[i]+'</span></div>');
			        				if(o.regionalType==5)
			        					nowDom5.append('<div class="groupsel-check"><input type="checkbox" disabled="disabled" name="information_id"><span>'+regional_id[i]+'</span></div>');
			        				
			        			}
			        		}
			        	});
			        }
				});
		 }
		
		function setValue(){
			var informationId = "${rmVsDiscrepancyInformation.informationId}";  //其他区域名称
			var inforArr = (informationId && informationId.length>0)?informationId.split(","):[];
			loadArea(inforArr);
			var areaName = "${rmVsDiscrepancyInformation.areaName}";   //数据机房区域名称
			var areaArr = (areaName && areaName.length>0)?areaName.split(","):[];
			showArea(areaArr);
			var siteType = "${rmVsDiscrepancyInformation.siteType}";  //服务场地
			if(siteType && siteType.length>0){
				$.each(siteType.split(","),function(i,o){
					$("input[name='siteType']").each(function(i_,o_){
						if($(o_).attr("value") == o){
							$(o_).attr("checked","checked");
							return;
						}
					});
				});
			}
			var toolsType = "${rmVsDiscrepancyInformation.toolsType}";  //工具
			if(toolsType && toolsType.length>0){
				$.each(toolsType.split(","),function(i,o){
					$("input[name='toolsType']").each(function(i_,o_){
						if($(o_).attr("value") == o){
							$(o_).attr("checked","checked");
							return;
						}
					});
				});
			}
			var optionType = "${rmVsDiscrepancyInformation.optionType}";  //其他服务需求
			if(optionType && optionType.length>0){
				$.each(optionType.split(","),function(i,o){
					$("input[name='optionType']").each(function(i_,o_){
						if($(o_).attr("value") == o){
							$(o_).attr("checked","checked");
							return;
						}
					});
				});
			}
			
			var siteRemark = "${rmVsDiscrepancyInformation.siteRemark}";  //服务场地详细说明
			if(siteRemark && siteRemark.length>0){
				var index=0;
				$("input[name='siteType']:checked").each(function(i,o){
					$(o).next().next().val(siteRemark.split(":::")[index]);
					index++;
				});
			}
			var toolsRemark = "${rmVsDiscrepancyInformation.toolsRemark}";  //服务场地详细说明
			if(toolsRemark && toolsRemark.length>0){
				var index=0;
				$("input[name='toolsType']:checked").each(function(i,o){
					$(o).next().next().val(toolsRemark.split(":::")[index]);
					index++;
				});
			}
			var optionRemark = "${rmVsDiscrepancyInformation.optionRemark}";  //其他详细说明
			if(optionRemark && optionRemark.length>0){
				var index=0;
				$("input[name='optionType']:checked").each(function(i,o){
					$(o).next().next().val(optionRemark.split(":::")[index]);
					index++;
				});
			}
		}
		
		
	</script>
	<style type="text/css">
		.groupsel-check{
			float: left;
			min-width: 180px;
			text-align: left;
		}
		.lock{
			width: 100%;
			height: 100%;
			position: absolute;
			top: 0px;
			left: 0px;
		}
		.btn-print{
			margin-left: 130px;
			margin-top: 10px;
		}
		.remark-input{
			width: 160px;
			float: right;
			margin-right: 115px;
		}
		.remark-select{
			width: 75px;
			float: right;
			margin-right: 20px;
		}
		.div-valign{
			height: 25px;
			line-height: 25px;
			overflow: hidden;
		}
		.input-valign{
			height: 30px;
			line-height: 30px;
			overflow: hidden;
		}
		.photo-show{
			float: left;
			width: 50px;
			height: 50px;
			margin:0 5px;
		}
		.check-group{
			float: left;
			min-width: 180px;
			text-align: left;
		}
		.textarea-remark{
			width:calc(100% - 2px);
			width:-webkit-calc(100% - 2px);
			width:-moz-calc(100% - 2px);
			height:40px;
			resize:none;
			padding:0;
		}
		.table{
			width: auto;
		}
		.table td{
			width: 120px;
		}
	</style>
</head>
<body>
	<form:form id="inputForm" class="form-horizontal">
		<legend>申请单信息</legend>
		<div class="row">
			<div class="control-group span6 div-valign">
				<input type="hidden" name="applicationInformationId" value="${rmVsApplicationInformation.id}"/>
				<input type="hidden" name="vsApplyId" value="${rmVsApplicationInformation.vsApplyId}"/>
				<label class="control-label">申请单号：</label><span>${rmVsApplicationInformation.vsApplyId}</span>
			</div>
			<div class="control-group span6 div-valign">
				<input type="hidden" name="customerName" value="${rmVsApplicationInformation.customerName}"/>
				<label class="control-label">客户名称：</label><span>${rmVsApplicationInformation.customerName}</span>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6 div-valign">
				<label class="control-label">申请人姓名：</label><span>${rmVsApplicationInformation.createBy.name}</span>
			</div>
			<div class="control-group span6 div-valign">
				<label class="control-label">申请人电话：</label><span>${rmVsApplicationInformation.createBy.mobile}</span>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6 div-valign">
				<input type="hidden" name="roomName" value="${rmVsApplicationInformation.roomName}"/>
				<label class="control-label">访问数据中心：</label><span>${rmVsApplicationInformation.roomName}</span>
			</div>
			<div class="control-group span6 div-valign">
				<input type="hidden" name="grounds" value="${rmVsApplicationInformation.grounds}"/>
				<label class="control-label">访问事由：</label><span>
					${fns:getDictLabel(rmVsApplicationInformation.grounds,'grounds',rmVsApplicationInformation.grounds)}
				</span>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6 div-valign">
				<label class="control-label">预定进场时间：</label>
				<span>
					<input type="hidden" id="approachDate" name="approachDate" value="<fmt:formatDate value="${rmVsApplicationInformation.approachDate }" pattern="yyyy-MM-dd HH:mm"/>"/>
					<fmt:formatDate value="${rmVsApplicationInformation.approachDate }" pattern="yyyy-MM-dd HH:mm"/>
				</span>
			</div>
			<div class="control-group span6 div-valign">
				<input type="hidden" name="stayTime" value="${rmVsApplicationInformation.stayTime}"/>
				<label class="control-label">停留时间：</label><span>
					${fns:getDictLabel(rmVsApplicationInformation.stayTime,'stay_time',rmVsApplicationInformation.stayTime)}</span>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6 div-valign">
				<input type="hidden" name="planNumber" value="${rmVsApplicationInformation.planNumber}"/>
				<label class="control-label">预定访问人数：</label><span>${rmVsApplicationInformation.planNumber }</span>
			</div>
			<div class="control-group span6 div-valign">
				<label class="control-label">已访问人数：</label><span>${rmVsApplicationInformation.actualNumber }</span>
			</div>
		</div>
		<div class="row">
			<div class="control-group span6 div-valign">
				<input type="hidden" name="remarks" value="${rmVsApplicationInformation.remarks}"/>
				<label class="control-label">申请单备注：</label><span>${rmVsApplicationInformation.remarks }</span>
			</div>
		</div>
		<%-- <div class="row">
			<div class="control-group span6">
				<label class="control-label">证件拍照：</label>
				<div class="controls" name="showphoto" id="showphoto">
					<div class="photo-show">
						<img src="${ctxStatic}/img/demo/user_1.png">
					</div>
					<div class="photo-show">
						<img src="${ctxStatic}/img/demo/user_1.png" >
					</div>
				</div>
			</div>
		</div> --%>
		<legend>访问人信息</legend>
		<div class="control-group">
			<label class="control-label">人员名单：</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>证件类型</th>
							<th>证件号码</th>
							<th>访问人姓名</th>
							<th>门禁卡号</th>
							<th>所属公司</th>
							<th>联系电话</th>
							<th>访客类型</th>
							<th>备注</th>
							<th>入场状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rmVsDiscrepancyInformation.rmVsAccessUserInformationList}" var="list">
							<tr>
								<td>
									<c:if test="${list.documentType == 1}"><input type="text" class="input-small" value="身份证" style="width:50px"></c:if>
									<c:if test="${list.documentType == 2}"><input type="text" class="input-small" value="护照" style="width:50px"></c:if>
									<c:if test="${list.documentType == 3}"><input type="text" class="input-small" value="驾驶证" style="width:50px"></c:if>
								</td>
								<td><input type="text" class="input-small" value="${list.idNumber}" style="width:90px"></td>
								<td><input type="text" class="input-small" value="${list.name}" style="width:70px"></td>
								<td><input type="text" class="input-small" value="${list.cardNo}" style="width:90px"></td>
								<td><input type="text" class="input-small" value="${list.affiliation}" style="width:70px"></td>
								<td><input type="text" class="input-small" value="${list.userPhone}" style="width:70px"></td>
								<td><input type="text" class="input-small" value="${fns:getDictLabel(list.visitorType,'visitor_type',list.visitorType)}" style="width:50px">
									
								</td>
								<td><input type="text" class="input-small" value="${list.userRemark}"></td>
								<td>
								<c:if test="${list.verificationFlag==1}"><input type="text" class="input-small" value="未登记入场" style="width:70px;background-color:green;color: #fff;"></c:if>
								<c:if test="${list.verificationFlag==2}"><input type="text" class="input-small" value="已登记入场" style="width:70px;background-color:green;color: #fff;"></c:if>
								<c:if test="${list.verificationFlag==3}"><input type="text" class="input-small" value="已退卡出场" style="width:70px;background-color:green;color: #fff;"></c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<legend>访问区域</legend>
		<div class="control-group" style="position: relative;">
			<label class="control-label">访问区域：</label>
			<div class="controls">
				<table style="width:100%;" class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th width="20%">区域分类</th>
							<th>区域名称</th>
						</tr>
					</thead>
					<tbody id="area_">
						<c:forEach items="${fns:getDictList('region_type')}" var="regionType">
							<tr>
								<td>${regionType.label}</td>
								<td><div name="regionType${regionType.value}"></div></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="lock"></div>
		</div>
		<div id="receive_div">
		<legend>陪同人员</legend>
		<div class="control-group">
			<label class="control-label">陪同人员：</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>陪同人员姓名</th>
							<th>手机号码</th>
						</tr>
					</thead>
					<tbody id="receive_">
						<c:forEach items="${rmVsDiscrepancyInformation.rmVsReceiveList}" var="rmVsReceiveList">
							<tr>
								<td><input type="text" class="input-small" name="receName" value="${rmVsReceiveList.receName}"></td>
								<td><input type="text" class="input-small" name="receMobile" value="${rmVsReceiveList.receMobile}"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		</div>
		<div id="tool_div">
		<legend>随携设备</legend>
		<div class="control-group">
			<label class="control-label">随携设备：</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>名称</th>
							<th>描述</th>
							<th>序列号</th>
							<th>操作内容</th>
							<th>验证状态</th>
						</tr>
					</thead>
					<tbody id="rmVsBring_Table">
						<c:forEach items="${rmVsDiscrepancyInformation.rmVsToolList}" var="rmVsToolList">
							<tr>
								<td><input type="text" class="input-small" name="toolName" value="${rmVsToolList.name}"></td>
								<td><input type="text" class="input-small" name="description" value="${rmVsToolList.description}"></td>
								<td><input type="text" class="input-small" name="toolNumber" value="${rmVsToolList.toolNumber}"></td>
								<td><input type="text" class="input-small" name="purpose" value="${rmVsToolList.purpose}"></td>
								<td><input type="text" class="input-small" value="未通过"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		</div>
		<div id="move_div">
		<legend>大件设备</legend>
		<div class="control-group">
			<label class="control-label">大件设备：</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>类型</th>
							<th>名称</th>
							<th>制造商</th>
							<th>型号</th>
							<th>序列号</th>
							<th>设备空间（U）</th>
							<th>重量（KG）</th>
							<th>移入/移出</th>
							<th>指定位置</th>
						</tr>
					</thead>
					<tbody id="rmVsBring_large_Table">
						<c:forEach items="${rmVsDiscrepancyInformation.rmVsMoveList}" var="rmVsMoveList">
							<tr>
								<td><input type="text" class="input-small" name="deviceType" style="width:65px;" value="${fns:getDictLabel(rmVsMoveList.deviceType,'device_type',rmVsMoveList.deviceType)}"></td>
								<td><input type="text" class="input-small" name="itemName" style="width:75px;"  value="${rmVsMoveList.itemName}"></td>
								<td><input type="text" class="input-small" name="manufacturer" style="width:70px;" value="${rmVsMoveList.manufacturer}"></td>
								<td><input type="text" class="input-small" name="model" style="width:70px;" value="${rmVsMoveList.model}"></td>
								<td><input type="text" class="input-small" name="serialNum" style="width:80px;" value="${rmVsMoveList.serialNum}"></td>
								<td><input type="text" class="input-small" name="deviceSpace" style="width:80px;" value="${rmVsMoveList.deviceSpace}"></td>
								<td><input type="text" class="input-small" name="deviceWeight" style="width:80px;" value="${rmVsMoveList.deviceWeight}"></td>
								<td><select name="moveAdvanceOrOut" disabled="disabled" style="width:70px;font-size:14px;">
								<c:if test="${rmVsMoveList.moveAdvanceOrOut==1}"><option value="1" selected="selected">移入</option><option value="2">移出</option></c:if>
								<c:if test="${rmVsMoveList.moveAdvanceOrOut==2}"><option value="1">移入</option><option value="2" selected="selected">移出</option></c:if>
								</select></td>
								<td><input type="text" class="input-small" name="specifiedPlace" style="width:80px;" value="${rmVsMoveList.specifiedPlace}"></td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目经理：</label>
			<div class="controls">
				<table class="table table-striped table-bordered table-condensed">
					<thead>
						<tr>
							<th>项目经理</th>
							<th>所属公司</th>
							<th>手机号码</th>
						</tr>
					</thead>
					<tbody id="leader_">
						<c:forEach items="${rmVsDiscrepancyInformation.rmVsLeaderList}" var="rmVsLeaderList">
							<tr>
								<td><input type="text" class="input-small" name="leadName" value="${rmVsLeaderList.leadName}"></td>
								<td><input type="text" class="input-small" name="leadCompany" value="${rmVsLeaderList.leadCompany}"></td>
								<td><input type="text" class="input-small" name="leadMobile" value="${rmVsLeaderList.leadMobile}"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		</div>
		<legend>服务需求</legend>
		<div class="control-group" style="position:relative;">
			<label class="control-label">服务场地：</label>
			<div class="controls">
				<c:forEach items="${fns:getDictList('site_type')}" var="siteType">
					<div class="control-group span6 input-valign">
						<input type="checkbox" name="siteType" disabled="disabled" value="${siteType.value}">
						<span>${siteType.label}</span>
						<input type="text" name="siteRemark" readonly="readonly" class="remark-input" placeholder="详细说明" value="">
					</div>
				</c:forEach>
			</div>
			<label class="control-label">工具：</label>
			<div class="controls">
				<c:forEach items="${fns:getDictList('tools_type')}" var="toolsType">
					<div class="control-group span6 input-valign">
						<input type="checkbox" name="toolsType" disabled="disabled" value="${toolsType.value}">
						<span>${toolsType.label}</span>
						<input type="text" name="toolsRemark" readonly="readonly" class="remark-input" placeholder="详细说明" value="">
					</div>
				</c:forEach>
			</div>
			<label class="control-label">其他：</label>
			<div class="controls">
				<c:forEach items="${fns:getDictList('option_type')}" var="optionType">
					<div class="control-group span6 input-valign">
						<input type="checkbox" name="optionType" disabled="disabled" value="${optionType.value}">
						<span>${optionType.label}</span>
						<input type="text" name="optionRemark" readonly="readonly" class="remark-input" placeholder="详细说明" value="">
					</div>
				</c:forEach>
			</div>
			<div class="lock"></div>
		</div>
		
		<input type="hidden" name="discrepancyInformationId" value="${rmVsDiscrepancyInformation.id }"/>
		<div class="form-actions">
			<input type="button" class="btn" value="返 回" onclick="history.go(-1)">
		</div>
	</form:form>
</body>
</html>