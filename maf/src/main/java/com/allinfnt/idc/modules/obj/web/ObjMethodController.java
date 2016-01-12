/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.web;

import java.io.IOException;
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
import com.allinfnt.idc.modules.obj.entity.ObjMethod;
import com.allinfnt.idc.modules.obj.service.ObjMethodService;
import com.google.common.collect.Lists;

import net.sf.json.JSONArray;

/**
 * 对象方法管理Controller
 * 
 * @author xusuojian
 * @version 2015-12-03
 */
@Controller
@RequestMapping(value = "${adminPath}/obj/objMethod")
public class ObjMethodController extends BaseController {

	@Autowired
	private ObjMethodService objMethodService;

	@ModelAttribute
	public ObjMethod get(@RequestParam(required = false) String id) {
		ObjMethod entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = objMethodService.get(id);
		}
		if (entity == null) {
			entity = new ObjMethod();
		}
		return entity;
	}

	@RequiresPermissions("obj:objMethod:view")
	@RequestMapping(value = { "list", "" })
	public String list(ObjMethod objMethod, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ObjMethod> page = objMethodService.findPage(new Page<ObjMethod>(request, response), objMethod);
		model.addAttribute("page", page);
		return "modules/obj/objMethodList";
	}

	@RequiresPermissions("obj:objMethod:view")
	@RequestMapping(value = "form")
	public String form(ObjMethod objMethod, Model model) {
		model.addAttribute("objMethod", objMethod);
		return "modules/obj/objMethodForm";
	}

	@RequiresPermissions("obj:objMethod:edit")
	@RequestMapping(value = "save")
	public String save(ObjMethod objMethod, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, objMethod)) {
			return form(objMethod, model);
		}
		objMethodService.save(objMethod);
		addMessage(redirectAttributes, "保存对象方法成功");
		return "redirect:" + Global.getAdminPath() + "/obj/objMethod/?repage";
	}

	@RequiresPermissions("obj:objMethod:edit")
	@RequestMapping(value = "delete")
	public String delete(ObjMethod objMethod, RedirectAttributes redirectAttributes) {
		objMethodService.delete(objMethod);
		addMessage(redirectAttributes, "删除对象方法成功");
		return "redirect:" + Global.getAdminPath() + "/obj/objMethod/?repage";
	}

	@RequestMapping("getAllObj")
	public void getAllObj(HttpServletResponse response, HttpServletRequest request) {

		String data = "";
		List<ObjMethod> list = objMethodService.getAllObj();
		if(null!=list){
			for (int i = 0; i < list.size(); i++) {
				if(i==0){
					data = list.get(i).getMethodName();
				}else{
					data +=  "," +list.get(i).getMethodName();
				}
			}
		}
		
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("findDefaultValByMethodName")
	public void findDefaultValByMethodName(HttpServletResponse response, HttpServletRequest request) {

		String data = "";
		String methodName = request.getParameter("motionText");
		ObjMethod objMethod = objMethodService.findDefaultValByMethodName(methodName);
		data = objMethod.getDefaultVal().toString();
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


	
}