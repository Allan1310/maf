/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

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

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.DateUtils;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmPropertyGroup;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.allinfnt.idc.modules.cm.service.CmPropertyGroupService;
import com.allinfnt.idc.modules.cm.service.CmPropertyManageService;

/**
 * 属性管理Controller
 * @author liujx
 * @version 2015-01-18
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmPropertyManage")
public class CmPropertyManageController extends BaseController {

	@Autowired
	private CmPropertyGroupService cmPropertyGroupService;
	@Autowired
	private CmPropertyManageService cmPropertyManageService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmPropertyManage get(@RequestParam(required=false) String id) {
		CmPropertyManage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmPropertyManageService.get(id);
		}
		if (entity == null){
			entity = new CmPropertyManage();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmPropertyManage:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmPropertyManage cmPropertyManage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmPropertyManage> page = cmPropertyManageService.findPage(new Page<CmPropertyManage>(request, response), cmPropertyManage); 
		model.addAttribute("page", page);
		return "modules/cm/cmPropertyManageList";
	}

	@RequiresPermissions("cm:cmPropertyManage:view")
	@RequestMapping(value = "form")
	public String form(CmPropertyManage cmPropertyManage, Model model,HttpServletRequest request) {
		String view = request.getParameter("view");
		try {
			if(cmPropertyManage.getPropertyType()!=null){
				if(cmPropertyManage.getPropertyType().equals(Canstants.cm_property_ZY)){
					List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findEntityByPropertyId(cmPropertyManage.getId());
					if(propertyGroups.size()>0){
						model.addAttribute("isRelation", true);
					}else{
						model.addAttribute("isRelation", false);
					}
				}else{
					model.addAttribute("isRelation", false);
				}
			}else{
				cmPropertyManage.setSort(Integer.valueOf(cmPropertyManageService.getNextSortValue()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("cmPropertyManage", cmPropertyManage);
		if(view!=null&&view.equals("view")){
			return "modules/cm/cmPropertyManageForm-view";
		}
		return "modules/cm/cmPropertyManageForm";
	}

	@RequiresPermissions("cm:cmPropertyManage:edit")
	@RequestMapping(value = "save")
	public String save(CmPropertyManage cmPropertyManage, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if (!beanValidator(model, cmPropertyManage)){
			return form(cmPropertyManage, model,request);
		}
		
		if(null==cmPropertyManage.getId()||"".equals(cmPropertyManage.getId())){
			cmPropertyManage.setPropertyNumber(DateUtils.getDate("yyyyMMddHHmmss"));
			cmPropertyManage.setStatus("0");
			
			cmPropertyManageService.save(cmPropertyManage);
			cmPropertyManageService.updateNextSortValue(cmPropertyManage.getSort());
			cmHandleLogService.saveLog(cmPropertyManage.getPropertyName(), "保存属性："+cmPropertyManage.getPropertyName());
			addMessage(redirectAttributes, "保存新属性成功");
		}else{
			cmPropertyManageService.save(cmPropertyManage);
			cmPropertyManageService.updateNextSortValue(cmPropertyManage.getSort());
			cmHandleLogService.saveLog(cmPropertyManage.getPropertyName(),"修改属性："+cmPropertyManage.getPropertyName());
			addMessage(redirectAttributes, "修改属性信息成功");
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyManage/?repage";
	}
	
	@RequiresPermissions("cm:cmPropertyManage:edit")
	@RequestMapping(value = "delete")
	public String delete(CmPropertyManage cmPropertyManage, RedirectAttributes redirectAttributes) {
		if(cmPropertyManage.getPropertyType().equals(Canstants.cm_property_ZY)){
			List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findEntityByPropertyId(cmPropertyManage.getId());
			if(propertyGroups.size()>0){
				addMessage(redirectAttributes, "删除失败：此专有属性有分类引用");
				return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyManage/?repage";
			}else{
				cmPropertyManageService.delete(cmPropertyManage);
			}
		}else{
			cmPropertyManageService.delete(cmPropertyManage);
		}
		cmHandleLogService.saveLog(cmPropertyManage.getPropertyName(),"删除属性："+cmPropertyManage.getPropertyName());
		addMessage(redirectAttributes, "删除属性信息成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyManage/?repage";
	}
	
	/**
	 * 校验属性添加字段内容
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "check")
	public void checkProperty(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String propertyType = request.getParameter("propertyType");
			String propertyName = request.getParameter("propertyName");
			String dataType = request.getParameter("dataType");
			List<CmPropertyManage> propertys = cmPropertyManageService.findPropertyByName(propertyName,propertyType,dataType);
			if(propertys.size()>0){
				if(propertyType.equals(Canstants.cm_property_TY)){
					response.getWriter().print("存在名称相同的通用属性");
				}else if(propertyType.equals(Canstants.cm_property_ZY)){
					response.getWriter().print("存在名称相同并且数据类型相同的专有属性");
				}
				
			}else{
				response.getWriter().print("ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("系统异常请稍后再试");
		}
	}

	@RequiresPermissions("cm:cmPropertyManage:edit")
	@RequestMapping(value = "update")
	public String update(CmPropertyManage cmPropertyManage, RedirectAttributes redirectAttributes){
		if(cmPropertyManage.getStatus()!=null){
			if(cmPropertyManage.getStatus().equals("0")){
				cmPropertyManage.setStatus("1");
				cmHandleLogService.saveLog(cmPropertyManage.getPropertyName(),"停用属性："+cmPropertyManage.getPropertyName());
				addMessage(redirectAttributes, "停用属性成功");
			}else{
				cmPropertyManage.setStatus("0");
				cmHandleLogService.saveLog(cmPropertyManage.getPropertyName(),"启用属性："+cmPropertyManage.getPropertyName());
				addMessage(redirectAttributes, "启用属性成功");
			}
			cmPropertyManageService.save(cmPropertyManage);
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyManage/?repage";
	}
}