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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.utils.ZhAlphabet;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;
import com.allinfnt.idc.modules.cm.service.CmCiGroupService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 分类管理Controller
 * @author liujx
 * @version 2015-01-20
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmCiGroup")
public class CmCiGroupController extends BaseController {

	@Autowired
	private CmCiGroupService cmCiGroupService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	
	@ModelAttribute
	public CmCiGroup get(@RequestParam(required=false) String id) {
		CmCiGroup entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmCiGroupService.get(id);
		}
		if (entity == null){
			entity = new CmCiGroup();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmCiGroup:view")
	@RequestMapping(value = {"list"})
	public String list(CmCiGroup cmCiGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<CmCiGroup> list = cmCiGroupService.findList(cmCiGroup); 
//		List<CmCiGroup> list = cmCiGroupService.findByParentIdsLike(cmCiGroup); 
		model.addAttribute("list", list);
		return "modules/cm/cmCiGroupList";
	}

	@RequiresPermissions("cm:cmCiGroup:view")
	@RequestMapping(value = "form")
	public String form(CmCiGroup cmCiGroup, Model model,HttpServletRequest request) {
		String view = request.getParameter("view");
		if (cmCiGroup.getParent()!=null && StringUtils.isNotBlank(cmCiGroup.getParent().getId())){
			cmCiGroup.setParent(cmCiGroupService.get(cmCiGroup.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(cmCiGroup.getId())){
				CmCiGroup cmCiGroupChild = new CmCiGroup();
				cmCiGroupChild.setParent(new CmCiGroup(cmCiGroup.getParent().getId()));
				List<CmCiGroup> list = cmCiGroupService.findList(cmCiGroup); 
				if (list.size() > 0){
					cmCiGroup.setSort(list.get(list.size()-1).getSort());
					if (cmCiGroup.getSort() != null){
						cmCiGroup.setSort(cmCiGroup.getSort() + 10);
					}
				}
			}
		}
		if (cmCiGroup.getSort() == null){
			cmCiGroup.setSort(10);
		}
		model.addAttribute("cmCiGroup", cmCiGroup);
		if(view!=null&&view.equals("view")){
			return "modules/cm/cmCiGroupForm-view";
		}
		return "modules/cm/cmCiGroupForm";
	}

	@RequiresPermissions("cm:cmCiGroup:edit")
	@RequestMapping(value = "save")
	public String save(CmCiGroup cmCiGroup, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if (!beanValidator(model, cmCiGroup)){
			return form(cmCiGroup, model,request);
		}
		
		if(cmCiGroup.getId()==null||cmCiGroup.getId().equals("")){
			if(cmCiGroup.getGroupNumber()==null||cmCiGroup.getGroupNumber().equals("")){
				//自动生成分类编号
				String groupNumber = new ZhAlphabet().String2Alpha(cmCiGroup.getGroupName(), "b");
				if(!groupNumber.equals("0")){
					cmCiGroup.setGroupNumber(groupNumber);
				}
			}
			cmCiGroup.setStatus("1");
			cmCiGroupService.save(cmCiGroup);
			addMessage(redirectAttributes, "保存新分类成功");
			cmHandleLogService.saveLog(cmCiGroup.getGroupName(),"保存配置项分类："+cmCiGroup.getGroupName());
		}else{
			cmCiGroupService.save(cmCiGroup);
			cmHandleLogService.saveLog(cmCiGroup.getGroupName(),"修改配置项分类："+cmCiGroup.getGroupName());
			addMessage(redirectAttributes, "修改分类信息成功");
		}
		
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiGroup/list";
	}
	
	@RequiresPermissions("cm:cmCiGroup:edit")
	@RequestMapping(value = "delete")
	public String delete(CmCiGroup cmCiGroup, RedirectAttributes redirectAttributes) {
		cmCiGroupService.delete(cmCiGroup);
		cmHandleLogService.saveLog(cmCiGroup.getGroupName(), "删除配置项分类："+cmCiGroup.getGroupName());
		addMessage(redirectAttributes, "删除分类信息成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiGroup/list";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String type,@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CmCiGroup> list = cmCiGroupService.findAllList(new CmCiGroup());
		for (int i=0; i<list.size(); i++){
			CmCiGroup e = list.get(i);
			if(e.getStatus().equals("0")){
				if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId());
					map.put("pIds", e.getParentIds());
					map.put("name", e.getGroupName());
					if(null!=type&&"4".equals(type)){
						map.put("isParent", true);
					}
					mapList.add(map);
				}
			}
		}
		return mapList;
	}
	
	/**
	 * 获取配置项分类树显示在分类列表页面
	 * @param cmCiGroupm
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiGroup:view")
	@RequestMapping(value = {""})
	public String index(CmCiGroup cmCiGroup, HttpServletRequest request, HttpServletResponse response, Model model){
		return "modules/cm/cmCiGroupIndex";
	}
	
	/**
	 * 校验分类信息
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "check")
	public void checkGroup(HttpServletRequest request,HttpServletResponse response) throws IOException{
		try {
			String parentId = request.getParameter("parentId");
			String groupName = request.getParameter("groupName");
			if(parentId == null || parentId.equals("")){
				parentId = "0";
			}
			List<CmCiGroup> groups = cmCiGroupService.findEntityByParameter(parentId, groupName);
			response.setContentType("text/html");
			if(groups.size()>0){
				response.getWriter().print("操作失败：有名称相同的分类存在此上级分类下");
			}else{
				response.getWriter().print("ok");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("操作失败：系统异常请稍后再试");
		}
	}
	
	/**
	 * 
	 * @param cmCiGroup
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("cm:cmCiGroup:edit")
	@RequestMapping(value = "update")
	public String update(CmCiGroup cmCiGroup, RedirectAttributes redirectAttributes){
		if(cmCiGroup.getStatus()!=null&&!"".equals(cmCiGroup.getStatus())){
			List<CmCiGroup> groups = cmCiGroupService.findGroupByParentId(cmCiGroup.getId());
			if(groups.size()>0){
				if(cmCiGroup.getStatus().equals("0")){
					addMessage(redirectAttributes, "操作失败："+cmCiGroup.getGroupName()+"此分类下存在已启用的子分类");
				}else{
					cmCiGroup.setStatus("0");
					cmCiGroupService.save(cmCiGroup);
					cmHandleLogService.saveLog(cmCiGroup.getGroupName(),"启用配置项分类："+cmCiGroup.getGroupName());
					addMessage(redirectAttributes, "启用"+cmCiGroup.getGroupName()+"分类成功");
				}
			}else{
				if(cmCiGroup.getStatus().equals("1")){
					cmCiGroup.setStatus("0");
					cmHandleLogService.saveLog(cmCiGroup.getGroupName(),"启用配置项分类："+cmCiGroup.getGroupName());
					addMessage(redirectAttributes, "启用"+cmCiGroup.getGroupName()+"分类成功");
				}else if(cmCiGroup.getStatus().equals("0")){
					cmCiGroup.setStatus("1");
					cmHandleLogService.saveLog(cmCiGroup.getGroupName(),"停用配置项分类："+cmCiGroup.getGroupName());
					addMessage(redirectAttributes, "停用"+cmCiGroup.getGroupName()+"分类成功");
				}
				cmCiGroupService.save(cmCiGroup);
			}
			
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiGroup/list";
	}
	
	/**
	 * 根据分类树查询列表
	 * @param cmCiGroup
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiGroup:view")
	@RequestMapping(value = {"listBy"})
	public String listBy(CmCiGroup cmCiGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<CmCiGroup> list = cmCiGroupService.findByParentIdsLike(cmCiGroup); 
		model.addAttribute("list", list);
		return "modules/cm/cmCiGroupList";
	}
}