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
import com.allinfnt.idc.modules.cm.dao.CmCiRelationDao;
import com.allinfnt.idc.modules.cm.entity.CmCiRelation;

/**
 * 配置项关联关系Service
 * @author liujx
 * @version 2015-02-03
 */
@Service
@Transactional(readOnly = true)
public class CmCiRelationService extends CrudService<CmCiRelationDao, CmCiRelation> {
	
	@Autowired
	private CmCiRelationDao cmCiRelationDao;
	
	public CmCiRelation get(String id) {
		return super.get(id);
	}
	
	public List<CmCiRelation> findList(CmCiRelation cmCiRelation) {
		return super.findList(cmCiRelation);
	}
	
	public Page<CmCiRelation> findPage(Page<CmCiRelation> page, CmCiRelation cmCiRelation) {
		return super.findPage(page, cmCiRelation);
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiRelation cmCiRelation) {
		super.save(cmCiRelation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmCiRelation cmCiRelation) {
		super.delete(cmCiRelation);
	}
	
	/**
	 * 根据关系配置项查询配置项关系列表
	 * @param reid
	 * @return
	 */
	public List<CmCiRelation> findListByReid(String reid){
		return cmCiRelationDao.findListByReid(reid);
	}
}