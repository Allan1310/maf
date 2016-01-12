/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.dao;

import java.util.List;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.obj.entity.ObjManage;

/**
 * 对象管理DAO接口
 * @author xusuojian
 * @version 2015-12-01
 */
@MyBatisDao
public interface ObjManageDao extends CrudDao<ObjManage> {
	
	/**
	 * 根据itemId查询所有的objManage对象
	 * @param itemId
	 * @return
	 */
	List<ObjManage> findObjManageListByItemId(String itemId);
	
}