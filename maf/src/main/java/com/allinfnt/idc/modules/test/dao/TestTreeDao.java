/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.test.dao;

import com.allinfnt.idc.common.persistence.TreeDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * @author allinfnt
 * @version 2015-01-16
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}