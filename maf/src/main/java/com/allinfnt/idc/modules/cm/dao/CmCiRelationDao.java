/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiRelation;

/**
 * 配置项关联关系DAO接口
 * @author liujx
 * @version 2015-02-03
 */
@MyBatisDao
public interface CmCiRelationDao extends CrudDao<CmCiRelation> {
	
	public List<CmCiRelation> findListByReid(@Param( value = "reid" ) String reid) throws RuntimeException;
}