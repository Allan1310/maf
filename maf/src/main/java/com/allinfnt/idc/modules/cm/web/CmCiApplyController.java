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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.JsonUtils;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmCiApply;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.service.CmCiApplyService;
import com.allinfnt.idc.modules.cm.service.CmCiInstanceService;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 变更申请Controller
 * @author liujx
 * @version 2015-01-25
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmCiApply")
public class CmCiApplyController extends BaseController {

	@Autowired
	private CmCiApplyService cmCiApplyService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	
	@ModelAttribute
	public CmCiApply get(@RequestParam(required=false) String id) {
		CmCiApply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmCiApplyService.get(id);
		}
		if (entity == null){
			entity = new CmCiApply();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmCiApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmCiApply cmCiApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmCiApply> page = cmCiApplyService.findPage(new Page<CmCiApply>(request, response), cmCiApply); 
		model.addAttribute("page", page);
		return "modules/cm/cmCiApplyList";
	}

	@RequiresPermissions("cm:cmCiApply:view")
	@RequestMapping(value = "form")
	public String form(CmCiApply cmCiApply, Model model) {
		String view = "cmCiApplyForm";
		if (StringUtils.isNotBlank(cmCiApply.getId())){
			String taskDefKey = cmCiApply.getAct().getTaskDefKey();
			if(cmCiApply.getAct().isFinishTask()){
				view = "cmCiApplyForm-view";
			}else{
				view = "cmCiApplyForm-audit";
				
				//获取配置项列表
				if(cmCiApply.getCiId()!=null && !cmCiApply.getCiId().equals("")){
					List<CmCiInstance> instances = Lists.newArrayList();
					if(cmCiApply.getCiId().indexOf(";")>-1){
						String[] ciIds = cmCiApply.getCiId().split(";");
						for(String ciId :ciIds){
							instances.add(cmCiInstanceService.get(ciId));
						}
					}else{
						instances.add(cmCiInstanceService.get(cmCiApply.getCiId()));
					}
					
					model.addAttribute("instances", instances);
				}
				model.addAttribute("taskDefKey", taskDefKey);
			}
			
		}else{
			User user = UserUtils.getUser();
			model.addAttribute("user", user);
		}
		model.addAttribute("cmCiApply", cmCiApply);
		return "modules/cm/"+view;
	}

	@RequiresPermissions("cm:cmCiApply:edit")
	@RequestMapping(value = "save")
	public String save(CmCiApply cmCiApply, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, cmCiApply)){
			return form(cmCiApply, model);
		}
		
		if(cmCiApply.getId()==null||cmCiApply.getId().equals("")){
			Map<String, Object> variables = Maps.newHashMap();
			cmCiApplyService.save(cmCiApply,variables);
			addMessage(redirectAttributes, "变更申请发起成功");
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiApply/?repage";
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param testAudit
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmCiApply:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(CmCiApply cmCiApply, Model model, RedirectAttributes redirectAttributes) {
		if ((StringUtils.isBlank(cmCiApply.getAct().getFlag())
				|| StringUtils.isBlank(cmCiApply.getAct().getComment()))&&!"InformationSubmit".equals(cmCiApply.getAct().getTaskDefKey())){
			addMessage(model, "请填写审核意见。");
			return form(cmCiApply, model);
		}
		cmCiApplyService.auditSave(cmCiApply);
		cmHandleLogService.saveLog(cmCiApply.getApplyNumber() , "处理配置项变更申请");
		addMessage(redirectAttributes, "变更工单处理成功");
		return "redirect:" + adminPath + "/act/task/todo/";
	}
	
	/**
	 * 删除变更请求
	 * @param cmCiApply
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("cm:cmCiApply:edit")
	@RequestMapping(value = "delete")
	public String delete(CmCiApply cmCiApply, RedirectAttributes redirectAttributes) {
		cmCiApplyService.delete(cmCiApply);
		cmHandleLogService.saveLog(cmCiApply.getApplyNumber() , "删除配置项变更申请");
		
		addMessage(redirectAttributes, "删除变更申请成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmCiApply/?repage";
	}

	/**
	 * CI变更申请接口
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "ciChangeApply")
	@SuppressWarnings("unchecked")
	public void ciChangeApply(HttpServletRequest request, HttpServletResponse response ) throws IOException{
		try {
			String result = "";
			CmCiApply cmCiApply = new CmCiApply();
			
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			
			String jsonData = Canstants.getJsonContext(request);
			Map<String, Object> jsonMap = JsonUtils.readJson2Map(jsonData);
			if(!Canstants.getNotNullString(jsonMap.get("serviceType")).equals("idc_cm_change_service")){
				result = "NOT THE THRID PARTY";
			}
			
			Map<String, Object> paramMap = (Map<String, Object>)jsonMap.get("opDetail");
			cmCiApply.setHandle(Canstants.getNotNullString(paramMap.get("handle")));
			
			Map<String, Object> variables = Maps.newHashMap();
			cmCiApplyService.save(cmCiApply,variables);
			result="SUCCESS";
			response.getWriter().print(Canstants.getJsonResult(true,result));
		} catch (Exception e) {
			response.getWriter().print(Canstants.getJsonResult(false,e.getMessage()));
		}
	}
	
	/**
	 * 查询变更工单接口
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "findCiApply")
	public void findCiApply(HttpServletRequest request, HttpServletResponse response ) throws IOException{
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			
			String jsonData = Canstants.getJsonContext(request);
			String result = cmCiApplyService.findCiApply(jsonData);
			
			response.getWriter().print(Canstants.getJsonResult(true,result));
		} catch (Exception e) {
			response.getWriter().print(Canstants.getJsonResult(false,e.getMessage()));
		}
	}
}