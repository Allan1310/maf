// JavaScript Document
$.fn.themeCreatLayout=function(data,op){		//themepanel的生成
	$(this).empty();
		//data=(localStorage.getItem("menuData")&&localStorage.getItem("menuData").length>0)?JSON.parse(localStorage.getItem("menuData")):data;
	var setting=$.extend({
		bgcolor:["default","red","blue","purple","orange","black"], //背景颜色选择清单
		viewHeight:150                     //默认自定义菜单显示高度为150px
	},op);
	$('<a href="javascript:;" data-click="theme-panel-expand" class="theme-collapse-btn"><i class="fa fa-cog"></i></a>').appendTo($(this));
	
	var themeContDiv=$("<div></div>");
	themeContDiv.addClass("theme-panel-content");
	var themeContTitleH=$("<h5></h5>");
	themeContTitleH.addClass("m-t-0 hide");
	themeContTitleH.text("背景色");
	themeContDiv.append(themeContTitleH);
	var themeContUl=$("<ul></ul>");
	themeContUl.addClass("theme-list clearfix hide");
	$.each(setting.bgcolor,function(index,item_o){
		var themeContLi=$("<li></li>");
		if(index==setting.bgcolor.length-1){
			themeContLi.addClass("active");
		}
		$('<a href="javascript:;" class="bg-'+((item_o=="default")?"green":item_o)+'" data-theme="'+item_o+'" data-click="theme-selector" data-toggle="tooltip" data-trigger="hover" data-container="body" data-title="'+item_o+'" data-original-title="" title="">&nbsp;</a>').appendTo(themeContLi);
		themeContUl.append(themeContLi);
	});
	themeContDiv.append(themeContUl);
	themeContDiv.append($('<div class="divider"></div>'));
	var themeContTitleViewH=$("<h5></h5>");
	themeContTitleViewH.addClass("m-t-0");
	themeContTitleViewH.text("视图");
	themeContDiv.append(themeContTitleViewH);
	
	var menuScrollDiv=$("<div></div>");
	menuScrollDiv.css({
		position:"relative",
		overflow:"hidden",
		width:"auto",
		height:setting.viewHeight+"px"
	});
	menuScrollContDiv=$("<div></div>");
	menuScrollContDiv.css({
		position:"absolute",
		left:"0px",
		right:"0px",
		overflow:"hidden",
		width:"auto",
		height:setting.viewHeight+"px"
	}).attr("data-scrollbar","true");
	
	var menuScrollContUl=$("<ul></ul>");
	menuScrollContUl.addClass("theme-menulist clearfix");
	
	$.each(data,function(index,item_data){
		var menuScrollContLi=$("<li></li>");
		var rmenuScrollContLiA=$('<a href="javascript:;" class="menulist-container" data-click="menulist">');
		rmenuScrollContLiA.attr({"data-url":item_data.url,"data-type":item_data.type,"data-title":item_data.title,"data-id":item_data.id,"data-color":item_data.modelColor});
		if(item_data.type&&item_data.type=="1"){
			menuScrollContLi.addClass("active");
			rmenuScrollContLiA.addClass("active");
		}
		var menuInputDiv=$('<div class="menulist-input"><i class="fa fa-square-o"></i></div>');
		rmenuScrollContLiA.append(menuInputDiv);
		
		var menuScrollContTitleDiv=$("<div></div>");
		menuScrollContTitleDiv.addClass("menulist-title");
		
		var menuScrollContTitleCDiv=$("<div></div>");
		menuScrollContTitleCDiv.addClass("menulist-title-content").attr("title",item_data.title);
		menuScrollContTitleCDiv.text(item_data.title);
		
		menuScrollContTitleDiv.append(menuScrollContTitleCDiv);
		rmenuScrollContLiA.append(menuScrollContTitleDiv);
		menuScrollContLi.append(rmenuScrollContLiA);
		menuScrollContUl.append(menuScrollContLi);
	});
	menuScrollContDiv.append(menuScrollContUl).appendTo(menuScrollDiv);
	themeContDiv.append(menuScrollDiv);
	$(this).append(themeContDiv);
}


$.fn.panelCreatLayout=function(data,op){             //panel的生成
	var that=this;
	var $this=$(this);
	var setting=$.extend({
		closeable:true,        //是否显示关闭 bol
		expandable:true,	   //是否显示放大 bol
		freshable:true,		   //是否显示刷新 bol
		toggleable:true		   //是否显示收缩 bol
	},op);
	var panelDiv=$("<div></div>");
	panelDiv.addClass("panel panel-inverse row-fluid").attr("data-sortable-id",data.id);
	panelDiv.attr({"data-url":data.url,"data-color":data.modelColor});
	var panelHeadDiv=$("<div></div>");
	panelHeadDiv.addClass("panel-heading"); //默认title背景，需要判断其他背景颜色
	if($(".theme-panel").find("li.active").length>0)
	panelHeadDiv.addClass("panel-heading-"+$(".theme-panel").find("li.active").children("a").attr("data-theme"));
	panelHeadDiv.addClass("widget-title orange");
	if(data.modelColor&&data.modelColor.length>0){
		panelHeadDiv.css({"backgroundColor":data.modelColor});
	}
	var panelHeadBtnDiv=$("<div></div>");
	panelHeadBtnDiv.addClass("panel-heading-btn");
	if(setting.expandable){
		$('<a href="javascript:;" class="btn_right max" data-click="panel-expand" data-original-title="" title=""></a>').appendTo(panelHeadBtnDiv);
	}
	if(setting.freshable){
	//	$('<a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload" data-original-title="" title=""><i class="fa fa-repeat"></i></a>').appendTo(panelHeadBtnDiv);
	}
	$('<a href="javascript:;" class="btn_right set" data-click="panel-set"><input type="hidden"/></a>').appendTo(panelHeadBtnDiv).click();
	if(setting.toggleable){
	//	$('<a href="javascript:;" class="btn_right set" data-click="panel-collapse"></a>').appendTo(panelHeadBtnDiv);
	}
	if(setting.closeable){
		$('<a href="javascript:;" class="btn_right close_y" data-click="panel-remove" data-original-title="" title=""></a>').appendTo(panelHeadBtnDiv);
	}
	panelHeadDiv.append(panelHeadBtnDiv);
	var panelHeadTitleH=$("<h4></h4>");
	panelHeadTitleH.addClass("panel-title");
	panelHeadTitleH.text(data.title?data.title:"日期");
	panelHeadDiv.append(panelHeadTitleH);
	
	var panelBodyDiv=$("<div></div>");
	panelBodyDiv.addClass("panel-body"); //内容部分，暂时考虑为jsp
	
	panelBodyDiv.html(_loadurl(data.url));
	
	/*$.post(ctx+data.url,{},function(data,status){
		panelBodyDiv.html(data);
		panelDiv.append(panelHeadDiv);
		panelDiv.append(panelBodyDiv);
		$this.append(panelDiv);
	});*/
	panelDiv.append(panelHeadDiv);
	panelDiv.append(panelBodyDiv);
	$this.append(panelDiv);
};

function _loadurl(url,data){
	data=$.extend({"pageSize":"5"},data);
	var html = $.ajax({ 
		  type:"post",
		  url: ctx+url, 
		  async: false ,
		  data:data?data:{}
		}).responseText;
	return html;
}