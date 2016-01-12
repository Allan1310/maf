/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.service.TreeService;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cm.entity.CmBaseCode;
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.dao.CmBaseCodeDao;
import com.allinfnt.idc.modules.cm.dao.CmCiGroupDao;
import com.allinfnt.idc.modules.cm.dao.CmCiInstanceDao;

/**
 * 分类管理Service
 * @author liujx
 * @version 2015-01-20
 */
@Service
@Transactional(readOnly = true)
public class CmCiGroupService extends TreeService<CmCiGroupDao, CmCiGroup> {
	@Autowired
	private CmCiGroupDao cmCiGroupDao;
	@Autowired
	private CmBaseCodeDao cmBaseCodeDao;
	@Autowired
	private CmCiInstanceDao cmCiInstanceDao;

	public CmCiGroup get(String id) {
		return super.get(id);
	}
	
	public List<CmCiGroup> findList(CmCiGroup cmCiGroup) {
		if (StringUtils.isNotBlank(cmCiGroup.getParentIds())){
//			cmCiGroup.setParentIds(","+cmCiGroup.getParentIds()+",");
			cmCiGroup.setParentIds(cmCiGroup.getParentIds());
		}
		return super.findList(cmCiGroup);
	}
	
	@Transactional(readOnly = false)
	public void save(CmCiGroup cmCiGroup) {
		
		//如果分类的图标发生改动，那么此分类下的所有配置项的图标全部修改
		if(cmCiGroup.getId()!=null&&!"".equals(cmCiGroup.getId())){
			CmCiGroup oldCiGroup = cmCiGroupDao.get(cmCiGroup);
			if(!Canstants.getNotNullString(oldCiGroup.getCmGraphIcon().getId()).equals(Canstants.getNotNullString(cmCiGroup.getCmGraphIcon().getId()))){
				CmCiInstance ciInstance = new CmCiInstance();
				ciInstance.setCmCiGroup(cmCiGroup);
				List<CmCiInstance> instances = cmCiInstanceDao.findList(ciInstance);
				if(instances.size()>0){
					for(CmCiInstance instance:instances){
						instance.setCmGraphIcon(cmCiGroup.getCmGraphIcon());
						cmCiInstanceDao.update(instance);
					}
				}
			}
			
		}
		
		super.save(cmCiGroup);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmCiGroup cmCiGroup) {
		super.delete(cmCiGroup);
	}
	
	/**
	 * 查询同一父分类下是否存在此分类
	 * @param parentId 父分类编号
	 * @param groupName 分类名称
	 * @return
	 */
	public List<CmCiGroup> findEntityByParameter(String parentId,String groupName){
		return dao.findEntityByParameter(parentId, groupName);
		
	}
	
	public List<CmCiGroup> findAllList(CmCiGroup cmCiGroup) {
		if (StringUtils.isNotBlank(cmCiGroup.getParentIds())){
			cmCiGroup.setParentIds(","+cmCiGroup.getParentIds()+",");
		}
		return cmCiGroupDao.findAllList(cmCiGroup);
	}
	
	public List<CmCiGroup> findByParentIdsLike(CmCiGroup cmCiGroup){
		if (StringUtils.isNotBlank(cmCiGroup.getParentId())){
			cmCiGroup.setParentIds(cmCiGroup.getParentId()+","+cmCiGroup.getId());
		}
		return cmCiGroupDao.findByParentIdsLike(cmCiGroup);
	}
	
	/**
	 * 查询此分类下是否存在已启用的子分类
	 * @param parentId
	 * @return
	 */
	public List<CmCiGroup> findGroupByParentId(String parentId){
		return dao.findGroupByParentId(parentId);
		
	}
	
	/**
	 * 获取排序的下一个值
	 * @return
	 */
	public String getNextSortValue(){
		return cmBaseCodeDao.findBaseCodeByName("groupSortNum").getCodeValue();
		
	}
	
	/**
	 * 更新排序的下一个值
	 * @param value
	 * @return
	 */
	@Transactional(readOnly = false)
	public int updateNextSortValue(Integer value){
		CmBaseCode baseCode = cmBaseCodeDao.findBaseCodeByName("groupSortNum");
		baseCode.setCodeValue(String.valueOf(value+10));
		return cmBaseCodeDao.update(baseCode);
		
	}
}