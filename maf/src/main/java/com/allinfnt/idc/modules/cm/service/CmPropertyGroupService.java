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
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;
import com.allinfnt.idc.modules.cm.entity.CmPropertyGroup;
import com.allinfnt.idc.modules.cm.dao.CmPropertyGroupDao;
import com.google.common.collect.Lists;

/**
 * 分类属性关系Service
 * @author liujx
 * @version 2015-01-20
 */
@Service
@Transactional(readOnly = true)
public class CmPropertyGroupService extends CrudService<CmPropertyGroupDao, CmPropertyGroup> {

	@Autowired
	private CmCiGroupService cmCiGroupService;
	
	public CmPropertyGroup get(String id) {
		return super.get(id);
	}
	
	public List<CmPropertyGroup> findList(CmPropertyGroup cmPropertyGroup) {
		
		List<CmPropertyGroup> propertyGroups = Lists.newArrayList();
		propertyGroups = dao.findEntityByGroupId(cmPropertyGroup.getGroupId());
		CmCiGroup cmCiGroup = cmCiGroupService.get(cmPropertyGroup.getGroupId());
		if(cmCiGroup!=null&&cmCiGroup.getId()!=null&&!"".equals(cmCiGroup.getId())){
			String[] parents = cmCiGroup.getParentIds().split(",");
			if(parents.length>0){
				for(String parentId : parents){
					if(!parentId.equals("")&&!parentId.equals("0")){
						propertyGroups.addAll(dao.findEntityByGroupId(parentId));
					}
				}
			}
			return propertyGroups;
		}
		return propertyGroups;
	}
	
	public Page<CmPropertyGroup> findPage(Page<CmPropertyGroup> page, CmPropertyGroup cmPropertyGroup) {
		if(cmPropertyGroup.getGroupId()!=null&&!"".equals(cmPropertyGroup.getGroupId())){
			return page.setList(dao.findEntityByGroupId(cmPropertyGroup.getGroupId()));
		}
		return super.findPage(page, cmPropertyGroup);
	}
	
	@Transactional(readOnly = false)
	public void save(CmPropertyGroup cmPropertyGroup) {
		super.save(cmPropertyGroup);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmPropertyGroup cmPropertyGroup) {
		super.delete(cmPropertyGroup);
	}
	
	/**
	 * 根据属性ID查询属性绑定的分类
	 * @param propertyId 属性ID
	 * @return
	 */
	public List<CmPropertyGroup> findEntityByPropertyId(String propertyId){
		return dao.findEntityByPropertyId(propertyId);
		
	}
	
	/**
	 * 根据分类ID查询此分类绑定的所有属性
	 * @param groupId 分类ID
	 * @param type 0：查询此分类的所有属性，1：查询此分类以及其父节点的所有属性
	 * @return
	 */
	public List<CmPropertyGroup> findEntityByGroupId(String groupId,String type){
		if(type.equals("0")){
			return dao.findEntityByGroupId(groupId);
		}else if(type.equals("1")){
			List<CmPropertyGroup> propertyGroups = Lists.newArrayList();
			CmCiGroup ciGroup = cmCiGroupService.get(groupId);
			
			if(ciGroup.getId()!=null&&!"".equals(ciGroup.getId())){
				propertyGroups = dao.findEntityByGroupId(groupId);
				String[] parents = ciGroup.getParentIds().split(",");
				if(parents.length>0){
					for(String parentId : parents){
						if(!parentId.equals("")&&!parentId.equals("0")){
							propertyGroups.addAll(dao.findEntityByGroupId(parentId));
						}
					}
				}
				return propertyGroups;
			}
			
		}
		return Lists.newArrayList();
		
	}
	
	/**
	 * 根据参数查询分类属性关系
	 * @param groupId
	 * @param porpertyId
	 * @return
	 */
	public List<CmPropertyGroup> findEntityByParameter(String groupId, String porpertyId){
		List<CmPropertyGroup> propertyGroups = Lists.newArrayList();
		propertyGroups = dao.findEntityByParameter(groupId, porpertyId);
		if(propertyGroups.size()>0){
			return propertyGroups;
		}else{
			CmCiGroup cmCiGroup = cmCiGroupService.get(groupId);
			if(cmCiGroup!=null&&cmCiGroup.getId()!=null&&!"".equals(cmCiGroup.getId())){
				String[] parents = cmCiGroup.getParentIds().split(",");
				if(parents.length>0){
					for(String parentId : parents){
						if(!parentId.equals("")&&!parentId.equals("0")){
							propertyGroups.addAll(dao.findEntityByParameter(parentId, porpertyId));
						}
					}
				}
			}
		}
		return propertyGroups;
	}
}