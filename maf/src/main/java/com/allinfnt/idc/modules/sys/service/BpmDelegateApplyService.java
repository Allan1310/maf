/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.sys.dao.BpmDelegateApplyDao;
import com.allinfnt.idc.modules.sys.entity.BpmDelegateApply;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 任务委托申请Service
 * @author liujx
 * @version 2015-03-29
 */
@Service
@Transactional(readOnly = true)
public class BpmDelegateApplyService extends CrudService<BpmDelegateApplyDao, BpmDelegateApply> {

	@Autowired
	private BpmDelegateApplyDao bpmDelegateApplyDao;
	
	public BpmDelegateApply get(String id) {
		return super.get(id);
	}
	
	public List<BpmDelegateApply> findList(BpmDelegateApply bpmDelegateApply) {
		bpmDelegateApply.setApplyUser(UserUtils.getUser());
		return super.findList(bpmDelegateApply);
	}
	
	public Page<BpmDelegateApply> findPage(Page<BpmDelegateApply> page, BpmDelegateApply bpmDelegateApply) {
		bpmDelegateApply.setApplyUser(UserUtils.getUser());
		return super.findPage(page, bpmDelegateApply);
	}
	
	@Transactional(readOnly = false)
	public void save(BpmDelegateApply bpmDelegateApply) {
		super.save(bpmDelegateApply);
	}
	
	@Transactional(readOnly = false)
	public void delete(BpmDelegateApply bpmDelegateApply) {
		super.delete(bpmDelegateApply);
	}

	/**
	 * 查询委托任务
	 * @param assignee
	 * @param processDefinitionId
	 * @return
	 */
	public BpmDelegateApply getDelegateInfo(String assignee,String processDefinitionId) {
		return bpmDelegateApplyDao.getDelegateInfo(assignee, processDefinitionId,Canstants.DATEFORMAT_2.format(new Date()));
	}
	
	/***
	 * 删除时间到期的委托任务
	 */
	@Transactional(readOnly = false)
	public void deleteDelegateApply(){
		logger.info("开始执行删除到期委托申请定时任务");
		try {
			List<BpmDelegateApply> applys = bpmDelegateApplyDao.findDelegateApply(Canstants.DATEFORMAT_2.format(new Date()));
			if(applys.size()>0){
				for(BpmDelegateApply apply:applys){
					apply.setStatus("1");
					apply.preUpdate();
					bpmDelegateApplyDao.update(apply);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("删除到期委托申请执行完成");
	}
	
}