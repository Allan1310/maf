/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项关联工单Entity
 * @author liujx
 * @version 2015-03-13
 */
public class CmRelationOrder extends DataEntity<CmRelationOrder> {
	
	private static final long serialVersionUID = 1L;
	private CmCiInstance ciInstance;		// 配置项编号
	private String orderId;		// 工单编号
	private String orderType;		// 工单类型
	
	public CmRelationOrder() {
		super();
	}

	public CmRelationOrder(String id){
		super(id);
	}

	public CmCiInstance getCiInstance() {
		return ciInstance;
	}

	public void setCiInstance(CmCiInstance ciInstance) {
		this.ciInstance = ciInstance;
	}

	@Length(min=0, max=64, message="工单编号长度必须介于 0 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=50, message="工单类型长度必须介于 0 和 50 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
}