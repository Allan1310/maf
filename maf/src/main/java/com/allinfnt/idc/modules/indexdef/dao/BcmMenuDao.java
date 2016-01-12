/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdef.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.indexdef.entity.BcmMenu;

/**
 * 首页自定义配置DAO接口
 * @author zx
 * @version 2015-03-25
 */
@MyBatisDao
public interface BcmMenuDao extends CrudDao<BcmMenu> {
	
}