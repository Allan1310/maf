/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.TreeEntity;

/**
 * 分类管理Entity
 * @author liujx
 * @version 2015-01-20
 */
public class CmCiGroup extends TreeEntity<CmCiGroup> {
	
	private static final long serialVersionUID = 1L;
	private CmCiGroup parent;		// 父编号
	private String parentIds;		// 所有父编号
	private String groupNumber;		// 分类编号
	private String groupName;		// 分类名称
	private String groupDesc;		// 分类描述
	private String status;		// 状态
	private CmGraphIcon cmGraphIcon; //配置项图标
	
	public CmCiGroup() {
		super();
	}

	public CmCiGroup(String id){
		super(id);
	}

	@JsonBackReference
	public CmCiGroup getParent() {
		return parent;
	}

	public void setParent(CmCiGroup parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=2000, message="所有父编号长度必须介于 0 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=0, max=50, message="分类编号长度必须介于 0 和 50 之间")
	public String getGroupNumber() {
		return groupNumber;
	}

	public void setGroupNumber(String groupNumber) {
		this.groupNumber = groupNumber;
	}
	
	@Length(min=0, max=50, message="分类名称长度必须介于 0 和 50 之间")
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	@Length(min=0, max=100, message="分类描述长度必须介于 0 和 100 之间")
	public String getGroupDesc() {
		return groupDesc;
	}

	public void setGroupDesc(String groupDesc) {
		this.groupDesc = groupDesc;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}

	public CmGraphIcon getCmGraphIcon() {
		return cmGraphIcon;
	}

	public void setCmGraphIcon(CmGraphIcon cmGraphIcon) {
		this.cmGraphIcon = cmGraphIcon;
	}
	
}