<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function loadData(data){
			try{
				$.ajax({
					type: "post",
			        url: '${ctx}/rm/rmVsApplicationInformation/m/list',
			        data:(data?data:""),
			        dataType: "json",
			        ContentType:'application/x-www-form-urlencoded',
			        global:false,
			        success: function(data){ 
			        	$("body").children(":not(.container-fluid)").removeClass("hide");
			        	$("input[name='pageNo']").val(data["pageNo"]);
			        	$("input[name='pageSize']").val(data["pageSize"]);
			        	$(".pagination").html(data.html);
			        	var nowDom=$("#contentTable").find("tbody");
			        	nowDom.empty();
			        	$.each(data.list?data.list:[],function(i,o){
			        		/* 截取时间 */
			        		var createDate = o.createDate;
			        		var approachDate = o.approachDate;
			        		var appearancesDate = o.appearancesDate;
			        		if(approachDate == undefined){
			        			approachDate = "";
			        			appearancesDate = "";
			        		}
			        		var grounds = "";
			        		var grou = "";
			        		var ground = o.grounds.split(",");
			        		for(j=0;j<ground.length;j++){
			        			if(ground[j]=="1"){
			        				grou = "参观";
			        			}else if(ground[j]=="2"){
			        				grou = "测试";
			        			}else if(ground[j]=="3"){
			        				grou = "线路安装";
			        			}else if(ground[j]=="4"){
			        				grou = "设备维护";
			        			}else if(ground[j]=="5"){
			        				grou = "设备调整";
			        			}
			        			grounds = grou + " " + grounds;
			        		}
			        		var timeout = ""
			        		if(o.isTimeout=="1")timeout="<span style='color:red'>已超时</span>";
			        		else if(o.isTimeout=="0")timeout="未超时";
			        		
			        		var auditType=""
		        			if(o.auditType=="1")auditType="审核中";
			        		else if(o.auditType=="2")auditType="审核成功";
			        		else if(o.auditType=="3")auditType="审核失败 ";
			        		else auditType="取消申请";
			        		var checkinType="";
			        		if(o.checkinType=="1")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">未入场</a>';
			        		else if(o.checkinType=="2")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">部分入场</a>';
			        		else if(o.checkinType=="3")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">全部入场</a>';
			        		else if(o.checkinType=="4")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">部分出场</a>';
			        		else if(o.checkinType=="5")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">全部出场</a>';
		        			else if(o.checkinType=="6")
			        			checkinType='<a href="${ctx}/webPanel/viewDetail?vsApplyId='+o.vsApplyId+'&id='+o.id+'">已取消访问</a>';
			        		var opreate='<td></td>';
			        		if(o.isDraft=="0"){
			        			opreate='<td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=3&isDraft=1">修改草稿</a></td>';
			        			if(o.checkinType=="6"){
			        				nowDom.append(('<tr><td>'+(i+1)+'</td><td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=2">'+o.vsApplyId+'</a></td><td>'+createDate+'</td><td>'+approachDate+'</td><td>'+appearancesDate+'</td><td>'+grounds+'</td><td>'+checkinType+'</td>'+'<td></td>'+'<td>'+timeout+'</td>'+'</tr>'));
			        			}else{
			        				nowDom.append(('<tr><td>'+(i+1)+'</td><td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=2">'+o.vsApplyId+'</a></td><td>'+createDate+'</td><td>'+approachDate+'</td><td>'+appearancesDate+'</td><td>'+grounds+'</td><td>'+checkinType+'</td>'+opreate+'<td>'+timeout+'</td>'+'</tr>'));
			        			}
			        		}else{
			        			opreate='<td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=1">修改&nbsp;</a>&nbsp;&nbsp;<a href="${ctx}/webPanel/cancelVisit?id='+o.id+'&btn=1" onclick="return confirmBtn();">取消访问</a></td>';
		        				if(o.checkinType=="1"){
		        					nowDom.append(('<tr><td>'+(i+1)+'</td><td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=2">'+o.vsApplyId+'</a></td><td>'+createDate+'</td><td>'+approachDate+'</td><td>'+appearancesDate+'</td><td>'+grounds+'</td><td>'+checkinType+'</td>'+opreate+'<td>'+timeout+'</td>'+'</tr>'));
		        				}else{
		        					nowDom.append(('<tr><td>'+(i+1)+'</td><td><a href="${ctx}/webPanel/webpanelTab?id='+o.id+'&btn=2">'+o.vsApplyId+'</a></td><td>'+createDate+'</td><td>'+approachDate+'</td><td>'+appearancesDate+'</td><td>'+grounds+'</td><td>'+checkinType+'</td>'+'<td></td>'+'<td>'+timeout+'</td>'+'</tr>'));
		        				}
			        		}
			        		
			        	});
			        	if((data.list?data.list:[]).length==0){
			        		var nowDom=$("#contentTable").find("tbody");
			        		var tdlength=$("#contentTable").find("thead").children("tr").children().length;
			        		var tr=$("<tr><td colspan='"+tdlength+"' style='text-align:center;font-weight:bold;'>没有记录!</td></tr>");
			        		nowDom.append(tr);
			        	}
			        },
			        error:function(){
			        	$("body").children(":not(.container-fluid)").remove();
						$("body").children(".container-fluid").removeClass("hide");
			        }
				}); 
			}
			catch(e){
				$("body").children(":not(.container-fluid)").remove();
				$("body").children(".container-fluid").removeClass("hide");
				
			}
		}
		$(document).ready(function() {
			$("body").children().each(function(i,o){
				if(!$(o).hasClass("hide")){
					$(o).addClass("hide");
				}
			});
			$("#btnAdd").click(function(){
				$(this).closest("form").attr("action",'${ctx}/webPanel/webpanelTab?btn=3');
				$(this).closest("form").submit();
			});
			$("#btnSubmit").click(function(){
				var param={};
				param["approachDate"]=$("input[name='approachDate']").val();
				param["appearancesDate"]=$("input[name='appearancesDate']").val();
				param["vsApplyId"]=$("input[name='vsApplyId']").val();
				param["grounds"]=$("select[name='grounds']").val();
				param["isTimeout"]=$("select[name='isTimeout']").val();
				param["checkinType"]=$("select[name='checkinType']").val();
				loadData(param);
			});
			loadData();        //加载列表数据	
		});
		function page(n,s){
			var param={};
			param["approachDate"]=$("input[name='approachDate']").val();
			param["appearancesDate"]=$("input[name='appearancesDate']").val();
			param["vsApplyId"]=$("input[name='vsApplyId']").val();
			param["grounds"]=$("select[name='grounds']").val();
			param["isTimeout"]=$("select[name='isTimeout']").val();
			param["checkinType"]=$("select[name='checkinType']").val();
			param["pageNo"]=n;
			param["pageSize"]=s;
			loadData(param);
        	return false;
        }
		function confirmBtn(){
			var gnl = confirm("您确认要取消访问吗？");
			if (gnl == true){
				return true;
			}else{
				return false;
			} 
			/* var submit = function (v, h, f) {
			    if (v == 'ok')
			    	return true;
			    else if (v == 'cancel')
			    	return false;
			};
			$.jBox.confirm("您确认要取消访问吗？", "提示", submit); */
		}
	</script>
</head>
<body>
	<div class="container-fluid hide">
		<div class="page-header"><h1>操作权限不足.</h1></div>
		
		<div><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		<script>try{top.$.jBox.closeTip();}catch(e){}</script>
	</div>
	<form:form id="searchForm" modelAttribute="rmVsApplicationInformation" method="post" action="" class="breadcrumb form-search">
		<ul class="ul-form">
			<li>
				<label style="width:100px;">预定进场时间：</label>
				<input type="text" name="approachDate" maxlength="20" class="Wdate input-medium" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});">
				<label style="width:100px;">预定出场时间：</label>
				<input type="text" name="appearancesDate" maxlength="20" class="Wdate input-medium" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});">
				<label style="width:100px;">申请单号：</label>
				<input type="text" maxlength="200" class="input-medium" name="vsApplyId"/>
				<input type="hidden" name="pageNo" />
				<input type="hidden" name="pageSize" />
			</li>
			<li>
				<label style="width:100px;">访问事由：</label>
				<select name="grounds" style="width:177px;">
					<option value="">--请选择--</option>
					<option value="1">参观</option>
					<option value="2">测试</option>
					<option value="3">线路安装</option>
					<option value="4">设备维护</option>
					<option value="5">设备调整</option>
				</select>
				<label style="width:100px;" title="未入场：&nbsp;&nbsp;&nbsp;所有人员均未入场。&#13;部分入场：已有人员入场。&#13;全部入场：所有人员均已入场。&#13;部分出场：所有人员均已入场，且已有人员退卡出场。&#13;全部出场：所有人员均已退卡出场。&#13;">入场状态：</label>
				<select name="checkinType" style="width:178px;">
					<option value="">--请选择--</option>
					<option value="1">未入场</option>
					<option value="2">部分入场</option>
					<option value="3">全部入场</option>
					<option value="4">部分出场</option>
					<option value="5">全部出场</option>
				</select>
				<label style="width:100px;" title="当前系统时间是否超过预定出场时间。">是否超时：</label>
				<select name="isTimeout" style="width:177px;">
					<option value="">--请选择--</option>
					<option value="0">未超时</option>
					<option value="1">已超时</option>
				</select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
			<input id="btnAdd" style="background-color: #FF940A;color: #fff;display: inline;border-style: none;padding: 5px 15px;font-size: 14px;border-radius: 4px;" type="button" value="申请" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>申请单号</th>
				<th>申请时间</th>
				<th title="">预定进场时间</th>
				<th title="">预定出场时间</th>
				<th>访问事由</th>
				<th title="未入场：&nbsp;&nbsp;&nbsp;所有人员均未入场。&#13;部分入场：已有人员入场。&#13;全部入场：所有人员均已入场。&#13;部分出场：所有人员均已入场，且已有人员退卡出场。&#13;全部出场：所有人员均已退卡出场。&#13;">入场状态</th>
				<th>操作</th>
				<th title="当前系统时间是否超过预定出场时间。">是否超时  </th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div class="pagination"></div>
</body>
</html>