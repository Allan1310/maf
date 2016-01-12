<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/static/jquery/jquery-1.8.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
	function mobileAjax(){
		/* $.ajax({
			type: "post",
	        async: false,
	        url:  "http://localhost:8080/idc/a/sys/dict/listData;JSESSIONID=1?__ajax=true",
	        dataType:'json',
	        data:{
	        	"type":"region_type"
	       	},
	        success: function (responseJSON) {
	        	alert(responseJSON);
	        },
	        error: function () {
	          
	        }
	    }); */
		$.ajax({
			type: "post",
	        async: false,
	        url:  "http://localhost:8080/idc/a/sys/dict/getDictLabel;JSESSIONID=1?__ajax=true",
	        dataType:'json',
	        data:{
	        	"value":"1",
	        	"type":"visitor_type",
	        	"defaultValue":"1"
	       	},
	        success: function (responseJSON) {
	        	alert(responseJSON[0]);
	        },
	        error: function () {
	        	alert("error");
	        }
	    });
	}
</script>
<input type="button" name = "button" value="提交" onclick="mobileAjax()"/>
<form action="http://localhost:8080/idc/a/sys/user/m/uploadUserPhone" method="post" enctype="multipart/form-data">
	<input type="file" name="userPhotoName"/>
	<input type="submit" name="submit" value="提交"/>
</form>
</body>
</html>