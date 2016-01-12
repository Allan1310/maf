/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

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

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cm.entity.CmAuditTrack;
import com.allinfnt.idc.modules.cm.service.CmAuditTrackService;

/**
 * 配置项审计跟踪Controller
 * @author liuzk
 * @version 2015-02-03
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmAuditTrack")
public class CmAuditTrackController extends BaseController {

	@Autowired
	private CmAuditTrackService cmAuditTrackService;
	
	@ModelAttribute
	public CmAuditTrack get(@RequestParam(required=false) String id) {
		CmAuditTrack entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmAuditTrackService.get(id);
		}
		if (entity == null){
			entity = new CmAuditTrack();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmAuditTrack:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmAuditTrack cmAuditTrack, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmAuditTrack> page = cmAuditTrackService.findPage(new Page<CmAuditTrack>(request, response), cmAuditTrack); 
		model.addAttribute("page", page);
		return "modules/cm/cmAuditTrackList";
	}

	@RequiresPermissions("cm:cmAuditTrack:view")
	@RequestMapping(value = "form")
	public String form(CmAuditTrack cmAuditTrack, Model model) {
		model.addAttribute("cmAuditTrack", cmAuditTrack);
		return "modules/cm/cmAuditTrackForm";
	}

	@RequiresPermissions("cm:cmAuditTrack:edit")
	@RequestMapping(value = "save")
	public String save(CmAuditTrack cmAuditTrack, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmAuditTrack)){
			return form(cmAuditTrack, model);
		}
		cmAuditTrackService.save(cmAuditTrack);
		addMessage(redirectAttributes, "保存配置项审计跟踪成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmAuditTrack/?repage";
	}
	
	@RequiresPermissions("cm:cmAuditTrack:edit")
	@RequestMapping(value = "delete")
	public String delete(CmAuditTrack cmAuditTrack, RedirectAttributes redirectAttributes) {
		cmAuditTrackService.delete(cmAuditTrack);
		addMessage(redirectAttributes, "删除配置项审计跟踪成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmAuditTrack/?repage";
	}

}