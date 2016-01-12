/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

import java.util.List;

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
import com.allinfnt.idc.modules.cm.entity.CmGraphIcon;
import com.allinfnt.idc.modules.cm.service.CmGraphIconService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;

/**
 * 配置项图标Controller
 * @author liujx
 * @version 2015-04-07
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmGraphIcon")
public class CmGraphIconController extends BaseController {

	@Autowired
	private CmGraphIconService cmGraphIconService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmGraphIcon get(@RequestParam(required=false) String id) {
		CmGraphIcon entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmGraphIconService.get(id);
		}
		if (entity == null){
			entity = new CmGraphIcon();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmGraphIcon:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmGraphIcon cmGraphIcon, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		String view = request.getParameter("view");
		if(null!=view && !"".equals(view)){
			List<CmGraphIcon> graphIcons = cmGraphIconService.findList(cmGraphIcon);
			model.addAttribute("graphIcons", graphIcons);
			return "modules/cm/cmGraphIconView";
		}
		
		Page<CmGraphIcon> page = cmGraphIconService.findPage(new Page<CmGraphIcon>(request, response), cmGraphIcon); 
		model.addAttribute("page", page);
		return "modules/cm/cmGraphIconList";
	}

	@RequiresPermissions("cm:cmGraphIcon:view")
	@RequestMapping(value = "form")
	public String form(CmGraphIcon cmGraphIcon, Model model, HttpServletRequest request) {
		String view = request.getParameter("view");
		model.addAttribute("cmGraphIcon", cmGraphIcon);
		if(view!=null&&view.equals("view")){
			return "modules/cm/cmGraphIconForm-view";
		}
		return "modules/cm/cmGraphIconForm";
	}

	@RequiresPermissions("cm:cmGraphIcon:edit")
	@RequestMapping(value = "save")
	public String save(CmGraphIcon cmGraphIcon, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, cmGraphIcon)){
			return form(cmGraphIcon, model,request);
		}
		if(cmGraphIcon.getId()==null||cmGraphIcon.getId().equals("")){
			cmGraphIconService.save(cmGraphIcon);
			addMessage(redirectAttributes, "保存配置项图标成功");
			cmHandleLogService.saveLog(cmGraphIcon.getIconName(), "新增配置项图标");
		}else{
			cmGraphIconService.save(cmGraphIcon);
			addMessage(redirectAttributes, "修改配置项图标成功");
			cmHandleLogService.saveLog(cmGraphIcon.getIconName(), "修改配置项图标");
		}
		
		return "redirect:"+Global.getAdminPath()+"/cm/cmGraphIcon/?repage";
	}
	
	@RequiresPermissions("cm:cmGraphIcon:edit")
	@RequestMapping(value = "delete")
	public String delete(CmGraphIcon cmGraphIcon, RedirectAttributes redirectAttributes) {
		cmGraphIconService.delete(cmGraphIcon);
		addMessage(redirectAttributes, "删除配置项图标成功");
		cmHandleLogService.saveLog(cmGraphIcon.getIconName(), "删除配置项图标");
		return "redirect:"+Global.getAdminPath()+"/cm/cmGraphIcon/?repage";
	}

}