/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.ActEntity;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;

/**
 * 变更申请Entity
 * @author liujx
 * @version 2015-01-26
 */
public class CmCiApply extends ActEntity<CmCiApply> {
	
	private static final long serialVersionUID = 1L;
	private User 	user;	//	归属用户
	private Office 	office;	//	归属部门
	private String applyNumber;		// 申请编号
	private String ciNumber; 
	private String ciId;		// 编号
	private String handle;		// 操作（0：新增，1：修改,2：删除）
	private String status;		// 状态
	
	public CmCiApply() {
		super();
	}

	public CmCiApply(String id){
		super(id);
	}

	@Length(min=0, max=1000, message="申请编号长度必须介于 0 和 1000 之间")
	public String getApplyNumber() {
		return applyNumber;
	}

	public void setApplyNumber(String applyNumber) {
		this.applyNumber = applyNumber;
	}
	
	@Length(min=0, max=1000, message="编号长度必须介于 0 和 1000 之间")
	public String getCiId() {
		return ciId;
	}

	public void setCiId(String ciId) {
		this.ciId = ciId;
	}
	
	@Length(min=0, max=1, message="操作（0：新增，1：修改）长度必须介于 0 和 1 之间")
	public String getHandle() {
		return handle;
	}

	public void setHandle(String handle) {
		this.handle = handle;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public String getCiNumber() {
		return ciNumber;
	}

	public void setCiNumber(String ciNumber) {
		this.ciNumber = ciNumber;
	}
	
}