/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cm.dao.CmAuditTrackDao;
import com.allinfnt.idc.modules.cm.entity.CmAuditTrack;

/**
 * 配置项审计跟踪Service
 * @author liuzk
 * @version 2015-02-03
 */
@Service
@Transactional(readOnly = true)
public class CmAuditTrackService extends CrudService<CmAuditTrackDao, CmAuditTrack> {

	@Autowired
	private CmAuditTrackDao cmAuditTrackDao;
	
	public CmAuditTrack get(String id) {
		return super.get(id);
	}
	
	public List<CmAuditTrack> findList(CmAuditTrack cmAuditTrack) {
		return super.findList(cmAuditTrack);
	}
	
	public Page<CmAuditTrack> findPage(Page<CmAuditTrack> page, CmAuditTrack cmAuditTrack) {
		return super.findPage(page, cmAuditTrack);
	}
	
	@Transactional(readOnly = false)
	public void save(CmAuditTrack cmAuditTrack) {
		super.save(cmAuditTrack);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmAuditTrack cmAuditTrack) {
		super.delete(cmAuditTrack);
	}
	
	public List<CmAuditTrack> findListById(String id){
		return cmAuditTrackDao.findListById(id);
	}
}