<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html >
<head>
<title>首页</title>
<meta name="decorator" content="default"/>

<link href="${ctxStatic}/css/jquery-ui.min.css" rel="stylesheet"><!--  -->

<link href="${ctxStatic}/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctxStatic}/css/font-awesome.min.css" type="text/css" rel="stylesheet" />

<link href="${ctxStatic}/css/animate.min.css" rel="stylesheet"> <!--  -->


<link href="${ctxStatic}/css/style.min.css" rel="stylesheet">

<link href="${ctxStatic}/css/style-responsive.min.css" rel="stylesheet"><!--  -->
<link href="${ctxStatic}/css/default.css" rel="stylesheet" id="theme">
<link href="${ctxStatic}/css/jquery-jvectormap-1.2.2.css" rel="stylesheet">

<link href="${ctxStatic}/css/datepicker3.css" rel="stylesheet">

<link href="${ctxStatic}/css/jquery.gritter.css" rel="stylesheet"><!--  -->


<link href="${ctxStatic}/css1/index.css" rel="stylesheet">



<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<script type="application/javascript" src="${ctxStatic}/jquery/jquery-ui.min.js"></script>
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>

<script type="application/javascript" src="${ctxStatic}/jquery/jquery.slimscroll.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/jquery/jquery.cookie.js"></script>



<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.gritter.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.flot.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.flot.time.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.flot.resize.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.flot.pie.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery.sparkline.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery-jvectormap-1.2.2.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/indexComponent/jquery-jvectormap-world-mill-en.js"></script>



<script type="application/javascript" src="${ctxStatic}/js1/jquery.colorpicker.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/panelCreateLayout.js"></script>

<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap-datepicker.js" type="text/javascript"></script>

<script type="application/javascript" src="${ctxStatic}/index/dashboard.min.js"></script>
<script type="application/javascript" src="${ctxStatic}/index/apps.min.js"></script>
<style type="text/css">
 .col-md-6{
 	width:50%;
 	float:left;
 }
 .panel-body{
 	 overflow:auto;
 	 background: none repeat scroll 0 0 #F9F9F9;
	border-top: 1px solid #CDCDCD;
	border-left: 1px solid #CDCDCD;
	border-right: 1px solid #CDCDCD;
	border-bottom: 1px solid #CDCDCD;
	clear: both;
	font-family: "microsoft yahei";
 }
.breadcrumb {
	padding: 8px 15px;
	 margin: 0 0 8px;
	list-style: none;
	background-color: #f5f5f5;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}
.breadcrumb input{
	height:30px;
}
.pagination {
	display:block;
	padding-left: 0;
	margin: 8px 0;
}
.table-bordered {
	border: 1px solid #ddd;
	border-collapse: separate;
	border-left: 0;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}
.ui-sortable .table th, .ui-sortable .table td {
	padding: 8px;
	line-height: 20px;
	text-align: left;
	vertical-align: top;
	border: 1px none #ddd;
	border-top: 1px solid #ddd;
	border-left: 1px solid #ddd;
}
.table-striped tbody>tr:nth-child(odd)>td, .table-striped tbody>tr:nth-child(odd)>th {
	background-color: #f5f5f5;
}
.table>thead>tr>th {
	color: #242a30;
	font-weight: 600;
	border-bottom: 1px none #e2e7eb!important; 
} 
 .spinner-small{
	-webkit-animation:rotation .6s infinite linear;
	-moz-animation:rotation .6s infinite linear;
	-o-animation:rotation .6s infinite linear;
	animation:rotation .6s infinite linear
} 

.panel-inverse .widget-title, .modal-header, .table th, div.dataTables_wrapper .ui-widget-header{
 	background-color: #efefef;
	background-image: -webkit-gradient(linear, 0 0%, 0 100%, from(#fdfdfd), to(#eaeaea));
	background-image: -webkit-linear-gradient(top, #fdfdfd 0%, #eaeaea 100%);
	background-image: -moz-linear-gradient(top, #fdfdfd 0%, #eaeaea 100%);
	background-image: -ms-linear-gradient(top, #fdfdfd 0%, #eaeaea 100%);
	background-image: -o-linear-gradient(top, #fdfdfd 0%, #eaeaea 100%);
	background-image: -linear-gradient(top, #fdfdfd 0%, #eaeaea 100%);
/* 	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fdfdfd', endColorstr='#eaeaea',GradientType=0 ); */
	border-bottom: 1px solid #CDCDCD;
	height: 36px;
 
 }
 .widget-title.zi {
	background-image: none;
/* 	filter:progid:DXImageTransform.Microsoft.gradient( startColorstr='#8e44ad', endColorstr='#8e44ad',GradientType=0 ); */
	background-color: #8e44ad;
}
 .widget-title.blue{
	background-image: none;
	background-color: #1eb9ee;
}
.widget-title.orange{
	background-image: none;
	background-color: #f59c1a;
}
.widget-title h4 {
	color: #ffffff;
	font-size: 18px;
	font-weight: normal;
	margin: 0;
}
.btn_right {
	width: 17px;
	height: 17px;
	display: inline-block;
	background-image: url("../../../static/img/icon_index_title.png");
	background-repeat: no-repeat;
	margin: 0px 10px;
	cursor: pointer;
	}
.btn_right.max {
	background-position: 0px 0px;
}
.btn_right.set {
	background-position: -30px 0px;
}
.btn_right.close_y {
	background-position: right center;
}
.row{
	min-height:487px;
}
.new-update:first-child {
	border-top: medium none;
}
.new-update:hover, .activity-list li a:hover {
	background-color: #f6f8fc;
}
.new-update {
	border-top: 1px solid #DDDDDD;
	padding: 2px 2px;
	line-height: 30px;
}
.font_zi {
	color: #8e44ad;
}
.moreDetail{
	text-align:right;
	
}
.moreDetail a{
	cursor:pointer;
}
.row-fluid [class*="span"]{
	overflow:hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
	height: 30px;
}
.new-update .img-parent{
	position:relative;
}
.new-update .img{
	postion:absolute;
	top:0px;
	left:0px;
	display: inline-block;
	width: 14px;
	height: 14px;
	margin-top: 1px;
	line-height: 14px;
	vertical-align: text-top;
	background-image: url("../../../static/img/glyphicons-halflings.png");
	background-position: 14px 14px;
	background-repeat: no-repeat;
	background-position:-168px 0;

}


</style>

<script>
var ctx="${ctx}";
var sessionid="${fns:getUser().id}";
		$(document).ready(function() {
				$(".row").css("minHeight",$('#mainFrame', parent.document).height());
        		$(".ui-sortable").empty();
				$.ajax({
			        type: "post",
			        url: "${ctx}"+'/indexdef/bcmMenu/listData',
			        data: "",
			        dataType: "json",
			        global:false,
			        success: function(dataAll){ 
			        	dataAnal(dataAll);
			        	$(".row").find(".spinner-small").remove();
			        }
		       });
			
		});
		function dataAnal(dataAll){
			var data=[];
			if(dataAll.length>0){
				dataAll_=dataAll[0];
				data=dataAll[1];
			}
			var newData=[]; //所有菜单数据
			var newShowData=[];//默认被显示的数据
			var newData_o=[];
        	$.each(dataAll_,function(index,item_data){
        		var newitem_data={};
    			if(data.length>0){
	   				$.each(data,function(index_o,item_data_o){
	   					if(item_data_o.id==item_data.id){
	   						newitem_data["type"]=1;
	   					}
	   				});
    			}
        		for(var key in item_data){
        			if (key=="menuShow"){
        				if(data.length==0){
            				newitem_data["type"]=item_data[key];
        				}
        				else{
            				newitem_data[key]=item_data[key];
        				}
        			}
        			else{
        				newitem_data[key]=item_data[key];
        			}
        		}
        		 if(data.length==0&&item_data["menuShow"]=="1"){
        			newShowData.push(newitem_data);
        		} 
        		newData.push(newitem_data);
        	});
        	$(".theme-panel").themeCreatLayout(newData);
        	var showpanelData=[];
        	var showpanelCol_1=[];
        	var showpanelCol_2=[];
        	$.each((data.length>0?data:newShowData),function(i,obj){
        		if(obj["columnType"]=="1"){
        			showpanelCol_1.push(obj);
        		}
        		else if(obj["columnType"]=="2"){
        			showpanelCol_2.push(obj);
        		}
        		else{
        			if(i%2==0){
        				showpanelCol_1.push(obj);
        			}
        			else{
        				showpanelCol_2.push(obj);
        			}
        			
        		}
        		
        	});
        	showpanelData.push(showpanelCol_1);
        	showpanelData.push(showpanelCol_2);
			 var n = window.location.href;
             n = n.split("?");
             n = n[0];
             n=n+"_"+sessionid;            //通过sesion控制差异
             var t = localStorage.getItem(n);
			 t = JSON.parse(t)?JSON.parse(t):showpanelData;
			 t=showpanelData;
			 $(".ui-sortable").each(function(index_,item_obj){
				 $.each(t[index_],function(index,item_data){
				 		$(item_obj).panelCreatLayout(item_data);    //panel绘画 
				 });
				 if(t[index_].length==0){
					 $(item_obj).append("<div class='panel panel-inverse hide' data-sortable-id='unuse-"+index_+"'><div class='panel-heading'></div></div>");
				 }
			});
			App.init(); //界面功能的加载
			Dashboard.init(); //控件的加载
		}
		function savePanelPosition(arr){
			console.info("arr",arr);
			var strid="";
			$.each(arr,function(index,itemobj){
				$.each(arr[index],function(index_c,item_c){
					strid=strid+item_c["id"]+";"+(index+1)+";"+(index_c+1)+";"+item_c["bgColor"]+",";
				});
			});
			strid=strid.substr(0,strid.length-1);
			 $.ajax({
		        type: "post",
		        url: "${ctx}"+'/indexdef/bcmMenu/saveData',
		        data:{types:strid},
		        dataType: "json",
		        global:false,
		        success: function(dataAll){ 
		        }
	       });
			
		}
</script>
</head>

<body >
	<div class="row" >
    	<div class="col-md-6 ui-sortable" >           
        </div>
    	<div class="col-md-6 ui-sortable">
        </div>
        <span  class="spinner-small"></span>
    </div>
   <div class="theme-panel"></div>
</body>
</html>
