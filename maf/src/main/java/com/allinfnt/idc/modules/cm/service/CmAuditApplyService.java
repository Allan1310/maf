/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;
import java.util.Map;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.act.dao.ActDao;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.act.utils.ActUtils;
import com.allinfnt.idc.modules.cm.dao.CmAuditApplyDao;
import com.allinfnt.idc.modules.cm.entity.CmAuditApply;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.OfficeService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 配置项审计Service
 * @author liuzk
 * @version 2015-02-03
 */
@Service
@Transactional(readOnly = true)
public class CmAuditApplyService extends CrudService<CmAuditApplyDao, CmAuditApply> {

	@Autowired
	private CmAuditApplyDao cmAuditApplyDao;
	@Autowired
	private IdentityService identityService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private ActDao actDao;
	
	public CmAuditApply get(String id) {
		return super.get(id);
	}
	
	public List<CmAuditApply> findList(CmAuditApply cmAuditApply) {
		return super.findList(cmAuditApply);
	}
	
	public Page<CmAuditApply> findPage(Page<CmAuditApply> page, CmAuditApply cmAuditApply) {
		cmAuditApply.getSqlMap().put("dsf", dataScopeFilter(cmAuditApply.getCurrentUser(), "o", "u","cm"));
		return super.findPage(page, cmAuditApply);
	}
	
	/**
	 * 启动流程
	 * @param cmAuditApply
	 * @param variables
	 */
	@Transactional(readOnly = false)
	public void save(CmAuditApply cmAuditApply) {
		if (StringUtils.isBlank(cmAuditApply.getId())){
			cmAuditApply.preInsert();
			cmAuditApplyDao.insert(cmAuditApply);
		}else{
			cmAuditApply.preUpdate();
			cmAuditApplyDao.update(cmAuditApply);
		}
		logger.debug("save entity: {}", cmAuditApply);
		
		String businessId = cmAuditApply.getId();
		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
		identityService.setAuthenticatedUserId(cmAuditApply.getCurrentUser().getLoginName());
		// 启动流程
		Map<String, Object> variables = Maps.newHashMap();
		variables.put("type", "auditApply");
		variables.put("busId", businessId);
		variables.put("title", cmAuditApply.getCurrentUser().getName()+"申请配置项审计计划");
		variables.put("applyUserId", cmAuditApply.getCurrentUser().getLoginName());
		
		Office office = officeService.get(cmAuditApply.getCurrentUser().getOffice());
		User primary = UserUtils.get(office.getPrimaryPerson().getId());
		variables.put("subDepartment", primary.getLoginName());
		
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(ActUtils.PD_AUDIT_APPLY[0], ActUtils.PD_AUDIT_APPLY[1]+":"+businessId, variables);
		// 更新流程实例ID
		cmAuditApply.setProcInsId(processInstance.getProcessInstanceId());
		cmAuditApply.preUpdate();
		cmAuditApplyDao.update(cmAuditApply);
		
		logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", new Object[] { 
				ActUtils.PD_AUDIT_APPLY[0], businessId, processInstance.getId(), variables });
		
	}
	
	@Transactional(readOnly = false)
	public void delete(CmAuditApply cmAuditApply) {
		super.delete(cmAuditApply);
	}

	/**
	 * 审核审批保存
	 * @param testAudit
	 */
	@Transactional(readOnly = false)
	public void auditSave(CmAuditApply cmAuditApply, String taskDefKey) {
		// 设置意见
		cmAuditApply.getAct().setComment(("yes".equals(cmAuditApply.getAct().getFlag())?"[同意] ":"[驳回] ")+cmAuditApply.getAct().getComment());
				
		//更新审计计划数据
		cmAuditApply.setRemarks(taskDefKey);
		super.save(cmAuditApply);
		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(cmAuditApply.getAct().getFlag())? "1" : "0");
		actTaskService.complete(cmAuditApply.getAct().getTaskId(), cmAuditApply.getAct().getProcInsId(), cmAuditApply.getAct().getComment(), vars);
	}
	
	@Transactional(readOnly = false)
	public void insert(CmAuditApply cmAuditApply) {
		if (StringUtils.isBlank(cmAuditApply.getId())){
			cmAuditApply.preInsert();
			cmAuditApplyDao.insert(cmAuditApply);
		}else{
			cmAuditApply.preUpdate();
			cmAuditApplyDao.update(cmAuditApply);
		}
	}

}