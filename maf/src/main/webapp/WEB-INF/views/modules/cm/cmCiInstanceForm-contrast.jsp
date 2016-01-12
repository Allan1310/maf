<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var newObject="";
			<c:forEach items="${leftTYProperty }" var="ciProperty">
				newObject="";
			</c:forEach>
		});
	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="cmCiInstance" action="${ctx}/cm/cmCiInstance/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<div id="tyDiv">
		<table class="table  table-bordered">
			<tr><th colspan="3">通用属性</th></tr>
			<c:if test="${leftCiInstance.ciVersion != rightCiInstance.ciVersion }">
			<tr class="error">
	 			<td width="30%" style="text-align: center;">配置项版本</td>
	 			<td width="35%" style="text-align: center;">${leftCiInstance.ciVersion}</td>
	 			<td width="35%" style="text-align: center;">${rightCiInstance.ciVersion}</td>
	 		</tr>
			</c:if>
			<c:if test="${leftCiInstance.ciVersion == rightCiInstance.ciVersion }">
			<tr  class="success">
	 			<td width="30%" style="text-align: center;">配置项版本</td>
	 			<td width="35%" style="text-align: center;">${leftCiInstance.ciVersion}</td>
	 			<td width="35%" style="text-align: center;">${rightCiInstance.ciVersion}</td>
	 		</tr>
			</c:if>
			<c:forEach items="${leftTYProperty }" var="leCiProperty">
				<c:forEach items="${rightTYProperty }" var="riCiProperty">
					<c:if test="${leCiProperty.id == riCiProperty.id }">
						<c:if test="${leCiProperty.propertyValue != riCiProperty.propertyValue }">
						<tr class="error">
				 			<td width="30%" style="text-align: center;">${leCiProperty.property.propertyName}</td>
				 			<td width="35%" style="text-align: center;">${leCiProperty.propertyValue}</td>
				 			<td width="35%" style="text-align: center;">${riCiProperty.propertyValue}</td>
				 		</tr>
						</c:if>
						<c:if test="${leCiProperty.propertyValue == riCiProperty.propertyValue }">
						<tr  class="success">
				 			<td width="30%" style="text-align: center;">${leCiProperty.property.propertyName}</td>
				 			<td width="35%" style="text-align: center;">${leCiProperty.propertyValue}</td>
				 			<td width="35%" style="text-align: center;">${riCiProperty.propertyValue}</td>
				 		</tr>
						</c:if>
					</c:if>
		 		</c:forEach>
	 		</c:forEach>
	 	</table>
		</div>
		<div id="zyDiv">
		<table class="table  table-bordered">
			<tr><th colspan="3">专有属性</th></tr>
			<c:forEach items="${zyProperty }" var="contrast">
				<c:if test="${contrast.is_equal == false }">
					<tr class="error">
			 			<td width="30%" style="text-align: center;">${contrast.proertyName}</td>
			 			<td width="35%" style="text-align: center;">${contrast.propertyLfValue}</td>
			 			<td width="35%" style="text-align: center;">${contrast.propertyRgValue}</td>
			 		</tr>
					</c:if>
					<c:if test="${contrast.is_equal == true }">
					<tr  class="success">
			 			<td width="30%" style="text-align: center;">${contrast.proertyName}</td>
			 			<td width="35%" style="text-align: center;">${contrast.propertyLfValue}</td>
			 			<td width="35%" style="text-align: center;">${contrast.propertyRgValue}</td>
			 		</tr>
					</c:if>
	 		</c:forEach>
		</table>
		</div>
	</form:form>
</body>
</html>