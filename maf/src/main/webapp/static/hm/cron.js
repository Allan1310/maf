/**
 * 每周期
 */
function everyTime(dom) {
	var item = $("input[name=v_" + dom.name + "]");
	item.val("*");
	item.change();
}

/**
 * 不指定
 */
function unAppoint(dom) {
	var name = dom.name;
	var val = "?";
	if (name == "year")
		val = "";
	var item = $("input[name=v_" + name + "]");
	item.val(val);
	item.change();
}

function appoint(dom) {

}

/**
 * 周期
 */
function cycle(dom) {
	var name = dom.name;
	var ns = $(dom).parent().find(".numberspinner");
	var start = ns.eq(0).numberspinner("getValue");
	var end = ns.eq(1).numberspinner("getValue");
	var item = $("input[name=v_" + name + "]");
	item.val(start + "-" + end);
	item.change();
}

/**
 * 从开始
 */
function startOn(dom) {
	var name = dom.name;
	var ns = $(dom).parent().find(".numberspinner");
	var start = ns.eq(0).numberspinner("getValue");
	var end = ns.eq(1).numberspinner("getValue");
	var item = $("input[name=v_" + name + "]");
	item.val(start + "/" + end);
	item.change();
}

function lastDay(dom){
	var item = $("input[name=v_" + dom.name + "]");
	item.val("L");
	item.change();
}

function weekOfDay(dom){
	var name = dom.name;
	var ns = $(dom).parent().find(".numberspinner");
	var start = ns.eq(0).numberspinner("getValue");
	var end = ns.eq(1).numberspinner("getValue");
	var item = $("input[name=v_" + name + "]");
	item.val(start + "#" + end);
	item.change();
}

function lastWeek(dom){
	var item = $("input[name=v_" + dom.name + "]");
	var ns = $(dom).parent().find(".numberspinner");
	var start = ns.eq(0).numberspinner("getValue");
	item.val(start+"L");
	item.change();
}

function workDay(dom) {
	var name = dom.name;
	var ns = $(dom).parent().find(".numberspinner");
	var start = ns.eq(0).numberspinner("getValue");
	var item = $("input[name=v_" + name + "]");
	item.val(start + "W");
	item.change();
}

$(function() {
	$(".numberspinner").numberspinner({
		onChange:function(){
			$(this).closest("div.line").children().eq(0).click();
		}
	});

	var vals = $("input[name^='v_']");
	var cron = $("#cron");
	vals.change(function() {
		var item = [];
		vals.each(function() {
			item.push(this.value);
		});
		cron.val(item.join(" "));
		//动态将规则添加到父页面
		top.mainFrame.$("#tempCron").val($("#cron").val());
	});
	
	var secondList = $(".secondList").children();
	$("#sencond_appoint").click(function(){
		if(this.checked){
			secondList.eq(0).change();
		}
	});

	secondList.change(function() {
		var sencond_appoint = $("#sencond_appoint").prop("checked");
		if (sencond_appoint) {
			var vals = [];
			secondList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 59) {
				val = vals.join(","); 
			}else if(vals.length == 59){
				val = "*";
			}
			var item = $("input[name=v_second]");
			item.val(val);
			item.change();
		}
	});
	
	var minList = $(".minList").children();
	$("#min_appoint").click(function(){
		if(this.checked){
			minList.eq(0).change();
		}
	});
	
	minList.change(function() {
		var min_appoint = $("#min_appoint").prop("checked");
		if (min_appoint) {
			var vals = [];
			minList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 59) {
				val = vals.join(",");
			}else if(vals.length == 59){
				val = "*";
			}
			var item = $("input[name=v_min]");
			item.val(val);
			item.change();
		}
	});
	
	var hourList = $(".hourList").children();
	$("#hour_appoint").click(function(){
		if(this.checked){
			hourList.eq(0).change();
		}
	});
	
	hourList.change(function() {
		var hour_appoint = $("#hour_appoint").prop("checked");
		if (hour_appoint) {
			var vals = [];
			hourList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 24) {
				val = vals.join(",");
			}else if(vals.length == 24){
				val = "*";
			}
			var item = $("input[name=v_hour]");
			item.val(val);
			item.change();
		}
	});
	
	var dayList = $(".dayList").children();
	$("#day_appoint").click(function(){
		if(this.checked){
			dayList.eq(0).change();
		}
	});
	
	dayList.change(function() {
		var day_appoint = $("#day_appoint").prop("checked");
		if (day_appoint) {
			var vals = [];
			dayList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 31) {
				val = vals.join(",");
			}else if(vals.length == 31){
				val = "*";
			}
			var item = $("input[name=v_day]");
			item.val(val);
			item.change();
		}
	});
	
	var mouthList = $(".mouthList").children();
	$("#mouth_appoint").click(function(){
		if(this.checked){
			mouthList.eq(0).change();
		}
	});
	
	mouthList.change(function() {
		var mouth_appoint = $("#mouth_appoint").prop("checked");
		if (mouth_appoint) {
			var vals = [];
			mouthList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 12) {
				val = vals.join(",");
			}else if(vals.length == 12){
				val = "*";
			}
			var item = $("input[name=v_mouth]");
			item.val(val);
			item.change();
		}
	});
	
	var weekList = $(".weekList").children();
	$("#week_appoint").click(function(){
		if(this.checked){
			weekList.eq(0).change();
		}
	});
	
	weekList.change(function() {
		var week_appoint = $("#week_appoint").prop("checked");
		if (week_appoint) {
			var vals = [];
			weekList.each(function() {
				if (this.checked) {
					vals.push(this.value);
				}
			});
			var val = "?";
			if (vals.length > 0 && vals.length < 7) {
				val = vals.join(",");
			}else if(vals.length == 7){
				val = "*";
			}
			var item = $("input[name=v_week]");
			item.val(val);
			item.change();
		}
	});
});
//回显规则
$(function() {
	var cronStr = top.mainFrame.$("#tempCron").val();
	cronStr = cronStr.replace(/(^\s*)|(\s*$)/g,'');
	var cronValueStrs = cronStr.split(" ");
	if(cronStr != '* * * * * ?' && cronValueStrs != null && cronValueStrs.length > 0){
		/**选中回显**/
		//秒 
		var cSecond = cronValueStrs[0];
		if(cSecond == '*'){
			$("#s_everyTimeId").attr("checked",true);
		}else{
			if(cSecond.indexOf("-")>=0){
				cycleSelected(cronValueStrs,0,'s_cycleId','secondStart_0','secondEnd_0');
			}else if(cSecond.indexOf("/")>=0){
				startOnSelected(cronValueStrs,0,'s_startOnId','secondStart_1','secondEnd_1');
			}else if(cSecond != '*' || cSecond.indexOf(",")>=0){
				checkbox(cSecond,"sencond_appoint","secondList");
			}
			$("#v_second").val(cSecond);
		}
		//分
		var cMin = cronValueStrs[1];
		if(cMin == '*'){
			$("#m_everyTimeId").attr("checked",true);
		}else if(cMin.indexOf("-")>=0){
			cycleSelected(cronValueStrs,1,'m_cycleId','minStart_0','minEnd_0');
		}else if(cMin.indexOf("/")>=0){
			startOnSelected(cronValueStrs,1,'m_startOnId','minStart_1','minEnd_1');
		}else if(cMin != '*' || cMin.indexOf(",")>=0){
			checkbox(cMin,"min_appoint","minList");
		}
		$("#v_min").val(cMin);
		//小时
		var cHour = cronValueStrs[2];
		if(cHour == '*'){
			$("#h_everyTimeId").attr("checked",true);
		}else if(cHour.indexOf("-")>=0){
			cycleSelected(cronValueStrs,2,'h_cycleId','hourStart_0','hourEnd_0');
		}else if(cHour.indexOf("/")>=0){
			startOnSelected(cronValueStrs,2,'h_startOnId','hourStart_1','hourEnd_1');
		}else if(cHour != '*' || cHour.indexOf(",")>=0){
			checkbox(cHour,"hour_appoint","hourList");
		}
		$("#v_hour").val(cHour);
		//日
		var cDay = cronValueStrs[3];
		if(cDay == '*'){
			$("#d_everyTimeId").attr("checked",true);
		}else if(cDay == '?'){
			$("#d_unAppointId").attr("checked",true);
		}else if(cDay.indexOf("-")>=0){
			cycleSelected(cronValueStrs,3,'d_cycleId','dayStart_0','dayEnd_0');
		}else if(cDay.indexOf("/")>=0){
			startOnSelected(cronValueStrs,3,'d_startOnId','dayStart_1','dayEnd_1');
		}else if(cDay.indexOf("W")>=0){
			$("#d_workDayId").attr("checked",true);
			$("#dayStart_2").val(cDay.replace("W",""));
		}else if(cDay == 'L'){
			$("#d_lastDayId").attr("checked",true);
		}else if(cDay != '*' || cDay.indexOf(",")>=0){
			checkbox(cDay,"day_appoint","dayList");
		}
		$("#v_day").val(cDay);
		//月
		var cMouth = cronValueStrs[4];
		if(cMouth == '*'){
			$("#mo_everyTimeId").attr("checked",true);
		}else if(cMouth == '?'){
			$("#mo_unAppointId").attr("checked",true);
		}else if(cMouth.indexOf("-")>=0){
			cycleSelected(cronValueStrs,4,'mo_cycleId','mouthStart_0','mouthEnd_0');
		}else if(cMouth.indexOf("/")>=0){
			startOnSelected(cronValueStrs,4,'mo_startOnId','mouthStart_1','mouthEnd_1');
		}else if(cMouth != '*' || cMouth.indexOf(",")>=0){
			checkbox(cMouth,"mouth_appoint","mouthList");
		}
		$("#v_mouth").val(cMouth);
		//周
		var cWeek = cronValueStrs[5];
		if(cWeek == '?'){
			$("#w_unAppointId").attr("checked",true);
		}else if(cWeek.indexOf("/")>=0){
			startOnSelected(cronValueStrs,5,'w_startOnId','weekStart_0','weekEnd_0');
		}else if(cWeek.indexOf("#")>=0){
			var cronStr = cWeek;
			cronStr = cronStr.split("#");
			if(cronStr != null && cronStr.length > 0){
				$("#w_weekOfDayId").attr("checked",true);
				$("#weekStart_1").val(cronStr[0]);
				$("#weekEnd_1").val(cronStr[1]);
			}
		}else if(cWeek.indexOf("L")>=0){
			$("#w_lastWeekId").attr("checked",true);
			$("#weekStart_2").val(cWeek.replace("L",""));
		}else if(cWeek != '' || cWeek.indexOf(",")>=0){
			checkbox(cWeek,"week_appoint","weekList");
		}
		$("#v_week").val(cWeek);
		//年
		var cYear =cronValueStrs[6];
		if(cYear == '*'){
			$("#y_everyTimeId").attr("checked",true);
		}else if(cYear.indexOf("-")>=0){
			cycleSelected(cronValueStrs,6,'y_cycleId','yearStart_0','yearEnd_0');
		}
		$("#v_year").val(cYear);
	}
});

function cycleSelected(cronValueStrs,i,radioId,startId,endId){
	var cronStr = cronValueStrs[i];
	cronStr = cronValueStrs[i].split("-");
	if(cronStr != null && cronStr.length > 0){
		$("#"+radioId).attr("checked",true);
		$("#"+startId).val(cronStr[0]);
		$("#"+endId).val(cronStr[1]);
	}
}
function startOnSelected(cronValueStrs,i,radioId,startId,endId){
	var cronStr = cronValueStrs[i];
	cronStr = cronValueStrs[i].split("/");
	if(cronStr != null && cronStr.length > 0){
		$("#"+radioId).attr("checked",true);
		$("#"+startId).val(cronStr[0]);
		$("#"+endId).val(cronStr[1]);
	}
}
function checkbox(checkboxs,radioId,checkboxCls){
	var cronStrCheckboxs = checkboxs.split(",");
	if(cronStrCheckboxs != null && cronStrCheckboxs.length > 0){
		$("#"+radioId).attr("checked",true);
		var cList = $("."+checkboxCls).children();
		cList.each(function() {
				for(var j=0;j<cronStrCheckboxs.length;j++){
					if($(this).val() == cronStrCheckboxs[j]){
						$(this).attr("checked",true);
					}
				}
		});
	}
}