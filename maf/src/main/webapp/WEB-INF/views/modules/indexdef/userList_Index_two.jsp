
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<style>
.input-append {
  display: inline-block;
  margin-bottom: 10px;
  font-size: 0;
  white-space: nowrap;
  vertical-align: middle;
}
.btn{
  margin-left: -1px;
}
.input-append input,.index{
  position: relative;
  margin-bottom: 0;
  vertical-align: top;
  -webkit-border-radius: 0 4px 4px 0;
  -moz-border-radius: 0 4px 4px 0;
  border-radius: 0 4px 4px 0;
}
</style>
   <div class="new-update clearfix" id="form_info">
	    <div class="search_y">
	        <input class="search_input_y" name="name" placeholder="用户名称" type="text">
	        <button class="search_btn_y" onclick="clickSearchFn(this)">用户查询</button>
	    </div>
	</div>
		<c:forEach items="${Ulist}" var="user">
			<div id="form_info" class="control-group">
			<input type="hidden" name="offid" value="${user.office.id }"/>
			<input type="hidden" name="name" value="${user.name }"/>
				${user.office.name }:&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="clickSearchFn(this)">${user.name }</a><br/><br/><br/>
			</div>
		</c:forEach>

