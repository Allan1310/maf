<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html >
	<head>
		<title>${fns:getConfig('productName')}</title>
		
		<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
    	<c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
     	<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
    
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="${ctxStatic}/css2/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css2/bootstrap-responsive.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css2/fullcalendar.css" />
        <link rel="stylesheet" href="${ctxStatic}/css2/unicorn.main.css" />
        <link rel="stylesheet" href="${ctxStatic}/css2/index.css" />
		<link rel="stylesheet" href="${ctxStatic}/css2/unicorn.blue.css" class="skin-color" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<style type="text/css">
			.container-fluid{
				padding:0px 0 0;
				height:calc(100% - 38px);
				height:-webkit-calc(100% - 38px);
				height:-moz-calc(100% - 38px);
			}
			.exit-sys{
			 	position:absolute;
			 	bottom:10px;
			 	width:30px;
			 	height:20px;
			 	right:10px;
			 	font-size:12px;
			 	/* border: 1px solid #eee; */
			 	padding-left:10px;
			 	padding-right:10px;
			 	padding-top:0px;
			 	padding-bottom:3px;
			 	/* background-color: #eee; */
			 	border-radius:2px;
			 	/* background:url(${ctxStatic}/images/icons/usernav/logout.png) no-repeat; */
			}
			#sidebar .webHome{
				background:url(${ctxStatic}/img/webIndex.png) no-repeat;
				width:24px;
				height:23px;
				margin-top:19px;
			}
			#sidebar .webService{
				background:url(${ctxStatic}/img/webService.png) no-repeat;
				width:24px;
				height:24px;
				margin-top:19px;
			}
			#sidebar .webResource{
				background:url(${ctxStatic}/img/webResource.png) no-repeat;
				width:24px;
				height:25px;
				margin-top:19px;
			
			}
			#sidebar .webTable{
				background:url(${ctxStatic}/img/webTable.png) no-repeat;
				width:26px;
				height:19px;
				margin-top:22px;
			
			}
			.user_info_y_txt a{
				text-decoration:underline;
				color:#ffffff;
				cursor:pointer;
			}
			#sidebar>ul>li>a{
				font-family: "microsoft yahei";
			}
		</style>
		
			<script type="text/javascript">
				 $(document).ready(function() {
					 $("#content").css("minHeight",$(window).height()-80);
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
						$("#sidebar li a").click(function(e){
							// 一级菜单焦点
							$("#sidebar li").removeClass("active");
							$(this).closest("li").addClass("active");
							$("#index-info").removeAttr("href").text("您所在位置");
							$("#now-info").removeAttr("href").attr("data-href",$(this).attr("href")).text($(this).children("span").text());
							return true;
						});
						// 初始化点击第一个一级菜单
						$("#sidebar ul li:first i").click();
						
						//加载新闻数据
						$.ajax({
							type: "post",
							url: "${ctx}/site/siteNews/m/list",
							data: "",
							dataType: "json",
							ContentType:'application/x-www-form-urlencoded',
					        global:false,
					        success: function(data){ 
					        	if(data.list){
					        		$(".silde_msg ul").empty();
					        		for(var i=0;i<(data.list.length>2?2:data.list.length);i++){
				        				var newsLi = $("<li></li>");
						        		var newsA = $("<a></a>");
						        		newsA.attr({
						        			"href": "${ctx}/site/siteNews/show?id="+data.list[i].id,
						        			"target": "_blank"
						        		});
						        		
						        		var newsSpan = $("<span></span>");
						        		if(data.list[i].type=="1"){
						        			newsSpan.text("[新闻]");
						        		}else if(data.list[i].type=="2"){
						        			newsSpan.text("[通知]");
						        		}else{
						        			newsSpan.text("[快讯]");
						        		}
						        		
						        		newsA.append(newsSpan);
						        		newsA.append(data.list[i].title);
						        		newsLi.append(newsA);
						        		
						        		$(".silde_msg ul").append(newsLi);
					        		}
					        	}
					        }
						});
					});
			
			</script>
		</head>
		
		
	<body>
		<div id="header">
            <div class="user_info_y">
                <img class="user_info_y_img" src="${empty fns:getUser().photo?( 'static/img/demo/user_1.png'): fns:getUser().photo}">
                <div class="user_info_y_txt">
                    用户：<a href="${ctx}/webPanel/webUserForm" target="mainFrame">${fns:getUser().name}</a><br>上次登录:<span id="loginDate"></span><br>地点：<span id="address"></span>
                </div>
            </div>

		</div>
        <div class="logo_mid">
            <div class="silde_msg">
                <ul>
                    <li><a href="#" target="_blank"><span>[快讯]</span>贝塔斯瑞β3 Beta Three Q215</a> </li>
                    <li><a href="#" target="_blank"><span>[快讯]</span>贝塔斯瑞A3 Beta Three Q216</a> </li>
                </ul>
            </div>
            <img src="${ctxStatic}/img/logo_mid_web.png">
            <a href="${ctx}/logout?random=<%=java.lang.Math.random()%>"  class="exit-sys" title="退出登录">退出</a>
        </div>
            
		<div id="sidebar" >
			<ul id="">
			<%-- 	<c:set var="firstMenu" value="true"/> --%>
				<%-- <li class="active"><a  href="${ctx}/indexdef/bcmMenu/indexdata" data-href="${ctx}/indexdef/bcmMenu/indexdata" target="mainFrame"><i class="icon icon-home"></i> <span>首页</span></a></li>
				<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
					<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'&&menu.id ne '27'}">
						<c:if test="${empty menu.href}">
							 <li class=""><a  href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}" target="mainFrame">
							 <c:if test="${menu.name eq '服务需求'}">
							 	<i class="icon icon-shopping-cart"></i> 
							 </c:if>
							 <c:if test="${menu.name eq '投诉建议'}">
							 	<i class="icon icon-comment"></i> 
							 </c:if>
							 <c:if test="${menu.name ne '投诉建议'&& menu.name ne '服务需求'}">
							 	<i class="icon icon-home"></i> 
							 </c:if>
							 <span>${menu.name}</span></a></li>
						</c:if>
						<c:if test="${not empty menu.href}">
							 <li class=""><a  href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><i class="icon icon-home"></i><span>${menu.name}</span></a></li>
						</c:if>
						<c:if test="${firstMenu}">
							<c:set var="firstMenuId" value="${menu.id}"/>
						</c:if>
						<c:set var="firstMenu" value="false"/>
           		 	</c:if>
            	</c:forEach> --%>
                <li class="active"><a  href="${ctx}/indexdef/bcmMenu/indexdata" target="mainFrame"><i class="icon icon-home webHome"></i> <span>首页</span></a></li>
                <li><a href="${ctx}/webPanel/webpanel" target="mainFrame"><i class="icon icon-shopping-cart webService" ></i> <span>服务需求</span></a></li>
                <li><a href="#" ><i class="icon icon-comment webResource" ></i> <span>资源中心</span></a></li>
                <li><a href="#" ><i class="icon icon-headphones webTable" ></i> <span>报表中心</span></a></li>

			</ul>
		
		</div>
		<div id="style-switcher" class="hide">
			<i class="icon-arrow-left icon-white"></i>
			<span>Style:</span>
			<a href="#grey" style="background-color: #555555;border-color: #aaaaaa;"></a>
			<a href="#blue" style="background-color: #2D2F57;"></a>
			<a href="#red" style="background-color: #673232;"></a>
		</div>

        <div id="content">
            <div id="breadcrumb">
                <a href="#"  class="tip-bottom" id="index-info" style="font-size: 14px;font-weight: bolder;"><i class="icon-home"></i>  您所在位置</a>
                <a href="#" class="current" id="now-info" style="font-size: 14px;font-weight: bolder;">服务需求</a>
            </div>
            <div class="container-fluid">
            	<iframe  id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="100%"></iframe>
            </div>
        </div>


        
		<script src="${ctxStatic}/js1/jquery.min.js"></script>
        <script src="${ctxStatic}/js1/excanvas.min.js"></script>
        <script src="${ctxStatic}/js1/bootstrap.min.js"></script>
        <script src="${ctxStatic}/js1/index_1.js"></script> 
    	<%--<script src="${ctxStatic}/js1/unicorn.dashboard.js"></script> --%>
        <script type="text/javascript">
        
        	$("html,body").css({"overflow-x":"hidden","overflow-y":"auto"});
        
        </script>
	</body>
</html>
