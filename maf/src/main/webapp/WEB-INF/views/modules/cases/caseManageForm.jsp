<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用例集管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
			$.ajax({  //动态加载motion下拉参数
				   type: "get",
				   url: "${ctx}/obj/objMethod/getAllObj",	
				   success: function(data){
						//alert(data);
						$("#motionData").val(data);
					}
				});
			
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
			
			$("#itemButton").click(function(){
				var parentId = $("#parentId").val();
				if(parentId == null || parentId == ''){
					$.jBox.error("请选择用例集!","提示");$("#parentId").focus();
					return ;
				}
				
				top.$.jBox.open("iframe:${ctx}/obj/objManage/selectList?parentId="+$("#parentId").val(), "选择路径",1000,450,
			       {opacity: 0.3,persistent: true,buttons:{"确认":"ok","关闭":"close"},
					submit:function(v,h,f){
			           	if(v == 'ok'){
			           		var custom = h.find("iframe")[0].contentWindow.$("#tempObjManage").val();
			           		//alert("custom="+custom);
			           		if(custom.indexOf(",") > 0){
			           			var tempIds =  new Array();
				           		tempIds = custom.split(","); 
				           		var ids = "",names="";
				           	// $("tr[id=tra]").remove();
				           		for(var i=0;i<tempIds.length;i++){
				           			var check = tempIds[i].split("||");
			           				if(i==0){
			           					ids = check[0];
			           					names = check[1];
			           				}else{
			           					ids += ","+check[0];
			           					names += ","+check[1];
			           				}
			           				$.ajax({
					 					   type: "POST",
					 					   url: "${ctx}/obj/objManage/selectData",
					 					  data: {id:check[0]},
					 					   dataType : "text",
					 					   success: function(data){
					 						  // alert(data);
					 						  var arr = data.split(","); 
					 						  if(arr.length>0){
					 						  var tr = $("#tableid").find("tr:last");
					 						  var htmlObject = "<tr id=\"tra\">"+
					 							"<input type=\"hidden\" id=\"objId\" name=\"objId\" value=\""+arr[1]+"\" />"+
					 							"<input type=\"hidden\" id=\"tempDefault\" value=\"\" />"+
					 							"<td><input type=\"text\" style=\"width: 85%;\" name=\"sort\" value=\"\" /></td>"+
					 							"<td><input type=\"text\" style=\"width: 85%;\" name=\"objName\" value=\""+arr[0]+"\" readonly=\"readonly\"/></td>"+
					 				 			"<td><select name=\"type\" style=\"width: 85%;\"><option value=\"0\">xpath</option><option value=\"1\">jquery</option><option value=\"2\">default</option></select></td>"+
					 				 			"<td><select name=\"motion\" style=\"width: 85%;\"></select></td>"+
					 				 			"<td><select name=\"param\" style=\"width: 85%;\"><option value=\"0\">default</option><option value=\"1\">自定义</option><option value=\"2\">空</option></select></td>"+
					 				 			"<td><input type=\"text\" style=\"width: 85%;\" name=\"waitTime\" value=\"0\" /></td>"+
					 				 			"<td><select name=\"screenshot\" style=\"width: 85%;\"><option value=\"0\">YES</option><option value=\"1\">NO</option></select></td>"+
					 				 			"<td>"+
												" <a class=\"btn\" href=\"javascript:void(0);\" onclick=\"deleteTestData(this);\"><i class=\"icon-minus\"></i></a>"+
												"</td>"+
					 				 			"</tr>";
					 						  $(tr).after(htmlObject);
					 						  }
					 						 	var motionData = $("#motionData").val();
		 									 	var TypeSelect = $("select[name = 'motion']");
		 										TypeSelect.html("");
		 										var TypeList = motionData.split(",");
		 										for(var i = 0;i<TypeList.length;i++){ 
		 										$("<option value='"+i+"'>" + TypeList[i] + "</option>").appendTo(TypeSelect); 
		 										}
					 						}
					 					});
				           		}
				           
			           		}
			           		else{
			           			custom = custom.split(",");
			           			$.ajax({
				 					   type: "POST",
				 					   url: "${ctx}/obj/objManage/selectData",
				 					  data: {id:custom[0]},
				 					   dataType : "text",
				 					   success: function(data){
				 						  // alert("data="+data);
				 						  var arr = data.split(","); 
				 						  if(arr.length>0){
				 						//	$("tr[id=tra]").remove();
				 						  var tr = $("#tableid").find("tr:last");
				 						  var htmlObject = "<tr id=\"tra\">"+
				 						 	"<input type=\"hidden\" id=\"objId\" name=\"objId\" value=\""+arr[1]+"\" />"+
				 						 	"<input type=\"hidden\" id=\"tempDefault\" value=\"\" />"+
				 						 	"<td><input type=\"text\" style=\"width: 85%;\" name=\"sort\" value=\"\" /></td>"+
				 				 			"<td><input type=\"text\" style=\"width: 85%;\" name=\"objName\" value=\""+arr[0]+"\" readonly=\"readonly\"/></td>"+
				 				 			"<td><select name=\"type\" style=\"width: 85%;\"><option value=\"0\">xpath</option><option value=\"1\">jquery</option><option value=\"2\">default</option></select></td>"+
				 				 			"<td><select name=\"motion\" style=\"width: 85%;\"></select></td>"+
				 				 			"<td><select name=\"param\" style=\"width: 85%;\"><option value=\"0\">default</option><option value=\"1\">自定义</option><option value=\"2\">空</option></select></td>"+
				 				 			"<td><input type=\"text\" style=\"width: 85%;\" name=\"waitTime\" value=\"0\" /></td>"+
				 				 			"<td><select name=\"screenshot\" style=\"width: 85%;\"><option value=\"0\">YES</option><option value=\"1\">NO</option></select></td>"+
				 				 			"<td>"+
											" <a class=\"btn\" href=\"javascript:void(0);\" onclick=\"deleteTestData(this);\"><i class=\"icon-minus\"></i></a>"+
											"</td>"+
				 				 			"</tr>";
				 						  $(tr).after(htmlObject);
				 						  }
				 						 	var motionData = $("#motionData").val();
	 									 	var TypeSelect = $("select[name = 'motion']");
	 										TypeSelect.html("");
	 										var TypeList = motionData.split(",");
	 										for(var i = 0;i<TypeList.length;i++){ 
	 										$("<option value='"+i+"'>" + TypeList[i] + "</option>").appendTo(TypeSelect); 
	 										}
				 						}
				 					});
			           		}
			           	}else if(v == 'close'){
							return true;
						}
			       $(".jbox-content", top.document).css("overflow-y","hidden");
				}});
			});
			
		});
		

		
		function makeTemplate(){
			var tableid = document.getElementById("tableid");  //根据id找到这个表格
			var rows = tableid.rows;     //取得这个table下的所有行
			var motionData = $("#motionData").val();
			var mlist = motionData.split(",");
			//alert(rows.length);
			var b = 1;
		    for(var i=1;i<rows.length;i++){	//循环遍历所有的tr行
		         var cell = rows[i].cells[1];//获取某行下面的某个td元素
		         //alert("第"+(i)+"行第2"+"列内容是"+cell.childNodes[0].value); //取每行固定列的值
		        
		       		//参数是自定义(param==1)，生成模板head 
			    	var paramValue = tableid.rows[i].childNodes[6].childNodes[0].value; //取选择的参数
			    	//alert("paramValue="+paramValue);
			    	if(paramValue==1){   //自定义
			    		 //动态添加到tableTestData的head
				        var length = tableTestData.rows[0].cells.length;  //head td长度
				        var addcell = tableTestData.rows[0].insertCell(length-1);
				        addcell.innerHTML = '<td style="width:10%">'+cell.childNodes[0].value+"</td>";
				        var addrow1 = tableTestData.rows[1].insertCell(length-1);
			        	addrow1.innerHTML = "<td style='width:10%'><input type='text' name=testName"+b +" value=\"\" style='width:200px'/></td>";
			        	b++;
			    	}

		    }
		    var length = tableTestData.rows[0].cells.length;  //head td长度
		      //alert("L="+length);	
		      var number = length - 3;
		     // alert(number);
		      $("#number").val(number);  //后台取testName+1....用
		}
		
		 var n = 2;
		function addTestData(type){
			  var tableTestData = document.getElementById("tableTestData");
			 
		      var temp = "";
		      var tableid = document.getElementById("tableid");  //根据id找到这个表格
		      var length = tableTestData.rows[0].cells.length;  //head td长度
		     // alert("length="+length);
		      for(var i = 2 ; i < length-1 ; i++){
		    	 	var defaultVal = tableid.rows[i-1].childNodes[6].childNodes[0].value; //取选择的参数
					temp = temp + "<td><input name=\"testName"+(i-1)+"\" type=\"text\" value=\"\" style=\"width: 200px;\" ></td>";
				}
		    var value = $("#caseName").val();
			var htmlObject ="<tr>"+
								"<td><input name=\"num\" type=\"text\" value=\""+n+"\" readonly=\"true\" style=\"width: 50px;\" ></td>"+
								"<td><input name=\"caseNameTest\" type=\"text\" value=\""+value+"\" readonly=\"true\"readonly=\"true\" style=\"width: 200px;\" ></td>"+temp+
								"<td>"+
								" <a class=\"btn\" href=\"javascript:void(0);\" onclick=\"deleteTestData(this);\"><i class=\"icon-minus\"></i></a>"+
								"</td>"+
							"</tr>";
				
			if(type == 'obj'){
				$("#testDiv tr:last").after(htmlObject);
			}
			n++;
		}
		
		function deleteTestData(obj){
			$(obj).parent().parent().remove();
		}
		
		function changeCaseNameTest(value){
			//alert("value="+value);
			$("#caseNameTest").val(value);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cases/caseManage/">用例管理列表</a></li>
		<li class="active"><a href="${ctx}/cases/caseManage/form"><shiro:hasPermission name="cases:caseList:edit">用例添加</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="caseManage" action="${ctx}/cases/caseManage/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
	<div class="row-fluid">	
		<div class="control-group span6">
			<label class="control-label">选择用例集:&nbsp;&nbsp;&nbsp;</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${caseManage.parent.id}" labelName="parent.name" labelValue="${caseManage.parent.name}"
					title="父级编号" url="/cases/caseList/treeData"  cssClass="" allowClear="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group span6">
			<label class="control-label">用例名称：</label>
			<div class="controls">
				<form:input path="caseName" htmlEscape="false" maxlength="100" class="input-xlarge required"  onblur="changeCaseNameTest(this.value);"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	</div>
	<div class="control-group">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a id="itemButton" href="javascript:" class="btn btn-primary">选择路径</a>
	</div>
	<div class="row-fluid">	
		<div class="control-group">
			<label class="control-label">用例步骤：&nbsp;&nbsp;&nbsp;</label>
			<div class="controls">
			<input type="hidden" id="motionData" name="motionData" value="" />
				<table class="table table-striped table-bordered table-condensed" style="width:80%" id="tableid">
					<tr>
						<td width="7%;">顺序</td>
						<td width="25%;">对象名称</td>
						<td width="10%;">对象寻址类型</td>
						<td width="15%;">动作</td>
						<td width="10%;">参数</td>
						<td width="10%;">等待时间</td>
						<td width="10%;">截图</td>
						<td width="5%;">操作</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="control-group">
			<label class="control-label">测试数据：&nbsp;&nbsp;&nbsp;</label>
			<input type="button" value="生成模板" class="btn btn-primary"  onclick="makeTemplate();"/>
			<div class="controls" id="testDiv">
				<table class="table table-striped table-bordered table-condensed" style="width:70%" id="tableTestData">
				<input type="hidden" id="number" name="number" value="" />
					<tr id="testDataHead">
						<td width="10%;">顺序</td>
						<td width="20%;">用例名称</td>
						<td width="10%;">操作</td>
					</tr>
					<tr>
						<td><input type="text" name="num" value="1" readonly="true" style="width: 50px;" /></td>
						<td><input type="text" id="caseNameTest" name="caseNameTest" readonly="true" style="width: 200px;" /></td>
						<td>
						<a class="btn" href="javascript:void(0);" onclick="addTestData('obj');"><i class="icon-plus"></i></a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
		<div class="form-actions">
			<shiro:hasPermission name="cases:caseManage:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>