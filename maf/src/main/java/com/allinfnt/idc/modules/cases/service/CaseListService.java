/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.TreeService;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cases.entity.CaseList;
import com.allinfnt.idc.modules.sys.entity.Area;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.allinfnt.idc.modules.cases.dao.CaseListDao;

/**
 * 用例集管理Service
 * @author xusuojian
 * @version 2015-12-07
 */
@Service
@Transactional(readOnly = true)
public class CaseListService extends TreeService<CaseListDao, CaseList> {

	public CaseList get(String id) {
		return super.get(id);
	}
	
	public List<CaseList> findList(CaseList caseList) {
		if (StringUtils.isNotBlank(caseList.getParentIds())){
			caseList.setParentIds(","+caseList.getParentIds()+",");
		}
		return super.findList(caseList);
	}

	@Transactional(readOnly = false)
	public void save(CaseList caseList) {
		super.save(caseList);
	}
	
	@Transactional(readOnly = false)
	public void delete(CaseList caseList) {
		super.delete(caseList);
	}
	
}