package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.cm.dao.CmCiInstanceHiDao;
import com.allinfnt.idc.modules.cm.dao.CmCiPropertyHiDao;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;

/**
 * 配置项管理Service
 * @author liujx
 * @version 2015-02-01
 */
@Service
@Transactional(readOnly = true)
public class CmCiInstanceHiService extends CrudService<CmCiInstanceHiDao, CmCiInstanceHi> {

	@Autowired
	private CmCiPropertyHiDao cmCiPropertyHiDao;
	@Autowired
	private CmCiInstanceHiDao cmCiInstanceHiDao;
	
	public CmCiInstanceHi get(String id) {
		return super.get(id);
	}
	
	public List<CmCiInstanceHi> findList(CmCiInstanceHi cmCiInstanceHi) {
		return super.findList(cmCiInstanceHi);
	}
	
	public Page<CmCiInstanceHi> findPage(Page<CmCiInstanceHi> page, CmCiInstanceHi cmCiInstanceHi) {
		cmCiInstanceHi.getSqlMap().put("dsf", dataScopeFilter(cmCiInstanceHi.getCurrentUser(), "o", "u"));
		return super.findPage(page, cmCiInstanceHi);
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiInstanceHi cmCiInstanceHi) {
		super.save(cmCiInstanceHi);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmCiInstanceHi cmCiInstanceHi) {
		super.delete(cmCiInstanceHi);
	}
	
	/***
	 * 查询配置项的所有属性
	 * @param ciId
	 * @return
	 */
	public List<CmCiProperty> findEntityHiByCiId(String ciId,String version){
		return cmCiPropertyHiDao.findEntityHiByCiId(ciId,version);
	}
	
	/***
	 * 查询配置项
	 * @param ciId
	 * @return
	 */
	public CmCiInstanceHi findEntityHiById(String ciId,String version){
		return cmCiInstanceHiDao.findEntityHiByCiId(ciId,version);
	}
	
	/**
	 * 
	 * @param page
	 * @param cmCiInstanceHi
	 * @return
	 */
	public Page<CmCiInstanceHi> findInstancesByVersion(Page<CmCiInstanceHi> page, CmCiInstanceHi cmCiInstanceHi) {
		page.setList(cmCiInstanceHiDao.findInstancesByVersion(cmCiInstanceHi));
		return page;
	} 
}
