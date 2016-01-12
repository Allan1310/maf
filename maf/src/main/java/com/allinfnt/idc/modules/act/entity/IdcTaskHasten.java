/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.act.entity;

import java.beans.Transient;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 催办Entity
 * @author liujx
 * @version 2015-03-24
 */
public class IdcTaskHasten extends DataEntity<IdcTaskHasten> {
	
	private static final long serialVersionUID = 1L;
	private String taskId;		// 任务ID
	private String lastHastenTime;		// 上次催办时间
	private String lastHastenUsers;		// 催办人
	private int count;		// 催办总次数
	/** 上次催办人员. */
	private String thisHastenUsers = "无";
	
	public IdcTaskHasten() {
		super();
	}

	public IdcTaskHasten(String id){
		super(id);
	}

	@Length(min=0, max=64, message="任务ID长度必须介于 0 和 64 之间")
	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	@Length(min=0, max=20, message="上次催办时间长度必须介于 0 和 20 之间")
	public String getLastHastenTime() {
		return lastHastenTime;
	}

	public void setLastHastenTime(String lastHastenTime) {
		this.lastHastenTime = lastHastenTime;
	}
	
	@Length(min=0, max=100, message="催办人长度必须介于 0 和 100 之间")
	public String getLastHastenUsers() {
		return lastHastenUsers;
	}

	public void setLastHastenUsers(String lastHastenUsers) {
		this.lastHastenUsers = lastHastenUsers;
	}
	
	@Length(min=0, max=11, message="催办总次数长度必须介于 0 和 11 之间")
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	/**
	 * @return the thisHastenUsers
	 */
	@Transient
	public String getThisHastenUsers() {
		return thisHastenUsers;
	}

	/**
	 * @param thisHastenUsers
	 *            the thisHastenUsers to set
	 */
	public void setThisHastenUsers(String thisHastenUsers) {
		this.thisHastenUsers = thisHastenUsers;
	}
	
	/*
	 * {@inheritDoc}
	 */
	@Override
	public String toString() {
		return "已催办" + count + "次，上次催办时间：" + lastHastenTime + "，上次催办用户："
				+ lastHastenUsers + "，本次将催办用户：" + thisHastenUsers;
	}
}