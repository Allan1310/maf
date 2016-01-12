/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdefuser.dao;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.indexdefuser.entity.BcmMenuUser;

/**
 * 首页自定义用户配置DAO接口
 * @author zx
 * @version 2015-03-17
 */
@MyBatisDao
public interface BcmMenuUserDao extends CrudDao<BcmMenuUser> {

	void deleteMenu(BcmMenuUser bcmMenuUser);
	
}