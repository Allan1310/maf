/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.test.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.test.entity.TestDataChild;

/**
 * 主子表生成DAO接口
 * @author allinfnt
 * @version 2015-01-16
 */
@MyBatisDao
public interface TestDataChildDao extends CrudDao<TestDataChild> {
	
}