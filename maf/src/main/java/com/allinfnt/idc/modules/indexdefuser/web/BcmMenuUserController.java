/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdefuser.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.indexdef.entity.BcmMenu;
import com.allinfnt.idc.modules.indexdefuser.entity.BcmMenuUser;
import com.allinfnt.idc.modules.indexdefuser.service.BcmMenuUserService;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 首页自定义用户配置Controller
 * @author zx
 * @version 2015-03-17
 */
@Controller
@RequestMapping(value = "${adminPath}/indexdefuser/bcmMenuUser")
public class BcmMenuUserController extends BaseController {

	@Autowired
	private BcmMenuUserService bcmMenuUserService;
	
	@ModelAttribute
	public BcmMenuUser get(@RequestParam(required=false) String id) {
		BcmMenuUser entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bcmMenuUserService.get(id);
		}
		if (entity == null){
			entity = new BcmMenuUser();
		}
		return entity;
	}
	
	@RequiresPermissions("indexdefuser:bcmMenuUser:view")
	@RequestMapping(value = {"list", ""})
	public String list(BcmMenuUser bcmMenuUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BcmMenuUser> page = bcmMenuUserService.findPage(new Page<BcmMenuUser>(request, response), bcmMenuUser); 
		model.addAttribute("page", page);
		return "modules/indexdefuser/index";
	}

	@RequiresPermissions("indexdefuser:bcmMenuUser:view")
	@RequestMapping(value = "form")
	public String form(BcmMenuUser bcmMenuUser, Model model) {
		model.addAttribute("bcmMenuUser", bcmMenuUser);
		return "modules/indexdefuser/bcmMenuUserForm";
	}

	@RequiresPermissions("indexdefuser:bcmMenuUser:edit")
	@RequestMapping(value = "save")
	public String save(BcmMenuUser bcmMenuUser, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bcmMenuUser)){
			return form(bcmMenuUser, model);
		}
		bcmMenuUserService.save(bcmMenuUser);
		addMessage(redirectAttributes, "保存首页自定义用户配置成功");
		return "redirect:"+Global.getAdminPath()+"/indexdefuser/bcmMenuUser/?repage";
	}
	@RequiresPermissions("indexdefuser:bcmMenuUser:edit")
	@RequestMapping(value = "delete")
	public String delete(BcmMenuUser bcmMenuUser, RedirectAttributes redirectAttributes) {
		bcmMenuUserService.delete(bcmMenuUser);
		addMessage(redirectAttributes, "删除首页自定义用户配置成功");
		return "redirect:"+Global.getAdminPath()+"/indexdefuser/bcmMenuUser/?repage";
	}
	@RequiresPermissions("indexdefuser:bcmMenuUser:view")
	@RequestMapping(value="listData")
	@ResponseBody
	public List<BcmMenuUser> listData(BcmMenuUser bcmMenuUser, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		bcmMenuUser.setUser(user);
		List<BcmMenuUser> listData = bcmMenuUserService.findList(bcmMenuUser);
		return listData;
	}
}