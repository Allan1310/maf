/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmBaseLine;

/**
 * 配置项基线DAO接口
 * @author liujx
 * @version 2015-03-02
 */
@MyBatisDao
public interface CmBaseLineDao extends CrudDao<CmBaseLine> {
	
}