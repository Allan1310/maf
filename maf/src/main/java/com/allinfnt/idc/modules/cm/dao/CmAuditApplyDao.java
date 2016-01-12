/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmAuditApply;

/**
 * 配置项审计DAO接口
 * @author liuzk
 * @version 2015-02-03
 */
@MyBatisDao
public interface CmAuditApplyDao extends CrudDao<CmAuditApply> {
	
}