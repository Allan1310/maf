/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.web;

import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.cm.entity.CmAuditApply;
import com.allinfnt.idc.modules.cm.entity.CmAuditTrack;
import com.allinfnt.idc.modules.cm.service.CmAuditApplyService;
import com.allinfnt.idc.modules.cm.service.CmAuditTrackService;
import com.allinfnt.idc.modules.cm.service.CmCiExportUtil;
import com.allinfnt.idc.modules.cm.service.CmHandleLogService;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SysIdentityService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 配置项审计Controller
 * @author liuzk
 * @version 2015-02-03
 */
@Controller
@RequestMapping(value = "${adminPath}/cm/cmAuditApply")
public class CmAuditApplyController extends BaseController {

	@Autowired
	private CmAuditApplyService cmAuditApplyService;
	@Autowired
	private CmAuditTrackService cmAuditTrackService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private SysIdentityService sysIdentityService;

	@ModelAttribute
	public CmAuditApply get(@RequestParam(required=false) String id) {
		CmAuditApply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = cmAuditApplyService.get(id);
		}
		if (entity == null){
			entity = new CmAuditApply();
		}
		return entity;
	}
	
	@RequiresPermissions("cm:cmAuditApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(CmAuditApply cmAuditApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CmAuditApply> page = cmAuditApplyService.findPage(new Page<CmAuditApply>(request, response), cmAuditApply); 
		model.addAttribute("page", page);
		return "modules/cm/cmAuditApplyList";
	}

	@RequiresPermissions("cm:cmAuditApply:view")
	@RequestMapping(value = "form")
	public String form(CmAuditApply cmAuditApply, Model model, HttpServletRequest request) {
		String flag = request.getParameter("flag");
		String view = "cmAuditApplyForm";
		if ("0".equals(flag) || "2".equals(flag)){
			model.addAttribute("cmAuditApply", cmAuditApply);
			return "modules/cm/cmAuditApplyForm";	
		}
		if (StringUtils.isNotBlank(cmAuditApply.getId())) {
			String taskDefKey = cmAuditApply.getAct().getTaskDefKey();//ciAdminAudit
			
			if(cmAuditApply.getAct().isFinishTask()){
				if("ciManagerAudit".equals(taskDefKey)||"ciAdminAudit".equals(taskDefKey)){
					//根据cmAuditApply.id查到问题列表
					List<CmAuditTrack> CmAuditTrackList =  cmAuditTrackService.findListById(cmAuditApply.getId());
					boolean idTrack = false;
					if(CmAuditTrackList.size()>0){
						idTrack = true;
					}
					model.addAttribute("idTrack", idTrack);
					model.addAttribute("CmAuditTrackList", CmAuditTrackList);
				}
				model.addAttribute("taskDefKey", cmAuditApply.getRemarks());
				view = "cmAuditApplyForm-view";//查看
				
			}else{
				view = "cmAuditApplyForm-audit";//查看审计申请单，填写审计报告，查看审计报告
				model.addAttribute("taskDefKey", taskDefKey);
				if("ciManagerAudit".equals(taskDefKey)||"ciAdminAudit".equals(taskDefKey)){
					//根据cmAuditApply.id查到问题列表
					List<CmAuditTrack> CmAuditTrackList =  cmAuditTrackService.findListById(cmAuditApply.getId());
					boolean idTrack = false;
					if(CmAuditTrackList.size()>0){
						idTrack = true;
					}
					model.addAttribute("idTrack", idTrack);
					model.addAttribute("CmAuditTrackList", CmAuditTrackList);
				}
			}
		}else{
			User user = UserUtils.getUser();
			model.addAttribute("user", user);
		}
		model.addAttribute("cmAuditApply", cmAuditApply);
		return "modules/cm/"+view;
	}

	@RequiresPermissions("cm:cmAuditApply:edit")
	@RequestMapping(value = "save")
	public String save(CmAuditApply cmAuditApply, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		
		if (!beanValidator(model, cmAuditApply)){
			return form(cmAuditApply, model, request);
		}
		String flag = request.getParameter("flag");
		//保存草稿
		if ("0".equals(flag) && cmAuditApply.getId() != null ){
			cmAuditApply.setStatus("0");
			cmAuditApply.setAuditNumber(sysIdentityService.nextId("CIBZ"));
			cmAuditApplyService.insert(cmAuditApply);
			cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "保存审计计划草稿：审计对象 ");
			addMessage(redirectAttributes, "保存审计计划草稿成功");
		}
		//修改草稿
		if ("2".equals(flag) && cmAuditApply.getId() != null ){
			cmAuditApplyService.insert(cmAuditApply);
			cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "修改审计计划草稿：审计对象");
			addMessage(redirectAttributes, "修改审计计划草稿成功");
		}
		//保存并提交流程
		if ("1".equals(flag) && cmAuditApply.getId() != null ) {
			cmAuditApply.setStatus("1");
			if(cmAuditApply.getAuditNumber()==null){
				cmAuditApply.setAuditNumber(sysIdentityService.nextId("CIBZ"));
			}
			cmAuditApplyService.save(cmAuditApply);
			cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "提交审计计划：审计对象 ");
			addMessage(redirectAttributes, "提交审计计划成功");
		}
		return "redirect:"+Global.getAdminPath()+"/cm/cmAuditApply/?repage";
	}
	
	@RequiresPermissions("cm:cmAuditApply:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(CmAuditApply cmAuditApply, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes){
		if(StringUtils.isBlank(cmAuditApply.getAct().getFlag())
				|| StringUtils.isBlank(cmAuditApply.getAct().getComment())){
			addMessage(model, "请求失败,请填写审核意见。");
			return form(cmAuditApply, model, request);
		}
		
		String taskDefKey = cmAuditApply.getAct().getTaskDefKey();
		if("ciAdminAudit".equals(taskDefKey)) {
			//审计报告重新填写，删除之前的问题配置项列表
			List<CmAuditTrack> cmAuditTrackList =  cmAuditTrackService.findListById(cmAuditApply.getId());
			if(cmAuditTrackList.size()>0){
				for(CmAuditTrack track:cmAuditTrackList){
					cmAuditTrackService.delete(track);
				}
			}
			saveCmAuditTrack(cmAuditApply,request);
		}
		cmAuditApplyService.auditSave(cmAuditApply, taskDefKey);
		addMessage(redirectAttributes, "审计计划审批成功。");
		cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "处理审计计划：审计计划 ");
		return "redirect:" + adminPath + "/act/task/todo/";
	}
	
	/**
	 * 从前台获取提交的数据
	 * @param cmAuditApply
	 * @param request
	 * @return
	 */
	public void saveCmAuditTrack(CmAuditApply cmAuditApply,HttpServletRequest request){
		String[] ciIds = request.getParameterValues("ciId");
		String[] ciNames = request.getParameterValues("ciName");
		String[] dutyOfficerIds = request.getParameterValues("dutyOfficerId");
		String[] questions = request.getParameterValues("question");
		String[] solveStatuss = request.getParameterValues("solveStatus");
		String[] planSolveTimes = request.getParameterValues("planSolveTime");
		String[] realitySolveTimes = request.getParameterValues("realitySolveTime");
		if(ciIds.length>0){
			for (int i=0;i<ciIds.length;i++) {
				CmAuditTrack cmAuditTrack = new CmAuditTrack();
				cmAuditTrack.setAuditId(cmAuditApply.getId());
				cmAuditTrack.setCiId(ciIds[i]);
				cmAuditTrack.setCiName(ciNames[i]);
				cmAuditTrack.setQuestion(questions[i]);
				cmAuditTrack.setDutyOfficer(UserUtils.get(dutyOfficerIds[i]));
				cmAuditTrack.setSolveStatus(solveStatuss[i]);
				cmAuditTrack.setPlanSolveTime(planSolveTimes[i]);
				cmAuditTrack.setRealitySolveTime(realitySolveTimes[i]);
				cmAuditTrackService.save(cmAuditTrack);
			}
		}
	}
	
	@RequiresPermissions("cm:cmAuditApply:edit")
	@RequestMapping(value = "delete")
	public String delete(CmAuditApply cmAuditApply, RedirectAttributes redirectAttributes) {
		cmAuditApplyService.delete(cmAuditApply);
		cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "删除审计计划：审计计划 ");
		addMessage(redirectAttributes, "删除配置项审计成功");
		return "redirect:"+Global.getAdminPath()+"/cm/cmAuditApply/?repage";
	}

	/**
	 * 查看审计报告
	 * @param cmAuditApply
	 * @param redirectAttributes
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cm:cmAuditApply:view")
	@RequestMapping(value = "report")
	public String report(CmAuditApply cmAuditApply, RedirectAttributes redirectAttributes, Model model) {
		List<CmAuditTrack> CmAuditTrackList =  cmAuditTrackService.findListById(cmAuditApply.getId());
		model.addAttribute("CmAuditTrackList", CmAuditTrackList);
		model.addAttribute("cmAuditApply", cmAuditApply);
		return "modules/cm/cmAuditReport";
	}
	
	@RequestMapping(value = "reportExport")
	public ModelAndView reportExport(CmAuditApply cmAuditApply, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		List<CmAuditTrack> auditTrackList =  cmAuditTrackService.findListById(cmAuditApply.getId());
		cmHandleLogService.saveLog(cmAuditApply.getAuditNumber(), "导出审计报告：");
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("auditTrackList", auditTrackList);
		map.put("cmAuditApply", cmAuditApply);
		CmCiExportUtil exportUtil=new CmCiExportUtil();
		return new ModelAndView(exportUtil,map);
	}
}