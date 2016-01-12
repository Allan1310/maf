<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>Insert title here</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cm/cmPropertyGroup/">分类属性关系列表</a></li>
	</ul>
	<div class="container-fluid">
		
	  	<div class="row-fluid">
	    	<div class="span2">
	    		
	    	</div>
	    	<div class="span10">
	    	</div>
	  	</div>
	</div>
	<sys:message content="${message}"/>
<div class="pagination">${page}</div>
</body>
</html>