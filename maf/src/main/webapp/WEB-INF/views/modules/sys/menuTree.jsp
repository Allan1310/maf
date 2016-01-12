<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	//左侧菜单收缩样式
	var itemCount = $("#menu-${param.parentId} .leftMenu-item").length;
	var subHeight = $(".leftMenu").height() - 35 * itemCount;
	$("#menu-${param.parentId} .subMenu").height(subHeight);
	$(".leftMenu-item").click(function(){
		$(this).next().siblings(".subMenu").hide(600);
		$(this).next().show(600);
	})
	
	//点击左侧菜单样式
	$(".subMenu-item").click(function(){
		$(".subMenu-item").removeClass("subMenu-selected");
		$(this).addClass("subMenu-selected");
		
		$("#index-child-info").text($(this).find("div").text());
	});
	
});
</script>

<div id="menu-${param.parentId}" class="menuTree">
	<c:set var="menuList" value="${fns:getMenuList()}"/>
	<c:set var="firstMenu" value="true"/>
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
		<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
			<a class="leftMenu-item" data-parent="#menu-${param.parentId}" data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}">
				<i class="icon icon-${not empty menu.icon ? menu.icon : 'circle-arrow-right'}"></i><div>${menu.name}</div>
			</a>
			<div class="subMenu ${not empty firstMenu && firstMenu ? 'show' : ''}">
				<c:forEach items="${menuList}" var="menu2">
					<c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
						<a class="subMenu-item ${not empty firstMenu && firstMenu ? 'subMenu-selected' : ''}" data-href=".menu3-${menu2.id}" href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}">
							<i></i><div>${menu2.name}</div>
							<c:set var="firstMenu" value="false"/>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</c:if>
	</c:forEach>
</div>





	 