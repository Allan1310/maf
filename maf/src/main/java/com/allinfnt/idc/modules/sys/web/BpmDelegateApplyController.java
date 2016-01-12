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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.sys.entity.BpmDelegateApply;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.BpmDelegateApplyService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 任务委托申请Controller
 * @author liujx
 * @version 2015-03-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/bpmDelegateApply")
public class BpmDelegateApplyController extends BaseController {

	@Autowired
	private BpmDelegateApplyService bpmDelegateApplyService;
	
	@ModelAttribute
	public BpmDelegateApply get(@RequestParam(required=false) String id) {
		BpmDelegateApply entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bpmDelegateApplyService.get(id);
		}
		if (entity == null){
			entity = new BpmDelegateApply();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:bpmDelegateApply:view")
	@RequestMapping(value = {"list", ""})
	public String list(BpmDelegateApply bpmDelegateApply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BpmDelegateApply> page = bpmDelegateApplyService.findPage(new Page<BpmDelegateApply>(request, response), bpmDelegateApply); 
		model.addAttribute("page", page);
		return "modules/sys/bpmDelegateApplyList";
	}

	@RequiresPermissions("sys:bpmDelegateApply:view")
	@RequestMapping(value = "form")
	public String form(BpmDelegateApply bpmDelegateApply, Model model) {
		model.addAttribute("bpmDelegateApply", bpmDelegateApply);
		return "modules/sys/bpmDelegateApplyForm";
	}

	@RequiresPermissions("sys:bpmDelegateApply:edit")
	@RequestMapping(value = "save")
	public String save(BpmDelegateApply bpmDelegateApply, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bpmDelegateApply)){
			return form(bpmDelegateApply, model);
		}
		if(Canstants.getNotNullString(bpmDelegateApply.getId()).equals("")){
			User user = UserUtils.getUser();
			
			List<BpmDelegateApply> oldDelegates = bpmDelegateApplyService.findList(bpmDelegateApply);
			
			if(oldDelegates.size()>0){
				for(BpmDelegateApply apply:oldDelegates){
					if(!Canstants.checkDateInTime(bpmDelegateApply.getStartTime(), apply.getStartTime(), apply.getEndTime())){
						if(Canstants.checkDateInTime(bpmDelegateApply.getEndTime(), apply.getStartTime(), apply.getEndTime())){
							addMessage(redirectAttributes, "委托申请失败，此时间段内"+bpmDelegateApply.getStartTime()+"--"+bpmDelegateApply.getEndTime()+"存在另外一个正在执行的委托申请。");
							return "redirect:"+Global.getAdminPath()+"/sys/bpmDelegateApply/?repage";
						}
					}else{
						addMessage(redirectAttributes, "委托申请失败，此时间段内"+bpmDelegateApply.getStartTime()+"--"+bpmDelegateApply.getEndTime()+"存在另外一个正在执行的委托申请。");
						return "redirect:"+Global.getAdminPath()+"/sys/bpmDelegateApply/?repage";
					}
				}
			}
			bpmDelegateApply.setApplyUser(user);
			bpmDelegateApply.setStatus("0");
			bpmDelegateApplyService.save(bpmDelegateApply);
			addMessage(redirectAttributes, "保存任务委托申请成功");
		}else{
			bpmDelegateApplyService.save(bpmDelegateApply);
			addMessage(redirectAttributes, "修改任务委托申请成功");
		}
		return "redirect:"+Global.getAdminPath()+"/sys/bpmDelegateApply/?repage";
	}
	
	@RequiresPermissions("sys:bpmDelegateApply:edit")
	@RequestMapping(value = "delete")
	public String delete(BpmDelegateApply bpmDelegateApply, RedirectAttributes redirectAttributes) {
		bpmDelegateApplyService.delete(bpmDelegateApply);
		addMessage(redirectAttributes, "删除任务委托申请成功");
		return "redirect:"+Global.getAdminPath()+"/sys/bpmDelegateApply/?repage";
	}

}