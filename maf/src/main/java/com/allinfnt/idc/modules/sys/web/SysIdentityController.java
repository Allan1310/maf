/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.web;

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
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.sys.entity.SysIdentity;
import com.allinfnt.idc.modules.sys.service.SysIdentityService;

/**
 * 流水号信息表Controller
 * 
 * @author rocliao
 * @version 2015-01-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysIdentity")
public class SysIdentityController extends BaseController {

	@Autowired
	private SysIdentityService sysIdentityService;

	@ModelAttribute
	public SysIdentity get(@RequestParam(required = false) String id) {
		SysIdentity entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = sysIdentityService.get(id);
		}
		if (entity == null) {
			entity = new SysIdentity();
		}
		return entity;
	}

	@RequiresPermissions("sys:sysIdentity:view")
	@RequestMapping(value = { "list", "" })
	public String list(SysIdentity sysIdentity, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<SysIdentity> page = sysIdentityService.findPage(
				new Page<SysIdentity>(request, response), sysIdentity);
		model.addAttribute("page", page);
		return "modules/sys/sysIdentityList";
	}

	@RequiresPermissions("sys:sysIdentity:view")
	@RequestMapping(value = "form")
	public String form(SysIdentity sysIdentity, Model model) {
		model.addAttribute("sysIdentity", sysIdentity);
		return "modules/sys/sysIdentityForm";
	}

	@RequiresPermissions("sys:sysIdentity:edit")
	@RequestMapping(value = "save")
	public String save(SysIdentity sysIdentity, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysIdentity)) {
			return form(sysIdentity, model);
		}
		sysIdentityService.save(sysIdentity);
		addMessage(redirectAttributes, "保存流水号成功");
		return "redirect:" + Global.getAdminPath() + "/sys/sysIdentity/?repage";
	}

	@RequiresPermissions("sys:sysIdentity:edit")
	@RequestMapping(value = "next")
	public String next(SysIdentity sysIdentity, Model model,
			RedirectAttributes redirectAttributes) {
		sysIdentityService.nextId(sysIdentity.getAlias());
		addMessage(redirectAttributes, sysIdentity.getName() + "增长成功");
		return "redirect:" + Global.getAdminPath() + "/sys/sysIdentity/?repage";
	}

	@RequiresPermissions("sys:sysIdentity:edit")
	@RequestMapping(value = "delete")
	public String delete(SysIdentity sysIdentity,
			RedirectAttributes redirectAttributes) {
		sysIdentityService.delete(sysIdentity);
		addMessage(redirectAttributes, "删除流水号成功");
		return "redirect:" + Global.getAdminPath() + "/sys/sysIdentity/?repage";
	}

	/**
	 * 验证别名是否有效
	 * 
	 * @param oldLoginName
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping(value = "checkAlias")
	public String checkAlias(String oldAlias, String alias) {
		if (alias != null && alias.equals(oldAlias)) {
			return "true";
		} else if (alias != null
				&& sysIdentityService.getByAlias(alias) == null) {
			return "true";
		}
		return "false";
	}

}