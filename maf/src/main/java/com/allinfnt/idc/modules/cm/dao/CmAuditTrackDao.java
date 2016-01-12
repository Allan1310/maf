/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmAuditTrack;

/**
 * 配置项审计跟踪DAO接口
 * @author liuzk
 * @version 2015-02-03
 */
@MyBatisDao
public interface CmAuditTrackDao extends CrudDao<CmAuditTrack> {

	public List<CmAuditTrack> findListById(@Param(value = "auditId") String id) throws RuntimeException;
	
}