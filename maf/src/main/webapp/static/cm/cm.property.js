/*
 * 属性管理js
 * @author liujx
 * @version 2015-1-19
 * 
 */

function properTypeSelect(){
	var type = $("#dataType").val();
	if(type=='2'){
		$("#selectType").show();
		$("#widgetType").hide();
	}else if(type=='3'){
		$("#widgetType").show();
		$("#selectType").hide();
	}else{
		$("#widgetType").hide();
		$("#selectType").hide();
	}
}
