package com.allinfnt.idc.modules.act.utils.workflow;

import java.util.Date;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.beans.factory.annotation.Autowired;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.modules.sys.entity.BpmDelegateApply;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.BpmDelegateApplyService;
import com.allinfnt.idc.modules.sys.service.SystemService;


public class DelegateTaskListener implements TaskListener {

	private static final long serialVersionUID = -2115272708948504865L;

	@Autowired
	private SystemService systemService;
	@Autowired
	private BpmDelegateApplyService bpmDelegateApplyService;
	
	@Override
	public void notify(DelegateTask delegateTask) {
		if (systemService == null) {
			systemService = SpringContextHolder.getBean("systemService");
		}
		if (bpmDelegateApplyService == null) {
			bpmDelegateApplyService = SpringContextHolder.getBean("bpmDelegateApplyService");
		}
		String assignee = delegateTask.getAssignee();
//        String processDefinitionId = delegateTask.getProcessDefinitionId().split(":")[0];
        if(null == assignee){
        	return;
        }
        User user = systemService.getUserByLoginName(assignee);
        BpmDelegateApply delegate = bpmDelegateApplyService.getDelegateInfo(user.getId(), "");

        if (delegate == null) {
            return;
        }
        
        if(Canstants.checkDateInTime(Canstants.DATEFORMAT.format(new Date()),delegate.getStartTime(),delegate.getEndTime())){
        	 String attorney = delegate.getAssigneeUser().getLoginName();
             delegateTask.setAssignee(attorney);
             delegateTask.setOwner(assignee);
        }
	}

}
