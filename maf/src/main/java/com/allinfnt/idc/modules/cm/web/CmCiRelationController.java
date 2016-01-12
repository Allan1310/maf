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
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.entity.CmCiRelation;
import com.allinfnt.idc.modules.cm.service.CmCiInstanceService;
import com.allinfnt.idc.modules.cm.service.CmCiRelationService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.google.common.collect.Lists;

/**
 * 配置项关联关系Controller
 * @author liujx
 * @version 2015-02-03
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmCiRelation")
public class CmCiRelationController extends BaseController {

	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	@Autowired
	private CmCiRelationService cmCiRelationService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmCiRelation get(@RequestParam(required=false) String id) {
		CmCiRelation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmCiRelationService.get(id);
		}
		if (entity == null){
			entity = new CmCiRelation();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmCiRelation cmCiRelation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmCiRelation> page = cmCiRelationService.findPage(new Page<CmCiRelation>(request, response), cmCiRelation);
		List<CmCiRelation> reRelations = cmCiRelationService.findListByReid(cmCiRelation.getCiInstance().getId());
		List<CmCiRelation> pageRelations = page.getList();
		pageRelations.addAll(reRelations);
		page.setList(pageRelations);
		model.addAttribute("cmCiRelation", cmCiRelation);
		model.addAttribute("ciInstance", cmCiRelation.getCiInstance());
		model.addAttribute("page", page);
		return "modules/cm/cmCiRelationList";
	}

	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "form")
	public String form(CmCiRelation cmCiRelation, Model model) {
		CmCiInstance ciInstance = cmCiInstanceService.get(Canstants.getNotNullString(cmCiRelation.getCiInstance().getId()));
		if(null!=cmCiRelation.getReCiInstance()){
			CmCiInstance reCiInstance = cmCiInstanceService.get(Canstants.getNotNullString(cmCiRelation.getReCiInstance().getId()));
			cmCiRelation.setReCiInstance(reCiInstance);
		}
		
		model.addAttribute("ciInstance", ciInstance);
		cmCiRelation.setCiVersion(ciInstance.getCiVersion());
		cmCiRelation.setCiInstance(ciInstance);
		model.addAttribute("cmCiRelation", cmCiRelation);
		return "modules/cm/cmCiRelationForm";
	}

	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "save")
	public String save(CmCiRelation cmCiRelation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmCiRelation)){
			return form(cmCiRelation, model);
		}
		
		if(null!=cmCiRelation.getId()&&"".equals(cmCiRelation.getId())){
			CmCiInstance reCiInstance = cmCiRelation.getReCiInstance();
			if(reCiInstance.getId().indexOf(",")>-1){
				String[] reCiId = reCiInstance.getId().split(",");
				for(int i = 0;i<reCiId.length;i++){
					CmCiInstance newReInstance = new CmCiInstance();
					CmCiRelation newCmCiRelation =new CmCiRelation();
					
					newReInstance.setId(reCiId[i]);
					newCmCiRelation.setRelationType(cmCiRelation.getRelationType());
					newCmCiRelation.setCiVersion(cmCiRelation.getCiVersion());
					newCmCiRelation.setCiInstance(cmCiRelation.getCiInstance());
					newCmCiRelation.setReCiInstance(newReInstance);
					newCmCiRelation.setStatus("0");
					cmCiRelationService.save(newCmCiRelation);
				}
			}else{
				CmCiInstance newReInstance = new CmCiInstance();
				CmCiRelation newCmCiRelation =new CmCiRelation();
				newReInstance.setId(reCiInstance.getId());
				newCmCiRelation.setRelationType(cmCiRelation.getRelationType());
				newCmCiRelation.setCiVersion(cmCiRelation.getCiVersion());
				newCmCiRelation.setCiInstance(cmCiRelation.getCiInstance());
				newCmCiRelation.setReCiInstance(newReInstance);
				newCmCiRelation.setStatus("0");
				cmCiRelationService.save(newCmCiRelation);
			}
		}
		cmHandleLogService.saveLog(cmCiRelation.getCiInstance().getCiName(),"添加配置项关联："+cmCiRelation.getRelationType()+cmCiRelation.getCiInstance().getCiName());
		addMessage(redirectAttributes, "保存配置项关联成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiRelation/?repage&ciInstance.id="+cmCiRelation.getCiInstance().getId();
	}
	
	@RequiresPermissions("cm:cmCiInstance:edit")
	@RequestMapping(value = "delete")
	public String delete(CmCiRelation cmCiRelation, RedirectAttributes redirectAttributes) {
		cmCiRelationService.delete(cmCiRelation);
		cmHandleLogService.saveLog(cmCiRelation.getCiInstance().getCiName(),"删除配置项关联关系:"+cmCiRelation.getRelationType()+cmCiRelation.getCiInstance().getCiName());
		addMessage(redirectAttributes, "删除配置项关联成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiRelation/?repage&ciInstance.id="+cmCiRelation.getCiInstance().getId();
	}

	/**
	 * 获取配置项的关系显示成拓补图
	 * @param cmCiRelation
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiInstance:view")
	@RequestMapping(value = "graph")
	public String graph(CmCiRelation cmCiRelation, Model model){
		List<CmCiRelation> newRelations = Lists.newArrayList();
		List<CmCiRelation> relations = cmCiRelationService.findList(cmCiRelation);
		List<CmCiRelation> reRelations = cmCiRelationService.findListByReid(cmCiRelation.getCiInstance().getId());
		
		for(CmCiRelation relation : relations){
			relation.setRemarks("正");
			newRelations.add(relation);
		}
		
		for(CmCiRelation relation : reRelations){
			relation.setRemarks("反");
			newRelations.add(relation);
		}
		
		model.addAttribute("size", newRelations.size());
		model.addAttribute("newRelations", newRelations);
		model.addAttribute("ciInstance",cmCiRelation.getCiInstance());
		return "modules/cm/cmCigraph";
	}
}