/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cases.entity.CaseSteps;

/**
 * 用例步骤DAO接口
 * @author xusuojian
 * @version 2015-12-08
 */
@MyBatisDao
public interface CaseStepsDao extends CrudDao<CaseSteps> {
	
}