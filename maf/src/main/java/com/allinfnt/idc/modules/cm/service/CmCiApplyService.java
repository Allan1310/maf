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

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.mapper.JsonMapper;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.JsonUtils;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.act.utils.ActUtils;
import com.allinfnt.idc.modules.cm.dao.CmCiApplyDao;
import com.allinfnt.idc.modules.cm.entity.CmCiApply;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SysIdentityService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 变更申请Service
 * @author liujx
 * @version 2015-01-25
 */
@Service
@Transactional(readOnly = true)
public class CmCiApplyService extends CrudService<CmCiApplyDao, CmCiApply> {

	@Autowired
	private CmCiApplyDao cmCiApplyDao;
	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private IdentityService identityService;
	@Autowired
	private CmHandleLogService cmHandleLogService;
	@Autowired
	private SysIdentityService sysIdentityService;
	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	@Autowired
	private CmRelationOrderService cmRelationOrderService;
	
	public CmCiApply get(String id) {
		return super.get(id);
	}
	
	public List<CmCiApply> findList(CmCiApply cmCiApply) {
		return super.findList(cmCiApply);
	}
	
	public Page<CmCiApply> findPage(Page<CmCiApply> page, CmCiApply cmCiApply) {
		cmCiApply.getSqlMap().put("dsf", dataScopeFilter(cmCiApply.getCurrentUser(), "o", "u","cm"));
		return super.findPage(page, cmCiApply);
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiApply cmCiApply) {
		super.save(cmCiApply);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmCiApply cmCiApply) {
		super.delete(cmCiApply);
	}
	
	/**
	 * 启动配置项变更流程
	 * @param cmCiApply
	 * @param variables
	 */
	@Transactional(readOnly = false)
	public void save(CmCiApply cmCiApply, Map<String, Object> variables){
		User user = UserUtils.getUser();
		// 保存业务数据
		if (StringUtils.isBlank(cmCiApply.getId())){
			cmCiApply.setApplyNumber(sysIdentityService.nextId("CIBZ"));
			cmCiApply.preInsert();
			cmCiApply.setUser(user);
			cmCiApply.setOffice(user.getOffice());
			cmCiApply.setStatus("0");
			cmCiApplyDao.insert(cmCiApply);
		}else{
			cmCiApply.preUpdate();
			cmCiApplyDao.update(cmCiApply);
		}
		logger.debug("save entity: {}", cmCiApply);
		
		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
		identityService.setAuthenticatedUserId(cmCiApply.getCurrentUser().getLoginName());
		
		// 启动流程
		String businessKey = ":"+cmCiApply.getId();
		variables.put("type", "ciApply");
		variables.put("busId", businessKey);
		String handle="";
		if(cmCiApply.getHandle().equals("0")){
			handle="新增";
		}else if(cmCiApply.getHandle().equals("1")){
			handle="修改";
		}else if(cmCiApply.getHandle().equals("2")){
			handle="删除";
		}
		cmHandleLogService.saveLog("发起"+handle+"变更申请"+cmCiApply.getApplyNumber() , "提交配置项变更申请");
		variables.put("title", cmCiApply.getCurrentUser().getName()+"申请配置项"+handle+"审批工单");
		variables.put("applyUserId", cmCiApply.getCurrentUser().getLoginName());
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(ActUtils.PD_CI_APPLY[0], businessKey, variables);
		
		// 更新流程实例ID
		cmCiApply.setProcInsId(processInstance.getProcessInstanceId());
		cmCiApply.preUpdate();
		cmCiApplyDao.update(cmCiApply);
		
		logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", new Object[] { 
				ActUtils.PD_CI_APPLY[0], businessKey, processInstance.getId(), variables });
	}
	
	/**
	 * 审核审批保存
	 * @param testAudit
	 */
	@Transactional(readOnly = false)
	public void auditSave(CmCiApply cmCiApply) {
		
		// 设置意见
		cmCiApply.getAct().setComment(("yes".equals(cmCiApply.getAct().getFlag())?"[同意] ":"[驳回] ")+cmCiApply.getAct().getComment());
		
		//更新配置项状态
		if(cmCiApply.getAct().getTaskDefKey().equals("InformationSubmit")&&"yes".equals(cmCiApply.getAct().getFlag())){
			if(cmCiApply.getCiId().indexOf(";")>-1){
				String[] ciIds = cmCiApply.getCiId().split(";");
				for(String ciId :ciIds){
					CmCiInstance ciInstance = cmCiInstanceService.get(ciId);
					ciInstance.setStatus("3");
					cmCiInstanceService.save(ciInstance);
					cmRelationOrderService.addRelationOrder(ciId, cmCiApply.getId(), "1");
				}
			}else{
				CmCiInstance ciInstance = cmCiInstanceService.get(cmCiApply.getCiId());
				ciInstance.setStatus("3");
				cmCiInstanceService.save(ciInstance);
				cmRelationOrderService.addRelationOrder(cmCiApply.getCiId(), cmCiApply.getId(), "1");
			}
		}
		
		if(cmCiApply.getAct().getTaskDefKey().equals("InformationSubmit")&&"no".equals(cmCiApply.getAct().getFlag())){
			if(cmCiApply.getCiId().indexOf(";")>-1){
				String[] ciIds = cmCiApply.getCiId().split(";");
				for(String ciId :ciIds){
					CmCiInstance ciInstance = cmCiInstanceService.get(ciId);
					if(cmCiApply.getHandle().equals("0")){
						ciInstance.setStatus("0");
					}else if(cmCiApply.getHandle().equals("1")){
						ciInstance.setStatus("2");
					}else if(cmCiApply.getHandle().equals("2")){
						ciInstance.setStatus("6");
					}
					cmCiInstanceService.save(ciInstance);
				}
			}else{
				if(cmCiApply.getCiId()!=null && !"".equals(cmCiApply.getCiId())){
					CmCiInstance ciInstance = cmCiInstanceService.get(cmCiApply.getCiId());
					if(cmCiApply.getHandle().equals("0")){
						ciInstance.setStatus("0");
					}else if(cmCiApply.getHandle().equals("1")){
						ciInstance.setStatus("2");
					}else if(cmCiApply.getHandle().equals("2")){
						ciInstance.setStatus("6");
					}
					cmCiInstanceService.save(ciInstance);
				}
			}
		}
		
		
//		String handle="";
//		if(cmCiApply.getHandle().equals("0")){
//			handle="新增";
//		}else if(cmCiApply.getHandle().equals("1")){
//			handle="修改";
//		}else if(cmCiApply.getHandle().equals("2")){
//			handle="删除";
//		}
		
		//更新配置项数据
		if(cmCiApply.getAct().getTaskDefKey().equals("CiManagerAudit")&&"yes".equals(cmCiApply.getAct().getFlag())){
			if(cmCiApply.getCiId().indexOf(";")>-1){
				String[] ciIds = cmCiApply.getCiId().split(";");
				for(String ciId :ciIds){
					cmCiInstanceService.updateCiInstance(ciId,cmCiApply.getHandle());
				}
			}else{
				cmCiInstanceService.updateCiInstance(cmCiApply.getCiId(),cmCiApply.getHandle());
			}
		}
		cmCiApply.preUpdate();
		cmCiApplyDao.update(cmCiApply);
		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		
//		if(cmCiApply.getAct().getTaskDefKey().equals("ciAdminAudit")&&"no".equals(cmCiApply.getAct().getFlag())){
//			vars.put("title", cmCiApply.getCurrentUser().getName()+"申请配置项"+handle+"审批工单,");
//		}
//		
//		if(cmCiApply.getAct().getTaskDefKey().equals("CiManagerAudit")&&"no".equals(cmCiApply.getAct().getFlag())){
//			vars.put("title", cmCiApply.getCurrentUser().getName()+"申请配置项"+handle+"审批工单");
//		}
		vars.put("pass", "yes".equals(cmCiApply.getAct().getFlag())? "1" : "0");
		actTaskService.complete(cmCiApply.getAct().getTaskId(), cmCiApply.getAct().getProcInsId(), cmCiApply.getAct().getComment(), vars);
		
	}
	
	/**
	 * 查询变更工单接口
	 * @param jsonData
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String findCiApply(String jsonData){
		
		String jsonResult = "";
		Map<String, Object> jsonMap = JsonUtils.readJson2Map(jsonData);
		if(!Canstants.getNotNullString(jsonMap.get("serviceType")).equals("idc_cm_findApply_service")){
			return "NOT THE THRID PARTY";
		}
		Map<String, Object> paramMap = (Map<String, Object>)jsonMap.get("opDetail");
		if(jsonMap.get("selectType").equals("0")){
			CmCiApply apply = get(Canstants.getNotNullString(paramMap.get("id")));
			jsonResult = JsonMapper.toJsonString(apply);
			
		}else if(jsonMap.get("selectType").equals("1")){
			CmCiApply apply = new CmCiApply();
			apply.setHandle(Canstants.getNotNullString(paramMap.get("handle")));
			List<CmCiApply> applyList = cmCiApplyDao.findList(apply);
			jsonResult = JsonMapper.toJsonString(applyList);
		}
		return jsonResult;
		
	}
}