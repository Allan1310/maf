<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<link rel="stylesheet" href="${ctxStatic}/css1/webpanelTab.css" />
<script type="text/javascript">
 function chageHeightStyle(){
	  $(".title-bg").each(function(index, element) {
		if($(element).children(".point-bg").length>0)
        $(element).children(".point-bg").height($(element).find(".font-bg").height()-6);
		if($(element).children(".point-big-bg").length>0)
		$(element).children(".point-big-bg").height($(element).find(".font-bg").height()-6);
		if($(element).children(".line-big-bg").length>0)
		$(element).children(".line-big-bg").height($(element).find(".font-bg").height());
		if($(element).children(".line-bg").length>0)
		$(element).children(".line-bg").height($(element).find(".font-bg").height());
     });
 }
 function changeGroupNum(){
	$(".table-groups:not(.hide)").each(function(i,o){
		$(o).find("span:first").text((i+1));
	}); 
 }
 $(document).ready(function(e) {
	 $("body").children().each(function(i,o){
			if(!$(o).hasClass("hide")){
				$(o).addClass("hide");
			}
	 });
	 if("${param.btn}"&&"${param.btn}"=="2"){
		 $(".lock").show();
	 }else{
		 $(".lock").hide();
	 }
	 $(window).resize(function(){
		chageHeightStyle();
	 });
	 
	 $("input[name='col_manage']").click(function(){
		 if($(this).attr("checked")){
			 $("#receive_group").removeClass("hide");
		 }else{
			 $("#receive_group").addClass("hide");
		 }
		 changeGroupNum();
	 });
	 $("input[name='col_equp']").click(function(){
		 if($(this).attr("checked")){
			 $("#equp_group").removeClass("hide");
		 }else{
			 $("#equp_group").addClass("hide");
		 }
		 changeGroupNum();
	 });
	 $(".error-close").click(function(){
		 $(this).parent().addClass("hide");
	 });
	 //限制人员进出的选项不能多选
	 /* $("input[name='grounds']").click(function(){
		 if($(this).attr("checked")){
			 $(this).parent().siblings().children("input").removeAttr("checked");
		 } 
	 }); */
	 $(".required").each(function(){
		 var $this = $(this);
		 $(this).html($this.html()+"<font color='red'>*</font>");
	 });
	  
	//新增的时候给的数据
	var dataParam={};
	if("${param.btn}"&&"${param.btn}"=="1"){
		dataParam["id"]="${param.id}";
	}
	else if("${param.btn}"&&"${param.btn}"=="2"){
		dataParam["id"]="${param.id}";
		$("#subMitBtn").parent().hide();
		$("#closeBtn").closest("div.closed").addClass("closeonly");
	}
	
	 $.ajax({
		type: "post",
        url: '${ctx}/rm/rmVsApplicationInformation/m/form',
        data:dataParam,
        dataType: "json",
        ContentType:'application/x-www-form-urlencoded',
        global:false,
        success: function(data){
        	$("body").children(":not(.container-fluid)").removeClass("hide");
	       	chageHeightStyle();	//title自适应
	       	changeGroupNum();       //动态显隐以后,每块自动排序
        	setValue(data);
        },
        error:function(){
        	$("body").children(":not(.container-fluid)").remove();
			$("body").children(".container-fluid").removeClass("hide");
        }
	});
});
 
 
 function showArea(dataArr){
	 loadArea();
	 var paramData={};
		dataArr=dataArr?dataArr:[];
		paramData["startTime"]=$("#approachDate").val();
		paramData["id"]=$("input[name='id']").val();
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
			        			nowDom.append('<div class="groupsel-check"><input type="checkbox"  disabled="disabled" name="area_name" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
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
	        					nowDom.append('<div class="groupsel-check"><input type="checkbox"  disabled="disabled" name="area_name"><span>'+regional_id[i]+'</span></div>');
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
			 			$(o).append('<div class="groupsel-check"><input type="checkbox" name="information_id" disabled="disabled" '+(equal?"checked":"")+'><span>'+datao.regionalId+'</span></div>');
			 		}else{
			 			$(o).append('<div class="groupsel-check"><input type="checkbox" name="information_id" disabled="disabled"><span>'+datao.regionalId+'</span></div>');
			 		}
			 	});
			 }
		 }); */
	 });
 }
 function setValue(data){
	 $("input[name='roomName']").val(data["rmVsApplicationInformation"]["roomName"]);
	 $("input[name='customerName']").val(data["rmVsApplicationInformation"]["customerName"]);
	 $("input[name='mail']").val(data["rmVsApplicationInformation"]["mail"]); 
	 $("input[name='auditType']").val(data["rmVsApplicationInformation"]["auditType"]);
	 $("textArea[name='remarks']").val(data["rmVsApplicationInformation"]["remarks"]);
	 $("textArea[name='doors']").val(data["rmVsApplicationInformation"]["doors"]);
	 
	 $("input[name='approachDate']").val(data["rmVsApplicationInformation"]["approachDate"]);
	 $("input[name='stayTime']").each(function(i,o){
		 if($(o).attr("value")==data["rmVsApplicationInformation"]["stayTime"]){
			 $(o).attr("checked","checked");
			 return false;
		 }
	 });
	 //$("input[name='appearancesDate']").val(data["rmVsApplicationInformation"]["appearancesDate"]);
	 //var areaDom=$("#area_");
	 var areaArr=(data["rmVsApplicationInformation"]["areaName"]&&data["rmVsApplicationInformation"]["areaName"].length>0)?data["rmVsApplicationInformation"]["areaName"].split(","):[];
	 if(data["rmVsApplicationInformation"]["approachDate"]&&data["rmVsApplicationInformation"]["approachDate"].length>0)
	 showArea(areaArr);
	 var inforArr=(data["rmVsApplicationInformation"]["informationId"]&&data["rmVsApplicationInformation"]["informationId"].length>0)?data["rmVsApplicationInformation"]["informationId"].split(","):[];
	 loadArea(inforArr);
	 if(data["rmVsApplicationInformation"]["grounds"] && data["rmVsApplicationInformation"]["grounds"].length>0){
		 $("input[name='grounds']").each(function(i,o){
			 for(var i=0;i<data["rmVsApplicationInformation"]["grounds"].split(",").length;i++){
				 if($(o).attr("value") == data["rmVsApplicationInformation"]["grounds"].split(",")[i]){
					 $(o).attr("checked","checked");
					 return;
				 }
			 }
		 });
	 }
	 $("input[name='visitRemark']").val(data["rmVsApplicationInformation"]["visitRemark"]);
	 if(data["rmVsApplicationInformation"]["rmVsAccessUserInformationList"]&&data["rmVsApplicationInformation"]["rmVsAccessUserInformationList"].length>0){
		 var parentDom=$("#manage_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsAccessUserInformationList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
				trDom.css({"margin-bottom":"20px"});
				var td_1=$(("<td>"+(i+1)+"</td>"));
				var td_2=$("<td></td>").append('<select name="visitor_type" style="width:90px" disabled="disabled"><c:forEach items="${fns:getDictList(\'visitor_type\')}" var="vt"><option value="${vt.value}" '+(o.visitorType&&o.visitorType=="${vt.value}"?"selected":"")+'>${vt.label}</option></c:forEach></select>');
				var td_3=$("<td></td>").append(('<input type="text" name="user_name" style="width:100px" readonly="readonly" value="'+o.name+'"/>'));
				var td_4=$("<td></td>").append(('<select name="user_type" style="width:90px" disabled="disabled"><option value="1" '+(o.documentType&&o.documentType=="1"?"selected":"")+'>身份证</option><option value="2" '+(o.documentType&&o.documentType=="2"?"selected":"")+'>护照</option><option value="3" '+(o.documentType&&o.documentType=="3"?"selected":"")+'>驾驶证</option></select>'));
				var td_5=$("<td></td>").append('<input type="text" name="user_num" style="width:140px" readonly="readonly" value="'+o.idNumber+'"/>');
				var td_6=$("<td></td>").append('<input type="text" name="user_phone" style="width:120px" readonly="readonly" value="'+o.userPhone+'"/>');
				var td_7=$("<td></td>").append('<input type="text" name="user_org" style="width:100px" readonly="readonly" value="'+o.affiliation+'"/>');
				var td_8=$("<td></td>").append('<input type="text" name="user_remark" style="width:90px" readonly="readonly" value="'+o.userRemark+'"/>');
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);	
				trDom.append(td_4);	
				trDom.append(td_5);
				trDom.append(td_6);	
				trDom.append(td_7);
				trDom.append(td_8);
				parentDom.append(trDom);
		 }); 
	 }
	 if(data["rmVsApplicationInformation"]["rmVsToolList"] && data["rmVsApplicationInformation"]["rmVsToolList"].length>0){
		 var deviceDom=$("#device_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsToolList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
			 trDom.css({"margin-bottom":"20px"});
			 var td_1=$(("<td>"+(i+1)+"</td>"));
			 var td_2=$("<td></td>").append('<input type="text" name="device_name" readonly="readonly" value="'+o.name+'"/>');
			 var td_3=$("<td></td>").append('<input type="text" name="description" readonly="readonly" value="'+o.description+'"/>');
			 var td_4=$("<td></td>").append('<input type="text" name="toolNumber" readonly="readonly" value="'+o.toolNumber+'"/>');
			 var td_5=$("<td></td>").append('<input type="text" name="purpose" readonly="readonly" value="'+o.purpose+'"/>');
			 trDom.append(td_1);
			 trDom.append(td_2);	
			 trDom.append(td_3);
			 trDom.append(td_4);
			 trDom.append(td_5);
			 deviceDom.append(trDom);
		 });
	 }
	 if(data["rmVsApplicationInformation"]["rmVsReceiveList"] && data["rmVsApplicationInformation"]["rmVsReceiveList"].length>0){
		 $("input[name='col_manage']").attr("checked","checked");
		 //$("#manage_group").removeClass("hide");
		 $("#receive_group").removeClass("hide");
		 //$("#device_group").removeClass("hide");
		 changeGroupNum();
		 var receiveDom=$("#receive_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsReceiveList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
				trDom.css({"margin-bottom":"20px"});
				var td_1=$(("<td>"+(i+1)+"</td>"));
				var td_2=$("<td></td>").append('<input type="text" name="rece_name" readonly="readonly" value="'+o.receName+'"/>');
				var td_3=$("<td></td>").append('<input type="text" name="rece_mobile" readonly="readonly" value="'+o.receMobile+'"/>');
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);
				receiveDom.append(trDom);
		 });
	 }
	 if(data["rmVsApplicationInformation"]["rmVsMoveList"]&&data["rmVsApplicationInformation"]["rmVsMoveList"].length>0){
		 $("input[name='col_equp']").attr("checked","checked");
		 $("#equp_group").removeClass("hide");
		 //$("#leader_group").removeClass("hide");
		 changeGroupNum();
		 var parentDom=$("#equp_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsMoveList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
				trDom.css({"margin-bottom":"20px"});
				var td_1=$(("<td>"+(i+1)+"</td>"));
				var td_2=$("<td></td>").append('<select name="deviceType" style="width:90px" disabled="disabled"><c:forEach items="${fns:getDictList(\'device_type\')}" var="dt"><option value="${dt.value}" '+(o.deviceType&&o.deviceType=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				var td_3=$("<td></td>").append('<input type="text" name="itemName" style="width:65px" readonly="readonly" value="'+o.itemName+'"/>');
				var td_4=$("<td></td>").append('<input type="text" name="manufacturer" style="width:70px" readonly="readonly" value="'+o.manufacturer+'"/>');
				var td_5=$("<td></td>").append('<input type="text" name="model" style="width:70px" readonly="readonly" value="'+o.model+'"/>');
				var td_6=$("<td></td>").append('<input type="text" name="serial_num" style="width:70px" readonly="readonly" value="'+o.serialNum+'"/>');
				var td_7=$("<td></td>").append('<input type="text" name="device_space" style="width:100px" readonly="readonly" value="'+o.deviceSpace+'"/>');
				var td_8=$("<td></td>").append('<input type="text" name="device_weight" style="width:90px" readonly="readonly" value="'+o.deviceWeight+'"/>');
				var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px" disabled="disabled"><c:forEach items="${fns:getDictList(\'move_or_out\')}" var="dt"><option value="${dt.value}" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				//var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px" disabled="disabled"><option value="1" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="1"?"selected":"")+'>移入</option><option value="2" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="2"?"selected":"")+'>移出</option></select>');
				var td_10=$("<td></td>").append('<select name="specified_place" style="width:90px" disabled="disabled"><c:forEach items="${fns:getDictList(\'specified_place\')}" var="dt"><option value="${dt.value}" '+(o.specifiedPlace&&o.specifiedPlace=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				//var td_10=$("<td></td>").append('<input type="text" name="specified_place" style="width:70px" readonly="readonly" value="'+o.specifiedPlace+'"/>');
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);	
				trDom.append(td_4);	
				trDom.append(td_5);
				trDom.append(td_6);	
				trDom.append(td_7);	
				trDom.append(td_8);
				trDom.append(td_9);
				trDom.append(td_10);
				parentDom.append(trDom);
		 });
		 
		 if(data["rmVsApplicationInformation"]["rmVsLeaderList"] && data["rmVsApplicationInformation"]["rmVsLeaderList"].length>0){
			 var leadDom = $("#leader_").find("tbody");
			 $.each(data["rmVsApplicationInformation"]["rmVsLeaderList"],function(i,o){
				 var trDom=$(("<tr></tr>"));
					trDom.css({"margin-bottom":"20px"});
					var td_1=$(("<td>"+(i+1)+"</td>"));
					var td_2=$("<td></td>").append('<input type="text" name="lead_name" readonly="readonly" value="'+o.leadName+'"/>');
					var td_3=$("<td></td>").append('<input type="text" name="lead_company" readonly="readonly" value="'+o.leadCompany+'"/>');
					var td_4=$("<td></td>").append('<input type="text" name="lead_mobile" readonly="readonly" value="'+o.leadMobile+'"/>');
					trDom.append(td_1);
					trDom.append(td_2);	
					trDom.append(td_3);
					trDom.append(td_4);
					leadDom.append(trDom);
			 });
		 }
	 }
	 
	 if(data["rmVsApplicationInformation"]["siteType"] && data["rmVsApplicationInformation"]["siteType"].length>0){
		 $("input[name='siteType']").each(function(i,o){
			 for(var i=0;i<data["rmVsApplicationInformation"]["siteType"].split(",").length;i++){
				 if($(o).attr("value") == data["rmVsApplicationInformation"]["siteType"].split(",")[i]){
					 $(o).attr("checked","checked");
					 return;
				 }
			 }
		 });
	 }
	 $("input[name='siteRemark']").val(data["rmVsApplicationInformation"]["siteRemark"]);
	 if(data["rmVsApplicationInformation"]["toolsType"] && data["rmVsApplicationInformation"]["toolsType"].length>0){
		 $("input[name='toolsType']").each(function(i,o){
			 for(var i=0;i<data["rmVsApplicationInformation"]["toolsType"].split(",").length;i++){
				 if($(o).attr("value") == data["rmVsApplicationInformation"]["toolsType"].split(",")[i]){
					 $(o).attr("checked","checked");
					 return;
				 }
			 }
		 });
	 }
	 $("input[name='toolsRemark']").val(data["rmVsApplicationInformation"]["toolsRemark"]);
	 if(data["rmVsApplicationInformation"]["optionType"] && data["rmVsApplicationInformation"]["optionType"].length>0){
		 $("input[name='optionType']").each(function(i,o){
			 for(var i=0;i<data["rmVsApplicationInformation"]["optionType"].split(",").length;i++){
				 if($(o).attr("value") == data["rmVsApplicationInformation"]["optionType"].split(",")[i]){
					 $(o).attr("checked","checked");
					 return;
				 }
			 }
		 });
	 }
	 $("input[name='optionRemark']").val(data["rmVsApplicationInformation"]["optionRemark"]);
	 
  }
 
 </script>
<style type="text/css">
	.lock{
		width: 100%;
		height: calc(100% - 80px);
		position: absolute;
		top: 0px;
		left: 0px;
	}
	#table_content{
		position: relative;
		height: auto;
	}
	.mana-warning_small{
		font-size: 14px;
		height: 50px;
		line-height: 50px;
	}
	.mana-button_small{
		background-size: 70% 70%;
	}
	.mana-table td{
		min-width: 30px;
	}
	.mana-table input, .mana-table select{
		width: 100px;
	}
	.label_{
		width: 20%;
	}
	.title-bg{
		width: 100%;
	}
	.btns a:hover{text-decoration: none;cursor: pointer;}
</style>
</head>

<body>
	<div class="container-fluid hide">
		<div class="page-header"><h1>操作权限不足.</h1></div>
		
		<div><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		<script>try{top.$.jBox.closeTip();}catch(e){}</script>
	</div>
	<div class="table-content" id="table_content">
		<div class="error-message hide">
			<div class="error-single"><a  href="#come_time" ><span>1、</span>出访时间不能为空</a></div>
			<div class="error-single"><a  href="#come_reason"><span>2、</span>访问事由不能为空</a></div>
			<div class="error-close">X</div>
		</div>
    	<h3 class="table-title">人员设备进出申请表</h3>
    	<div class="table-groups">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>1</span></div>
                	<div class="bg font-bg bg-height">请在此处填写您的基本信息：</div>
                    <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                    <input type="hidden" name="id" value="${param.id}"/>
                    <input type="hidden" name="auditType"/>
                    <input type="hidden" name="doors"/>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="label_">申请人:</td>
                        <td class="label-input"><input type="text" name="applyName" value="${fns:getUser().name}"  readonly/></td>
                        <td class="label_">申请人所属公司：</td>
                        <td class="label-input"><input type="text"  name="customerName"  readonly/></td>
                    </tr>
                	<tr class="basic-info">
                    	<td class="label_">手机/电话:</td>
                        <td class="label-input"><input type="text"  name="phone" value="${ empty fns:getUser().mobile?fns:getUser().phone:fns:getUser().mobile}" readonly/></td>
                        <td class="label_">访问数据中心：</td>
                        <td class="label-input"><input type="text" name="roomName"  readonly/><input type="hidden" name="mail"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="table-groups" id="come_reason">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>2</span></div>
                	<div class="bg font-bg bg-height">请在此处填写您的进入类型：</div>
                    <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="label-check"><span class="required">访问事由</span></td>
                        <td class="label-check-groups" style="width:50%;">
                        	<div class="groupsel" id="grounds">
                        		<c:forEach items="${fns:getDictList('grounds')}" var="grounds"  >
                        			<div class="groupsel-check"><input type="checkbox" name="grounds" value="${grounds.value}" disabled="disabled"/><span>${grounds.label}</span></div>
								</c:forEach>
								
                            </div>
                        </td>
                        <td class="label-check-groups" style="width:25%;">
                        	<div class="groupsel-check">
                        		<span>备注：</span>
                        		<input name="visitRemark" type="text" style="width:125px;line-height:normal;margin:0 3px 0 8px;" readonly="readonly">
                        	</div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    	
        <div class="table-groups" id="come_time">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>3</span></div>
                	<div class="bg font-bg bg-height">请在此处确认您的访问日期和时间：</div>
                    <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0">
            	<tbody>
                	<tr class="basic-info">
                		<td class="label_ required" style="width:15%;">访问时间：</td>
                    	<td class="date-input" style="width:20%;">
                    		<input id="approachDate" name="approachDate" type="text" readonly="readonly" maxlength="20" class="Wdate" />
						</td>
                        <!-- <td class="date-input"><input id="appearancesDate" name="appearancesDate" type="text" readonly="readonly" maxlength="20" class="Wdate" pattern="yyyy-MM-dd HH:mm"
						/></td> -->
						<td class="label_ required" style="width:15%;">停留时间：</td>
						<td class="label-check-groups">
							<div class="groupsel" id="stayTime">
                        		<c:forEach items="${fns:getDictList('stay_time')}" var="stayTime"  >
                        			<div class="groupsel-check">
                        				<c:if test="${stayTime.value==1}">
                        					<input type="radio" name="stayTime" value="${stayTime.value}" checked="checked" disabled="disabled"/>
                        				</c:if>
                        				<c:if test="${stayTime.value!=1}">
                        					<input type="radio" name="stayTime" value="${stayTime.value}" disabled="disabled"/>
                        				</c:if>
                        				<span>${stayTime.label}</span>
                        			</div>
								</c:forEach>
                            </div>
						</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="table-groups" id="area_parent">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>4</span></div>
                	<div class="bg font-bg bg-height">请在此处填写您要进入的区域：</div>
                    <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
            <table width="100%" cellpadding="0" cellspacing="0" id="area_">
            	<c:forEach items="${fns:getDictList('region_type')}" var="regionType">
            		<tr class="basic-info">
            			<td class="label-check"><span>${regionType.label}</span></td>
            			<td class="label-check-groups">
            				<div class="groupsel" name="regionType${regionType.value}">
            					
            				</div>
            			</td>
            		</tr>
            	</c:forEach>
            </table>
        </div>
        
        <div class="table-groups" id="manage_group">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>5</span></div>
                	<div class="bg font-bg bg-height">请在此处填写需要进入的人员名单:</div>
                     <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table  class="mana-table add-mana-table" id="manage_">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="mana-td-">序号</td>
                    	<td class="mana-td- required">访客类型</td>
                    	<td class="mana-td- required">姓名</td>
                        <td class="mana-td- required">证件类型</td>
                        <td class="mana-td- required">证件号码</td>
                        <td class="mana-td- required">手机号码</td>
                        <td class="mana-td- required">所属公司</td>
                        <td class="mana-td-">备注</td>
                    </tr>
                </tbody>
            </table>
            <div class="mana-button mana-button_small"  data-click="add" data-param="people"><a></a></div>
            <div class="mana-warning mana-warning_small" >温馨提示：请告知上述人员来访时务必携带您所登记的证件原件。</div>
            <!-- <table width="100%" style="margin-top:21px;">
            	<tbody>
            		<tr class="basic-info">
            			<td class="label-check"><span>陪同需求</span></td>
            			<td class="label-check-groups">
            				<div class="groupsel">
            					<div class="groupsel-check"><input type="checkbox" name="col_manage" disabled="disabled"/><span>有无工作人员陪同</span></div>
            				</div>
            			</td>
            		</tr>
            	</tbody>
            </table> -->
        </div>
        <div class="table-groups hide" id="receive_group">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>a</span></div>
                	<div class="bg font-bg bg-height">请在此处填写需要陪同进入的工作人员名单:</div>
                     <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
            <table  class="mana-table add-mana-table" id="receive_">
            	<tbody>
            		<tr class="basic-info">
                    	<td class="mana-td-">序号</td>
                    	<td class="mana-td- required">陪同人员姓名</td>
                    	<td class="mana-td- required">手机号码</td>
                    </tr>
            	</tbody>
            </table>
            <div class="mana-button mana-button_small"  data-click="add" data-param="receive"><a></a></div>
        </div>
        <div class="table-groups" id="device_group">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>b</span></div>
                	<div class="bg font-bg bg-height">请在此处填写随携设备的名单:</div>
                     <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
            <table  class="mana-table add-mana-table" id="device_">
            	<tbody>
            		<tr class="basic-info">
                    	<td class="mana-td-">序号</td>
                    	<td class="mana-td- required">名称</td>
                    	<td class="mana-td-">描述</td>
                    	<td class="mana-td- required">序列号</td>
                    	<td class="mana-td- required">操作内容</td>
                    </tr>
            	</tbody>
            </table>
            <div class="mana-button mana-button_small"  data-click="add" data-param="device"><a></a></div>
            <div class="mana-warning mana-warning_small">温馨提示：严禁携带危险物品进入数据中心，所有物品都应接收安全检查。</div>
        </div>
        
        <table width="100%" style="margin-top:21px;">
        	<tbody>
        		<tr class="basic-info">
        			<td class="label-check"><span>有无大件设备进出</span></td>
        			<td class="label-check-groups">
        				<div class="groupsel">
        					<!-- <div class="groupsel-check"><input type="checkbox" name="col_equp"/><span>是否大件设备进出</span></div> -->
        					<div class="groupsel-check"><input id="col_equp1" type="radio" name="col_equp" checked="checked" disabled="disabled"/><span>无</span></div>
        					<div class="groupsel-check"><input id="col_equp1" type="radio" name="col_equp" disabled="disabled"/><span>有</span></div>
        				</div>
        			</td>
        		</tr>
        	</tbody>
        </table>
        
        <div class="table-groups hide" id="equp_group">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>6</span></div>
                	<div class="bg font-bg bg-height">请在此处分别填写大件设备出入信息及项目经理信息:</div>
                    <div class="bg point-bg bg-height">&nbsp;</div>
                    <div class=" line-bg bg-height">&nbsp;</div>
                </div>
            </div>
            <div style="overflow-x:auto;">
            	<table  class="mana-table add-mana-table" id="equp_">
	            	<tbody>
	                	<tr class="basic-info">
	                    	<td class="mana-td-">序号</td>
	                    	<td class="mana-td- required">类型</td>
	                    	<td class="mana-td- required">名称</td>
	                    	<td class="mana-td-">制造商</td>
	                        <td class="mana-td- required">型号</td>
	                        <td class="mana-td- required">序列号</td>
	                        <td class="mana-td-">设备空间（U）</td>
	                        <td class="mana-td-">重量（KG）</td>
	                        <td class="mana-td- required">移入/移出</td>
	                        <td class="mana-td- required">移入/移出位置</td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            <div class="mana-button mana-button_small" data-click="add" data-param="equp"><a></a></div>
            <table  class="mana-table add-mana-table" id="leader_" style="margin-top:14px;">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="mana-td-">序号</td>
                    	<td class="mana-td- required">项目经理</td>
                    	<td class="mana-td- required">所属公司</td>
                    	<td class="mana-td- required">手机号码</td>
                    </tr>
                </tbody>
            </table>
            <div class="mana-button mana-button_small" data-click="add" data-param="leader"><a></a></div>
            <div class="mana-warning mana-warning_small">温馨提示：大件设备进出，需客户方指定项目经理现场确认设备出入情况。
            	所有设备应在指定地点完成拆箱，测试操作后，才能搬入机房，敬请谅解。</div>
        </div>
        
        <div class="table-groups">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>7</span></div>
                	<div class="bg font-bg bg-height">请在此处选择需要提供的服务要求或其他特殊说明</div>
                    <div class="bg point-big-bg bg-height">&nbsp;</div>
                    <div class=" line-big-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0" id="fnt_">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="label-check"><span>A</span><span>.服务场地</span></td>
                        <td class="label-check-groups" style="width:75%;">
                            <div class="groupsel" id="siteType">
                            	<c:forEach items="${fns:getDictList('site_type')}" var="siteType">
                            		<div class="groupsel-check"><input type="checkbox" name="siteType" value="${siteType.value}" disabled="disabled"/><span>${siteType.label}</span></div>
                            	</c:forEach>
                            </div>
                        </td>
                    </tr>
                    <tr class="basic-info">
                    	<td class="label-check"><span>B</span><span>.工具</span></td>
                        <td class="label-check-groups" style="width:75%;">
                        	<div class="groupsel" id="toolsType">
                            	<c:forEach items="${fns:getDictList('tools_type')}" var="toolsType">
                            		<div class="groupsel-check"><input type="checkbox" name="toolsType" value="${toolsType.value}" disabled="disabled"/><span>${toolsType.label}</span></div>
                            	</c:forEach>
                            </div>
                        </td>
                    </tr>
                	<tr class="basic-info">
                    	<td class="label-check"><span>C</span><span>.其他</span></td>
                        <td class="label-check-groups" style="width:75%;">
                        	<div class="groupsel" id="optionType">
                            	<c:forEach items="${fns:getDictList('option_type')}" var="optionType">
                            		<div class="groupsel-check"><input type="checkbox" name="optionType" value="${optionType.value}" disabled="disabled"/><span>${optionType.label}</span></div>
                            	</c:forEach>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="mana-warning mana-warning_small" style="margin-top:21px;">温馨提示：我们将按照先到先得的原则，尽可能的满足您所勾选的需求。</div>
        </div>
        <div class="table-groups">
        	<div class="groups-title">
                <div class="title-bg">
                	<div class="bg font-bg bg-height" style="padding: 0 0 0 10px;"><span>8</span></div>
                	<div class="bg font-bg bg-height">其他</div>
                    <div class="bg point-big-bg bg-height">&nbsp;</div>
                    <div class=" line-big-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="data-textarealabels" >备注</td>
                      	<td class="data-textarea"><textarea name="remarks" readonly="readonly"></textarea></td>
                    </tr>
                </tbody>
            </table>
        </div>
      	<div class="btns" style="margin-top: 60px;">
          	<a style="padding: 6px 85px;border: 1px solid #eee;background-color: #eee;font-size: 20px;border-radius:4px;" id="closeBtn" href="${ctx}/webPanel/webpanelList"  target="mainFrame">关闭</a>
        </div>
    </div>
</body>
</html>
