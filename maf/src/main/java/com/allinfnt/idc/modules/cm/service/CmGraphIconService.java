/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cm.entity.CmGraphIcon;
import com.allinfnt.idc.modules.cm.dao.CmGraphIconDao;

/**
 * 配置项图标Service
 * @author liujx
 * @version 2015-04-07
 */
@Service
@Transactional(readOnly = true)
public class CmGraphIconService extends CrudService<CmGraphIconDao, CmGraphIcon> {

	public CmGraphIcon get(String id) {
		return super.get(id);
	}
	
	public List<CmGraphIcon> findList(CmGraphIcon cmGraphIcon) {
		return super.findList(cmGraphIcon);
	}
	
	public Page<CmGraphIcon> findPage(Page<CmGraphIcon> page, CmGraphIcon cmGraphIcon) {
		return super.findPage(page, cmGraphIcon);
	}
	
	@Transactional(readOnly = false)
	public void save(CmGraphIcon cmGraphIcon) {
		super.save(cmGraphIcon);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmGraphIcon cmGraphIcon) {
		super.delete(cmGraphIcon);
	}
	
}