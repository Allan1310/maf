/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cm.entity.CmHandleLog;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;

/**
 * 配置管理操作日志Controller
 * @author liuzk
 * @version 2015-02-09
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmHandleLog")
public class CmHandleLogController extends BaseController {

	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmHandleLog get(@RequestParam(required=false) String id) {
		CmHandleLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmHandleLogService.get(id);
		}
		if (entity == null){
			entity = new CmHandleLog();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmHandleLog:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmHandleLog cmHandleLog, HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		
		cmHandleLog.setHandleTime(Canstants.getNotNullString(startTime));
		if(!Canstants.getNotNullString(endTime).equals("")){
			cmHandleLog.setCreateTime(Canstants.DATEFORMAT.parse(endTime));
		}
		Page<CmHandleLog> page = cmHandleLogService.findPage(new Page<CmHandleLog>(request, response), cmHandleLog); 
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("page", page);
		return "modules/cm/cmHandleLogList";
	}

	@RequiresPermissions("cm:cmHandleLog:view")
	@RequestMapping(value = "form")
	public String form(CmHandleLog cmHandleLog, Model model) {
		model.addAttribute("cmHandleLog", cmHandleLog);
		return "modules/cm/cmHandleLogForm";
	}

	@RequiresPermissions("cm:cmHandleLog:edit")
	@RequestMapping(value = "save")
	public String save(CmHandleLog cmHandleLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmHandleLog)){
			return form(cmHandleLog, model);
		}
		cmHandleLogService.save(cmHandleLog);
		addMessage(redirectAttributes, "保存配置管理操作日志成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmHandleLog/?repage";
	}
	
	@RequiresPermissions("cm:cmHandleLog:edit")
	@RequestMapping(value = "delete")
	public String delete(CmHandleLog cmHandleLog, RedirectAttributes redirectAttributes) {
		cmHandleLogService.delete(cmHandleLog);
		addMessage(redirectAttributes, "删除配置管理操作日志成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmHandleLog/?repage";
	}

	@RequestMapping(value = "export")
	public String export(CmHandleLog cmHandleLog, RedirectAttributes redirectAttributes,HttpServletRequest request,
				HttpServletResponse response) throws ParseException{
		
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		
		if(Canstants.getNotNullString(startTime).equals("")||Canstants.getNotNullString(endTime).equals("")){
			addMessage(redirectAttributes, "导出失败：请选择操作日期起止时间");
			return "redirect:"+Global.getAdminPath()+"/cm/cmHandleLog/?repage&startTime="+startTime+"&endTime"+endTime;
		}
		cmHandleLog.setHandleTime(Canstants.getNotNullString(startTime));
		if(!Canstants.getNotNullString(endTime).equals("")){
			cmHandleLog.setCreateTime(Canstants.DATEFORMAT.parse(endTime));
		}
		Page<CmHandleLog> page = cmHandleLogService.findPage(new Page<CmHandleLog>(request, response), cmHandleLog);
		if(page.getList()==null||page.getList().size()<1){
			addMessage(redirectAttributes, "导出失败：无导出内容");
			return "redirect:"+Global.getAdminPath()+"/cm/cmHandleLog/?repage&startTime="+startTime+"&endTime"+endTime;
		}else{
			cmHandleLogService.export(page.getList(), response);
		}
		return null;
	}
}