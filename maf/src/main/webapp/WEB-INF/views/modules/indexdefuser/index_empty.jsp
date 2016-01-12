<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html >
<head>
<title>首页</title>
<meta name="decorator" content="default"/>
<style type="text/css">
.empty-content{
	min-height:457px;
	background-color:#eeeeee;
	text-align:center;
	line-height:487px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$(".empty-content").css("minHeight",$('#mainFrame', parent.document).height());
	});
</script>
</head>

<body>
	<div class="empty-content">未进行首页配置,请管理员进行首页配置!</div>
</body>
</html>
