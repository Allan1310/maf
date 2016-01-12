/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.act.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.act.entity.IdcTaskHasten;

/**
 * 催办DAO接口
 * @author liujx
 * @version 2015-03-24
 */
@MyBatisDao
public interface IdcTaskHastenDao extends CrudDao<IdcTaskHasten> {

	/**
	 * 根据taskId查询催办信息
	 * @param taskId
	 * @return
	 * @throws RuntimeException
	 */
	public IdcTaskHasten findByTaskId(String taskId)throws RuntimeException;
	
}