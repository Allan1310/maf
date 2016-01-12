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
 
 function serialize(o){       //数组换json
    var result = "";
 	var tempResult = [];
 	if(o instanceof Array){
 	    for(var i = 0 ; i < o.length ; i ++)
 		{
 		    tempResult.push(serialize(o[i]));
 		}
 		result = '['+tempResult.join(',')+']';
 	}
 	else
 	{
 	    for(var key in o)
 		{
 		    if(o[key] instanceof Array) tempResult.push(key+":"+serialize(o[key]));
 			else tempResult.push('"'+key+'"'+":"+'"'+o[key]+'"');

 		}
 		result = '{'+tempResult.join(',')+'}';
 	}
 	return result;
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
			 //$("#manage_group").removeClass("hide");
			 $("#receive_group").removeClass("hide");
			 //$("#device_group").removeClass("hide");
		 }else{
			 //$("#manage_group").addClass("hide");
			 $("#receive_group").addClass("hide");
			 //$("#device_group").addClass("hide");
		 }
		 changeGroupNum();
	 });
	 
	 $("input[name='col_equp']").click(function(){
		 if($(this).attr("checked")){
			 $("#equp_group").removeClass("hide");
			//$("#leader_group").removeClass("hide");
		 }else{
			 $("#equp_group").addClass("hide");
			 //$("#leader_group").addClass("hide");
		 }
		 changeGroupNum();
	 });
	 
	 $("#col_equp1").click(function(){
		$("#equp_group").addClass("hide");
		changeGroupNum();
	 });
	 
	 $("#col_equp2").click(function(){
		$("#equp_group").removeClass("hide");
		changeGroupNum();
		
	 });
	 
	 
	/*  $("#closeBtn").click(function(){
		 console.info("history",history);
		history.go(-1);
	 }); */
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
	 
	 /*日期选择*/
		 $("#approachDate").click(function(){
			var param={}; 
			param.dateFmt="yyyy-M-d H:00";
			param.minDate="%y-%M-%d %H:%m";
			param.onpicked=function(e){
				if($("#approachDate").val().length>0){
					showArea();
				}
			};
			WdatePicker(param);
	  });
	  /*日期选择--end*/
	$("[data-click='add']").click(function(e){
		e.preventDefault();
		var parentDom=$(this).parent().parent().parent();
		var childrenTrLength=parentDom.find("tr:not(.basic-info)").length;
		switch($(this).attr("data-param")){
			case 'people':
				var trDom=$("<tr></tr>");
				trDom.css({"margin-bottom":"20px"});	
				var td_1=$("<td></td>");
				var td_2=$("<td></td>").append('<select name="visitor_type" style="width:90px;"><c:forEach items="${fns:getDictList(\'visitor_type\')}" var="vt"><option value="${vt.value}">${vt.label}</option></c:forEach></select>');
				var td_3=$("<td></td>").append('<input type="text" name="user_name" style="width:100px;"/>');
				var td_4=$("<td></td>").append('<select name="user_type" style="width:90px;"><option value="1">身份证</option><option value="2">护照</option><option value="3">驾驶证</option></select>');
				var td_5=$("<td></td>").append('<input type="text" name="user_num" style="width:140px;"/>');
				var td_6=$("<td></td>").append('<input type="text" name="user_phone" maxlength="11"  style="width:120px;"/>');
				var td_7=$("<td></td>").append('<input type="text" name="user_org" style="width:100px;"/>');
				var td_8=$("<td></td>").append('<input type="text" name="user_remark" style="width:110px;"/>');
				var td_9=$("<td></td>").append('<input type="button" value="删除" style="width:70px;" onclick="deleteEqup(this)" userid="0"/>');
				td_1.text(childrenTrLength+1);
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);	
				trDom.append(td_4);	
				trDom.append(td_5);
				trDom.append(td_6);	
				trDom.append(td_7);
				trDom.append(td_8);
				trDom.append(td_9);
				parentDom.append(trDom);
				break;
			case 'receive':
				var trDom=$("<tr></tr>");
				trDom.css({"margin-bottom":"20px"});
				var td_1=$("<td>"+(childrenTrLength+1)+"</td>");
				var td_2=$("<td></td>").append('<input type="text" name="rece_name" />');
				var td_3=$("<td></td>").append('<input type="text" name="rece_mobile" />');
				var td_4=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)"  receid="0"/>');
				trDom.append(td_1);
				trDom.append(td_2);
				trDom.append(td_3);
				trDom.append(td_4);
				parentDom.append(trDom);
				break;
			case 'device':
				var trDom=$("<tr></tr>");
				trDom.css({"margin-bottom":"20px"});
				var td_1=$("<td>"+(childrenTrLength+1)+"</td>");
				var td_2=$("<td></td>").append('<input type="text" name="device_name" />');
				var td_3=$("<td></td>").append('<input type="text" name="description" />');
				var td_4=$("<td></td>").append('<input type="text" name="toolNumber" />');
				var td_5=$("<td></td>").append('<input type="text" name="purpose" />');
				var td_6=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)"  toolid="0"/>');
				trDom.append(td_1);
				trDom.append(td_2);
				trDom.append(td_3);
				trDom.append(td_4);
				trDom.append(td_5);
				trDom.append(td_6);
				parentDom.append(trDom);
				break;
			case 'equp' :
				var trDom=$("<tr></tr>");
				trDom.css({"margin-bottom":"20px"});
				var td_1=$("<td></td>");
				var td_2=$("<td></td>").append('<select name="deviceType" style="width:90px;"><c:forEach items="${fns:getDictList(\'device_type\')}" var="dt"><option value="${dt.value}">${dt.label}</option></c:forEach></select>');//类型
				var td_3=$("<td></td>").append('<input type="text" name="itemName" style="width:75px;"/>');//名称
				var td_4=$("<td></td>").append('<input type="text" name="manufacturer" style="width:70px;"/>');//制造商
				var td_5=$("<td></td>").append('<input type="text" name="model" style="width:70px;"/>');//型号
				var td_6=$("<td></td>").append('<input type="text" name="serial_num" style="width:80px;"/>');//序列号
				var td_7=$("<td></td>").append('<input type="text" name="device_space" style="width:100px;"/>');//设备空间
				var td_8=$("<td></td>").append('<input type="text" name="device_weight" style="width:80px;"/>');//重量
				var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px;"><c:forEach items="${fns:getDictList(\'move_or_out\')}" var="dt"><option value="${dt.value}">${dt.label}</option></c:forEach></select>');//类型
				//var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px;"><option value="1">移入</option><option value="2">移出</option></select>');
				var td_10=$("<td></td>").append('<select name="specified_place" style="width:90px;"><c:forEach items="${fns:getDictList(\'specified_place\')}" var="dt"><option value="${dt.value}">${dt.label}</option></c:forEach></select>');//类型
				//var td_10=$("<td></td>").append('<input type="text" name="specified_place" style="width:70px;"/>');
				var td_11=$("<td></td>").append('<input type="button" value="删除" style="width:60px;margin-left:-10px;" onclick="deleteEqup(this)"  deviceid="0"/>');
				td_1.text(childrenTrLength+1);
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
				trDom.append(td_11);
				parentDom.append(trDom);
				break;
			case 'leader':
				var trDom=$("<tr></tr>");
				trDom.css({"margin-bottom":"20px"});
				var td_1=$("<td></td>");
				var td_2=$("<td></td>").append('<input type="text" name="lead_name" />');//类型
				var td_3=$("<td></td>").append('<input type="text" name="lead_company"/>');//名称
				var td_4=$("<td></td>").append('<input type="text" name="lead_mobile"/>');//制造商
				var td_5=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)"  leadid="0"/>');
				td_1.text(childrenTrLength+1);
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);	
				trDom.append(td_4);	
				trDom.append(td_5);
				parentDom.append(trDom);
				break;
		}
	});
	
	/*---提交数据--*/
	$("#subMitBtn").click(function(){
		var allowSubmitbol=true;
		var param={};
		param["userids"]=$("#user_id").val();
		param["toolids"]=$("#tool_id").val();
		param["receids"]=$("#rece_id").val();
		param["leadidvs"]=$("#lead_id").val();
		param["deviceids"]=$("#device_id").val();
				
		param["isDraft"]="1";
		param["auditType"]=$("input[name='auditType']").val().length>0?$("input[name='auditType']").val():"1";//状态，若是提交或者保存都是1，若是审核失败，重新提交是3
		var groundsString="";
		$("input[name='grounds']").each(function(i,o){
			 if($(o).attr("checked")){
				 if(groundsString.length>0){
					 groundsString=groundsString+","+$(o).val();
				 }else{
					 groundsString=$(o).val();
				 }
			 }
		 });
		param["grounds"]=groundsString; //访问事由
		param["visitRemark"]=$("input[name='visitRemark']").val(); //访问事由其他
		param["approachDate"]=$("input[name='approachDate']").val(); //进场时间
		param["stayTime"]=$("input[name='stayTime']:checked").val(); //停留时间
		//param["appearancesDate"]=$("input[name='appearancesDate']").val(); //出场时间
		param["id"]=$("input[name='id']").val(); //出场时间
		var areaString="";
		$("div[name='regionType3']").find("div").each(function(i,o){
			if($(o).find("input[name='area_name']").attr("checked")){
				if(areaString.length>0){
					areaString=areaString+","+$(o).find("input[name='area_name']").next().text();
				}
				else{
					areaString=$(o).find("input[name='area_name']").next().text();
				}
			}
		});
		param["areaName"]=areaString; //机房数据区
		var inforString="";
		$("input[name='information_id']").each(function(i,o){
			if($(o).attr("checked")){
				if(inforString.length>0){
					inforString=inforString+","+$(o).next().text();
				}else{
					inforString=$(o).next().text();
				}
			}
		});
		param["informationId"]=inforString; //访问区域
		/*访问人员--start*/
		var rmVsAccessUserInformationList=[];
		var rmVsReceiveList=[];
		var rmVsToolList=[];
		$("#manage_").find("tr:not(.basic-info)").each(function(i,o){
			if($(o).find("input[name='user_name']").val().length>0){
				var data_rmVsAccessUserInformation={};
				data_rmVsAccessUserInformation["visitorType"]=$(o).find("select[name='visitor_type']").val();//访客类型
				data_rmVsAccessUserInformation["name"]=$(o).find("input[name='user_name']").val();//访问人姓名
				data_rmVsAccessUserInformation["documentType"]=$(o).find("select[name='user_type']").val();//访问人证件类型
				data_rmVsAccessUserInformation["idNumber"]=$(o).find("input[name='user_num']").val();//访问人证件号码
				data_rmVsAccessUserInformation["userPhone"]=$(o).find("input[name='user_phone']").val();//手机号码
				data_rmVsAccessUserInformation["affiliation"]=$(o).find("input[name='user_org']").val();//所属公司
				data_rmVsAccessUserInformation["userRemark"]=$(o).find("input[name='user_remark']").val();//备注
				data_rmVsAccessUserInformation["id"]=$(o).find("input[name='user_id']").val();//ID
				rmVsAccessUserInformationList.push(data_rmVsAccessUserInformation);
			}	
		});
		param["rmVsAccessUserInformationList"]=serialize(rmVsAccessUserInformationList); //访问人群集合
		$("#device_").find("tr:not(.basic-info)").each(function(i,o){
			if($(o).find("input[name='device_name']").val().length>0){
				var data_device={};
				data_device["name"]=$(o).find("input[name='device_name']").val();
				data_device["description"]=$(o).find("input[name='description']").val();
				data_device["toolNumber"]=$(o).find("input[name='toolNumber']").val();
				data_device["purpose"]=$(o).find("input[name='purpose']").val();
				data_device["id"]=$(o).find("input[name='tool_id']").val();
				rmVsToolList.push(data_device);
			}
		});
		param["rmVsToolList"]=serialize(rmVsToolList);
		if($("input[name='col_manage']:checked").length>0){
			$("#receive_").find("tr:not(.basic-info)").each(function(i,o){
				if($(o).find("input[name='rece_name']").val().length>0){
					var data_receive={};
					data_receive["receName"]=$(o).find("input[name='rece_name']").val();//陪同人员姓名
					data_receive["receMobile"]=$(o).find("input[name='rece_mobile']").val();//手机号码
					data_receive["id"]=$(o).find("input[name='rece_id']").val();//手机号码
					rmVsReceiveList.push(data_receive);
				}
			});
		param["rmVsReceiveList"]=serialize(rmVsReceiveList);
		}
		/*访问人员--end*/
		
		/*设备进出--start*/
		
		var rmVsMoveList=[];
		var rmVsLeaderList=[];
		if($("input[name='col_equp']:checked").length>0){
			$("#equp_").find("tr:not(.basic-info)").each(function(i,o){
				if($(o).find("input[name='itemName']").val().length>0){
					var data_rmVsMove={};
					data_rmVsMove["deviceType"]=$(o).find("select[name='deviceType']").val();//类型
					data_rmVsMove["itemName"]=$(o).find("input[name='itemName']").val();//设备名
					data_rmVsMove["manufacturer"]=$(o).find("input[name='manufacturer']").val();//制造商
					data_rmVsMove["model"]=$(o).find("input[name='model']").val();//设备型号
					data_rmVsMove["serialNum"]=$(o).find("input[name='serial_num']").val();//序列号
					data_rmVsMove["deviceSpace"]=$(o).find("input[name='device_space']").val();//设备空间
					data_rmVsMove["deviceWeight"]=$(o).find("input[name='device_weight']").val();//重量
					data_rmVsMove["moveAdvanceOrOut"]=$(o).find("select[name='move_advanceOrOut']").val();//移入移出
					data_rmVsMove["specifiedPlace"]=$(o).find("select[name='specified_place']").val();//指定位置
					data_rmVsMove["id"]=$(o).find("input[name='device_id']").val();
					rmVsMoveList.push(data_rmVsMove);
				}	
			});
			param["rmVsMoveList"]=rmVsMoveList.length>0?serialize(rmVsMoveList):"1"; //访问人群集合
			
			$("#leader_").find("tr:not(.basic-info)").each(function(i,o){
				if($(o).find("input[name='lead_name']").val().length>0){
					var data_leader={};
					data_leader["leadName"]=$(o).find("input[name='lead_name']").val();
					data_leader["leadCompany"]=$(o).find("input[name='lead_company']").val();
					data_leader["leadMobile"]=$(o).find("input[name='lead_mobile']").val();
					data_leader["id"]=$(o).find("input[name='lead_id']").val();
					rmVsLeaderList.push(data_leader);
				}
			});
			param["rmVsLeaderList"]=rmVsLeaderList.length>0?serialize(rmVsLeaderList):"1";
		}
		else{
			param["rmVsMoveList"]="1";
			param["rmVsLeaderList"]="1";
		}

		param["rmVsProjectInformationList"]="1";
		//param["rmVsToolList"]="1";
		/*设备进出--end*/
			param["act.taskId"]="";
			param["act.taskName"]="";
			param["act.taskDefKey"]="";
			param["act.procInsId"]="";
			param["act.procDefId"]="";
			param["act.flag"]="";
			param["customerName"]= $("input[name='customerName']").val();
			param["roomName"]= $("input[name='roomName']").val();
			param["phone"]= $("input[name='phone']").val();
			param["mail"]= $("input[name='mail']").val();
			param["doors"]= $("input[name='doors']").val();
			
			param["id"]=$("input[name='id']").val();
		/*fnt信息--start*/
		/* $("#fnt_").find("input").each(function(i,o){
			if($(o).attr("checked")){
				param[$(o).attr("name")]="1";
			}
			else{
				param[$(o).attr("name")]="2";
			}
		}); */
		/*fnt信息--end*/
		/* 配到服务--start */
		var siteTypeString="";
		$("input[name='siteType']").each(function(i,o){
			 if($(o).attr("checked")){
				 if(siteTypeString.length>0){
					 siteTypeString=siteTypeString+","+$(o).val();
				 }else{
					 siteTypeString=$(o).val();
				 }
			 }
		 });
		param["siteType"]=siteTypeString;
		param["siteRemark"]=$("input[name='siteRemark']").val();
		var toolsTypeString="";
		$("input[name='toolsType']").each(function(i,o){
			 if($(o).attr("checked")){
				 if(toolsTypeString.length>0){
					 toolsTypeString=toolsTypeString+","+$(o).val();
				 }else{
					 toolsTypeString=$(o).val();
				 }
			 }
		 });
		param["toolsType"]=toolsTypeString;
		param["toolsRemark"]=$("input[name='toolsRemark']").val();
		var optionTypeString="";
		$("input[name='optionType']").each(function(i,o){
			 if($(o).attr("checked")){
				 if(optionTypeString.length>0){
					 optionTypeString=optionTypeString+","+$(o).val();
				 }else{
					 optionTypeString=$(o).val();
				 }
			 }
		 });
		param["optionType"]=optionTypeString;
		param["optionRemark"]=$("input[name='optionRemark']").val();
		/* 配到服务--end */
		param["remarks"]=$("textarea[name='remarks']").val(); //备注

		/*----数据验证----*/
			var errorDom=$(".error-message");
			errorDom.children(":not(.error-close)").remove();
			if(!param["grounds"]||param["grounds"].length===0){
				errorDom.append(('<div class="error-single"><a  href="#come_reason" ><span >'+(errorDom.children().length)+' &nbsp;&nbsp;</span><span style="">来访事由不能为空。</span></a></div>'));				
				allowSubmitbol=false;
			}
			
			if(!param["approachDate"]||param["approachDate"].length===0){
				errorDom.append(('<div class="error-single"><a  href="#come_time" ><span>'+(errorDom.children().length)+'、</span>来访时间不能为空.</a></div>'));				
				allowSubmitbol=false;
			}
			if((!param["areaName"]||param["areaName"].length==0) && (!param["informationId"]||param["informationId"].length==0)){
				errorDom.append(('<div class="error-single"><a  href="#area_parent" ><span>'+(errorDom.children().length)+'、</span>进入区域不能为空.</a></div>'));				
				allowSubmitbol=false;
			}
			var phoneCheck = /^1[3|4|5|7|8][0-9]\d{8}$/;
			if($("#manage_").find("tr:not(.basic-info)").length==0){
				errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员不能为空.</a></div>'));				
				allowSubmitbol=false;
			}
			else if($("#manage_").find("tr:not(.basic-info)").length>0){
				$("#manage_").find("tr:not(.basic-info)").each(function(i,o){
					if($(o).find("input[name='user_name']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员名字不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					else if($(o).find("input[name='user_num']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员证件号码不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					else if($(o).find("select[name='user_type']").val()=="1" && checkIdcard($(o).find("input[name='user_num']").val()) == false){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员身份证号码不正确.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					else if($(o).find("input[name='user_phone']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员手机号码不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					else if(!phoneCheck.test($(o).find("input[name='user_phone']").val())){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>来访人员手机号码不正确.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					else if($(o).find("input[name='user_org']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>所属公司不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
				});
				var a = new Array();
				$("input[name='user_num']").each(function(i,o){
					a.push($(o).val());
				});
				if(isRepeat(a)){
					$.jBox.error('证件号码重复。', '提示');
					allowSubmitbol=false;
					return false;
					/* errorDom.append(('<div class="error-single"><a  href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>证件号码重复.</a></div>'));	
					allowSubmitbol=false;
					return false; */
				}
			}
			if($("input[name='col_manage']").attr("checked")){
				if($("#receive_").find("tr:not(.basic-info)").length==0){
					errorDom.append(('<div class="error-single"><a  href="#receive_group" ><span>'+(errorDom.children().length)+'、</span>陪同人员不能为空.</a></div>'));				
					allowSubmitbol=false;
				}
				else if($("#receive_").find("tr:not(.basic-info)").length>0){
					$("#receive_").find("tr:not(.basic-info)").each(function(i,o){
						if($(o).find("input[name='rece_name']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#receive_group" ><span>'+(errorDom.children().length)+'、</span>陪同人员姓名不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if($(o).find("input[name='rece_mobile']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#receive_group" ><span>'+(errorDom.children().length)+'、</span>陪同人员手机号码不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if(!phoneCheck.test($(o).find("input[name='rece_mobile']").val())){
							errorDom.append(('<div class="error-single"><a  href="#receive_group" ><span>'+(errorDom.children().length)+'、</span>陪同人员手机号码不正确.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
					});
				}
			}
			if($("#device_").find("tr:not(.basic-info)").length>0){
				$("#device_").find("tr:not(.basic-info)").each(function(i,o){
					if($(o).find("input[name='device_name']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#device_group" ><span>'+(errorDom.children().length)+'、</span>随携设备名称不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					if($(o).find("input[name='toolNumber']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#device_group" ><span>'+(errorDom.children().length)+'、</span>随携设备序列号不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
					if($(o).find("input[name='purpose']").val().length==0){
						errorDom.append(('<div class="error-single"><a  href="#device_group" ><span>'+(errorDom.children().length)+'、</span>随携设备操作内容不能为空.</a></div>'));				
						allowSubmitbol=false;
						return false;
					}
				});
			}
			if($("#col_equp2").attr("checked")){
				if($("#equp_").find("tr:not(.basic-info)").length==0){
					errorDom.append(('<div class="error-single"><a  href="#equp_group" ><span>'+(errorDom.children().length)+'、</span>大件设备不能为空.</a></div>'));				
					allowSubmitbol=false;
				}
				else if($("#equp_").find("tr:not(.basic-info)").length>0){
					$("#equp_").find("tr:not(.basic-info)").each(function(i,o){
						if($(o).find("input[name='itemName']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#equp_group" ><span>'+(errorDom.children().length)+'、</span>大件设备名称不能为空。如无大件设备，请勿勾选有无大件设备选项。</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if($(o).find("input[name='model']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#equp_group" ><span>'+(errorDom.children().length)+'、</span>大件设备型号不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if($(o).find("input[name='serial_num']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#equp_group" ><span>'+(errorDom.children().length)+'、</span>大件设备序列号不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						/* if($(o).find("input[name='specified_place']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#equp_group" ><span>'+(errorDom.children().length)+'、</span>大件设备指定位置不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						} */
					});
				}
				var types = "";
				$("#manage_").find("tr:not(.basic-info)").each(function(i,o){
					types = $(o).find("select[name='visitor_type']").val()+","+types;
				});
				// 所有的人中包含项目经理
				if(!(types.indexOf("4") > -1)){
					//errorDom.append(('<div class="error-single"><a href="#manage_group" ><span>'+(errorDom.children().length)+'、</span>申请单含有大件设备，必须选择至少一个项目经理.</a></div>'));				
					$.jBox.error('申请单中含有大件设备，请在访客人员列表中选择至少一个项目经理', '提示');
					allowSubmitbol=false;
					return false;
				}
				
				/* if($("#leader_").find("tr:not(.basic-info)").length==0){
					errorDom.append(('<div class="error-single"><a  href="#leader_" ><span>'+(errorDom.children().length)+'、</span>项目经理不能为空.</a></div>'));				
					allowSubmitbol=false;
				}
				else if($("#leader_").find("tr:not(.basic-info)").length>0){
					$("#leader_").find("tr:not(.basic-info)").each(function(i,o){
						if($(o).find("input[name='lead_name']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#leader_" ><span>'+(errorDom.children().length)+'、</span>项目经理名称不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if($(o).find("input[name='lead_company']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#leader_" ><span>'+(errorDom.children().length)+'、</span>项目经理所属公司不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
						if($(o).find("input[name='lead_mobile']").val().length==0){
							errorDom.append(('<div class="error-single"><a  href="#leader_" ><span>'+(errorDom.children().length)+'、</span>项目经理手机号码不能为空.</a></div>'));				
							allowSubmitbol=false;
							return false;
						}
					});
				} */
			}
			
		/*----数据验证----*/
		if(allowSubmitbol){
			$.jBox.tip("正在提交申请...", 'loading');
			$.ajax({
				type: "post",
		        url: '${ctx}/rm/rmVsApplicationInformation/m/save',
		        data:param,
		        dataType: "json",
		        ContentType:'application/x-www-form-urlencoded',
		        global:false,
		        async: false,
		        success: function(data){ 
		        	if(data.code=="0"){//保存成功了。
		        		//$("#closeBtn").children().click();
		        		window.setTimeout(function () { 
		        			$.jBox.tip('申请成功。', 'success'); 
		        			window.setTimeout(function(){
		        				location.href="${ctx}/webPanel/webpanelList";
		        			},1000);
		        		}, 2000);
		        	}
		        	else{
		        		$(".page-header").children("h1").text(data.message);
		        		$("body").children(":not(.container-fluid)").remove();
						$("body").children(".container-fluid").removeClass("hide");
		        	}
		        }
			});
		}
		else{
			$(".error-message").removeClass("hide");
			$("<a href='#table_content'><i></i></a>").appendTo($("body")).children("i").click();
		}
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
	dataParam["id"]="${param.id}";
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
	 
	/* 保存草稿 */
		$("#subMiteBtn").click(function(){
			var allowSubmitbol=true;
			var param={};
			param["isDraft"]="0";
			param["auditType"]=$("input[name='auditType']").val().length>0?$("input[name='auditType']").val():"1";//状态，若是提交或者保存都是1，若是审核失败，重新提交是3
			var groundsString="";
			$("input[name='grounds']").each(function(i,o){
				 if($(o).attr("checked")){
					 if(groundsString.length>0){
						 groundsString=groundsString+","+$(o).val();
					 }else{
						 groundsString=$(o).val();
					 }
				 }
			 });
			param["grounds"]=groundsString; //访问事由
			param["visitRemark"]=$("input[name='visitRemark']").val(); //访问事由其他
			param["approachDate"]=$("input[name='approachDate']").val(); //进场时间
			param["stayTime"]=$("input[name='stayTime']:checked").val(); //停留时间
			param["id"]=$("input[name='id']").val(); //出场时间
			var areaString="";
			$("div[name='regionType3']").find("div").each(function(i,o){
				if($(o).find("input[name='area_name']").attr("checked")){
					if(areaString.length>0){
						areaString=areaString+","+$(o).find("input[name='area_name']").next().text();
					}
					else{
						areaString=$(o).find("input[name='area_name']").next().text();
					}
				}
			});
			param["areaName"]=areaString; //机房数据区
			var inforString="";
			$("input[name='information_id']").each(function(i,o){
				if($(o).attr("checked")){
					if(inforString.length>0){
						inforString=inforString+","+$(o).next().text();
					}else{
						inforString=$(o).next().text();
					}
				}
			});
			param["informationId"]=inforString; //访问区域
			/*访问人员--start*/
			var rmVsAccessUserInformationList=[];
			var rmVsReceiveList=[];
			var rmVsToolList=[];
			$("#manage_").find("tr:not(.basic-info)").each(function(i,o){
				if($(o).find("input[name='user_name']").val().length>0){
					var data_rmVsAccessUserInformation={};
					data_rmVsAccessUserInformation["visitorType"]=$(o).find("select[name='visitor_type']").val();//访客类型
					data_rmVsAccessUserInformation["name"]=$(o).find("input[name='user_name']").val();//访问人姓名
					data_rmVsAccessUserInformation["documentType"]=$(o).find("select[name='user_type']").val();//访问人证件类型
					data_rmVsAccessUserInformation["idNumber"]=$(o).find("input[name='user_num']").val();//访问人证件号码
					data_rmVsAccessUserInformation["userPhone"]=$(o).find("input[name='user_phone']").val();//手机号码
					data_rmVsAccessUserInformation["affiliation"]=$(o).find("input[name='user_org']").val();//所属公司
					data_rmVsAccessUserInformation["userRemark"]=$(o).find("input[name='user_remark']").val();//备注
					data_rmVsAccessUserInformation["id"]=$(o).find("input[name='user_id']").val();//ID
					rmVsAccessUserInformationList.push(data_rmVsAccessUserInformation);
				}	
			});
			param["rmVsAccessUserInformationList"]=serialize(rmVsAccessUserInformationList); //访问人群集合
			$("#device_").find("tr:not(.basic-info)").each(function(i,o){
				if($(o).find("input[name='device_name']").val().length>0){
					var data_device={};
					data_device["name"]=$(o).find("input[name='device_name']").val();
					data_device["description"]=$(o).find("input[name='description']").val();
					data_device["toolNumber"]=$(o).find("input[name='toolNumber']").val();
					data_device["purpose"]=$(o).find("input[name='purpose']").val();
					data_device["id"]=$(o).find("input[name='tool_id']").val();
					rmVsToolList.push(data_device);
				}
			});
			param["rmVsToolList"]=serialize(rmVsToolList);
			if($("input[name='col_manage']:checked").length>0){
				$("#receive_").find("tr:not(.basic-info)").each(function(i,o){
					if($(o).find("input[name='rece_name']").val().length>0){
						var data_receive={};
						data_receive["receName"]=$(o).find("input[name='rece_name']").val();//陪同人员姓名
						data_receive["receMobile"]=$(o).find("input[name='rece_mobile']").val();//手机号码
						data_receive["id"]=$(o).find("input[name='rece_id']").val();//手机号码
						rmVsReceiveList.push(data_receive);
					}
				});
			param["rmVsReceiveList"]=serialize(rmVsReceiveList);
			}
			/*访问人员--end*/
			
			/*设备进出--start*/
			var rmVsMoveList=[];
			var rmVsLeaderList=[];
			if($("input[name='col_equp']:checked").length>0){
				$("#equp_").find("tr:not(.basic-info)").each(function(i,o){
					if($(o).find("input[name='itemName']").val().length>0){
						var data_rmVsMove={};
						data_rmVsMove["deviceType"]=$(o).find("select[name='deviceType']").val();//类型
						data_rmVsMove["itemName"]=$(o).find("input[name='itemName']").val();//设备名
						data_rmVsMove["manufacturer"]=$(o).find("input[name='manufacturer']").val();//制造商
						data_rmVsMove["model"]=$(o).find("input[name='model']").val();//设备型号
						data_rmVsMove["serialNum"]=$(o).find("input[name='serial_num']").val();//序列号
						data_rmVsMove["deviceSpace"]=$(o).find("input[name='device_space']").val();//设备空间
						data_rmVsMove["deviceWeight"]=$(o).find("input[name='device_weight']").val();//重量
						data_rmVsMove["moveAdvanceOrOut"]=$(o).find("select[name='move_advanceOrOut']").val();//移入移出
						data_rmVsMove["specifiedPlace"]=$(o).find("select[name='specified_place']").val();//指定位置
						data_rmVsMove["id"]=$(o).find("input[name='device_id']").val();
						rmVsMoveList.push(data_rmVsMove);
					}	
				});
				param["rmVsMoveList"]=rmVsMoveList.length>0?serialize(rmVsMoveList):"1"; //访问人群集合
				
				$("#leader_").find("tr:not(.basic-info)").each(function(i,o){
					if($(o).find("input[name='lead_name']").val().length>0){
						var data_leader={};
						data_leader["leadName"]=$(o).find("input[name='lead_name']").val();
						data_leader["leadCompany"]=$(o).find("input[name='lead_company']").val();
						data_leader["leadMobile"]=$(o).find("input[name='lead_mobile']").val();
						data_leader["id"]=$(o).find("input[name='lead_id']").val();
						rmVsLeaderList.push(data_leader);
					}
				});
				param["rmVsLeaderList"]=rmVsLeaderList.length>0?serialize(rmVsLeaderList):"1";
			}
			else{
				param["rmVsMoveList"]="1";
				param["rmVsLeaderList"]="1";
			}

			param["rmVsProjectInformationList"]="1";
			//param["rmVsToolList"]="1";
			/*设备进出--end*/
				param["act.taskId"]="";
				param["act.taskName"]="";
				param["act.taskDefKey"]="";
				param["act.procInsId"]="";
				param["act.procDefId"]="";
				param["act.flag"]="";
				param["customerName"]= $("input[name='customerName']").val();
				param["roomName"]= $("input[name='roomName']").val();
				param["phone"]= $("input[name='phone']").val();
				param["mail"]= $("input[name='mail']").val();
				param["doors"]= $("input[name='doors']").val();
				
				param["id"]=$("input[name='id']").val();
			/*fnt信息--start*/
			/* $("#fnt_").find("input").each(function(i,o){
				if($(o).attr("checked")){
					param[$(o).attr("name")]="1";
				}
				else{
					param[$(o).attr("name")]="2";
				}
			}); */
			/*fnt信息--end*/
			/* 配到服务--start */
			var siteTypeString="";
			$("input[name='siteType']").each(function(i,o){
				 if($(o).attr("checked")){
					 if(siteTypeString.length>0){
						 siteTypeString=siteTypeString+","+$(o).val();
					 }else{
						 siteTypeString=$(o).val();
					 }
				 }
			 });
			param["siteType"]=siteTypeString;
			param["siteRemark"]=$("input[name='siteRemark']").val();
			var toolsTypeString="";
			$("input[name='toolsType']").each(function(i,o){
				 if($(o).attr("checked")){
					 if(toolsTypeString.length>0){
						 toolsTypeString=toolsTypeString+","+$(o).val();
					 }else{
						 toolsTypeString=$(o).val();
					 }
				 }
			 });
			param["toolsType"]=toolsTypeString;
			param["toolsRemark"]=$("input[name='toolsRemark']").val();
			var optionTypeString="";
			$("input[name='optionType']").each(function(i,o){
				 if($(o).attr("checked")){
					 if(optionTypeString.length>0){
						 optionTypeString=optionTypeString+","+$(o).val();
					 }else{
						 optionTypeString=$(o).val();
					 }
				 }
			 });
			param["optionType"]=optionTypeString;
			param["optionRemark"]=$("input[name='optionRemark']").val();
			/* 配到服务--end */
			param["remarks"]=$("textarea[name='remarks']").val(); //备注

			/*----数据验证----*/
			if(allowSubmitbol){
				$.ajax({
					type: "post",
			        url: '${ctx}/rm/rmVsApplicationInformation/m/save',
			        data:param,
			        dataType: "json",
			        ContentType:'application/x-www-form-urlencoded',
			        global:false,
			        async: false,
			        success: function(data){ 
			        	if(data.code=="0"){//保存草稿成功了。
			        		$.jBox.tip("正在保存草稿...", 'loading');
			        		window.setTimeout(function () { $.jBox.tip('保存草稿成功。', 'success'); }, 1500);
			        		location.href="${ctx}/webPanel/webpanelList";
			        	}else{
			        		$(".page-header").children("h1").text(data.message);
			        		$("body").children(":not(.container-fluid)").remove();
							$("body").children(".container-fluid").removeClass("hide");
			        	}
			        }
				});
			}
			else{
				$(".error-message").removeClass("hide");
				$("<a href='#table_content'><i></i></a>").appendTo($("body")).children("i").click();
			}
		}); 
});
function isRepeat(arr){
     var hash = {};
     for(var i in arr) {
         if(hash[arr[i]])
              return true;
         hash[arr[i]] = true;
     }
     return false;
}
 /* 删除该条数据的同时，删除数据库 */
 var userids = "";
 var toolids = "";
 var receids = "";
 var leadids = "";
 var deviceids = "";
 function deleteEqup(o){
	 var userid = $(o).attr("userid");
	 var toolid = $(o).attr("toolid");
	 var receid = $(o).attr("receid");
	 var leadid = $(o).attr("leadid");
	 var deviceid = $(o).attr("deviceid");
	 if(userid!='0'){
		 /* var submit = function (v, h, f) {
		    if (v == 'ok'){
		    	$.post("${ctx}/rm/rmVsAccessUserInformation/m/delete?id="+userid);
		    }else if (v == 'cancel'){
		    	userids = userid +","+userids;
		    }
		    return true; //close
		 }; */
		 $.jBox.tip('已删除');
		 $.post("${ctx}/rm/rmVsAccessUserInformation/m/delete?id="+userid);
	 }else if(toolid!='0'){
		 /* var f = confirm("您确定立即删除吗？");
			if (f == true){
				$.post("${ctx}/rm/rmVsTool/m/delete?id="+toolid);
			}else{
				toolids = toolid +","+toolids;
			} */
		$.jBox.tip('已删除');
		$.post("${ctx}/rm/rmVsTool/m/delete?id="+toolid);
	 }else if(receid!='0'){
		 /* var f = confirm("您确定立即删除吗？");
			if (f == true){
				$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteRece?receid="+receid);
			}else{
				receids = receid +","+receids;
			} */
		$.jBox.tip('已删除');
		$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteRece?receid="+receid);
	 }else if(leadid!='0'){
		 /* var f = confirm("您确定立即删除吗？");
			if (f == true){
				$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteLead?leadid="+leadid);
			}else{
				leadids = leadid +","+leadids;
			} */
		$.jBox.tip('已删除');
		$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteLead?leadid="+leadid);
	 }else if(deviceid!='0'){
		 /* var f = confirm("您确定立即删除吗？");
			if (f == true){
				$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteDevice?deviceid="+deviceid);
			}else{
				deviceids = deviceid +","+deviceids;
			} */
		$.jBox.tip('已删除');
		$.post("${ctx}/rm/rmVsDiscrepancyInformation/m/deleteDevice?deviceid="+deviceid);
	 }
	 $('#user_id').val(userids);
	 $('#tool_id').val(toolids);
	 $('#rece_id').val(receids);
	 $('#lead_id').val(leadids);
	 $('#device_id').val(deviceids);
	 
	 $($(o).closest('tr').get(0)).text();
	 $(o).closest('tr').nextAll().each(function(index, element) {
        $(element).children("td:first").text(parseInt($(element).children("td:first").text())-1);
   	 });
	 $(o).closest('tr').remove();
 }
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
	        					nowDom1.append('<div class="groupsel-check"><input type="checkbox" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
	        				if(o.regionalType==2)
		        				nowDom2.append('<div class="groupsel-check"><input type="checkbox" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
		        			if(o.regionalType==3)
			        			nowDom.append('<div class="groupsel-check"><input type="checkbox" name="area_name" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
			        		if(o.regionalType==4)
				        		nowDom4.append('<div class="groupsel-check"><input type="checkbox" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
				        	if(o.regionalType==5)
					        	nowDom5.append('<div class="groupsel-check"><input type="checkbox" name="information_id" '+(equlbol?"checked":"")+'><span>'+regional_id[i]+'</span></div>')
					        				
	        			}
	        		}
	        		else{
	        			for(i=0;i<regional_id.length;i++){
	        				if(o.regionalType==1)
	        					nowDom1.append('<div class="groupsel-check"><input type="checkbox" name="information_id"><span>'+regional_id[i]+'</span></div>');
	        				if(o.regionalType==2)
	        					nowDom2.append('<div class="groupsel-check"><input type="checkbox" name="information_id"><span>'+regional_id[i]+'</span></div>');
	        				if(o.regionalType==3)
	        					nowDom.append('<div class="groupsel-check"><input type="checkbox" name="area_name"><span>'+regional_id[i]+'</span></div>');
	        				if(o.regionalType==4)
	        					nowDom4.append('<div class="groupsel-check"><input type="checkbox" name="information_id"><span>'+regional_id[i]+'</span></div>');
	        				if(o.regionalType==5)
	        					nowDom5.append('<div class="groupsel-check"><input type="checkbox" name="information_id"><span>'+regional_id[i]+'</span></div>');
	        				
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
			 			$(o).append('<div class="groupsel-check"><input type="checkbox" name="information_id" '+(equal?"checked":"")+'><span>'+datao.regionalId+'</span></div>');
			 		}else{
			 			$(o).append('<div class="groupsel-check"><input type="checkbox" name="information_id"><span>'+datao.regionalId+'</span></div>');
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
				var td_2=$("<td></td>").append('<select name="visitor_type" style="width:90px"><c:forEach items="${fns:getDictList(\'visitor_type\')}" var="vt"><option value="${vt.value}" '+(o.visitorType&&o.visitorType=="${vt.value}"?"selected":"")+'>${vt.label}</option></c:forEach></select>');
				var td_3=$("<td></td>").append(('<input type="text" name="user_name" style="width:100px" value="'+o.name+'"/>'));
				var td_4=$("<td></td>").append(('<select name="user_type" style="width:90px"><option value="1" '+(o.documentType&&o.documentType=="1"?"selected":"")+'>身份证</option><option value="2" '+(o.documentType&&o.documentType=="2"?"selected":"")+'>护照</option><option value="3" '+(o.documentType&&o.documentType=="3"?"selected":"")+'>驾驶证</option></select>'));
				var td_5=$("<td></td>").append('<input type="text" name="user_num" style="width:140px" value="'+o.idNumber+'"/>');
				var td_6=$("<td></td>").append('<input type="text" name="user_phone" style="width:120px" value="'+o.userPhone+'"/>');
				var td_7=$("<td></td>").append('<input type="text" name="user_org" style="width:100px" value="'+o.affiliation+'"/>');
				var td_8=$("<td></td>").append('<input type="text" name="user_remark" style="width:110px" value="'+o.userRemark+'"/>');
				var td_9=$("<td></td>").append('<input type="button" value="删除" style="width:70px" onclick="deleteEqup(this)" userid="'+o.id+'"/><input type="hidden" name="user_id" value="'+o.id+'"/>');
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);	
				trDom.append(td_4);	
				trDom.append(td_5);
				trDom.append(td_6);	
				trDom.append(td_7);
				trDom.append(td_8);
				trDom.append(td_9);
				parentDom.append(trDom);
		 }); 
	 }
	 if(data["rmVsApplicationInformation"]["rmVsToolList"] && data["rmVsApplicationInformation"]["rmVsToolList"].length>0){
		 var deviceDom=$("#device_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsToolList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
			 trDom.css({"margin-bottom":"20px"});
			 var td_1=$(("<td>"+(i+1)+"</td>"));
			 var td_2=$("<td></td>").append('<input type="text" name="device_name" value="'+o.name+'"/>');
			 var td_3=$("<td></td>").append('<input type="text" name="description" value="'+o.description+'"/>');
			 var td_4=$("<td></td>").append('<input type="text" name="toolNumber" value="'+o.toolNumber+'"/>');
			 var td_5=$("<td></td>").append('<input type="text" name="purpose" value="'+o.purpose+'"/>');
			 var td_7=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)" toolid="'+o.id+'"/><input type="hidden" name="tool_id" value="'+o.id+'"/>');
			 trDom.append(td_1);
			 trDom.append(td_2);	
			 trDom.append(td_3);
			 trDom.append(td_4);
			 trDom.append(td_5);
			 trDom.append(td_7);
			 deviceDom.append(trDom);
		 });
	 }
	 if(data["rmVsApplicationInformation"]["rmVsReceiveList"] && data["rmVsApplicationInformation"]["rmVsReceiveList"].length>0){
		 $("input[name='col_manage']").attr("checked","checked");
		 $("#receive_group").removeClass("hide");
		 changeGroupNum();
		 var receiveDom=$("#receive_").find("tbody");
		 $.each(data["rmVsApplicationInformation"]["rmVsReceiveList"],function(i,o){
			 var trDom=$(("<tr></tr>"));
				trDom.css({"margin-bottom":"20px"});
				var td_1=$(("<td>"+(i+1)+"</td>"));
				var td_2=$("<td></td>").append('<input type="text" name="rece_name" value="'+o.receName+'"/>');
				var td_3=$("<td></td>").append('<input type="text" name="rece_mobile" value="'+o.receMobile+'"/>');
				var td_4=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)" receid="'+o.id+'"/><input type="hidden" name="rece_id" value="'+o.id+'"/>');
				trDom.append(td_1);
				trDom.append(td_2);	
				trDom.append(td_3);
				trDom.append(td_4);
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
				var td_2=$("<td></td>").append('<select name="deviceType" style="width:90px"><c:forEach items="${fns:getDictList(\'device_type\')}" var="dt"><option value="${dt.value}" '+(o.deviceType&&o.deviceType=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				var td_3=$("<td></td>").append('<input type="text" name="itemName" style="width:75px" value="'+o.itemName+'"/>');
				var td_4=$("<td></td>").append('<input type="text" name="manufacturer" style="width:70px" value="'+o.manufacturer+'"/>');
				var td_5=$("<td></td>").append('<input type="text" name="model" style="width:70px" value="'+o.model+'"/>');
				var td_6=$("<td></td>").append('<input type="text" name="serial_num" style="width:80px" value="'+o.serialNum+'"/>');
				var td_7=$("<td></td>").append('<input type="text" name="device_space" style="width:100px" value="'+o.deviceSpace+'"/>');
				var td_8=$("<td></td>").append('<input type="text" name="device_weight" style="width:80px" value="'+o.deviceWeight+'"/>');
				var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px"><c:forEach items="${fns:getDictList(\'move_or_out\')}" var="dt"><option value="${dt.value}" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				//var td_9=$("<td></td>").append('<select name="move_advanceOrOut" style="width:90px"><option value="1" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="1"?"selected":"")+'>移入</option><option value="2" '+(o.moveAdvanceOrOut&&o.moveAdvanceOrOut=="2"?"selected":"")+'>移出</option></select>');
				var td_10=$("<td></td>").append('<select name="specified_place" style="width:90px"><c:forEach items="${fns:getDictList(\'specified_place\')}" var="dt"><option value="${dt.value}" '+(o.specifiedPlace&&o.specifiedPlace=="${dt.value}"?"selected":"")+'>${dt.label}</option></c:forEach></select>');
				//var td_10=$("<td></td>").append('<input type="text" name="specified_place" style="width:70px" value="'+o.specifiedPlace+'"/>');
				var td_11=$("<td></td>").append('<input type="button" value="删除" style="width:60px" onclick="deleteEqup(this)" deviceid="'+o.id+'"/><input type="hidden" name="device_id" style="width:70px" value="'+o.id+'"/>');
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
				trDom.append(td_11);
				parentDom.append(trDom);
		 });
		 
		 if(data["rmVsApplicationInformation"]["rmVsLeaderList"] && data["rmVsApplicationInformation"]["rmVsLeaderList"].length>0){
			 var leadDom = $("#leader_").find("tbody");
			 $.each(data["rmVsApplicationInformation"]["rmVsLeaderList"],function(i,o){
				 var trDom=$(("<tr></tr>"));
					trDom.css({"margin-bottom":"20px"});
					var td_1=$(("<td>"+(i+1)+"</td>"));
					var td_2=$("<td></td>").append('<input type="text" name="lead_name" value="'+o.leadName+'"/>');
					var td_3=$("<td></td>").append('<input type="text" name="lead_company" value="'+o.leadCompany+'"/>');
					var td_4=$("<td></td>").append('<input type="text" name="lead_mobile" value="'+o.leadMobile+'"/>');
					var td_5=$("<td></td>").append('<input type="button" value="删除" onclick="deleteEqup(this)" leadid="'+o.id+'"/><input type="hidden" name="lead_id" value="'+o.id+'"/>');
					trDom.append(td_1);
					trDom.append(td_2);	
					trDom.append(td_3);
					trDom.append(td_4);
					trDom.append(td_5);
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
	 
	 
	 $(".btns a").mouse
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
		margin-top:16px;
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
	.btn_add{
		background-color:#FF940A;
		color:#fff;
		border:1px solid gray;
	}
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
                        			<div class="groupsel-check"><input type="checkbox" name="grounds" value="${grounds.value}"/><span>${grounds.label}</span></div>
								</c:forEach>
								
                            </div>
                        </td>
                        <td class="label-check-groups" style="width:25%;">
                        	<div class="groupsel-check">
                        		<span>备注：</span>
                        		<input name="visitRemark" type="text" style="width:125px;line-height:normal;margin:0 3px 0 8px;">
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
                        					<input type="radio" name="stayTime" value="${stayTime.value}" checked="checked"/>
                        				</c:if>
                        				<c:if test="${stayTime.value!=1}">
                        					<input type="radio" name="stayTime" value="${stayTime.value}" />
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
                        <td class="mana-td-"><input type="button" class="btn_add" style="line-height:20px;text-indent:0px;width: 70px;" data-click="add" data-param="people" value="新增"></td>
                        <td class="mana-td-" style="display: none;"></td>
                    </tr>
                </tbody>
            </table>
            <!-- <div class="mana-button mana-button_small pull-right"  data-click="add" data-param="people"><a></a></div> -->
            <div class="mana-warning mana-warning_small pull-left" >温馨提示：请告知上述人员来访时务必携带您所登记的证件原件。</div>
            <!-- <table width="100%" style="margin-top:21px;">
            	<tbody>
            		<tr class="basic-info">
            			<td class="label-check"><span>陪同需求</span></td>
            			<td class="label-check-groups">
            				<div class="groupsel">
            					<div class="groupsel-check"><input type="checkbox" name="col_manage"/><span>有无工作人员陪同</span></div>
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
                    	<td class="mana-td-"><input type="button" class="btn_add" style="line-height:20px;text-indent:0px;" data-click="add" data-param="receive" value="新增"></td>
                    	<td class="mana-td-" style="display: none;"></td>
                    </tr>
            	</tbody>
            </table>
            <!-- <div class="mana-button mana-button_small pull-right"  data-click="add" data-param="receive"><a></a></div> -->
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
                    	<td class="mana-td- required">带入事由</td>
                    	<td class="mana-td-"><input type="button" class="btn_add" style="line-height:20px;text-indent:0px;" data-click="add" data-param="device" value="新增"></td>
                    	<td class="mana-td-" style="display: none;"></td>
                    </tr>
            	</tbody>
            </table>
            <!-- <div class="mana-button mana-button_small pull-right"   data-click="add" data-param="device"><a></a></div> -->
            <div class="mana-warning mana-warning_small pull-left">温馨提示：严禁携带危险物品进入数据中心，所有物品都应接收安全检查。</div>
        </div>
        
        <table width="100%" style="margin-top:21px;">
        	<tbody>
        		<tr class="basic-info">
        			<td class="label-check"><span>有无大件设备进出</span></td>
        			<td class="label-check-groups">
        				<div class="groupsel">
        					<!-- <div class="groupsel-check"><input type="checkbox" name="col_equp"/><span>是否大件设备进出</span></div> -->
        					<div class="groupsel-check"><input id="col_equp1" type="radio" name="col_equp" checked="checked"/><span>无</span></div>
        					<div class="groupsel-check"><input id="col_equp2" type="radio" name="col_equp"/><span>有</span></div>
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
	                        <td class="mana-td- required">指定位置</td>
	                        <td class="mana-td-"><input type="button" class="btn_add" style="line-height:20px;text-indent:0px;width: 60px;margin-left: -10px;" data-click="add" data-param="equp" value="新增"></td>
	                        <td class="mana-td-" style="display: none;"></td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            <!-- <div class="mana-button mana-button_small pull-right" data-click="add" data-param="equp"><a></a></div> -->
            <table  class="mana-table add-mana-table " id="leader_" style="margin-top:50px;">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="mana-td-">序号</td>
                    	<td class="mana-td- required">项目经理</td>
                    	<td class="mana-td- ">所属公司</td>
                    	<td class="mana-td- ">手机号码</td>
                        <td class="mana-td-"><input type="button" class="btn_add" style="line-height:20px;text-indent:0px;" data-click="add" data-param="leader" value="新增"></td>
                        <td class="mana-td-" style="display: none;"></td>
                    </tr>
                </tbody>
            </table>
           <!--  <div class="mana-button mana-button_small pull-right"  data-click="add" data-param="leader"><a></a></div> -->
            <div class="mana-warning mana-warning_small pull-left" style="height: 110px;line-height: 25px;">
            	<div>温馨提示：</div>                                                
            	<div>1、大件设备进出，需客户方指定项目经理现场确认设备出入情况。</div>                                                
            	<div>2、所有设备应在指定地点完成拆箱，测试操作后，才能搬入机房，敬请谅解！</div>
            	<div>3、如果有大件设备，请在访客人员列表中选择至少一个项目经理。谢谢配合！</div>
            </div>
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
                            		<div class="groupsel-check"><input type="checkbox" name="siteType" value="${siteType.value}"/><span>${siteType.label}</span></div>
                            	</c:forEach>
                            </div>
                        </td>
                    </tr>
                    <tr class="basic-info">
                    	<td class="label-check"><span>B</span><span>.工具</span></td>
                        <td class="label-check-groups" style="width:75%;">
                        	<div class="groupsel" id="toolsType">
                            	<c:forEach items="${fns:getDictList('tools_type')}" var="toolsType">
                            		<div class="groupsel-check"><input type="checkbox" name="toolsType" value="${toolsType.value}"/><span>${toolsType.label}</span></div>
                            	</c:forEach>
                            </div>
                        </td>
                    </tr>
                	<tr class="basic-info">
                    	<td class="label-check"><span>C</span><span>.其他</span></td>
                        <td class="label-check-groups" style="width:75%;">
                        	<div class="groupsel" id="optionType">
                            	<c:forEach items="${fns:getDictList('option_type')}" var="optionType">
                            		<div class="groupsel-check"><input type="checkbox" name="optionType" value="${optionType.value}"/><span>${optionType.label}</span></div>
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
                      	<td class="data-textarea"><textarea name="remarks"></textarea></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- <div class="table-groups">
        	<div class="groups-title">
            	<span class="title-seq">8、</span>
                <div class="title-bg">
                	<div class="bg font-bg bg-height">数据中心受控物品，未经许可不得在数据中心使用，如发现违纪到我中心信息安全的情况，我中心人员有权要求对相关 内容进行处理，如内容</div>
                    <div class="bg point-big-bg bg-height">&nbsp;</div>
                    <div class=" line-big-bg bg-height">&nbsp;</div>
                </div>
            </div>
        	<table width="100%" cellpadding="0" cellspacing="0">
            	<tbody>
                	<tr class="basic-info">
                    	<td class="data-labels" rowspan="4">数据中心受控物品登记</td>
                      	<td class="data-label">种类</td>
                        <td class="data-label">数量</td>
                        <td class="data-label">种类</td>
                        <td class="data-label">数量</td>
                    </tr>
                	<tr class="basic-info">
                        <td class="data-label">照相机</td>
                        <td class="label_"><input type="text" /></td>
                        <td class="data-label">PDA</td>
                        <td class="label_"><input type="text" /></td>
                    </tr>
                    <tr class="basic-info">
                        <td class="data-label">摄像机</td>
                        <td class="label_"><input type="text" /></td>
                        <td class="data-label">笔记本电脑</td>
                        <td class="label_"><input type="text" /></td>
                    </tr>
                    <tr class="basic-info">
                        <td class="data-label">录音笔</td>
                        <td class="label_"><input type="text" /></td>
                        <td class="data-label">其他</td>
                        <td class="label_"><input type="text" /></td>
                    </tr>
                </tbody>
            </table>
        </div> -->
      	<div class="btns" style="margin-top: 60px;">${isEdit}
       		<a style="padding: 6px 60px;border: 1px solid #eee;background-color: #FF940A;font-size: 20px;border-radius:4px;color: #fff;" id="subMitBtn">提交申请</a>
          	<c:choose>
          		<c:when test="${btn == 1}"></c:when>
          		<c:otherwise>
          			<a style="padding: 6px 60px;background-color: #FF940A;font-size: 20px;border-radius:4px;color: #fff;margin-left: 30px;margin-right: 30px;" id="subMiteBtn">保存草稿</a>
          		</c:otherwise>
          	</c:choose>
          	<a style="padding: 6px 85px;border: 1px solid #eee;background-color: #FF940A;color: #fff;font-size: 20px;border-radius:4px;" id="closeBtn" href="${ctx}/webPanel/webpanelList"  target="mainFrame">关闭</a>
        </div>
        <div class="lock"></div>
    </div>
	 <input type="hidden" id="user_id" value="">
	 <input type="hidden" id="tool_id" value="">
	 <input type="hidden" id="rece_id" value="">
	 <input type="hidden" id="lead_id" value="">
	 <input type="hidden" id="device_id" value="">
</body>
</html>