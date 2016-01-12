/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmPropertyGroup;

/**
 * 分类属性关系DAO接口
 * @author liujx
 * @version 2015-01-20
 */
@MyBatisDao
public interface CmPropertyGroupDao extends CrudDao<CmPropertyGroup> {
	
	public List<CmPropertyGroup> findEntityByPropertyId(@Param(value = "propertyId") String propertyId) throws RuntimeException;
	public List<CmPropertyGroup> findEntityByGroupId(@Param(value = "groupId") String groupId) throws RuntimeException;
	public List<CmPropertyGroup> findEntityByParameter(@Param(value = "groupId") String groupId, @Param(value = "propertyId") String porpertyId) throws RuntimeException;
}