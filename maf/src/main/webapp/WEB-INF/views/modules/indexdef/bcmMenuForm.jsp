<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首页自定义配置管理</title>
	<meta name="decorator" content="default"/>
	
	<script type="text/javascript">
		$(function(){
			$("#cp5").colorpicker({
	            fillcolor:true,
	            event:'mouseover',
	            target:$("#pcolor"),
	            success:function(o,color){
	            	top.mainFrame.document.getElementById("pcolor").value = color;
	            }
	        });
			$("#pcolor").colorpicker({
	            fillcolor:true,
	            event:'click',
	            target:$("#pcolor"),
	            success:function(o,color){
	            	top.mainFrame.document.getElementById("pcolor").value = color;
	            }
	        });
		});
	</script>
	<script type="application/javascript" src="${ctxStatic}/js1/jquery.colorpicker.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

			$(".color-select").click(function(){
				$("#pcolor").val( $(this).text());
			})
			
		});
		function setLinkUrl(e){
			 $.ajax({
		        type: "get",
		        url: "${ctx}"+'/indexdef/bcmMenu/linkurldata',
		        data: {"menuId":$(e).val()},
		        dataType: "text",
		        global:false,
		        success: function(dataAll){ 
		        	$("#linkUrl").val(dataAll);
		        }
	       });
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/indexdef/bcmMenu/">首页模块列表</a></li>
		<li class="active"><a href="${ctx}/indexdef/bcmMenu/form?id=${bcmMenu.id}">首页模块<shiro:hasPermission name="indexdef:bcmMenu:edit">${not empty bcmMenu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="indexdef:bcmMenu:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bcmMenu" action="${ctx}/indexdef/bcmMenu/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">菜单名称：</label>
			<div class="controls">
				<form:select path="menuId" class="input-xlarge required" onchange="setLinkUrl(this)">
					<form:option value="" label=""/>
					<form:options items="${menuList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group hide">
				<label class="control-label">链接地址：</label>
				<div class="controls">
					<input id="linkUrl" name="linkUrl" class="required" readonly="readonly" type="text" value="${bcmMenu.menu.href}" maxlength="200" style="width:255px;">
				</div>
		</div>
		<div class="control-group ">
			<label class="control-label">默认显示：</label>
			<div class="controls">
				<form:select path="menuShow" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">是否放大：</label>
			<div class="controls">
				<form:select path="menuExpandType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">是否刷新：</label>
			<div class="controls">
				<form:select path="menuReloadType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">是否收缩：</label>
			<div class="controls">
				<form:select path="menuHideType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">是否关闭：</label>
			<div class="controls">
				<form:select path="menuCloseType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
				<label class="control-label">模块颜色：</label>
				<div class="controls">
					<input id="pcolor" name="modelColor"  value="${bcmMenu.modelColor}" readonly="readonly"
					style="color:${empty bcmMenu.modelColor?'': bcmMenu.modelColor};width:255px;height:20px;line-height: 20px;padding: 4px 6px 4px 6px;border: 1px solid #ccc;border-radius: 4px;box-shadow:inset 0px 1px 1px rgba(0,0,0,0.075)"/>			
					<img src="${ctxStatic }/js/colorpicker.png" id="cp5" style="cursor:pointer"/>
					&nbsp;
					<span class="color-select" style="background-color: #8E44AD;color: #fff;padding:4px;margin-left:5PX;">#8E44AD</span>
					<span class="color-select" style="background-color: #00ACAC;color: #fff;padding:4px;margin-left:5PX;">#00ACAC</span>
					<span class="color-select" style="background-color: #F59C1A;color: #fff;padding:4px;margin-left:5PX;">#F59C1A</span>
					<span class="color-select" style="background-color: #FF5B57;color: #fff;padding:4px;margin-left:5PX;">#FF5B57</span>
					<span class="color-select" style="background-color: #1EB9EE;color: #fff;padding:4px;margin-left:5PX;">#1EB9EE</span>
					
				</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="indexdef:bcmMenu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>