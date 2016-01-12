/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiInstanceHi;

/**
 * 配置项历史版本DAO接口
 * @author liujx
 * @version 2015-02-01
 */
@MyBatisDao
public interface CmCiInstanceHiDao extends CrudDao<CmCiInstanceHi> {
	
	public CmCiInstanceHi findEntityHiByCiId(@Param(value = "ciId")String ciId ,@Param(value = "version")String version) throws RuntimeException;
	
	public List<CmCiInstanceHi> findInstancesByVersion(CmCiInstanceHi cmCiInstanceHi) throws RuntimeException;
}