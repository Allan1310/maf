/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.web;

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
import com.allinfnt.idc.modules.item.entity.ItemManage;
import com.allinfnt.idc.modules.item.service.ItemManageService;

/**
 * 项目管理Controller
 * 
 * @author xusuojian
 * @version 2015-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/item/itemManage")
public class ItemManageController extends BaseController {

	@Autowired
	private ItemManageService itemManageService;

	@ModelAttribute
	public ItemManage get(@RequestParam(required = false) String id) {
		ItemManage entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = itemManageService.get(id);
		}
		if (entity == null) {
			entity = new ItemManage();
		}
		return entity;
	}

	@RequiresPermissions("item:itemManage:view")
	@RequestMapping(value = { "list", "" })
	public String list(ItemManage itemManage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ItemManage> page = itemManageService.findPage(new Page<ItemManage>(request, response), itemManage);
		model.addAttribute("page", page);
		return "modules/item/itemManageList";
	}

	@RequiresPermissions("item:itemManage:view")
	@RequestMapping(value = "form")
	public String form(ItemManage itemManage, Model model) {
		model.addAttribute("itemManage", itemManage);
		return "modules/item/itemManageForm";
	}

	@RequiresPermissions("item:itemManage:edit")
	@RequestMapping(value = "save")
	public String save(ItemManage itemManage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, itemManage)) {
			return form(itemManage, model);
		}
		itemManageService.save(itemManage);
		addMessage(redirectAttributes, "保存项目成功");
		return "redirect:" + Global.getAdminPath() + "/item/itemManage/?repage";
	}

	@RequiresPermissions("item:itemManage:edit")
	@RequestMapping(value = "delete")
	public String delete(ItemManage itemManage, RedirectAttributes redirectAttributes) {
		itemManageService.delete(itemManage);
		addMessage(redirectAttributes, "删除项目成功");
		return "redirect:" + Global.getAdminPath() + "/item/itemManage/?repage";
	}

	@RequiresPermissions("item:itemManage:view")
	@RequestMapping(value = { "selectList" })
	public String selectList(ItemManage itemManage, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<ItemManage> page = itemManageService.findPage(new Page<ItemManage>(request, response), itemManage);
		model.addAttribute("page", page);
		return "modules/item/itemManageSelectList";
	}
}