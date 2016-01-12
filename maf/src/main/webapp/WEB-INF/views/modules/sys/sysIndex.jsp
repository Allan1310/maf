<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html >
	<head>
		<title>${fns:getConfig('productName')}</title>
		
		<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
    	<c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
     	<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
    
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${ctxStatic}/css/sysIndex.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap-responsive.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/fullcalendar.css" />
        <link rel="stylesheet" href="${ctxStatic}/css1/unicorn.main.css" />
        <link rel="stylesheet" href="${ctxStatic}/css1/index.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/unicorn.blue.css" class="skin-color" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<style type="text/css">
		html, body{
			height:100%;
		   	width:100%;
		   	padding:0;
		   	margin:0;
		   	background:#ECF0F1;
			font-family:"microsoft yahei";
			font-size:12px;
			color:#333333;
			min-width:1252px;
		}
		a{
			color:#FFFFFF;
			text-decoration:none;
		}
		a:hover{
			color:#FFFFFF;
			text-decoration:underline;
		}
		
		
		.iframeContent{
			padding:4px;
		}
		</style>
		
		<script type="text/javascript">
		$(document).ready(function(e) {
			
			/*将选中的上方菜单名字填写到左边*/
			$(".leftTop-text").text($(".headerMenu-selected").find("div:last").text());
			
			//获取登录的地点
			$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js', function(r_result) {
				var address="";
			 	if (remote_ip_info.ret == '1') {
				 	address=remote_ip_info.province;
		        } else {
		            address="未匹配";
		        }
			 	$("#address").text(address);
		    });
			
			//点击顶部菜单样式
		    $(".headerMenu-item").click(function(){
				$(".headerMenu-item").removeClass("headerMenu-selected");
				$(this).addClass("headerMenu-selected");
				$(".leftTop-text").text($(this).find("div:last").text());
			});
			
			//点击上方菜单之后加载左侧菜单
			$("#menu a").click(function(){
				$("#index-info").text($(this).find("div:last").text());
				
				var menuId = "#menu-" + $(this).attr("data-id");
				if ($(menuId).length > 0){
					$(".menuTree").hide();
					$(menuId).show();
					
					$(menuId + " .subMenu:first").siblings(".subMenu").hide();
					$(menuId + " .subMenu:first").show();
					$(menuId + " .subMenu:first a:first i").click();
				}else{
					$.post($(this).attr("data-href"), function(data){
						if (data.indexOf("id=\"loginForm\"") != -1){
							alert('未登录或登录超时。请重新登录，谢谢！');
							top.location = "${ctx}";
							return false;
						}
						$(".menuTree").hide();
						$(".leftMenu").append(data);
						
						$(menuId + " a").bind("focus",function() {
							if(this.blur) {this.blur()};
						});
						
						tipAndSearch();
						
						/* $(menuId + " .subMenu:first").siblings(".subMenu").hide();
						$(menuId + " .subMenu:first").show(); */
						$(menuId + " .subMenu:first a:first i").click();
					});
				}
				wSizeWidth();
			});
			
		  		
			//菜单收起效果
			$(".leftArrow").click(function(){
				$(".leftSide").animate({"margin-left":"-180px"});
				$(".mainContent").animate({"width":$("body").width() - 5},function(){
						$(".mainContent").css("width","calc(100% - 5px)");
						$(".mainContent").css("width","-webkit-calc(100% - 5px)");
						$(".mainContent").css("width","-moz-calc(100% - 5px)");
						$(".spread").show();
				});
			});
			
			//菜单展开效果
			$(".spread").click(function(){
				$(".spread").hide();
				$(".leftSide").animate({"margin-left":"0"});
				$(".mainContent").animate({"width":$("body").width() - 185},function(){
						$(".mainContent").css("width","calc(100% - 185px)");
						$(".mainContent").css("width","-webkit-calc(100% - 185px)");
						$(".mainContent").css("width","-moz-calc(100% - 185px)");
				});
			});
			
			$("#menu a:first").click();
		});

		function wSizeWidth(){
			$("#mainFrame").height($(".mainContent").height() - 48);
		}

		function tipAndSearch(){
			// === Tooltips === //
			$('.tip').tooltip();	
			$('.tip-left').tooltip({ placement: 'left' });	
			$('.tip-right').tooltip({ placement: 'right' });	
			$('.tip-top').tooltip({ placement: 'top' });	
			$('.tip-bottom').tooltip({ placement: 'bottom' });	
			
			// === Search input typeahead === //
			$('#search input[type=text]').typeahead({
				source: ['Dashboard','Form elements','Common Elements','Validation','Wizard','Buttons','Icons','Interface elements','Support','Calendar','Gallery','Reports','Charts','Graphs','Widgets'],
				items: 4
			});
		}
		
		</script>
	</head>
		
		
	<body>
		<div class="header">
	    	<div class="logo"></div>
	        <div id="menu" class="headerMenu">
	        	<c:set var="firstMenu" value="true"/>
	        	<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
	        		<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
	        			<c:if test="${empty menu.href}">
							<a class="headerMenu-item ${not empty firstMenu && firstMenu ? 'headerMenu-selected' : ''}" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}">
								<div class="menu-icon ${menu.icon}-icon"></div>
	                			<div class="menu-text">${menu.name}</div>
							</a>
							<div class="line-first"></div>
						</c:if>
						<c:if test="${not empty menu.href}">
	                        <a class="headerMenu-item ${not empty firstMenu && firstMenu ? 'headerMenu-selected' : ''}" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame">
	                        	<div class="menu-icon ${menu.icon}-icon"></div>
	                			<div class="menu-text">${menu.name}</div>
	                        </a>
	                        <div class="line-first"></div>
						</c:if>
						<c:if test="${firstMenu}">
							<c:set var="firstMenuId" value="${menu.id}"/>
						</c:if>
						<c:set var="firstMenu" value="false"/>
	        		</c:if>
	        	</c:forEach>
	        	<!-- <div class="line-last"></div> -->
	        </div>
	        <div class="headerUser">
	        	<div class="help-content"><a href="#">帮助</a> / <a href="#">关于</a> / <a href="${ctx}/logout" title="退出登录">退出</a></div>
	            <div class="user-content">${fns:getUser().name}</div>
	        </div>
	    </div>
	    <div class="leftSide">
	    	<div class="leftTop"><div class="leftTop-text">系统首页</div><div class="spread"></div><div class="leftArrow"></div></div>
	        <div class="leftMenu">
	        	
	        </div>
	    </div>
	    <div class="mainContent">
	    	<div class="mainTop">
	        	<div class="mainLocation">位置：<!-- <span id="index-info">首页</span> -->
	        		<span class="tip-bottom" id="index-info">首页</span>
					<span class="current" id="index-child-info">个人信息</span>
	        	</div>
	            <div class="mainAddress">地点：<span id="address"></span></div>
	            <div class="mainLast">上次登录：<fmt:formatDate value="${fns:getUser().loginDate}" pattern="yyyy/MM/dd"/></div>
	        </div>
	        <div class="iframeContent">
				<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="487"></iframe>
			</div>
	    </div>


        <script src="${ctxStatic}/js1/excanvas.min.js"></script>
        <script src="${ctxStatic}/js1/bootstrap.min.js"></script>
        <script src="${ctxStatic}/js1/unicorn.js"></script>
        <script src="${ctxStatic}/js1/index.js"></script>
	</body>
</html>
