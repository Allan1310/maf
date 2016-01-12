<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<meta http-equiv="Cache-Control" content="no-store" /><meta http-equiv="Pragma" content="no-cache" /><meta http-equiv="Expires" content="0" />
<meta name="author" content="peng.liao"/><meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10" />
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.method.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<!--[if lte IE 6]><link href="${ctxStatic}/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script><![endif]-->
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/common/oa.min.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/bootstrap.css" type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/css/main.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/common/oa.min.js" type="text/javascript"></script>
<%
if (request.getAttribute("from_protal") != null) {
	response.sendRedirect((String)request.getAttribute("from_protal"));
}
%>
<html>
<head>
	<title>${fns:getConfig('productName')} - 登录  - 通联金融科技</title>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
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
	
	<!-- login-wrapper start -->
<div class="login-wrapper">
	<!--[if lte IE 8]><div class='alert alert-block' style="text-align:left;padding-bottom:10px;margin:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您升级到 IE9 及以上的版本，或者使用较新版本的 Chrome、Firefox、Safari 等浏览器。使用360浏览器、猎豹浏览器也需要升级IE。 <a href="http://browsehappy.com" target="_blank" class="btn btn-info"><i class="icon-arrow-up"></i>点此下载升级</a> </p></div><![endif]-->
	
    <div class="login">
    	<div class="header">
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
		</div>
    	<div class="well">
    	
            <div class="navbar2"></div>
           
			<form id="loginForm" class="row-fluid" action="${ctx}/login" method="post" >
				<div class="control-group">
                    <div class="controls"><input id="username" name="username" class="span12 required" type="text" placeholder="用户名"  value="${username}"/></div>
                </div>
                <div class="control-group">
                    <div class="controls"><input id="password" name="password" class="span12 required" type="password" name="pass" placeholder="密码" /></div>
                </div>
                <c:if test="${isValidateCodeLogin}">
                
                 <div class=" validateCode" style="padding-left:30px;">
                 	<label for="validateCode">验证码</label>
					<tags:validateCode name="validateCode" inputCssStyle="margin-top:-10px;;"/>
	
                 </div>
				</c:if>
                <div class="control-group float_r">
                    <div class="controls"><label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe" class="inline"/> 记住我</label> | <label class=" inline" title="公司门户"><a target="_blank" href="http://www.allinfnt.com/">公司门户</a> </label> | <label class=" inline" title="电子邮箱"><a target="_blank" href="https://mail.allinfnt.com/owa">电子邮箱</a> </label> </div>
                </div>
			 	<div style="display:none;">
			 	 	<c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
				</div>
                <div class="login-btn"><input type="submit" value="  登录  " class="btn btn-warning btn-large "/></div>
			</form>
		</div>
	</div>
	
</div>
</body>
</html>