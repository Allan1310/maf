<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html >
	<head>
		<title>${fns:getConfig('productName')}</title>
		
		<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
    	<c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
     	<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
    
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap-responsive.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/fullcalendar.css" />
        <link rel="stylesheet" href="${ctxStatic}/css1/unicorn.main.css" />
        <link rel="stylesheet" href="${ctxStatic}/css1/index.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/unicorn.blue.css" class="skin-color" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<style type="text/css">
			#iframeContent{
				padding:4px 4px;
			}
			#sidebarCont{
				display: block;
				float: left;
				position: relative;
				width: 220px;
				z-index: 16;
			}
			#sidebar{
				min-height:350px;
				overflow:auto;
				overflow-x:hidden;
			}
			.sidebar-col{
				float: left;
				width:8px;
				min-height:350px;
				border:1px inset #aaa;
				position:relative;
			
			}
			#openClose{
				margin-top:-10px;
				position:absolute;
				right:0px;
				width:6px;
				top:50%;
			}
			#openClose.open{
				background-position:-29px center;
			}
		</style>
		
			<script type="text/javascript">
				 $(document).ready(function() {
					 //获取ip所在地理位置信息
					 $.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js', function(r_result) {
							var address="";
						 if (remote_ip_info.ret == '1') {
							 address=remote_ip_info.province;
							 $
				            } else {
				                address="未匹配";
				            }
						 $("#address").text(address);
				        });
					 var loginDate='<fmt:formatDate value="${fns:getUser().loginDate}" />';
					 loginDate=new Date(loginDate).Format("yyyy/MM/dd");
					 $("#loginDate").text(loginDate);
						// 绑定菜单单击事件
						$("#menu a").click(function(){
							// 一级菜单焦点
							$("#menu a").removeClass("active");
							$(this).addClass("active");
							$("#index-info").text($(this).text());
							// 显示二级菜单
							var menuId = "#menu-" + $(this).attr("data-id");
							if ($(menuId).length > 0){
								$("#sidebar .accordion").hide();
								$(menuId).show();
								// 初始化点击第一个二级菜单
								if (!$(menuId + " .submenu:first").hasClass('open')){
									$(menuId + " .submenu:first a:first").click();
								}
								// 初始化点击第一个三级菜单
								$(menuId + " .submenu-body li:first a:first i").click();
							}else{
								// 获取二级菜单数据
								$.post($(this).attr("data-href"), function(data){
									if (data.indexOf("id=\"loginForm\"") != -1){
										alert('未登录或登录超时。请重新登录，谢谢！');
										top.location = "${ctx}";
										return false;
									}
									$("#sidebar .accordion").hide();
									$("#sidebar").append(data);
									// 链接去掉虚框
									$(menuId + " a").bind("focus",function() {
										if(this.blur) {this.blur()};
									});
									// 二级标题
									$(menuId + " .submenu a:first").click(function(){
										$(this).children("i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
										if(!$($(this).attr('data-href')).children().length==0){
											$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
										}
									});
									dentisClick();
								//	$(menuId + " .submenu a:first").click();
									$(menuId + " .submenu-body li:first a:first i").click();
								});
							}
							wSizeWidth();
							return false;
						});
						// 初始化点击第一个一级菜单
						$("#menu a:first").click();
					});
				 function wSizeWidth(){
						$("#mainFrame").height($(window).height()-102);
					}
			
			</script>
		</head>
		
		
	<body>
		<div id="header">
			<h1><a href="${ctx}">to通联金科</a></h1>
		</div>
		<div class="exit-sys"><a href="${ctx}/logout" title="退出登录">退出</a></div>
        <div class="nav_y" id="menu">
        	<c:set var="firstMenu" value="true"/>
        	<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
        		<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
        			<c:if test="${empty menu.href}">
						<a class="${not empty firstMenu && firstMenu ? ' active' : ''}" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
					</c:if>
           			<c:if test="${not empty menu.href}">
						<a class="${not empty firstMenu && firstMenu ? ' active' : ''}" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
					</c:if>
        			<c:if test="${firstMenu}">
						<c:set var="firstMenuId" value="${menu.id}"/>
					</c:if>
					<c:set var="firstMenu" value="false"/>
           		 </c:if>
            </c:forEach>
        </div>
            
		<div id="sidebarCont">
			<div class="user_info_y">
                <img class="user_info_y_img" src="${empty fns:getUser().photo?( 'static/img/demo/user_1.png'): fns:getUser().photo}">
                <div class="user_info_y_txt">
                    用户：${fns:getUser().name}<br>上次登录:<span id="loginDate"></span><br>地点：<span id="address"></span>
                </div>
            </div>
			<div id="sidebar"></div>
		</div>
		<div class="sidebar-col" ><div id="openClose" class="close">&nbsp;</div></div>
		<div id="style-switcher" style="display:none;">
			<i class="icon-arrow-left icon-white"></i>
			<span>Style:</span>
			<a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
			<a href="#blue" style="background-color: #2D2F57;"></a>
			<a href="#red" style="background-color: #673232;"></a>
		</div>
		
		<div id="content">
			<div id="breadcrumb" style="margin-top:-38px;border-top-left-radius:8px;">
				<a href="#" class="tip-bottom" id="index-info"><!-- <i class="icon-home"></i>  -->首页</a>
				<a href="#" class="current" id="index-child-info">个人信息</a>
			</div>
			<div id="iframeContent">
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="487"></iframe>
			</div>
			<!-- <div class="row-fluid">
					<div id="footer" class="span12">
						2015 &copy;通联金融科技
					</div>
			</div> -->
		</div>


        <script src="${ctxStatic}/js1/excanvas.min.js"></script>
   <%--      <script src="${ctxStatic}/js1/jquery.min.js"></script>
        <script src="${ctxStatic}/js1/jquery.ui.custom.js"></script> --%>
        <script src="${ctxStatic}/js1/bootstrap.min.js"></script>
<%--         <script src="${ctxStatic}/js1/jquery.flot.min.js"></script>
        <script src="${ctxStatic}/js1/jquery.flot.pie.min.js"></script>
        <script src="${ctxStatic}/js1/jquery.flot.resize.min.js"></script> --%>
        <script src="${ctxStatic}/js1/unicorn.js"></script>
      <%--   <script src="${ctxStatic}/js1/unicorn.charts.js"></script> --%>
        <script src="${ctxStatic}/js1/index.js"></script>
        <script type="text/javascript">
        
        	$("html,body").css({"overflow-x":"hidden","overflow-y":"hidden"});
        
        </script>
	</body>
</html>
