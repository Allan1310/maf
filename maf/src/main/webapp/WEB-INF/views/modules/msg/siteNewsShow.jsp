<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${siteNews.title }</title>
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		
	</script>
	
	<style>
	
	@media screen and (max-width:1000px){
		.main{width:100%; }	

	}
	@media screen and (min-width:1000px){
		.main{width:1000px; }
	}
	</style>
</head>
<body>
	<div style="margin-top:20px;margin-left:10px;margin-right:10px;">
	<table class="main" style="background: #fff;MARGIN-RIGHT: auto; MARGIN-LEFT: auto; " >
		<thead>
			<tr style="font-family:黑体;height:60px;">
				<th style="vertical-align:middle; text-align:center;font-size:20px;" colspan="3" >${siteNews.title }</th>
				<th style="width:10%;max-width:160px;vertical-align:middle; text-align:right;border-left-style:none;"><img width="152px;" height="40px;" src="${ctxStatic }/images/logo.gif"/></th>
			</tr>
		</thead>
		<tbody>
			<tr style="border-bottom: 1px solid #ddd;height:10px; text-align:center;"><td colspan="4" ><fmt:formatDate value="${siteNews.newsDate}" pattern="yyyy-MM-dd"/></td></tr>
			<tr><td colspan="4">&nbsp;</td></tr>
			<tr>
				<td colspan="4">
					<div style="min-height:200px;margin:10px;">
					${siteNews.content}
					</div>
				</td>
			<tr>
			<c:if test="${not empty siteNews.files}">
				<tr>
					<td colspan="4">
					<input type="hidden" id="files" value="${siteNews.files}" />
					<sys:ckfinder input="files" type="files" uploadPath="/site/siteNews" readonly="true"/>					
				</td>
				<tr>
				
			</c:if>
		</tbody>
	</table>
	</div>
</body>
</html>

