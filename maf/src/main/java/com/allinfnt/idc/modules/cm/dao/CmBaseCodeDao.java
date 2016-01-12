/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmBaseCode;

/**
 * 配置项基础配置表DAO接口
 * @author liujx
 * @version 2015-02-03
 */
@MyBatisDao
public interface CmBaseCodeDao extends CrudDao<CmBaseCode> {
	
	/**
	 * 根据名称查询配置信息
	 * @param codeName
	 * @return
	 * @throws RuntimeException
	 */
	public CmBaseCode findBaseCodeByName(@Param( value = "codeName" ) String codeName) throws RuntimeException;
	
}