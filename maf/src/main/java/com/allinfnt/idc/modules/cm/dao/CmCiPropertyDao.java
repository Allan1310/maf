/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiProperty;

/**
 * 配置项属性DAO接口
 * @author liujx
 * @version 2015-01-26
 */
@MyBatisDao
public interface CmCiPropertyDao extends CrudDao<CmCiProperty> {
	
	public List<CmCiProperty> findEntityByCiId(@Param(value = "ciId")String ciId) throws RuntimeException;
	public int insert(CmCiProperty entity);
	/**
	 * 保存配置项属性历史版本
	 * @param ciId
	 * @return
	 * @throws RuntimeException
	 */
	public int savePropertyHi(@Param(value = "ciId")String ciId) throws RuntimeException;
	
	/**
	 * 更改历史记录数据
	 * @param ciId
	 * @return
	 * @throws RuntimeException
	 */
	public int updatePropertyHi(@Param(value = "ciId")String ciId,@Param(value = "ciVersion")String ciVersion) throws RuntimeException;
	
	/**
	 * 根据属性ID删除配置项属性
	 * @param ciId
	 * @param propertyId
	 * @return
	 * @throws RuntimeException
	 */
	public int delProperty(@Param(value = "ciId")String ciId ,@Param(value = "propertyId")String propertyId) throws RuntimeException;
}