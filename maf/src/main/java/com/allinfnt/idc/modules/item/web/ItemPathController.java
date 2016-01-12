/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.web;

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
import com.allinfnt.idc.modules.item.entity.ItemPath;
import com.allinfnt.idc.modules.item.service.ItemPathService;

/**
 * 路径管理Controller
 * @author xusuojian
 * @version 2015-11-26
 */
@Controller
@RequestMapping(value = "${adminPath}/item/itemPath")
public class ItemPathController extends BaseController {

	@Autowired
	private ItemPathService itemPathService;
	
	@ModelAttribute
	public ItemPath get(@RequestParam(required=false) String id) {
		ItemPath entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = itemPathService.get(id);
		}
		if (entity == null){
			entity = new ItemPath();
		}
		return entity;
	}
	
	@RequiresPermissions("item:itemPath:view")
	@RequestMapping(value = {"list", ""})
	public String list(ItemPath itemPath, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ItemPath> page = itemPathService.findPage(new Page<ItemPath>(request, response), itemPath); 
		model.addAttribute("page", page);
		return "modules/item/itemPathList";
	}

	@RequiresPermissions("item:itemPath:view")
	@RequestMapping(value = "form")
	public String form(ItemPath itemPath, Model model) {
		model.addAttribute("itemPath", itemPath);
		return "modules/item/itemPathForm";
	}

	@RequiresPermissions("item:itemPath:edit")
	@RequestMapping(value = "save")
	public String save(ItemPath itemPath, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, itemPath)){
			return form(itemPath, model);
		}
		itemPathService.save(itemPath);
		addMessage(redirectAttributes, "保存路径成功");
		return "redirect:"+Global.getAdminPath()+"/item/itemPath/?repage";
	}
	
	@RequiresPermissions("item:itemPath:edit")
	@RequestMapping(value = "delete")
	public String delete(ItemPath itemPath, RedirectAttributes redirectAttributes) {
		itemPathService.delete(itemPath);
		addMessage(redirectAttributes, "删除路径成功");
		return "redirect:"+Global.getAdminPath()+"/item/itemPath/?repage";
	}
	
	@RequiresPermissions("item:itemPath:view")
	@RequestMapping(value = { "selectList" })
	public String selectList(ItemPath itemPath, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<ItemPath> page = itemPathService.findPage(new Page<ItemPath>(request, response), itemPath);
		model.addAttribute("page", page);
		return "modules/item/itemPathSelectList";
	}

}