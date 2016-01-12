/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置管理操作日志Entity
 * @author liuzk
 * @version 2015-02-09
 */
public class CmHandleLog extends DataEntity<CmHandleLog> {
	
	private static final long serialVersionUID = 1L;
	private String ciApplyId;		// 操作申请编号
	private String entityId;		// 实体编号
	private String handler;			// 操作人（默认记录发起人）
	private String handleTime;		// 操作日期
	private Date createTime;		// 创建时间
	
	
	public CmHandleLog() {
		super();
	}

	public CmHandleLog(String id){
		super(id);
	}

	@Length(min=0, max=20, message="操作申请编号长度必须介于 0 和 20 之间")
	public String getCiApplyId() {
		return ciApplyId;
	}

	public void setCiApplyId(String ciApplyId) {
		this.ciApplyId = ciApplyId;
	}
	
	@Length(min=0, max=64, message="配置项编号长度必须介于 0 和 64 之间")
	public String getEntityId() {
		return entityId;
	}

	public void setEntityId(String ciId) {
		this.entityId = ciId;
	}
	
	@Length(min=0, max=64, message="操作人（默认记录发起人）长度必须介于 0 和 64 之间")
	public String getHandler() {
		return handler;
	}

	public void setHandler(String handler) {
		this.handler = handler;
	}
	
	@Length(min=0, max=20, message="操作日期长度必须介于 0 和 20 之间")
	public String getHandleTime() {
		return handleTime;
	}

	public void setHandleTime(String handleTime) {
		this.handleTime = handleTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}