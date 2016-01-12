/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

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
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmPropertyGroup;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.cm.service.CmCiGroupService;
import com.allinfnt.idc.modules.cm.service.CmCiInstanceService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.allinfnt.idc.modules.cm.service.CmPropertyGroupService;
import com.allinfnt.idc.modules.cm.service.CmPropertyManageService;
import com.google.common.collect.Lists;

/**
 * 分类属性关系Controller
 * @author liujx
 * @version 2015-01-20
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmPropertyGroup")
public class CmPropertyGroupController extends BaseController {

	@Autowired
	private CmCiGroupService cmCiGroupService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	@Autowired
	private CmPropertyGroupService cmPropertyGroupService;
	@Autowired
	private CmPropertyManageService cmPropertyManageService;
	
	@ModelAttribute
	public CmPropertyGroup get(@RequestParam(required=false) String id) {
		CmPropertyGroup entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmPropertyGroupService.get(id);
		}
		if (entity == null){
			entity = new CmPropertyGroup();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmPropertyGroup:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmPropertyGroup cmPropertyGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		 
		/**
		 * 获取全部通用属性，并动态生成属性表单代码
		 */
		List<CmPropertyManage> TYSXList = Lists.newArrayList();
		TYSXList = cmPropertyManageService.findPropertyByType(Canstants.cm_property_TY);
		List<CmPropertyManage> newTYPropertyGroups = Lists.newArrayList();
		int num = 0;
		for(CmPropertyManage property:TYSXList){
			property.setRemarks(Canstants.dynamicFormByType(property,"1","",num));
			num++;
			newTYPropertyGroups.add(property);
		}
		
		/**
		 * 获取此分类下所有的专有属性，并动态生成属性的表单代码
		 */
		List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findList(cmPropertyGroup);
		List<CmPropertyGroup> newPropertyGroups = Lists.newArrayList();
		for(CmPropertyGroup propertyGroup:propertyGroups){
			CmPropertyManage property = propertyGroup.getCmPropertyManage();
			property.setRemarks(Canstants.dynamicFormByType(property,"1","",num));
			num++;
			propertyGroup.setCmPropertyManage(property);
			newPropertyGroups.add(propertyGroup);
		}
		
		model.addAttribute("newTYPropertyGroups", newTYPropertyGroups);
		model.addAttribute("newPropertyGroups", newPropertyGroups);
		model.addAttribute("groupId", cmPropertyGroup.getGroupId());
		return "modules/cm/cmPropertyGroupList";
	}

	@RequiresPermissions("cm:cmPropertyGroup:view")
	@RequestMapping(value = "form")
	public String form(CmPropertyGroup cmPropertyGroup, Model model,HttpServletResponse response, HttpServletRequest request) {
		List<CmPropertyManage> ZYSXList = Lists.newArrayList();
		String flag = request.getParameter("search");
		if(flag!=null&&flag.equals("true")){
			String propertyName = request.getParameter("searchInput");
			CmPropertyManage manage = new CmPropertyManage();
			manage.setPropertyName(Canstants.getNotNullString(propertyName));
			manage.setPropertyType(Canstants.cm_property_ZY);
			manage.setStatus("0");
			Page<CmPropertyManage> page = cmPropertyManageService.findPage(new Page<CmPropertyManage>(request, response), manage);
			if(!Canstants.getNotNullString(propertyName).equals("")){
				ZYSXList = page.getList();
			}else{
				ZYSXList = cmPropertyManageService.findPropertyByType(Canstants.cm_property_ZY);
			}
			
		}else{
			ZYSXList = cmPropertyManageService.findPropertyByType(Canstants.cm_property_ZY);
		}
		model.addAttribute("ZYSXList", ZYSXList);
		model.addAttribute("cmPropertyGroup", cmPropertyGroup);
		return "modules/cm/cmPropertyGroupForm";
	}

	@RequiresPermissions("cm:cmPropertyGroup:edit")
	@RequestMapping(value = "save")
	public String save(CmPropertyGroup cmPropertyGroup, Model model, RedirectAttributes redirectAttributes,HttpServletResponse response, HttpServletRequest request) {
		if (!beanValidator(model, cmPropertyGroup)){
			return form(cmPropertyGroup, model,response,request);
		}
		
		if(cmPropertyGroup.getId()!=null&&"".equals(cmPropertyGroup.getId())){
			try {
				List<CmPropertyGroup> propertyGroups = getNewPropertyGroup(cmPropertyGroup,redirectAttributes,request);
				if(propertyGroups.size()>0){
					boolean flag = false;
					List<String> propertyIds = Lists.newArrayList();
					for(CmPropertyGroup propertyGroup:propertyGroups){
						if(cmPropertyGroupService.findEntityByParameter(propertyGroup.getGroupId(), propertyGroup.getCmPropertyManage().getId()).size()>0){
							
						}else{
							cmPropertyGroupService.save(propertyGroup);
							propertyIds.add(propertyGroup.getCmPropertyManage().getId());
							flag = true;
						}
					}
					
					if(flag){
						cmCiInstanceService.updateInstanceProperty(cmPropertyGroup.getGroupId(),propertyIds,"add");
					}
				}
				String propertyName = "";
				for (CmPropertyGroup cmPropertyGroup2 : propertyGroups) {
					propertyName = cmPropertyManageService.get(cmPropertyGroup2.getCmPropertyManage().getId()).getPropertyName() +" "+ propertyName;
				}
				cmHandleLogService.saveLog(cmCiGroupService.get(cmPropertyGroup.getGroupId()).getGroupName(), "给分类 "+cmCiGroupService.get(cmPropertyGroup.getGroupId()).getGroupName()+" 分配属性："+propertyName);
				
				addMessage(redirectAttributes, "保存分类属性成功");
			} catch (Exception e) {
				addMessage(redirectAttributes, e.getMessage());
				e.printStackTrace();
			}
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyGroup/?groupId="+cmPropertyGroup.getGroupId();
	}
	
	@RequiresPermissions("cm:cmPropertyGroup:edit")
	@RequestMapping(value = "delete")
	public String delete(CmPropertyGroup cmPropertyGroup, RedirectAttributes redirectAttributes) {
		cmPropertyGroupService.delete(cmPropertyGroup);
		
		//分类属性删除配置项版本增加
		List<String> propertyIds = Lists.newArrayList();
		propertyIds.add(cmPropertyGroup.getCmPropertyManage().getId());
		cmCiInstanceService.updateInstanceProperty(cmPropertyGroup.getGroupId(),propertyIds,"del");
		
		cmHandleLogService.saveLog(cmCiGroupService.get(cmPropertyGroup.getGroupId()).getGroupName(), "删除分类  "+cmCiGroupService.get(cmPropertyGroup.getGroupId()).getGroupName()+" 属性："+cmPropertyManageService.get(cmPropertyGroup.getCmPropertyManage().getId()).getPropertyName());
		
		addMessage(redirectAttributes, "删除分类属性关系成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmPropertyGroup/?groupId="+cmPropertyGroup.getGroupId();
	}
	
	/**
	 * 获取新的分类属性绑定关系
	 * @param cmPropertyGroup
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	public List<CmPropertyGroup> getNewPropertyGroup(CmPropertyGroup cmPropertyGroup,RedirectAttributes redirectAttributes, HttpServletRequest request) throws Exception{
		List<CmPropertyGroup> propertyGroups = Lists.newArrayList();
		try {
			String[] propertyIds = request.getParameterValues("propertyId");
			if(null!=propertyIds&&propertyIds.length>0){
				
				for(String propertyId : propertyIds){
					CmPropertyGroup newpropertyGroup = new CmPropertyGroup();
					newpropertyGroup.setGroupId(cmPropertyGroup.getGroupId());
					newpropertyGroup.setCmPropertyManage(new CmPropertyManage(propertyId));
					newpropertyGroup.setStatus("0");
					propertyGroups.add(newpropertyGroup);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("操作失败："+e.getMessage());
		}
		return propertyGroups;
		
	}
}