/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.web;

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
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cases.entity.CaseList;
import com.allinfnt.idc.modules.cases.service.CaseListService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.allinfnt.idc.modules.test.entity.TestTree;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 用例集管理Controller
 * @author xusuojian
 * @version 2015-12-07
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/caseList")
public class CaseListController extends BaseController {

	@Autowired
	private CaseListService caseListService;
	
	@ModelAttribute
	public CaseList get(@RequestParam(required=false) String id) {
		CaseList entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = caseListService.get(id);
		}
		if (entity == null){
			entity = new CaseList();
		}
		return entity;
	}
	
	@RequiresPermissions("cases:caseList:view")
	@RequestMapping(value = {"list", ""})
	public String list(CaseList caseList, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<CaseList> list = caseListService.findList(caseList); 
		model.addAttribute("list", list);

		return "modules/cases/caseListList";
	}

	@RequiresPermissions("cases:caseList:view")
	@RequestMapping(value = "form")
	public String form(CaseList caseList, Model model) {
		if (caseList.getParent()!=null && StringUtils.isNotBlank(caseList.getParent().getId())){
			caseList.setParent(caseListService.get(caseList.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(caseList.getId())){
				CaseList testTreeChild = new CaseList();
				testTreeChild.setParent(new CaseList(caseList.getParent().getId()));
				List<CaseList> list = caseListService.findList(caseList); 
				if (list.size() > 0){
					caseList.setSort(list.get(list.size()-1).getSort());
					if (caseList.getSort() != null){
						caseList.setSort(caseList.getSort() + 30);
					}
				}
			}
		}
		if (caseList.getSort() == null){
			caseList.setSort(30);
		}
		
		model.addAttribute("caseList", caseList);
		return "modules/cases/caseListForm";
	}

	@RequiresPermissions("cases:caseList:edit")
	@RequestMapping(value = "save")
	public String save(CaseList caseList, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, caseList)){
			return form(caseList, model);
		}
		//如果不是根节点，从父节点取关联项目及ID
		if(!caseList.getParentId().equals("")){
			CaseList cl = caseListService.get(caseList.getParentId());
			caseList.setItemId(cl.getItemId());
			caseList.setItemName(cl.getItemName());
		}
		caseListService.save(caseList);
		addMessage(redirectAttributes, "保存用例集成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseList/?repage";
	}
	
	@RequiresPermissions("cases:caseList:edit")
	@RequestMapping(value = "delete")
	public String delete(CaseList caseList, RedirectAttributes redirectAttributes) {
		caseListService.delete(caseList);
		addMessage(redirectAttributes, "删除用例集成功");
		return "redirect:"+Global.getAdminPath()+"/cases/caseList/?repage";
	}
	
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<CaseList> list = caseListService.findList(new CaseList());
		for (int i=0; i<list.size(); i++){
			CaseList e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}