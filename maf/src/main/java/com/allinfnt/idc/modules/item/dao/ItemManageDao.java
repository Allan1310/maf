/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.item.entity.ItemManage;

/**
 * 项目管理DAO接口
 * @author xusuojian
 * @version 2015-11-25
 */
@MyBatisDao
public interface ItemManageDao extends CrudDao<ItemManage> {
	
}