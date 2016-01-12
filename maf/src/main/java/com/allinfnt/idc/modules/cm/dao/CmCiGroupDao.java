/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.TreeDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiGroup;

/**
 * 分类管理DAO接口
 * @author liujx
 * @version 2015-01-20
 */
@MyBatisDao
public interface CmCiGroupDao extends TreeDao<CmCiGroup> {
	public List<CmCiGroup> findEntityByParameter(@Param( value = "parentId" ) String parentId,@Param( value = "groupName" ) String groupName) throws RuntimeException;
	public List<CmCiGroup> findGroupByParentId(@Param( value = "parentId" ) String parentId) throws RuntimeException;
}