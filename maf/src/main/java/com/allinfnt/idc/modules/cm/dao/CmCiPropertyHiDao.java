/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;
import com.allinfnt.idc.modules.cm.entity.CmCiPropertyHi;

/**
 * 配置项属性历史DAO接口
 * @author liujx
 * @version 2015-02-01
 */
@MyBatisDao
public interface CmCiPropertyHiDao extends CrudDao<CmCiPropertyHi> {
	
	public List<CmCiProperty> findEntityHiByCiId(@Param(value = "ciId")String ciId ,@Param(value = "version")String version) throws RuntimeException;
}