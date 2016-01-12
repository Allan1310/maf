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
import com.allinfnt.idc.modules.cm.entity.CmBaseCode;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.cm.dao.CmBaseCodeDao;
import com.allinfnt.idc.modules.cm.dao.CmPropertyManageDao;

/**
 * 属性管理Service
 * @author liujx
 * @version 2015-01-18
 */
@Service
@Transactional(readOnly = true)
public class CmPropertyManageService extends CrudService<CmPropertyManageDao, CmPropertyManage> {
	@Autowired
	private CmBaseCodeDao cmBaseCodeDao;
	@Autowired
	private CmPropertyManageDao cmPropertyManageDao;
	
	public CmPropertyManage get(String id) {
		return super.get(id);
	}
	
	public List<CmPropertyManage> findList(CmPropertyManage cmPropertyManage) {
		return super.findList(cmPropertyManage);
	}
	
	public Page<CmPropertyManage> findPage(Page<CmPropertyManage> page, CmPropertyManage cmPropertyManage) {
		return super.findPage(page, cmPropertyManage);
	}
	
	@Transactional(readOnly = false)
	public void save(CmPropertyManage cmPropertyManage) {
		super.save(cmPropertyManage);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmPropertyManage cmPropertyManage) {
		super.delete(cmPropertyManage);
	}
	
	/**
	 * 根据属性名称查询属性信息
	 * @author liujx
	 * @param propertyName 属性名称
	 * @param propertyType 属性类型
	 * @param dataType	属性数据类型
	 * @return
	 */
	public List<CmPropertyManage> findPropertyByName(String propertyName,String propertyType,String dataType){
		return dao.findPropertyByName(propertyName,propertyType,dataType);
		
	}
	
	/**
	 * 根据属性类型查询
	 * @param propertyType
	 * @return
	 */
	public List<CmPropertyManage> findPropertyByType(String propertyType){
		return dao.findPropertyByType(propertyType);
		
	}
	
	public List<CmPropertyManage> findListByName(String propertyName){
		return cmPropertyManageDao.findListByName(propertyName);
	}
	
	/**
	 * 获取排序的下一个值
	 * @return
	 */
	public String getNextSortValue(){
		return cmBaseCodeDao.findBaseCodeByName("sortNum").getCodeValue();
		
	}
	
	/**
	 * 更新排序的下一个值
	 * @param value
	 * @return
	 */
	@Transactional(readOnly = false)
	public int updateNextSortValue(Integer value){
		CmBaseCode baseCode = cmBaseCodeDao.findBaseCodeByName("sortNum");
		baseCode.setCodeValue(String.valueOf(value+10));
		return cmBaseCodeDao.update(baseCode);
		
	}
}