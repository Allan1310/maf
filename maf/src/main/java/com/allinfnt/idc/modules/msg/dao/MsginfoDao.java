/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.dao;

import java.util.List;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.msg.entity.Msginfo;

/**
 * 消息管理DAO接口
 * 
 * @author Peng
 * @version 2015-03-11
 */
@MyBatisDao
public interface MsginfoDao extends CrudDao<Msginfo> {
	/**
	 * 查询发送状态消息
	 * 
	 * @return
	 */
	public List<Msginfo> findBybackflag(String backflag);

	/**
	 * 获取通知数目
	 * 
	 * @return
	 */
	public Long findCount(String receiverId);

	/**
	 * 根据接收人查询消息记录
	 */
	public List<Msginfo> findByreceiverId(Msginfo msgMsginfo);

}