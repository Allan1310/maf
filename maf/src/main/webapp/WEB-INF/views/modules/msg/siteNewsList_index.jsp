<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
		<c:if test="${empty page.list }">
			<div class="new-update clearfix">
			    <div class="span4">暂时没有相关信息！</div>
			</div>
		</c:if>
		<c:forEach items="${page.list}" var="siteNews" varStatus="varstatus">
		<c:if test="${varstatus.index+1<6 }">
			
			<div class="new-update clearfix">
			    <div class="span4"><a href="${ctx}/site/siteNews/show?id=${siteNews.id}" target="_blank">${siteNews.title }</a></div>
			</div>
		</c:if>
		</c:forEach>
	<div class="new-update clearfix moreDetail"><a href="${ctx}/site/siteNews/reNews" target="mainFrame">显示更多</a></div>
</body>
</html>