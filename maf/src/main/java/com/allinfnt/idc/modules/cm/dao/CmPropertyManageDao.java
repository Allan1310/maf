/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;

/**
 * 属性管理DAO接口
 * @author liujx
 * @version 2015-01-18
 */
@MyBatisDao
public interface CmPropertyManageDao extends CrudDao<CmPropertyManage> {
	public List<CmPropertyManage> findPropertyByName(@Param(value = "propertyName") String propertyName,@Param(value = "propertyType") String propertyType,
																										@Param(value = "dataType") String dataType) throws RuntimeException;
	public List<CmPropertyManage> findPropertyByType(@Param(value = "propertyType") String propertyType) throws RuntimeException;
	
	public List<CmPropertyManage> findListByName(@Param(value = "propertyName") String propertyName) throws RuntimeException;
	
}