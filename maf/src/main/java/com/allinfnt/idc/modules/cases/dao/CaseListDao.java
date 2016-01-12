/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.dao;

import com.allinfnt.idc.common.persistence.TreeDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cases.entity.CaseList;

/**
 * 用例集管理DAO接口
 * @author xusuojian
 * @version 2015-12-07
 */
@MyBatisDao
public interface CaseListDao extends TreeDao<CaseList> {
	
}