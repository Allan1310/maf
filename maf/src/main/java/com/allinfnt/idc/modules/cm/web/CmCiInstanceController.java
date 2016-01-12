/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.utils.excel.POIExcelUtil;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;
import com.allinfnt.idc.modules.cm.entity.CmInstanceContrast;
import com.allinfnt.idc.modules.cm.entity.CmPropertyGroup;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.cm.service.CmCiGroupService;
import com.allinfnt.idc.modules.cm.service.CmCiInstanceHiService;
import com.allinfnt.idc.modules.cm.service.CmCiInstanceService;
import com.allinfnt.idc.modules.cm.service.CmCiPropertyService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.allinfnt.idc.modules.cm.service.CmPropertyGroupService;
import com.allinfnt.idc.modules.cm.service.CmPropertyManageService;
import com.allinfnt.idc.modules.sys.dao.UserDao;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.OfficeService;
import com.allinfnt.idc.modules.sys.utils.DictUtils;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 配置项管理Controller
 * @author liuzk
 * @version 2015-01-22
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmCiInstance")
public class CmCiInstanceController extends BaseController {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private CmCiGroupService cmCiGroupService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private CmCiPropertyService cmCiPropertyService;
	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	@Autowired
	private CmCiInstanceHiService cmCiInstanceHiService;
	@Autowired
	private CmPropertyGroupService cmPropertyGroupService;
	@Autowired
	private CmPropertyManageService cmPropertyManageService;
	
	@ModelAttribute
	public CmCiInstance get(@RequestParam(required=false) String id) {
		CmCiInstance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmCiInstanceService.get(id);
		}
		if (entity == null){
			entity = new CmCiInstance();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = {"list",""})
	public String list(CmCiInstance cmCiInstance, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		if(cmCiInstance.getExt1()!=null&&"1".equals(cmCiInstance.getExt1())){
			/**
			 * 获取此分类下所有的专有属性，并动态生成属性的表单代码
			 */
			List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findEntityByGroupId(cmCiInstance.getCmCiGroup().getId(), "1");
			List<CmPropertyGroup> newPropertyGroups = Lists.newArrayList();
			int num = 0;
			for(CmPropertyGroup propertyGroup:propertyGroups){
				CmPropertyManage property = propertyGroup.getCmPropertyManage();
				property.setRemarks(Canstants.dynamicFormByType(property,"1","",num));
				num++;
				propertyGroup.setCmPropertyManage(property);
				newPropertyGroups.add(propertyGroup);
			}
			
			/**
			 * 获取全部通用属性，并动态生成属性表单代码
			 */
			List<CmPropertyManage> propertyManages = cmPropertyManageService.findPropertyByType(Canstants.cm_property_TY);
			List<CmPropertyManage> newpropertyManages = Lists.newArrayList();
			for(CmPropertyManage propertyManage:propertyManages){
				propertyManage.setRemarks(Canstants.dynamicFormByType(propertyManage,"1","",num));
				num++;
				newpropertyManages.add(propertyManage);
			}
			
			model.addAttribute("newPropertyGroups", newPropertyGroups);
			model.addAttribute("newpropertyManages", newpropertyManages);
			return "modules/cm/cmCiInstanceForm";
		}else{
			Page<CmCiInstance> page = cmCiInstanceService.findPage(new Page<CmCiInstance>(request, response), cmCiInstance);
			if(cmCiInstance.getCmCiGroup()!=null&&cmCiInstance.getCmCiGroup().getId()!=null){
				cmCiInstance.setCmCiGroup(cmCiGroupService.get(cmCiInstance.getCmCiGroup()));
			}
			model.addAttribute("cmCiInstance", cmCiInstance);
			model.addAttribute("page", page);
			return "modules/cm/cmCiInstanceList";
		}
		
	}

	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "form")
	public String form(CmCiInstance cmCiInstance, Model model, HttpServletRequest request) {
		String view = request.getParameter("view");
		String his = request.getParameter("his");
		model.addAttribute("cmCiInstance", cmCiInstance);
		model.addAttribute("user", UserUtils.getUser());
		if(view!=null&&!"".equals(view))
		{
			List<CmCiProperty> ciPropertys = Lists.newArrayList();
			if(null!=his&&!"".equals(his)){
				ciPropertys = cmCiInstanceHiService.findEntityHiByCiId(cmCiInstance.getId(),his);
				CmCiInstanceHi  cmCiInstanceHi = cmCiInstanceHiService.findEntityHiById(cmCiInstance.getId(), his);
				model.addAttribute("cmCiInstance", cmCiInstanceHi);
			}else{
				ciPropertys = cmCiInstanceService.findEntityByCiId(cmCiInstance.getId());
			}
			
			List<CmCiProperty> TYProperty = Lists.newArrayList();
			List<CmCiProperty> ZYProperty = Lists.newArrayList();
			for(CmCiProperty cmCiProperty : ciPropertys){
				if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
					TYProperty.add(cmCiProperty);
				}else{
					ZYProperty.add(cmCiProperty);
				}
			}
			if("view".equals(view)){
				List<CmCiProperty> newTYProperty = Lists.newArrayList();
				for(CmCiProperty ciProperty:TYProperty){
					if(ciProperty.getProperty().getDataType().equals("3")&&ciProperty.getProperty().getExt2().equals("9")){
						User user = userDao.get(ciProperty.getPropertyValue());
						ciProperty.setPropertyValue(user.getName());
					}
					if(ciProperty.getProperty().getDataType().equals("3")&&ciProperty.getProperty().getExt2().equals("11")){
						Office office = officeService.get(ciProperty.getPropertyValue());
						ciProperty.setPropertyValue(office.getName());
					}
					newTYProperty.add(ciProperty);
				}
				model.addAttribute("TYProperty", newTYProperty);
				model.addAttribute("ZYProperty", ZYProperty);
				return "modules/cm/cmCiInstanceForm-view";
			}else if("update".equals(view)){
				int num = 0;
				List<CmCiProperty> newTYProperty = Lists.newArrayList();
				for(CmCiProperty ciProperty:TYProperty){
					ciProperty.setRemarks(Canstants.dynamicFormByType(ciProperty.getProperty(),"0",ciProperty.getPropertyValue(),num));
					num++;
					newTYProperty.add(ciProperty);
				}
				
				List<CmCiProperty> newZYProperty = Lists.newArrayList();
				for(CmCiProperty ciProperty:ZYProperty){
					ciProperty.setRemarks(Canstants.dynamicFormByType(ciProperty.getProperty(),"0",ciProperty.getPropertyValue(),num));
					num++;
					newZYProperty.add(ciProperty);
				}
				
				
				model.addAttribute("TYProperty", newTYProperty);
				model.addAttribute("ZYProperty", newZYProperty);
				return "modules/cm/cmCiInstanceForm-update";
			}
			
		}
		return "modules/cm/cmCiInstanceForm";
	}

	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "save")
	public String save(CmCiInstance cmCiInstance, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmCiInstance)){
			return form(cmCiInstance, model,request);
		}
		
		if(cmCiInstance.getId()!=null&&"".equals(cmCiInstance.getId())){
			CmCiGroup ciGroup = cmCiGroupService.get(cmCiInstance.getCmCiGroup());
			cmCiInstance.setCmGraphIcon(ciGroup.getCmGraphIcon());
			cmCiInstance.setCiVersion(Canstants.getVersionString(""));
			cmCiInstance.setStatus("5");
			cmCiInstance.setExt1("1");
		}else{
			if(cmCiInstance.getExt1().equals("1")){
				List<CmCiProperty> ciPropertys = getCiPropertys(cmCiInstance,request,"0");
				for(CmCiProperty ciProperty:ciPropertys){
					cmCiInstanceService.save(ciProperty);
				}
				cmCiInstance.setExt1("2");
				cmCiInstance.setStatus("0");
				cmHandleLogService.saveLog(cmCiInstance.getCiName() , "新增配置项："+cmCiInstance.getCiName());
			}else if(cmCiInstance.getExt1().equals("2")){
				List<CmCiProperty> ciPropertys = getCiPropertys(cmCiInstance,request,"1");
				for(CmCiProperty ciProperty:ciPropertys){
					cmCiInstanceService.save(ciProperty);
				}
				cmCiInstance.setStatus("2");
				CmCiInstance oldInstance = cmCiInstanceService.get(cmCiInstance.getId());
				if(!cmCiInstance.getCiVersion().equals(oldInstance.getCiVersion())){
					cmCiInstance.setRemarks(Canstants.getNotNullString(cmCiInstance.getRemarks())+"version:"+cmCiInstance.getCiVersion()+";");
					cmCiInstance.setCiVersion(oldInstance.getCiVersion());
				}
				
				if(!cmCiInstance.getCiStatusA().equals(oldInstance.getCiStatusA())){
					cmCiInstance.setRemarks(Canstants.getNotNullString(cmCiInstance.getRemarks())+"statusA:"+cmCiInstance.getCiStatusA()+";");
					cmCiInstance.setCiStatusA(oldInstance.getCiStatusA());
				}
				
				if(!cmCiInstance.getCiStatusB().equals(oldInstance.getCiStatusB())){
					cmCiInstance.setRemarks(Canstants.getNotNullString(cmCiInstance.getRemarks())+"statusB:"+cmCiInstance.getCiStatusB()+";");
					cmCiInstance.setCiStatusB(oldInstance.getCiStatusB());
				}
			}
		}
		
		cmCiInstanceService.save(cmCiInstance);
		if(cmCiInstance.getExt1().equals("1")){
			return "redirect:"+Global.getAdminPath()+"/cm/cmCiInstance/list?id="+cmCiInstance.getId();
		}
		addMessage(redirectAttributes, "保存配置项成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiInstance/list";
	}
	
	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "delete")
	public String delete(CmCiInstance cmCiInstance, RedirectAttributes redirectAttributes) {
		if("4".equals(cmCiInstance.getStatus())){
			cmCiInstanceService.delete(cmCiInstance);
			cmHandleLogService.saveLog(cmCiInstance.getCiName(),"删除配置项模型："+cmCiInstance.getCiName());
			addMessage(redirectAttributes, "删除配置项模型成功");
			return "redirect:"+Global.getAdminPath()+"/cm/cmCiInstance/model";
		}
		
		if("1".equals(cmCiInstance.getStatus())){
			cmCiInstance.setStatus("6");
			cmCiInstanceService.save(cmCiInstance);
			addMessage(redirectAttributes, "配置项已更改为待删除状态，请发起变更申请");
			cmHandleLogService.saveLog(cmCiInstance.getCiName(),"删除配置项："+cmCiInstance.getCiName());
		}else if("0".equals(cmCiInstance.getStatus())||"2".equals(cmCiInstance.getStatus())
														||"1".equals(cmCiInstance.getExt1())){
			cmCiInstanceService.delete(cmCiInstance);
			addMessage(redirectAttributes, "删除配置项成功");
			cmHandleLogService.saveLog(cmCiInstance.getCiName(),"删除配置项："+cmCiInstance.getCiName());
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiInstance/list";
	}
	
	/**
	 * 查询模型列表
	 * @param cmCiInstance
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "model")
	public String model(CmCiInstance cmCiInstance, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<CmCiInstance> page = cmCiInstanceService.findPageIsModel(new Page<CmCiInstance>(request, response), cmCiInstance);
		if(cmCiInstance.getCmCiGroup()!=null&&cmCiInstance.getCmCiGroup().getId()!=null){
			cmCiInstance.setCmCiGroup(cmCiGroupService.get(cmCiInstance.getCmCiGroup()));
		}
		model.addAttribute("cmCiInstance", cmCiInstance);
		model.addAttribute("page", page);
		return "modules/cm/cmCiInstanceModelList";
	}
	
	/**
	 * 获取配置项属性信息
	 * @param cmCiInstance
	 * @param request
	 * @param saveType 0:新增，1：修改
	 * @return
	 */
	public List<CmCiProperty> getCiPropertys(CmCiInstance cmCiInstance, HttpServletRequest request,String saveType){
		List<CmCiProperty> ciPropertys = Lists.newArrayList();
		if(saveType.equals("0")){
			List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findEntityByGroupId(cmCiInstance.getCmCiGroup().getId(), "1");
			List<CmPropertyManage> propertyManages = cmPropertyManageService.findPropertyByType(Canstants.cm_property_TY);
			for(CmPropertyGroup propertyGroup:propertyGroups){
				CmCiProperty ciProperty = new CmCiProperty();
				ciProperty.setCiId(cmCiInstance.getId());
				ciProperty.setCiVersion(cmCiInstance.getCiVersion());
				ciProperty.setProperty(propertyGroup.getCmPropertyManage());
				ciProperty.setPropertyValue(Canstants.getNotNullString(request.getParameter("PT"+propertyGroup.getCmPropertyManage().getId())));
				ciProperty.setStatus("0");
				ciProperty.setHandle("0");
				ciProperty.setHandleStatus("0");
				ciPropertys.add(ciProperty);
			}
			
			for(CmPropertyManage propertyManage:propertyManages){
				if(propertyManage.getPropertyName().equals("设备名称")){
					cmCiInstance.setCiName(Canstants.getNotNullString(request.getParameter("PT"+propertyManage.getId())));
				}
				if(propertyManage.getPropertyName().equals("设备编号")){
					cmCiInstance.setCiNumber(Canstants.getNotNullString(request.getParameter("PT"+propertyManage.getId())));
				}
				CmCiProperty ciProperty = new CmCiProperty();
				ciProperty.setCiId(cmCiInstance.getId());
				ciProperty.setCiVersion(cmCiInstance.getCiVersion());
				ciProperty.setProperty(propertyManage);
				ciProperty.setPropertyValue(Canstants.getNotNullString(request.getParameter("PT"+propertyManage.getId())));
				ciProperty.setStatus("0");
				ciProperty.setHandle("0");
				ciProperty.setHandleStatus("0");
				ciPropertys.add(ciProperty);
			}
		}else if(saveType.equals("1")){
			List<CmCiProperty> cmCiPropertys = cmCiInstanceService.findEntityByCiId(cmCiInstance.getId());
			for(CmCiProperty cmCiProperty:cmCiPropertys){
				if(!Canstants.getNotNullString(cmCiProperty.getPropertyValue()).equals(Canstants.getNotNullString(request.getParameter("PT"+cmCiProperty.getProperty().getId())))){
					cmCiProperty.setPropertyUpdateValue(Canstants.getNotNullString(request.getParameter("PT"+cmCiProperty.getProperty().getId())));
					cmCiProperty.setHandle("1");
					cmCiProperty.setHandleStatus("1");
				}
				ciPropertys.add(cmCiProperty);
			}
		}
		
		
		
		return ciPropertys;
	}

	/**
	 * 配置项模型页面跳转
	 * 
	 * @param cmCiInstance
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "modelForm")
	public String modelForm(CmCiInstance cmCiInstance, Model model,
			RedirectAttributes redirectAttributes) {
		model.addAttribute("cmCiGroup", cmCiInstance.getCmCiGroup());
		return "modules/cm/cmCiInstanceModelForm";
	}
	
	/**
	 * 保存配置项模型
	 * 
	 * @param cmCiInstance
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "modelSave")
	public String modelSave(CmCiInstance cmCiInstance, Model model,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, cmCiInstance)) {
			return form(cmCiInstance, model, request);
		}
		
		if(cmCiInstance.getId()==null||cmCiInstance.getId().equals("")){
			CmCiGroup ciGroup = cmCiGroupService.get(cmCiInstance.getCmCiGroup());
			cmCiInstance.setCmGraphIcon(ciGroup.getCmGraphIcon());
			cmCiInstance.setStatus("4");
			cmCiInstanceService.save(cmCiInstance);
			cmHandleLogService.saveLog(cmCiInstance.getCiName(), "新增配置项模型："+cmCiInstance.getCiName());
			addMessage(redirectAttributes, "保存配置项模型成功");
		}else{
			cmCiInstanceService.save(cmCiInstance);
			cmHandleLogService.saveLog(cmCiInstance.getCiName(), "修改配置项模型："+cmCiInstance.getCiName());
			addMessage(redirectAttributes, "修改配置项模型成功");
		}
		
		return "redirect:" + Global.getAdminPath() + "/cm/cmCiInstance/model";
	}
	
	/**
	 * 查看配置项模型详细信息
	 * 
	 * @param cmCiInstance
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "modelDetail")
	public String modelDetail(CmCiInstance cmCiInstance,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		CmCiGroup cmCiGroup = cmCiGroupService.get(cmCiInstance.getCmCiGroup().getId());
		cmCiInstance.setExt2(cmCiGroup.getGroupName());
		model.addAttribute("cmCiInstance", cmCiInstance);
		/* 获取此分类下所有的专有属性，并动态生成属性的表单代码 */
		List<CmPropertyGroup> cmPropertyGroupList = cmPropertyGroupService
				.findEntityByGroupId(cmCiInstance.getCmCiGroup().getId(), "1");
		List<CmPropertyGroup> newPropertyGroups = Lists.newArrayList();
		int num= 0;
		for (CmPropertyGroup propertyGroup : cmPropertyGroupList) {
			CmPropertyManage property = propertyGroup.getCmPropertyManage();
			property.setRemarks(Canstants.dynamicFormByType(property,"1","",num));
			num++;
			propertyGroup.setCmPropertyManage(property);
			newPropertyGroups.add(propertyGroup);
		}
		model.addAttribute("newPropertyGroups", newPropertyGroups);
		/* 获取全部通用属性，并动态生成属性表单代码 */
		List<CmPropertyManage> TYSXList = cmPropertyManageService
				.findPropertyByType(Canstants.cm_property_TY);
		List<CmPropertyManage> newTYPropertyGroups = Lists.newArrayList();
		for (CmPropertyManage property : TYSXList) {
			property.setRemarks(Canstants.dynamicFormByType(property,"1","",num));
			num++;
			newTYPropertyGroups.add(property);
		}
		model.addAttribute("newTYPropertyGroups", newTYPropertyGroups);
		return "modules/cm/cmCiInstanceModelDetail";
	}
	
	@RequestMapping(value = "modelExport")
	public String modelExport(CmCiInstance cmCiInstance,
			HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			List<CmPropertyManage> TYSXList = cmPropertyManageService.findPropertyByType(Canstants.cm_property_TY);
			List<CmPropertyGroup> cmPropertyGroupList = cmPropertyGroupService.findEntityByGroupId(cmCiInstance.getCmCiGroup().getId(), "1");
			List<CmPropertyGroup> newPropertyGroups = Lists.newArrayList();
			List<CmPropertyManage> ZYSXList = Lists.newArrayList();
			for (CmPropertyGroup propertyGroup : cmPropertyGroupList) {
				CmPropertyManage property = propertyGroup.getCmPropertyManage();
				newPropertyGroups.add(propertyGroup);
				ZYSXList.add(property);
			}
			TYSXList.addAll(ZYSXList);
			List<String> propertyNameList = Lists.newArrayList();
			propertyNameList.add("配置项分类");
			propertyNameList.add("运行状态");
			propertyNameList.add("使用状态");
			for (CmPropertyManage cmPropertyManage : TYSXList) {
				propertyNameList.add(cmPropertyManage.getPropertyName());
			}
			cmHandleLogService.saveLog(cmCiInstance.getCiName(), "导出配置项模型："+cmCiInstance.getCiName());
			cmCiInstanceService.exportModel(cmCiInstance, request, response, TYSXList, propertyNameList);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导出配置项模型失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/cm/cmCiInstance/?repage";
	}

	@RequestMapping(value = "batchImport")
	public String batchImport(){
		return "modules/cm/cmCiInstanceBatchImport";
	}
	/**
	 * 批量导入配置项
	 * @param cmCiInstance
	 * @param model
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "batchSave")
	public String batchSave(CmCiInstance cmCiInstance, Model model, MultipartFile multipartFile,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		try{
			if(StringUtils.isBlank(multipartFile.getOriginalFilename())){
				throw new RuntimeException("导入文档为空!");
			}else if(!multipartFile.getOriginalFilename().toLowerCase().endsWith("xls") && !multipartFile.getOriginalFilename().toLowerCase().endsWith("xlsx")){    
				throw new RuntimeException("文档格式不正确!");
	        }
			List<Object> valueList = Lists.newArrayList();
			List<List<Object>> dataList = POIExcelUtil.readExcel(multipartFile.getInputStream(), 0, 1, 0);
			String groupId = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().indexOf("-")+1,multipartFile.getOriginalFilename().lastIndexOf(".xlsx"));
			
			/**
			 * 获取分类全部属性
			 */
			List<CmPropertyManage> propertyManages = cmPropertyManageService.findPropertyByType(Canstants.cm_property_TY);
			List<CmPropertyGroup> propertyGroups = cmPropertyGroupService.findEntityByGroupId(groupId, "1");
			for(CmPropertyGroup propertyGroup:propertyGroups){
				propertyManages.add(propertyGroup.getCmPropertyManage());
			}
			
			boolean errorFlag = false;
			StringBuffer errorMeg = new StringBuffer();
			List<String> ids = Lists.newArrayList();
			for (int i = 1; i < dataList.size(); i++) {
				boolean flag = false;
				errorMeg.append("导入失败：第"+i+"行");
				valueList = dataList.get(i);
				List<CmCiProperty> cmCiPropertys = Lists.newArrayList();
				CmCiInstance instance = new CmCiInstance();
				CmCiGroup ciGroup = cmCiGroupService.get(groupId);
				instance.setStatus("1");
				instance.setExt1("2");
				instance.setCiVersion(Canstants.getVersionString(""));
				instance.setCmCiGroup(ciGroup);
				instance.setCmGraphIcon(ciGroup.getCmGraphIcon());
				cmCiInstanceService.save(instance);
				
				for (int j = 0; j < valueList.size(); j++) {
					
					if(j<3){//取出配置项状态
						if(j == 1){
							instance.setCiStatusA(DictUtils.getDictValue(Canstants.getNotNullString(valueList.get(j)), "ci_status_a", ""));
						}else if(j == 2){
							instance.setCiStatusB(DictUtils.getDictValue(Canstants.getNotNullString(valueList.get(j)), "ci_status_b", ""));
						}
					}else{
						//取出配置项属性
						CmCiProperty cmCiProperty = new CmCiProperty();
						CmPropertyManage property = propertyManages.get(j-3);
						String value = Canstants.getNotNullString(valueList.get(j));
						
						if(property.getIsNull().equals("0")&&value.equals("")){
							flag = true;
							errorMeg.append(property.getPropertyName()+"为必填项，不能为空。");
						}
						
						cmCiProperty.setCiId(instance.getId());
						cmCiProperty.setCiVersion(instance.getCiVersion());
						cmCiProperty.setProperty(property);
						cmCiProperty.setHandle("0");
						cmCiProperty.setStatus("0");
						cmCiProperty.setHandleStatus("0");
						
						if(property.getDataType().equals("3")&&property.getExt2().equals("9")){
							User user = userDao.getUserByName(value);
							if(user == null||user.getId().equals("")){
								flag = true;
								errorMeg.append("系统中"+property.getPropertyName()+"没有此"+value+"人员。");
							}else{
								cmCiProperty.setPropertyValue(user.getId());
							}
						}else if(property.getDataType().equals("3")&&property.getExt2().equals("11")){
							Office office = officeService.findByName(value);
							if(office == null||office.getId().equals("")){
								flag = true;
								errorMeg.append("系统中"+property.getPropertyName()+"没有此"+value+"部门或机构。");
							}else{
								cmCiProperty.setPropertyValue(office.getId());
							}
						}else {
							if(property.getPropertyName().indexOf("设备名称")>-1){
								instance.setCiName(value);
							}else if(property.getPropertyName().indexOf("设备编号")>-1){
								instance.setCiNumber(value);
							}
							cmCiProperty.setPropertyValue(value);
						}
						cmCiPropertys.add(cmCiProperty);
					}
				}
				if(flag){
					cmCiInstanceService.delete(instance);
					errorFlag = flag;
				}else{
					for(CmCiProperty cmCiProperty: cmCiPropertys){
						cmCiPropertyService.save(cmCiProperty);
					}
					ids.add(instance.getId());
					cmCiInstanceService.save(instance);
					cmHandleLogService.saveLog(instance.getCiName(), "导入配置项："+instance.getCiName());
				}
			}
			
			if(errorFlag){
				for(String id : ids){
					cmCiInstanceService.delete(new CmCiInstance(id));
				}
				addMessage(redirectAttributes, errorMeg.toString());
			}else{
				addMessage(redirectAttributes, "批量导入配置项信息成功");
			}
		}catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "批量导入配置项信息信息失败,请检查文件类型与文件是否一致、文件格式是否正确！"+ e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/cm/cmCiInstance/?repage";
	}
	
	/**
	 * 展示配置项列表
	 * @param cmCiInstance
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "listView")
	public String listView(CmCiInstance cmCiInstance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmCiInstance> page = cmCiInstanceService.findPage(new Page<CmCiInstance>(request, response), cmCiInstance);
		model.addAttribute("cmCiInstance", cmCiInstance);
		model.addAttribute("page", page);
		return "modules/cm/cmCiInstanceList-view";
	}

	@RequestMapping(value = "report")
	public String report(CmCiInstance cmCiInstance, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(cmCiInstance, request, response, model);
		return "modules/cm/cmCiInstanceReport";
	}
	
	/**
	 * 报表导出
	 * @param cmCiInstance
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "reportExport")
	public String reportExport(CmCiInstance cmCiInstance,
			HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		String ids = request.getParameter("ids");
		try {
			if(ids == null || ids.equals("")){
				addMessage(redirectAttributes, "报表导出失败，请选择要导出的配置项！");
			}else{
				cmCiInstanceService.exportReport(cmCiInstance, request, response, redirectAttributes, ids);
				addMessage(redirectAttributes, "报表导出成功！");
				return null;
			}
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出配置项模型失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/cm/cmCiInstance/report?repage&status=1";
	}
	
	
	/**
	 * 展示配置项版本列表
	 * @param cmCiInstance
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "listVersion")
	public String listVersion(CmCiInstance cmCiInstance, Model model, HttpServletRequest request, HttpServletResponse response){
		
		CmCiInstance instance = get(cmCiInstance.getId());
		CmCiInstanceHi cmCiInstanceHi = new CmCiInstanceHi();
		cmCiInstanceHi.setId(cmCiInstance.getId());
		Page<CmCiInstanceHi> page = cmCiInstanceHiService.findPage(new Page<CmCiInstanceHi>(request, response), cmCiInstanceHi); 
		model.addAttribute("page", page);
		model.addAttribute("instance", instance);
		return "modules/cm/cmCiInstanceList-version";
		
	}
	
	/**
	 * 获取两个对比的配置项信息
	 * @param model
	 * @param request
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "contrast")
	public String contrast(Model model, HttpServletRequest request){
		
		String[] ciId = request.getParameter("ciId").split(",");
		String[] ciVersion = request.getParameter("ciVersion").split(",");
		String oldOrNew = request.getParameter("oldOrNew");
		
		List<CmCiProperty> leftTYProperty = Lists.newArrayList();
		List<CmCiProperty> leftZYProperty = Lists.newArrayList();
		List<CmCiProperty> rightTYProperty = Lists.newArrayList();
		List<CmCiProperty> rightZYProperty = Lists.newArrayList();
		/**
		 * 获取左边配置项信息
		 */
		if(oldOrNew.equals("1")){
			CmCiInstance leftCiInstance = cmCiInstanceService.get(Canstants.getNotNullString(ciId[0]));
			List<CmCiProperty> leftCiPropertys = cmCiInstanceService.findEntityByCiId(Canstants.getNotNullString(ciId[0]));
			
			for(CmCiProperty cmCiProperty : leftCiPropertys){
				if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
					if(cmCiProperty.getProperty().getPropertyName().indexOf("维护人员")>-1){
						User user = userDao.get(cmCiProperty.getPropertyValue());
						cmCiProperty.setPropertyValue(user.getName());
					}
					leftTYProperty.add(cmCiProperty);
				}else{
					leftZYProperty.add(cmCiProperty);
				}
			}
			model.addAttribute("leftCiInstance", leftCiInstance);
		}else{
			CmCiInstanceHi leftCiInstance = cmCiInstanceHiService.findEntityHiById(Canstants.getNotNullString(ciId[0]),Canstants.getNotNullString(ciVersion[0]));
			List<CmCiProperty> leftCiPropertys = cmCiInstanceHiService.findEntityHiByCiId(Canstants.getNotNullString(ciId[0]),Canstants.getNotNullString(ciVersion[0]));
			for(CmCiProperty cmCiProperty : leftCiPropertys){
				if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
					if(cmCiProperty.getProperty().getPropertyName().indexOf("维护人员")>-1){
						User user = userDao.get(cmCiProperty.getPropertyValue());
						cmCiProperty.setPropertyValue(user.getName());
					}
					leftTYProperty.add(cmCiProperty);
				}else{
					leftZYProperty.add(cmCiProperty);
				}
			}
			model.addAttribute("leftCiInstance", leftCiInstance);
		}
		
		
		/**
		 * 获取右边配置项信息
		 */
		if(oldOrNew.equals("2")){
			CmCiInstance rightCiInstance = cmCiInstanceService.get(Canstants.getNotNullString(ciId[1]));
			List<CmCiProperty> rightCiPropertys = cmCiInstanceService.findEntityByCiId(Canstants.getNotNullString(ciId[1]));
			for(CmCiProperty cmCiProperty : rightCiPropertys){
				if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
					if(cmCiProperty.getProperty().getPropertyName().indexOf("维护人员")>-1){
						User user = userDao.get(cmCiProperty.getPropertyValue());
						cmCiProperty.setPropertyValue(user.getName());
					}
					rightTYProperty.add(cmCiProperty);
				}else{
					rightZYProperty.add(cmCiProperty);
				}
			}
			
			model.addAttribute("rightCiInstance", rightCiInstance);
		}else{
			CmCiInstanceHi rightCiInstance = cmCiInstanceHiService.findEntityHiById(Canstants.getNotNullString(ciId[1]),Canstants.getNotNullString(ciVersion[1]));
			List<CmCiProperty> rightCiPropertys = cmCiInstanceHiService.findEntityHiByCiId(Canstants.getNotNullString(ciId[1]),Canstants.getNotNullString(ciVersion[1]));
			for(CmCiProperty cmCiProperty : rightCiPropertys){
				if(cmCiProperty.getProperty().getPropertyType().equals(Canstants.cm_property_TY)){
					if(cmCiProperty.getProperty().getPropertyName().indexOf("维护人员")>-1){
						User user = userDao.get(cmCiProperty.getPropertyValue());
						cmCiProperty.setPropertyValue(user.getName());
					}
					rightTYProperty.add(cmCiProperty);
				}else{
					rightZYProperty.add(cmCiProperty);
				}
			}
			
			model.addAttribute("rightCiInstance", rightCiInstance);
			
		}
		
		List<CmInstanceContrast> contrasts  = Lists.newArrayList();
		if(leftZYProperty.size()>rightZYProperty.size()){
			for(CmCiProperty leftProperty : leftZYProperty){
				CmInstanceContrast contrast = new CmInstanceContrast();
				boolean flag = false;
				for(CmCiProperty rightProperty : rightZYProperty){
					if(leftProperty.getProperty().getId().equals(rightProperty.getProperty().getId())){
						contrast.setProertyName(leftProperty.getProperty().getPropertyName());
						contrast.setPropertyLfValue(leftProperty.getPropertyValue());
						contrast.setPropertyRgValue(rightProperty.getPropertyValue());
						if(leftProperty.getPropertyValue().equals(rightProperty.getPropertyValue())){
							contrast.setIs_equal(true);
						}else{
							contrast.setIs_equal(false);
						}
						flag = true;
					}
				}
				
				if(!flag){
					contrast.setProertyName(leftProperty.getProperty().getPropertyName());
					contrast.setPropertyLfValue(leftProperty.getPropertyValue());
					contrast.setPropertyRgValue("--");
					contrast.setIs_equal(false);
				}
				contrasts.add(contrast);
			}
		}else{
			for(CmCiProperty rightProperty : rightZYProperty){
				CmInstanceContrast contrast = new CmInstanceContrast();
				boolean flag = false;
				for(CmCiProperty leftProperty : leftZYProperty){
					if(leftProperty.getProperty().getId().equals(rightProperty.getProperty().getId())){
						contrast.setProertyName(leftProperty.getProperty().getPropertyName());
						contrast.setPropertyLfValue(leftProperty.getPropertyValue());
						contrast.setPropertyRgValue(rightProperty.getPropertyValue());
						if(leftProperty.getPropertyValue().equals(rightProperty.getPropertyValue())){
							contrast.setIs_equal(true);
						}else{
							contrast.setIs_equal(false);
						}
						flag = true;
					}
				}
				
				if(!flag){
					contrast.setProertyName(rightProperty.getProperty().getPropertyName());
					contrast.setPropertyLfValue("--");
					contrast.setPropertyRgValue(rightProperty.getPropertyValue());
					contrast.setIs_equal(false);
				}
				contrasts.add(contrast);
			}
		}
		
		model.addAttribute("zyProperty", contrasts);
		model.addAttribute("leftTYProperty", leftTYProperty);
		model.addAttribute("rightTYProperty", rightTYProperty);
		return "modules/cm/cmCiInstanceForm-contrast";
		
	}
	
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String groupId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CmCiInstance> list = cmCiInstanceService.findEntityByGroupId(groupId);
		for (int i=0; i<list.size(); i++){
			CmCiInstance e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("pId", groupId);
			map.put("name", StringUtils.replace(e.getCiName(), " ", ""));
			mapList.add(map);
		}
		return mapList;
	}
	
	/**
	 * 查询Ci实例信息
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "/findCIByParameters")
	public void findCIByParameters(HttpServletRequest request, HttpServletResponse response ) throws IOException{
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			String jsonData = Canstants.getJsonContext(request);
			String result = cmCiInstanceService.findCIByParameters(jsonData);
			response.getWriter().print(Canstants.getJsonResult(true,result));
		} catch (Exception e) {
			response.getWriter().print(Canstants.getJsonResult(false,e.getMessage()));
		}
		
	}
	
	/**
	 * 查询配置项属性接口
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "findCiProperty")
	public void findCiProperty(HttpServletRequest request, HttpServletResponse response ) throws IOException{
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			String jsonData = Canstants.getJsonContext(request);
			String result = cmCiInstanceService.findCiProperty(jsonData);
			response.getWriter().print(Canstants.getJsonResult(true,result));
		} catch (Exception e) {
			response.getWriter().print(Canstants.getJsonResult(false,e.getMessage()));
		}
	}
	
	/**
	 * 校验版本号
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "checkOutVersion")
	public void checkOutVersion(HttpServletRequest request, HttpServletResponse response ) throws IOException{
		try {
			String version = request.getParameter("version");
			String ciId = request.getParameter("ciId");
			CmCiInstance instance = get(ciId);
			String result = Canstants.checkOutVersion(version, instance.getCiVersion());
			response.getWriter().print(result);
		} catch (Exception e) {
			response.getWriter().print(e.getMessage());
		}
	}
	
	/**
	 * 配置项版本回退
	 * @param cmCiInstance
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "versionRollback")
	public String versionRollback(CmCiInstance cmCiInstance, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		try {
			cmCiInstanceService.versionRollback(cmCiInstance);
			addMessage(redirectAttributes, "版本回退成功");
			CmCiInstance instance = get(cmCiInstance.getId());
			CmCiInstanceHi cmCiInstanceHi = new CmCiInstanceHi();
			cmCiInstanceHi.setId(cmCiInstance.getId());
			Page<CmCiInstanceHi> page = cmCiInstanceHiService.findPage(new Page<CmCiInstanceHi>(request, response), cmCiInstanceHi); 
			model.addAttribute("page", page);
			model.addAttribute("instance", instance);
		} catch (Exception e) {
			addMessage(redirectAttributes, "回退失败："+e.getMessage());
		}
		return "modules/cm/cmCiInstanceList-version";
		
	}
	
	@RequestMapping(value = "update")
	public String update(CmCiInstance cmCiInstance, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes){
		if(cmCiInstance.getStatus().equals("2")){
			cmCiInstance.setRemarks("");
		}
		cmCiInstance.setStatus("1");
		cmCiInstanceService.save(cmCiInstance);
		addMessage(redirectAttributes, "重置数据成功！");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiInstance/list";
	}
}