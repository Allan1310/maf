/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项属性Entity
 * @author liujx
 * @version 2015-01-26
 */
public class CmCiProperty extends DataEntity<CmCiProperty> {
	
	private static final long serialVersionUID = 1L;
	private String ciId;		// 配置项实例ID
	private String ciVersion;		// 配置项实例版本
	private CmPropertyManage property;		// 属性ID
	private String propertyValue;		// 属性值
	private String propertyUpdateValue;		// 属性更改值
	private String handle;		// 操作类型（0：新增，1：修改，3：删除）
	private String status;		// 状态
	private String handleStatus;		// 操作状态（0：未变更，1：正在变更）
	
	public CmCiProperty() {
		super();
	}

	public CmCiProperty(String id){
		super(id);
	}

	@Length(min=0, max=64, message="配置项实例ID长度必须介于 0 和 64 之间")
	public String getCiId() {
		return ciId;
	}

	public void setCiId(String ciId) {
		this.ciId = ciId;
	}
	
	@Length(min=0, max=10, message="配置项实例版本长度必须介于 0 和 10 之间")
	public String getCiVersion() {
		return ciVersion;
	}

	public void setCiVersion(String ciVersion) {
		this.ciVersion = ciVersion;
	}
	
	public CmPropertyManage getProperty() {
		return property;
	}

	public void setProperty(CmPropertyManage property) {
		this.property = property;
	}

	@Length(min=0, max=255, message="属性值长度必须介于 0 和 255 之间")
	public String getPropertyValue() {
		return propertyValue;
	}

	public void setPropertyValue(String propertyValue) {
		this.propertyValue = propertyValue;
	}
	
	@Length(min=0, max=255, message="属性更改值长度必须介于 0 和 255 之间")
	public String getPropertyUpdateValue() {
		return propertyUpdateValue;
	}

	public void setPropertyUpdateValue(String propertyUpdateValue) {
		this.propertyUpdateValue = propertyUpdateValue;
	}
	
	@Length(min=0, max=1, message="操作类型（0：新增，1：修改，3：删除）长度必须介于 0 和 1 之间")
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
	
	@Length(min=0, max=1, message="操作状态（0：未变更，1：正在变更）长度必须介于 0 和 1 之间")
	public String getHandleStatus() {
		return handleStatus;
	}

	public void setHandleStatus(String handleStatus) {
		this.handleStatus = handleStatus;
	}
	
}