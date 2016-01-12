/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmRelationOrder;

/**
 * 配置项关联工单DAO接口
 * @author liujx
 * @version 2015-03-13
 */
@MyBatisDao
public interface CmRelationOrderDao extends CrudDao<CmRelationOrder> {
	
}