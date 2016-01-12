
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
<script type="text/javascript">
$(document).ready(function() {
	$("#name").val("");
	var userid = $("#userid").val();
	if(userid == "1"){
		$("#show").hide();
		$("#index").show();
	}else{
		$("#index").hide();
		$("#show").show();
	}
});
</script>

   <div class="new-update clearfix" id="form_info" style="border:0px;">
	    <div class="search_y">
	        <input class="search_input_y" name="name" placeholder="用户姓名" type="text">
	        <button class="search_btn_y" onclick="clickSearchFn(this)">用户查询</button>
	    </div>
	</div>
		<c:forEach items="${list}" var="user">
		 <input id="userid" type="hidden" value="${user.no}"/>
			<div id="index" class="control-group" >
					电话：${user.phone }</br></br>
					传真：${user.mobile }</br></br>
					邮箱：${user.email}</br></br>
					地址：${user.name}
			</div>
			<div id="show" class="control-group" >
					姓名：${user.name }</br></br>
					电话：${user.phone }</br></br>
					手机：${user.mobile}</br></br>
					邮箱：${user.email}
			</div>
		</c:forEach>
		
