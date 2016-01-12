<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	.form-horizontal .file-input{
		width:50px;
		height:50px;
		position:absolute;
		z-index:10;
		top:0px;
		left:0px;
		opacity:0;
		cursor:pointer;
	}
	.form-horizontal .photo-controls{
		position:relative;
		height:50px;
	}
	.photo-controls .phono-show{
		width:50px;
		height:48px;
		position:absolute;
		top:0px;
		left:0px;
		border:1px solid #ccc;
		background-color:#fff;
		cursor:pointer;
	}
	.photo-controls .photo-span{
		color:#ccc;
		margin-left:50px;
		float:none;
	}
	.form-horizontal img{
		width:50px;
		height:48px;
	}
	</style>
	<script type="text/javascript" src="${ctxStatic}/js1/ajaxfileupload.js"></script>
	<script type="text/javascript">
	var nowUrl="";
		$(document).ready(function() {
			/* $("#fileDiv").click(function(e){
				$("input[name='userPhotoName']").click();
			}); */
			$("input[name='userPhotoName']").on("change",function(){
				var url,
				$this = $(this);
				$showImg = $("#fileDivImg").find("img");
				if (navigator.userAgent.indexOf("MSIE")>=1) {//IE
					url = $(this).get(0).value;
					if(jQuery.browser.version == "10.0"||jQuery.browser.version == "11.0"){
						url = window.URL.createObjectURL($this.get(0).files.item(0));
					}
				}else{//Firefox & Chrome
					url = window.URL.createObjectURL($this.get(0).files.item(0));
				}
				if(url){
					$showImg.attr("src",url);
					nowUrl=url;
				}
			});
			$("#btnSubmit").click(function(){
				if(checked()){
					var param={};
					param["id"]=$("input[name='id']").val();
					param["email"]=$("input[name='email']").val();
					param["mobile"]=$("input[name='mobile']").val();
					param["phone"]=$("input[name='phone']").val();
					
					$.ajax({
						type: "post",
				        url: '${ctx}/sys/user/m/updateUser',
				        data:param,
				        dataType: "json",
				        ContentType:'application/x-www-form-urlencoded',
				        global:false,
				        success: function(data){ 
				        	console.info("data",data)
				        	if(data.code=="0"){
				        		if(nowUrl.length>0){
				    				$.ajaxFileUpload({
				    		            url: '${ctx}/sys/user/m/uploadUserPhoto', 
				    		            type: 'post',
				    		            secureuri: false, //一般设置为false
				    		            fileElementId: 'userPhotoName', // 上传文件的id、name属性名
				    		            dataType: 'json', //返回值类型，一般设置为json、application/json
				    		            success: function(data, status){ 
				    		            },
				    		            error: function(data, status, e){ 
				    		            }
				    		        });
				        		}
				        		$.jBox.success(data.message);
				        	}
				        	else{
				        		$.jBox.error(data.message);
				        	}
				        }
					});

				}
			})
		});
		function checked(){
			if($("#method").val()!="syn"){
			var tempVals = $("input[name='mobile']").val();
			if(tempVals.length < 11 || !(/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(tempVals))){ 
				$.jBox.error("请填写正确的手机号码!","提示");
			    $("#mobile").focus(); 
			    return false; 
			} 
			}
			return true;
		}
	</script>
</head>
<body>
	 <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/webPanel/webUserForm">个人信息</a></li>
		<li><a href="${ctx}/webPanel/webUserPs">修改密码</a></li>
	</ul><br/>
	<form id="inputForm"  class="form-horizontal" enctype="multipart/form-data">
		<div class="control-group">
			<label class="control-label">头像:</label>
			<div class="controls photo-controls">
				<input  id="userPhotoName" type="file" name="userPhotoName" id="userPhotoName" class="file-input" accept="image/gif, image/jpeg,image/png">
				<div id="fileDivImg" class="phono-show"><img src="${empty fns:getUser().photo?( '${ctxStatic}/img/demo/user_1.png'): fns:getUser().photo}"/></div> 
				<span class="photo-span">(点击头像进行图片上传)</span>
			</div>
		</div>
	</form>
	<form   class="form-horizontal">
		<input type="hidden" name="id" value="${fns:getUser().id}"/>
		<input type="hidden" id="method" name="method" value="sub"/>
		<div class="control-group">
			<label class="control-label">公司名称:</label>
			<div class="controls">
				<label class="lbl">${fns:getUser().company}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<input type="text" name="name" maxlength="50" class="required" readonly="true" value="${fns:getUser().name}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="text" value="${fns:getUser().loginName}" readonly="true">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<input  name="email" type="text" maxlength="100" class="email" value="${fns:getUser().email}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<input  name="phone" type="text" maxlength="15" value="${fns:getUser().phone}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<input  name="mobile" type="text" maxlength="11" class="required" value="${fns:getUser().mobile}">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>