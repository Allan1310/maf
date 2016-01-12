/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 任务委托申请Entity
 * @author liujx
 * @version 2015-03-29
 */
public class BpmDelegateApply extends DataEntity<BpmDelegateApply> {
	
	private static final long serialVersionUID = 1L;
	private User applyUser;		// 申请人
	private User assigneeUser;		// 委托人
	private String startTime;		// 委托开始时间
	private String endTime;		// 委托结束时间
	private String templateId;		// 流程模板编号
	private String status;		// 状态（是否可用0：可执行，1：已注销）
	
	public BpmDelegateApply() {
		super();
	}

	public BpmDelegateApply(String id){
		super(id);
	}

	public User getApplyUser() {
		return applyUser;
	}

	public void setApplyUser(User applyUser) {
		this.applyUser = applyUser;
	}
	
	public User getAssigneeUser() {
		return assigneeUser;
	}

	public void setAssigneeUser(User assigneeUser) {
		this.assigneeUser = assigneeUser;
	}

	@Length(min=0, max=20, message="委托开始时间长度必须介于 0 和 20 之间")
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	@Length(min=0, max=20, message="委托结束时间长度必须介于 0 和 20 之间")
	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=0, max=1000, message="流程模板编号长度必须介于 0 和 1000 之间")
	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
	@Length(min=0, max=1, message="状态（是否可用0：可执行，1：已注销）长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}