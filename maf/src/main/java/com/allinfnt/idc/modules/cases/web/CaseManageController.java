/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.web;

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
import com.allinfnt.idc.modules.cases.entity.CaseManage;
import com.allinfnt.idc.modules.cases.service.CaseManageService;
import com.allinfnt.idc.modules.script.maker.TestCaseMaker;
import com.allinfnt.idc.modules.sys.entity.User;

/**
 * 用例管理Controller
 * @author xusuojian
 * @version 2015-12-08
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/caseManage")
public class CaseManageController extends BaseController {

	@Autowired
	private CaseManageService caseManageService;
	
	@ModelAttribute
	public CaseManage get(@RequestParam(required=false) String id) {
		CaseManage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = caseManageService.get(id);
		}
		if (entity == null){
			entity = new CaseManage();
		}
		return entity;
	}
	
	@RequiresPermissions("cases:caseManage:view")
	@RequestMapping(value = { "index" })
	public String index(CaseManage caseManage, Model model) {
		return "modules/cases/caseIndex";
	}
	
	@RequiresPermissions("cases:caseManage:view")
	@RequestMapping(value = {"list", ""})
	public String list(CaseManage caseManage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CaseManage> page = caseManageService.findPage(new Page<CaseManage>(request, response), caseManage); 
		model.addAttribute("page", page);
		return "modules/cases/caseManageList";
	}

	@RequiresPermissions("cases:caseManage:view")
	@RequestMapping(value = "form")
	public String form(CaseManage caseManage, Model model) {
		model.addAttribute("caseManage", caseManage);
		return "modules/cases/caseManageForm";
	}

	@RequiresPermissions("cases:caseManage:edit")
	@RequestMapping(value = "save")
	public String save(CaseManage caseManage, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, caseManage)){
			return form(caseManage, model);
		}
		caseManageService.save(caseManage,request);
		addMessage(redirectAttributes, "保存用例成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseManage/?repage";
	}
	
	@RequiresPermissions("cases:caseManage:edit")
	@RequestMapping(value = "delete")
	public String delete(CaseManage caseManage, RedirectAttributes redirectAttributes) {
		caseManageService.delete(caseManage);
		addMessage(redirectAttributes, "删除用例成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseManage/?repage";
	}
	
	@RequiresPermissions("cases:caseManage:edit")
	@RequestMapping(value = "makeCase")
	public String makeCase(CaseManage caseManage, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, caseManage)){
			return form(caseManage, model);
		}
		//生成用例
		TestCaseMaker testCaseMarker = new TestCaseMaker(caseManage.getId());
		testCaseMarker.create();
		addMessage(redirectAttributes, "生成用例成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseManage/?repage";
	}

}