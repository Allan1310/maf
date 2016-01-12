/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.sys.entity.SysIdentity;

/**
 * 流水号信息表DAO接口
 * 
 * @author rocliao
 * @version 2015-01-29
 */
@MyBatisDao
public interface SysIdentityDao extends CrudDao<SysIdentity> {

	SysIdentity findByAlias(String alias);

}