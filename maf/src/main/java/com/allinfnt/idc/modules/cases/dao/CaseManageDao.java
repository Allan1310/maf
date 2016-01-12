/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cases.entity.CaseManage;

/**
 * 用例管理DAO接口
 * @author xusuojian
 * @version 2015-12-08
 */
@MyBatisDao
public interface CaseManageDao extends CrudDao<CaseManage> {
	
}