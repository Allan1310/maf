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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cases.entity.CaseList;
import com.allinfnt.idc.modules.cases.service.CaseListService;
import com.allinfnt.idc.modules.obj.entity.ObjManage;
import com.allinfnt.idc.modules.obj.entity.ObjMethod;
import com.allinfnt.idc.modules.obj.service.ObjManageService;
import com.allinfnt.idc.modules.sys.utils.DictUtils;

/**
 * 对象管理Controller
 * @author xusuojian
 * @version 2015-12-01
 */
@Controller
@RequestMapping(value = "${adminPath}/obj/objManage")
public class ObjManageController extends BaseController {

	@Autowired
	private ObjManageService objManageService;
	@Autowired
	private CaseListService caseListService;
	@ModelAttribute
	public ObjManage get(@RequestParam(required=false) String id) {
		ObjManage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = objManageService.get(id);
		}
		if (entity == null){
			entity = new ObjManage();
		}
		return entity;
	}
	
	@RequiresPermissions("obj:objManage:view")
	@RequestMapping(value = {"list", ""})
	public String list(ObjManage objManage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ObjManage> page = objManageService.findPage(new Page<ObjManage>(request, response), objManage); 
		model.addAttribute("page", page);
		return "modules/obj/objManageList";
	}

	@RequiresPermissions("obj:objManage:view")
	@RequestMapping(value = "form")
	public String form(ObjManage objManage, Model model,HttpServletRequest request) {
		String flag = request.getParameter("flag");   //修改标记
		if(null != flag && flag.equals("update")){
			model.addAttribute("objManage", objManage);
			return "modules/obj/objManageUpdate";
		}else{
		model.addAttribute("objManage", objManage);
		return "modules/obj/objManageForm";
		}
	}

	@RequiresPermissions("obj:objManage:edit")
	@RequestMapping(value = "save")
	public String save(ObjManage objManage, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, objManage)){
			return form(objManage, model,request);
		}
		objManageService.save(objManage, request);
		addMessage(redirectAttributes, "保存对象成功");
		return "redirect:"+Global.getAdminPath()+"/obj/objManage/?repage";
	}
	
	@RequiresPermissions("obj:objManage:edit")
	@RequestMapping(value = "delete")
	public String delete(ObjManage objManage, RedirectAttributes redirectAttributes) {
		objManageService.delete(objManage);
		addMessage(redirectAttributes, "删除对象成功");
		return "redirect:"+Global.getAdminPath()+"/obj/objManage/?repage";
	}
	
	@RequiresPermissions("obj:objManage:view")
	@RequestMapping(value = "selectList")
	public String selectList(ObjManage objManage, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		//用例集id
		String parentId = request.getParameter("parentId"); 
		//得到用例集关联的项目id
		CaseList caseList = caseListService.get(parentId);
		String itemId = caseList.getItemId();
		//得到项目下面的所有对象
		Page<ObjManage> page = objManageService.findObjManageListByItemId(new Page<ObjManage>(request, response), itemId); 
		model.addAttribute("page", page);
		return "modules/obj/objManageSelectList";
	}
	
	@RequestMapping("getCheckedIds")
	public void getCheckedIds(HttpServletResponse response, HttpServletRequest request) {
		try {
			String tempCheckedIds = request.getParameter("tempCheckedIds");
			response.getWriter().print(tempCheckedIds);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "selectData")
    @ResponseBody
    public String selectData(ObjManage objManage, Model model, HttpServletRequest request,
            HttpServletResponse response) {
		ObjManage obj = objManageService.get(objManage.getId());
		//对象名称=对象名称+路径，id
        String data = obj.getPathName()+ "+" + obj.getObjName()+ "," + obj.getId();

        return data;
    }
	
	
}