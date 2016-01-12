/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.sys.entity.SetWeekday;

/**
 * 工作日设置DAO接口
 * @author 蒋斌
 * @version 2015-01-29
 */
@MyBatisDao
public interface SetWeekdayDao extends CrudDao<SetWeekday> {
	
	public List<SetWeekday> findDay(@Param("day") String day);
	
}