<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate" /><meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" /><meta name="author" content="peng.liao"/><meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10" />


<script src="${ctxStatic}/js1/jquery.min.js"></script>  
<script src="${ctxStatic}/js1/unicorn.login.js"></script>

<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.method.min.js" type="text/javascript"></script>

<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>

<%
if (request.getAttribute("from_protal") != null) {
	response.sendRedirect((String)request.getAttribute("from_protal"));
}
%>
<html >
    <head>
        <title>${fns:getConfig('productName')} - 浦发信用卡自动化</title>
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/css1/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="${ctxStatic}/css1/unicorn.login.css" />
        
        <script type="text/javascript">
		$(document).ready(function() {
			
		//	$("#validateCode_img").attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime())
			
			$("#loginform").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});

			//如果是IE并且是IE9以下 
			//var r=browser();
		});
		// 如果在框架中，则跳转刷新上级页面
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}

		function browser (){
			var ua=window.navigator.userAgent,
				ret="";

			if(/Firefox/g.test(ua)){

				ua=ua.split(" ");
				ret="Firefox|"+ua[ua.length-1].split("/")[1];

			}else if(/MSIE/g.test(ua)){

				ua=ua.split(";");
				ret="IE|"+ua[1].split(" ")[2];

			}else if(/Opera/g.test(ua)){

				ua=ua.split(" ");
				ret="Opera|"+ua[ua.length-1].split("/")[1];

			}else if(/Chrome/g.test(ua)){

				ua=ua.split(" ");
				ret="Chrome|"+ua[ua.length-2].split("/")[1];

			}else if(/^apple\s+/i.test(navigator.vendor)){

				ua=ua.split(" ");
				ret="Safair|"+ua[ua.length-2].split("/")[1];

			}else{
				ret="未知浏览器";

			}

		 return ret.split("|");
	}

				
	</script>
   </head>
    <body>
        <div id="logo">
            <img src="${ctxStatic}/img/logo_1.png" alt="" />
        </div>
        <div class="login_main">
	       	<div class="header">
				<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
					<label id="loginError" class="error">${message}</label>
				</div>
			</div>
        	<!--[if lte IE 8]><div class='alert alert-block' style="text-align:left;padding-bottom:10px;margin:10px;position:absolute;top:0px;z-index:201;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您升级到 IE9 及以上的版本，或者使用较新版本的 Chrome、Firefox、Safari 等浏览器。使用360浏览器、猎豹浏览器也需要升级IE。 <a href="http://browsehappy.com" target="_blank" class="btn btn-info"><i class="icon-arrow-up"></i>点此下载升级</a> </p></div><![endif]-->
            <div id="loginbox">
                <form id="loginform" class="form-vertical" action="${ctx}/login" method="post" >
                    <p class="title">用户登录</p>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i class="icon-user"></i></span><input id="username" name="username" class="required" type="text" placeholder="请输入用户名" value="${username}"/>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i class="icon-lock"></i></span><input id="password_hide" name="password_hide" class="required" type="text" placeholder="请输入密码" style="display:none;"><input id="password" name="password" class="required" type="password" name="pass" placeholder="请输入密码" />
                            </div>
                        </div>
                    </div>
                    <%-- <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend yzm">
                                <span class="add-on"><i class="icon-lock"></i></span><input type="text" placeholder="请输入验证码" />
                                <span class="login_yzm"><img src="${ctxStatic}/img/demo/yzm.png"></span>
                            </div>
                        </div>
                    </div> --%>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend yzm">
                                <span class="add-on"><i class="icon-lock"></i></span><input id="validateCode" name="validateCode" type="text" class="required" placeholder="请输入验证码" />
                                <span class="login_yzm"><img id="validateCode_img" src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$(this).attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());"></span>
                            </div>
                        </div>
                    </div> 
                  <%--  <div class=" validateCode" style="padding-left:30px;">
						<sys:validateCode name="validateCode" inputCssStyle="margin-top:-10px;;"/>
		
	                 </div> --%>
                    <div class="form-actions">
                        <span class="pull-left"><a href="#" class="flip-link" id="to-recover">忘记密码了?</a></span>
                        <span class="pull-right"><input type="submit" class="btn btn btn-warning" value="登录" /></span>
                    </div>
                </form>
                <form id="recoverform" action="#" class="form-vertical" >
                    <p>填写E-mail地址，我们将向您的邮箱中发送重置密码的链接地址。</p>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-prepend">
                                <span class="add-on"><i class="icon-envelope"></i></span><input type="text" placeholder="E-mail" />
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <span class="pull-left"><a href="#" class="flip-link" id="to-login">&lt; 返回登录</a></span>
                        <span class="pull-right"><input type="submit" class="btn btn-warning" value="重置密码" /></span>
                    </div>
                </form>
            </div>
        </div>
        <div class="silder">
            <ul>
                <li class="one"></li>
                <!--  li class="two"></li>
                <li class="three"></li>  -->
            </ul> 
            <div class="video_index_head_page"></div>
        </div>
        <div style="display:none;">
			 	 	<c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
				</div>
        <div class="copy_right">&copy;${fns:getConfig('copyrightYear')}&nbsp;浦发信用卡自动化测试平台 &nbsp;${fns:getConfig('version')}</div>
    <script>
        function slide($obj,$page,speed){
            var _len = $obj.find('li').size();
            var _pageHtml = '';
            var _cut = -1;
            var bodyBgArr = ['#a13d1b','#2b5f33','#e63041','#160700'];
            if(_len < 2){
                $obj.find('li').eq(0).css({'opacity':'1','z-index':'1'});
                return false;
            }else{
                for(var i = 0; i< _len; i++){
                    _pageHtml += '<span></span>';
                }

                $page.html(_pageHtml).find('span').eq(0).addClass('active');
                $obj.find('li').eq(0).css({'opacity':'1','z-index':'1'});

                var _autoSlide = setInterval(function(){
                    _cut ++;
                    _cut = _cut > _len ? 0 : _cut;
                    $obj.find('li').eq(_cut).stop().animate({opacity:1},800).css({"z-index": "1"}).siblings().animate({opacity: 0},800).css({"z-index":"0"});
                    $page.find('span').eq(_cut).addClass('active').siblings('span').removeClass('active');
                },speed);

                $obj.hover(function(){
                    clearInterval(_autoSlide);
                },function(){
                    _autoSlide = setInterval(function(){
                        _cut ++;
                        _cut = _cut > _len ? 0 : _cut;
                        //$obj.find('li').eq(_cut).siblings('li').fadeOut(800);
                        // $obj.find('li').eq(_cut).fadeIn(800);
                        $obj.find('li').eq(_cut).stop().animate({opacity:1},2000).css({"z-index": "1"}).siblings().animate({opacity: 0},2000).css({"z-index":"0"});
                        $page.find('span').eq(_cut).addClass('active').siblings('span').removeClass('active');
                        //$('body').animate({backgroundColor:bodyBgArr[_cut]},1500)
                    },speed);
                });

                $page.find('span').on('mouseenter',function(){
                    var _pageIndex = $(this).index();
                    _cut = _pageIndex;
                    $obj.find('li').eq(_cut).stop().animate({opacity:1},2000).css({"z-index": "1"}).siblings().animate({opacity: 0},2000).css({"z-index":"0"});
                    $page.find('span').eq(_cut).addClass('active').siblings('span').removeClass('active');
                    //$('body').animate({backgroundColor:bodyBgArr[_cut]},2000)
                })
            }
        }
        //首页顶部轮播
        slide($('.silder'),$('.video_index_head_page'),3000);
    </script>
    </body>
</html>