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
import com.allinfnt.idc.modules.cm.entity.CmBaseLine;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;
import com.allinfnt.idc.modules.cm.service.CmBaseLineService;
import com.allinfnt.idc.modules.cm.service.CmCiGroupService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;

/**
 * 配置项基线Controller
 * @author liujx
 * @version 2015-03-02
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmBaseLine")
public class CmBaseLineController extends BaseController {

	@Autowired
	private CmCiGroupService cmCiGroupService;
	@Autowired
	private CmBaseLineService cmBaseLineService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmBaseLine get(@RequestParam(required=false) String id) {
		CmBaseLine entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmBaseLineService.get(id);
		}
		if (entity == null){
			entity = new CmBaseLine();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmBaseLine:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmBaseLine cmBaseLine, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmBaseLine> page = cmBaseLineService.findPage(new Page<CmBaseLine>(request, response), cmBaseLine); 
		model.addAttribute("page", page);
		return "modules/cm/cmBaseLineList";
	}

	@RequiresPermissions("cm:cmBaseLine:view")
	@RequestMapping(value = "form")
	public String form(CmBaseLine cmBaseLine, Model model) {
		model.addAttribute("cmBaseLine", cmBaseLine);
		return "modules/cm/cmBaseLineForm";
	}

	@RequiresPermissions("cm:cmBaseLine:edit")
	@RequestMapping(value = "save")
	public String save(CmBaseLine cmBaseLine, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmBaseLine)){
			return form(cmBaseLine, model);
		}
		cmBaseLineService.save(cmBaseLine);
		addMessage(redirectAttributes, "生成配置项基线成功");
		cmHandleLogService.saveLog("生成新的基线版本"+cmBaseLine.getBaseVersion(), "生成新的基线版本");
		return "redirect:"+Global.getAdminPath()+"/cm/cmBaseLine/?repage";
	}
	
	@RequiresPermissions("cm:cmBaseLine:edit")
	@RequestMapping(value = "delete")
	public String delete(CmBaseLine cmBaseLine, RedirectAttributes redirectAttributes) {
		cmBaseLineService.delete(cmBaseLine);
		addMessage(redirectAttributes, "删除配置项基线成功");
		cmHandleLogService.saveLog("删除基线版本"+cmBaseLine.getBaseVersion(), "删除基线版本");
		return "redirect:"+Global.getAdminPath()+"/cm/cmBaseLine/?repage";
	}
	
	/**
	 * 
	 * @return
	 */
	@RequiresPermissions("cm:cmBaseLine:view")
	@RequestMapping(value = "ciList")
	public String ciList(CmCiInstanceHi cmCiInstanceHi, HttpServletRequest request, HttpServletResponse response, Model model){
		
		Page<CmCiInstanceHi> page = cmBaseLineService.findPage(new Page<CmCiInstanceHi>(request, response), cmCiInstanceHi); 
		if(cmCiInstanceHi.getCmCiGroup()!=null&&cmCiInstanceHi.getCmCiGroup().getId()!=null){
			cmCiInstanceHi.setCmCiGroup(cmCiGroupService.get(cmCiInstanceHi.getCmCiGroup()));
			model.addAttribute("cmCiInstanceHi", cmCiInstanceHi);
		}
		model.addAttribute("page", page);
		model.addAttribute("baseVersion", cmCiInstanceHi.getCiVersion());
		return "modules/cm/cmBaseLCiList";
		
	}

}