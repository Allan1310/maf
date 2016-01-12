/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.web;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.JsonUtils;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.sys.entity.SetWeekday;
import com.allinfnt.idc.modules.sys.service.SetWeekdayService;
import com.allinfnt.idc.modules.sys.utils.ImportUtils;

/**
 * 工作日设置Controller
 * @author 蒋斌
 * @version 2015-01-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/setWeekday")
public class SetWeekdayController extends BaseController {

	@Autowired
	private SetWeekdayService setWeekdayService;
	
	@ModelAttribute
	public SetWeekday get(@RequestParam(required=false) String id) {
		SetWeekday entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = setWeekdayService.get(id);
		}
		if (entity == null){
			entity = new SetWeekday();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:setWeekday:view")
	@RequestMapping(value = {"list", ""})
	public String list(SetWeekday setWeekday, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SetWeekday> page = setWeekdayService.findPage(new Page<SetWeekday>(request, response), setWeekday); 
		model.addAttribute("page", page);
		return "modules/sys/setWeekdayList";
	}

	@RequiresPermissions("sys:setWeekday:view")
	@RequestMapping(value = "form")
	public String form(SetWeekday setWeekday, Model model) {
		model.addAttribute("setWeekday", setWeekday);
		return "modules/sys/setWeekdayForm";
	}

	@RequiresPermissions("sys:setWeekday:edit")
	@RequestMapping(value = "save")
	public String save(@RequestParam(value = "file", required = false) MultipartFile file,SetWeekday setWeekday,
			Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, setWeekday)){
			return form(setWeekday, model);
		}
		List<String> dataList = null;
		String fileName = file.getOriginalFilename();
		if(fileName != null && !"".equals(fileName)){
			dataList = ImportUtils.encapsulationData(file);
	     }
		setWeekdayService.save(setWeekday,dataList);
		addMessage(redirectAttributes, "保存工作日设置成功");
		return "redirect:"+Global.getAdminPath()+"/sys/setWeekday/?repage";
	}
	
	@RequiresPermissions("sys:setWeekday:edit")
	@RequestMapping(value = "delete")
	public String delete(SetWeekday setWeekday, RedirectAttributes redirectAttributes) {
		setWeekdayService.delete(setWeekday);
		addMessage(redirectAttributes, "删除工作日设置成功");
		return "redirect:"+Global.getAdminPath()+"/sys/setWeekday/?repage";
	}

	@RequestMapping(value = "isExistDay")
	public void isExistDay(SetWeekday setWeekday,HttpServletRequest request,HttpServletResponse response){
		try{
			Object[] objs = new Object[1];
			boolean flag = setWeekdayService.findDay(setWeekday.getDay());
			if(!flag){
				objs[0] = setWeekday.getDay()+" 已存在，请重新添加!";
			}
			response.getWriter().print(JsonUtils.ObjectToJsonArray(objs));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}