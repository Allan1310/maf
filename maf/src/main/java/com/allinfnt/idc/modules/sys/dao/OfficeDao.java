/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.TreeDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * 
 * @author allinfnt
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	public List<Office> findUserBySubdepartment();

	public Office findBuUserName(String userName);

	public Office findByDeptName(String userName);
	
	public List<Office> findByCodeList(@Param("code") String code);

	public List<Office> findSubList(String parentIds);
	
	public Office findByName(String name);
}
