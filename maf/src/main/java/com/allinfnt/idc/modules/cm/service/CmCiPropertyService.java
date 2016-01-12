/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cm.dao.CmCiPropertyDao;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;

/**
 * 配置项管理Service
 * @author liuzk
 * @version 2015-01-22
 */
@Service
@Transactional(readOnly = true)
public class CmCiPropertyService extends CrudService<CmCiPropertyDao, CmCiProperty> {
	@Autowired
	private CmCiPropertyDao cmCiPropertyDao;
	
	@Transactional(readOnly = false)
	public void save(CmCiProperty cmCiProperty) {
		super.save(cmCiProperty);
	}
}