/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.item.entity.ItemPath;

/**
 * 路径管理DAO接口
 * @author xusuojian
 * @version 2015-11-26
 */
@MyBatisDao
public interface ItemPathDao extends CrudDao<ItemPath> {
	
}