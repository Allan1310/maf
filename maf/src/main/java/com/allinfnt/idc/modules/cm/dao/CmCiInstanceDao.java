/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;

/**
 * 配置项管理DAO接口
 * @author liuzk
 * @version 2015-01-22
 */
@MyBatisDao
public interface CmCiInstanceDao extends CrudDao<CmCiInstance> {
	/**
	 * 根据参数查询配置项列表
	 * @param cmCiInstance
	 * @return
	 * @throws RuntimeException
	 */
	public List<CmCiInstance> findListByParam(CmCiInstance cmCiInstance) throws RuntimeException;

	/**
	 * 查询配置项模型
	 * @return
	 * @throws RuntimeException
	 */
	public List<CmCiInstance> findPageIsModel(CmCiInstance cmCiInstance) throws RuntimeException;
	
	/**
	 * 更新配置项状态
	 * @param id
	 * @param status
	 * @return
	 * @throws RuntimeException
	 */
	public int updateStatusById(@Param(value="id") String id,@Param(value="status") String status) throws RuntimeException;
	
	/**
	 * 保存历史版本
	 * 
	 * @param id
	 * @return
	 * @throws RuntimeException
	 */
	public int saveInstanceHi(@Param(value="id") String id) throws RuntimeException;
	
	
	public List<CmCiInstance> findEntityByGroupId(@Param(value="groupId") String groupId) throws RuntimeException;
}