/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmRelationOrder;
import com.allinfnt.idc.modules.cm.service.CmRelationOrderService;

/**
 * 配置项关联工单Controller
 * @author liujx
 * @version 2015-03-13
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmRelationOrder")
public class CmRelationOrderController extends BaseController {

	@Autowired
	private CmRelationOrderService cmRelationOrderService;
	
	@ModelAttribute
	public CmRelationOrder get(@RequestParam(required=false) String id) {
		CmRelationOrder entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmRelationOrderService.get(id);
		}
		if (entity == null){
			entity = new CmRelationOrder();
		}
		return entity;
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(CmRelationOrder cmRelationOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmRelationOrder> page = cmRelationOrderService.findPage(new Page<CmRelationOrder>(request, response), cmRelationOrder); 
		model.addAttribute("page", page);
		model.addAttribute("ciInstance", cmRelationOrder.getCiInstance());
		return "modules/cm/cmRelationOrderList";
	}

	@RequestMapping(value = "form")
	public String form(CmRelationOrder cmRelationOrder, Model model) {
		model.addAttribute("cmRelationOrder", cmRelationOrder);
		return "modules/cm/cmRelationOrderForm";
	}

	@RequestMapping(value = "save")
	public String save(CmRelationOrder cmRelationOrder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmRelationOrder)){
			return form(cmRelationOrder, model);
		}
		cmRelationOrderService.save(cmRelationOrder);
		addMessage(redirectAttributes, "保存配置项关联工单成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmRelationOrder/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(CmRelationOrder cmRelationOrder, RedirectAttributes redirectAttributes) {
		cmRelationOrderService.delete(cmRelationOrder);
		addMessage(redirectAttributes, "删除配置项关联工单成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmRelationOrder/?repage";
	}

}