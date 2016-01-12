/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;
import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 分类属性关系Entity
 * @author liujx
 * @version 2015-01-20
 */
public class CmPropertyGroup extends DataEntity<CmPropertyGroup> {
	
	private static final long serialVersionUID = 1L;
	private String groupId;		// 分类编号
	private CmPropertyManage cmPropertyManage;		// 属性编号
	private String status;		// 状态（0：可用，1：不可用）
	private String node;		// 标示
	
	public CmPropertyGroup() {
		super();
	}

	public CmPropertyGroup(String id){
		super(id);
	}

	@Length(min=0, max=64, message="分类编号长度必须介于 0 和 64 之间")
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	@JsonBackReference
	public CmPropertyManage getCmPropertyManage() {
		return cmPropertyManage;
	}

	public void setCmPropertyManage(CmPropertyManage cmPropertyManage) {
		this.cmPropertyManage = cmPropertyManage;
	}

	@Length(min=0, max=1, message="状态（0：可用，1：不可用）长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=4, message="标示长度必须介于 0 和 4 之间")
	public String getNode() {
		return node;
	}

	public void setNode(String node) {
		this.node = node;
	}
	
}