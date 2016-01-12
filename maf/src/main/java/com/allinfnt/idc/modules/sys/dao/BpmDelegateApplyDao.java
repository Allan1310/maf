/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.sys.entity.BpmDelegateApply;

/**
 * 任务委托申请DAO接口
 * @author liujx
 * @version 2015-03-29
 */
@MyBatisDao
public interface BpmDelegateApplyDao extends CrudDao<BpmDelegateApply> {
	
	public BpmDelegateApply getDelegateInfo(@Param( value="applyUserId" )String applyUserId,@Param( value="templateId" )String templateId,@Param( value="nowTime" )String nowTime) throws RuntimeException; 
	
	public List<BpmDelegateApply> findDelegateApply(@Param( value="endTime" )String endTime) throws RuntimeException; 
}