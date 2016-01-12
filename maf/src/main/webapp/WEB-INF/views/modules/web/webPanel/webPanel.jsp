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
			$(".nav-menu a").each(function(i,o){
				if($(o).find(".nextMenu").hasClass("lock-tool")){
					$(o).children().css("cursor","default");
				}
			});
			//window.parent.document.getElementById('mainFrame')
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
	<%-- <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
		<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
			<c:if test="${empty menu.href}">
				<a  href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}" target="mainFrame">
		    	<div class="menu-groups ${empty menu.remarks?'other otherServices':menu.remarks }">
		        	<div class="menu-tools">
		            	<div class="nextMenu"></div>
		            </div>
		        	<div class="menu-content">
		            	<div class="img-con"></div>
		                <div class="font-con">${menu.name}</div>
		            </div>
		        </div>
		        </a>
	        </c:if>
	        <c:if test="${not empty menu.href}">
		        <a  href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-href="" bol-href="true" data-id="${menu.id}" target="mainFrame">
			    	<div class="menu-groups ${empty menu.remarks?'childColor childrenImg':menu.remarks }">
			        	<div class="menu-tools">
			            	<div class="nextMenu"></div>
			            </div>
			        	<div class="menu-content">
			            	<div class="img-con"></div>
			                <div class="font-con">${menu.name}</div>
			            </div>
			        </div>
		        </a>
	        </c:if>
        </c:if>
    </c:forEach>  --%> 
  	<a href="${ctx}/webPanel/webpanelList" data-href="${ctx}/webPanel/webpanelList"  target="mainFrame">
   	 	<div class="menu-groups blue equipment">
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
        <div class="menu-groups white manipulation">
       		<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">远程操作</div>
            </div>
        </div>
     </a> 
     <a href="#" data-href="#" target="mainFrame">       
        <div class="menu-groups white auditService">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">审计服务</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame">       
        <div class="menu-groups white infoSearch">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">信息查询</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame"> 
        <div class="menu-groups white ediaServices">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">介质服务</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame"> 
        <div class="menu-groups white exerciseCoordination">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">演练协调</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame"> 
        <div class="menu-groups white suggestions">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">投诉及建议</div>
            </div>
        </div>
     </a>
     <a href="#" data-href="#" target="mainFrame"> 
        <div class="menu-groups white otherServices">
        	<div class="menu-tools">
            	<div class="nextMenu lock-tool"></div>
            </div>
        	<div class="menu-content">
            	<div class="img-con"></div>
                <div class="font-con">其他服务</div>
            </div>
        </div>
      </a>  
    </div>
</body>
</html>

