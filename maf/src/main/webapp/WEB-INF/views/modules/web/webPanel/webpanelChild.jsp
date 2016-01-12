<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${fns:getConfig('productName')}</title>
<link rel="stylesheet" href="${ctxStatic}/css2/webpanel.css" />
<script src="${ctxStatic}/js1/jquery.min.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			//window.parent.document.getElementById('mainFrame')
			$(".nav-menu a").each(function(i,o){
				if($(o).find(".nextMenu").hasClass("lock-tool")){
					$(o).children().css("cursor","default");
				}
			});
			$(".nav-menu a").click(function(){
				if($(this).find(".nextMenu").hasClass("lock-tool")){
					return false;
				}
				else{
					if($(window.parent.document.getElementById('now-info')).attr("data-href")&&$(this).attr("href")!=$(window.parent.document.getElementById('now-info')).attr("data-href")){
						$(window.parent.document.getElementById('index-info')).attr({"href":$(window.parent.document.getElementById('now-info')).attr("data-href"),"target":"mainFrame"}).text($(window.parent.document.getElementById('now-info')).text());
						if($(this).attr("bol-href")=="true"){
							$(window.parent.document.getElementById('now-info')).removeAttr("href").attr("data-href",'').text($(this).find(".font-con").text());
						}
						else
						$(window.parent.document.getElementById('now-info')).removeAttr("href").attr("data-href",$(this).attr("href")).text($(this).find(".font-con").text());
					}
				}
			});
		});
</script>
</head>
<body>
	<div class="nav-menu"> 
	<div class="nav-menu-logo"></div>
  	<a href="${ctx}/webPanel/webpanelList" data-href="${ctx}/webPanel/webpanelList"  target="mainFrame">
   	 	<div class="menu-groups blue childrenImg">
       		<div class="menu-tools">
            	<div class="nextMenu"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">人员设备进出</div>
            </div>
        </div>
    </a> 
    <a href="#" data-href="#" target="mainFrame">       
        <div class="menu-groups white childrenImg">
       		<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">参观访问</div>
            </div>
        </div>
     </a> 
     <a href="#" data-href="#" target="mainFrame">       
        <div class="menu-groups white childrenImg">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">门卡开通</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame">       
        <div class="menu-groups white childrenImg">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">权限调整</div>
            </div>
        </div>
     </a> 
    </div>
</body>
</html>

