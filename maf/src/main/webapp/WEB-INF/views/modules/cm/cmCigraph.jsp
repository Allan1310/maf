<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>配置项关联管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/common/base.css">
	<link href="${ctxStatic}/jquery.snippet/jquery.snippet.min.css" rel="stylesheet">
	<script src="${ctxStatic}/common/site.js"></script>
	<script type="text/javascript" src="${ctxStatic}/jquery.snippet/jquery.snippet.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/jTopo/jtopo-min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/toolbar/toolbar.js"></script>
	<script type="text/javascript" id='code'>
		var scene;
		var stage;
		$(document).ready(function() {
			
			var canvas = document.getElementById('canvas');
			stage = new JTopo.Stage(canvas);
			//显示工具栏
			showJTopoToobar(stage);
			
			scene = new JTopo.Scene();	
			stage.add(scene);
			//scene.background = '${ctxStatic}/images/graph/bg2.jpg';
			//scene.backgroundColor ='#AFADAC';
			var type = $("#graphShowType").val();
			if(type == 'circle'){
				showCircleGraph(scene);
			}else if(type == 'tree'){
				showTreeGraph(scene);
			}
			
			
			
		});
		
		//创建新的连线
		function newLink(nodeA, nodeZ, text,scene){
            var link = new JTopo.Link(nodeA, nodeZ, text);        
            link.lineWidth = 2; // 线宽
            link.arrowsRadius = 10; //箭头大小
            link.bundleOffset = 60; // 折线拐角处的长度
            link.bundleGap = 20; // 线条之间的间隔
            link.textOffsetY = 3; // 文本偏移量（向下3个像素）
            link.fontColor = "0,0,0";
            if(text == '应用于'){
            	link.strokeColor = '156,102,31';
            }else if(text == '依赖于'){
            	link.strokeColor = '64,224,205';
            }else if(text == '安装于'){
            	link.strokeColor = '34,139,34';
            }else if(text == '安装于'){
            	link.strokeColor = '107,142,35';
            }else if(text == '部署于'){
            	link.strokeColor = '3,168,158';
            }else if(text == '绑定在'){
            	link.strokeColor = '25,25,112';
            }else if(text == '存储连接'){
            	link.strokeColor = '0,199,140';
            }else if(text == '网络连接'){
            	link.strokeColor = '153,51,250';
            }else if(text == '上行连接'){
            	link.strokeColor = '218,112,214';
            }else if(text == '逻辑连接'){
            	link.strokeColor = '199,97,20';
            }else if(text == '虚拟连接'){
            	link.strokeColor = '188,143,143';
            }else if(text == '由其组成'){
            	link.strokeColor = '210,180,140';
            }else if(text == '被划分成'){
            	link.strokeColor = '128,42,42';
            }else if(text == '热备'){
            	link.strokeColor = '255,215,0';
            }else if(text == '热备'){
            	link.strokeColor = '250,240,230';
            }else{
            	link.strokeColor = '0,200,255';
            }
            scene.add(link);
        }
		
		function showCiInstance(idx,type){
			var htmlObject="";
			hideDIV("del");
			<c:forEach items="${newRelations}" var="cmCiRelation" varStatus="status">
				if('${cmCiRelation.id }' == idx){
					
					if('${cmCiRelation.remarks}' == '正'){
						if(type == 're'){
							htmlObject="<tr id='instance1'><td>配置项编号：</td><td><a href='${ctx}/cm/cmCiInstance/form?id=${cmCiRelation.reCiInstance.id}&view=view'>${cmCiRelation.reCiInstance.ciNumber}</a></td></tr>"+
									   "<tr id='instance2'><td>配置项名称：</td><td>${cmCiRelation.reCiInstance.ciName}</td></tr>";
						}else{
							htmlObject="<tr id='instance1'><td>配置项编号：</td><td><a href='${ctx}/cm/cmCiInstance/form?id=${cmCiRelation.ciInstance.id}&view=view'>${cmCiRelation.ciInstance.ciNumber}</a></td></tr>"+
							   		   "<tr id='instance2'><td>配置项名称：</td><td>${cmCiRelation.ciInstance.ciName}</td></tr>";
						}
					}else{
						if(type == 're'){
							htmlObject="<tr id='instance1'><td>配置项编号：</td><td><a href='${ctx}/cm/cmCiInstance/form?id=${cmCiRelation.ciInstance.id}&view=view'>${cmCiRelation.ciInstance.ciNumber}</a></td></tr>"+
									   "<tr id='instance2'><td>配置项名称：</td><td>${cmCiRelation.ciInstance.ciName}</td></tr>";
						}else{
							htmlObject="<tr id='instance1'><td>配置项编号：</td><td><a href='${ctx}/cm/cmCiInstance/form?id=${cmCiRelation.reCiInstance.id}&view=view'>${cmCiRelation.reCiInstance.ciNumber}</a></td></tr>"+
							   		   "<tr id='instance2'><td>配置项名称：</td><td>${cmCiRelation.reCiInstance.ciName}</td></tr>";
						}
					}
				}
			</c:forEach>
			
			$("#ciInstance tr:last").after(htmlObject);
			$("#ciInstance").show();
		}
		
		function hideDIV(type){
			if(type == 'del'){
				$("#instance1").remove();
	            $("#instance2").remove();
			}else{
				$("#ciInstance").hide();
			}
			
            
		}
		
		function showCircleGraph(scene){
			
			
			var node;
			var instanceId;
			
			var currentNode = null;
			var size = '${size}';
			
			var m = 360/Number(size);
			
			<c:forEach items="${newRelations}" var="cmCiRelation" varStatus="status">
				if('${status.index+1 }' == '1'){
					node = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
					if('${cmCiRelation.remarks}' == '正'){
						node = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						node.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}else{
						node = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						node.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}
					node.setLocation(500,250);			
					node.fontColor = "0,0,0";
					node.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.ciInstance.id}';
						}else{
							instanceId = '${cmCiRelation.reCiInstance.id}';
						}
		            });
					
					node.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"noRe");
		            });
					scene.add(node);
					var vmNode;
					if('${cmCiRelation.remarks}' == '正'){
						vmNode = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}else{
						vmNode = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}
					
					vmNode.fontColor = "0,0,0";
					vmNode.fillStyle = '255,255,0';
					vmNode.setLocation(500 + Math.cos(2*Math.PI /360) * 200 , 250 + Math.sin(2*Math.PI /360) * 200);
					scene.add(vmNode);
					
					if('${cmCiRelation.remarks}' == '正'){
						newLink(vmNode,node ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}',scene);
					}else{
						newLink(node,vmNode ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}',scene);
					}
					vmNode.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.reCiInstance.id}';
						}else{
							instanceId = '${cmCiRelation.ciInstance.id}';
						}
		            });
					
					vmNode.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"re");
		            });
				}else{
					
					var vmNode;
					if('${cmCiRelation.remarks}' == '正'){
						vmNode = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}else{
						vmNode = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}
						
					vmNode.fontColor = "0,0,0";
					vmNode.fillStyle = '255,255,0';
					vmNode.setLocation(500 + Math.cos(2*Math.PI /360*m*Number('${status.index}')) * 200 , 250 + Math.sin(2*Math.PI /360*m*Number('${status.index}')) * 200);
					scene.add(vmNode);								
					if('${cmCiRelation.remarks}' == '正'){
						newLink(vmNode,node ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}',scene);
					}else{
						newLink(node,vmNode ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}',scene);
					}
					vmNode.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.reCiInstance.id}';
						}else{
							instanceId = '${cmCiRelation.ciInstance.id}';
						}
		            });
					
					vmNode.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"re");
		            });
				}
			</c:forEach>
			
			stage.click(function(event){
		        if(event.button == 0){// 右键
		            // 关闭弹出菜单（div）
		            $("#contextmenu").hide();
		        }
		    });
			
			$("#contextmenu a").click(function(){
		        var text = $(this).text();
		        
		        if(text == '更改颜色'){
		            currentNode.fillColor = JTopo.util.randomColor();
		        }else if(text == '顺时针旋转'){
		            currentNode.rotate += 0.5;
		        }else if(text == '逆时针旋转'){
		            currentNode.rotate -= 0.5;
		        }else if(text == '放大'){
		            currentNode.scaleX += 0.2;
		            currentNode.scaleY += 0.2;
		        }else if(text == '缩小'){
		            currentNode.scaleX -= 0.2;
		            currentNode.scaleY -= 0.2;
		        }else if(text == '查看关联项'){
		        	location.href = '${ctx}/cm/cmCiRelation/graph?ciInstance.id='+instanceId;
		        }
		        $("#contextmenu").hide();
		    });
			
			 function handler(event){
		        if(event.button == 2){// 右键
		            // 当前位置弹出菜单（div）
		            $("#contextmenu").css({
		                top:event.pageY,
		                left:event.pageX
		            }).show();    
		        }
		    }
			 
		}
		
		function showTreeGraph(scene){
			var node;
			var currentNode = null;
			var instanceId;
			
			var size = '${size}';
			var numX;
			if(size%2!=0){
				numX = 1000/(Number(size)+1)
			}else{
				numX = 1000/Number(size)
			}
			
			<c:forEach items="${newRelations}" var="cmCiRelation" varStatus="status">
				if('${status.index+1 }' == '1'){
					node = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
					if('${cmCiRelation.remarks}' == '正'){
						node = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						node.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}else{
						node = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						node.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}
						
					node.fontColor = "0,0,0";
					node.setLocation(500,150);	
					node.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.ciInstance.id}';
						}else{
							instanceId = '${cmCiRelation.reCiInstance.id}';
						}
		            });
					
					node.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"noRe");
		            });
					scene.add(node);
					var vmNode;
					if('${cmCiRelation.remarks}' == '正'){
						vmNode = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}else{
						vmNode = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}
					
					vmNode.fontColor = "0,0,0";
					vmNode.setLocation(numX*'${status.index +1}',300);
					scene.add(vmNode);
					
					if('${cmCiRelation.remarks}' == '正'){
						addLink(vmNode,node ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}');
					}else{
						addLink(node,vmNode ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}');
					}
					vmNode.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.reCiInstance.id}';
						}else{
							instanceId = '${cmCiRelation.ciInstance.id}';
						}
		            });
					
					vmNode.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"re");
		            });
				}else{
					
					var vmNode;
					if('${cmCiRelation.remarks}' == '正'){
						vmNode = new JTopo.Node('${cmCiRelation.reCiInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.reCiInstance.cmGraphIcon.iconFile }', true);
					}else{
						vmNode = new JTopo.Node('${cmCiRelation.ciInstance.ciNumber}');
						vmNode.setImage('${cmCiRelation.ciInstance.cmGraphIcon.iconFile }', true);
					}
					
					vmNode.fontColor = "0,0,0";
					vmNode.setLocation(numX*'${status.index+1 }',300);
					scene.add(vmNode);								
					if('${cmCiRelation.remarks}' == '正'){
						addLink(vmNode,node ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}');
					}else{
						addLink(node,vmNode ,'${fns:getDictLabel(cmCiRelation.relationType,'ci_relation_type',cmCiRelation.relationType)}');
					}
					vmNode.addEventListener('mouseup', function(event){
		                currentNode = this;
		                handler(event);
		                if('${cmCiRelation.remarks}' == '正'){
		                	instanceId = '${cmCiRelation.reCiInstance.id}';
						}else{
							instanceId = '${cmCiRelation.ciInstance.id}';
						}
		            });
					
					vmNode.addEventListener('click', function(event){
						showCiInstance('${cmCiRelation.id}',"re");
		            });
				}
			</c:forEach>
            
            function addLink(nodeA, nodeZ,text){
                var link = new JTopo.FlexionalLink(nodeA, nodeZ,text);
                link.arrowsRadius = 10; //箭头大小
                link.bundleOffset = 10; // 折线拐角处的长度
                link.offsetGap = 30;
                link.fontColor = "0,0,0";
                if(text == '应用于'){
                	link.strokeColor = '156,102,31';
                }else if(text == '依赖于'){
                	link.strokeColor = '64,224,205';
                }else if(text == '安装于'){
                	link.strokeColor = '34,139,34';
                }else if(text == '安装于'){
                	link.strokeColor = '107,142,35';
                }else if(text == '部署于'){
                	link.strokeColor = '3,168,158';
                }else if(text == '绑定在'){
                	link.strokeColor = '25,25,112';
                }else if(text == '存储连接'){
                	link.strokeColor = '0,199,140';
                }else if(text == '网络连接'){
                	link.strokeColor = '153,51,250';
                }else if(text == '上行连接'){
                	link.strokeColor = '218,112,214';
                }else if(text == '逻辑连接'){
                	link.strokeColor = '199,97,20';
                }else if(text == '虚拟连接'){
                	link.strokeColor = '188,143,143';
                }else if(text == '由其组成'){
                	link.strokeColor = '210,180,140';
                }else if(text == '被划分成'){
                	link.strokeColor = '128,42,42';
                }else if(text == '热备'){
                	link.strokeColor = '255,215,0';
                }else if(text == '热备'){
                	link.strokeColor = '250,240,230';
                }else{
                	link.strokeColor = '0,200,255';
                }
                link.lineWidth = 1;
                scene.add(link);
                return link;
            }
            
            stage.click(function(event){
		        if(event.button == 0){// 右键
		            // 关闭弹出菜单（div）
		            $("#contextmenu").hide();
		        }
		    });
			
			$("#contextmenu a").click(function(){
		        var text = $(this).text();
		        if(text == '更改颜色'){
		            currentNode.fillColor = JTopo.util.randomColor();
		        }else if(text == '顺时针旋转'){
		            currentNode.rotate += 0.5;
		        }else if(text == '逆时针旋转'){
		            currentNode.rotate -= 0.5;
		        }else if(text == '放大'){
		            currentNode.scaleX += 0.2;
		            currentNode.scaleY += 0.2;
		        }else if(text == '缩小'){
		            currentNode.scaleX -= 0.2;
		            currentNode.scaleY -= 0.2;
		        }else if(text == '查看关联项'){
		        	location.href = '${ctx}/cm/cmCiRelation/graph?ciInstance.id='+instanceId;
		        }
		        
		        $("#contextmenu").hide();
		    });
			
			 function handler(event){
		        if(event.button == 2){// 右键
		            // 当前位置弹出菜单（div）
		            $("#contextmenu").css({
		                top:event.pageY,
		                left:event.pageX
		            }).show();    
		        }
		    }
		}
		
		function graphShowType(){
			var type = $("#graphShowType").val();
			if(type == 'circle'){
				scene.clear();
				showCircleGraph(scene);
			}else if(type == 'tree'){
				scene.clear();
				showTreeGraph(scene);
			}
		}
	</script>
	<style type="text/css">
	#contextmenu {
		border: 1px solid #aaa;
		border-bottom: 0;
		background: #eee;
		position: absolute;
		list-style: none;
		margin: 0;
		padding: 0;
		display: none;
	}
																			   
	#contextmenu li a {
		display: block;
		padding: 10px;
		border-bottom: 1px solid #aaa;
		cursor: pointer;
	}
																			   
	#contextmenu li a:hover {
		background: #fff;
	}
	#ciInstance{ 
		position:fixed; 
		top:35%; 
		left:85%; 
		width:15%;
		height:300px;
		background-color:white; 
		z-index:1002; 
		overflow:auto;
		box-shadow: 0 0 3px #000;
		}
	</style>
</head>
<body>
<ul class="nav nav-tabs">
	<li style="font-size: 12px;"><a href="${ctx}/cm/cmCiInstance/">配置项列表</a></li>
	<li style="font-size: 12px;"><a href="${ctx}/cm/cmCiInstance/form?id=${ciInstance.id}&view=view">配置项查看<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	<li style="font-size: 12px;"><a href="${ctx}/cm/cmCiInstance/listVersion?id=${ciInstance.id}">配置项版本<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	<li style="font-size: 12px;"><a href="${ctx}/cm/cmCiRelation?ciInstance.id=${ciInstance.id}">关联配置项<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	<li style="font-size: 12px;"><a href="${ctx}/cm/cmRelationOrder/list?ciInstance.id=${ciInstance.id}">关联工单<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
	<li style="font-size: 12px;" class="active"><a href="${ctx}/cm/cmCiRelation/graph?ciInstance.id=${ciInstance.id}">配置项拓扑图<shiro:hasPermission name="cm:cmCiInstance:view"></shiro:hasPermission></a></li>
</ul>
<ul id="contextmenu" style="display:none;">	
	<li><a>顺时针旋转</a></li>
	<li><a>逆时针旋转</a></li>	
	<li><a>更改颜色</a></li>
	<li><a>放大</a></li>
	<li><a>缩小</a></li>
	<li><a>查看关联项</a></li>
</ul>
<div id="ciInstance" style="display: none;">
	<table class="table">
		<tr><th colspan="2">配置项信息&nbsp;&nbsp;&nbsp;<a onclick="hideDIV('hide')">关闭</a></th></tr>
	</table>
</div>
<center>
<div class="wrap_div">
	<div class="content">
		<div class="right" class="content">
	  	<div id="content" class="content">
			<canvas id="canvas" width="1167px;" height="600px;"></canvas>	
		</div>
		</div>
	  <div class="clear"></div>
	</div>
</div>
</center>
</body>
</html>