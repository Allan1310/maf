<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项图标管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var oldIdValue = top.mainFrame.cmCiGroupContent.$("#iconId").val();
			$("input[name=icon]").each(function(){
				$(this).click(function(){
					var id = $(this).val(), title = $(this).attr("title");
					if($(this).attr("checked")){
						top.mainFrame.cmCiGroupContent.selectGroupIcon(id,title);
					}
					
				});
				
			});
			
			$("input[name=icon]").each(function(){
				var id = $(this).val();
				if(oldIdValue==id){
					$(this).attr("checked",true);
				}
			});
		});
	</script>
</head>
<body>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tbody>
		<c:forEach items="${graphIcons}" var="graphIcon" varStatus="status" >
			<c:if test="${(status.index+1)%4 == 1 }">
				<tr>
			</c:if>
			
				<td style="text-align: center;">
					<img src="${graphIcon.iconFile }"  style="max-width:60px;max-height:60px;_height:60px;border:0;padding:3px;"><br>
					<input type="radio" name="icon" value="${graphIcon.id }" title="${graphIcon.iconName }">
				</td>
				
			<c:if test="${(status.index+1)%4 == 0 }">
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>