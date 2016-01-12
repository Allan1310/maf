/**
 * Created by Dargonpaul on 2015/3/26.
 */
$(function(){
    $('.max').click(function(){
        $(this).parents('.jsManage').toggleClass('fixedMax');
    });
    $('.close_y').click(function(){
        $(this).parents('.jsManage').remove();
    });
    
    $("#openClose").click(function(e){
    	if($(this).hasClass("open")){
    		return false;
    	}
    	else{
    		$("#openClose.open").unbind("mouseenter");
    		$("#sidebarCont").stop().animate({"marginLeft":"-220px"},300);
    		$(this).addClass("open");
    		 $("#openClose.open").bind("mouseenter",function(){
		    	$("#sidebarCont").stop().animate({"marginLeft":"0px"},300);
				$(this).removeClass("open");
				$("#content").stop().animate({"marginLeft":"230px"},300);
				$(this).unbind("mouseenter");
    		 });
    		$("#content").stop().animate({"marginLeft":"10px"},300);
    	}
    });
})