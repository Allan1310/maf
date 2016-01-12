/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cm.entity.CmBaseCode;
import com.allinfnt.idc.modules.cm.entity.CmBaseLine;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;
import com.allinfnt.idc.modules.cm.dao.CmBaseCodeDao;
import com.allinfnt.idc.modules.cm.dao.CmBaseLineDao;

/**
 * 配置项基线Service
 * @author liujx
 * @version 2015-03-02
 */
@Service
@Transactional(readOnly = true)
public class CmBaseLineService extends CrudService<CmBaseLineDao, CmBaseLine> {

	@Autowired
	private CmBaseCodeDao cmBaseCodeDao;
	
	@Autowired
	private CmCiInstanceService cmCiInstanceService;
	@Autowired
	private CmCiInstanceHiService cmCiInstanceHiService;
	
	public CmBaseLine get(String id) {
		return super.get(id);
	}
	
	public List<CmBaseLine> findList(CmBaseLine cmBaseLine) {
		return super.findList(cmBaseLine);
	}
	
	public Page<CmBaseLine> findPage(Page<CmBaseLine> page, CmBaseLine cmBaseLine) {
		cmBaseLine.getSqlMap().put("dsf", dataScopeFilter(cmBaseLine.getCurrentUser(), "o", "u"));
		return super.findPage(page, cmBaseLine);
	}
	
	/**
	 * 生成配置项基线
	 */
	@Transactional(readOnly = false)
	public void save(CmBaseLine cmBaseLine) {
		CmBaseCode basecode = cmBaseCodeDao.findBaseCodeByName("baseLine");
		String[] VArray = basecode.getCodeValue().split("-");
		String baseLineV = Canstants.getVersionString(VArray[1]);
		cmBaseLine.setBaseVersion(VArray[0]+baseLineV);
		super.save(cmBaseLine);
		cmCiInstanceService.createNewBaseLine(VArray[0]+baseLineV);
		basecode.setCodeValue(VArray[0]+"-"+baseLineV);
		cmBaseCodeDao.update(basecode);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmBaseLine cmBaseLine) {
		super.delete(cmBaseLine);
	}
	
	/**
	 * 
	 * @param page
	 * @param cmCiInstance
	 * @return
	 */
	public Page<CmCiInstanceHi> findPage(Page<CmCiInstanceHi> page, CmCiInstanceHi cmCiInstanceHi) {
		return cmCiInstanceHiService.findInstancesByVersion(page, cmCiInstanceHi);
	}
	
}