/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmHandleLog;

/**
 * 配置管理操作日志DAO接口
 * @author liuzk
 * @version 2015-02-09
 */
@MyBatisDao
public interface CmHandleLogDao extends CrudDao<CmHandleLog> {

	public int insert(CmHandleLog cmHandleLog) throws RuntimeException;
	
}