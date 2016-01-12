/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.entity;


import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 工作日设置Entity
 * @author 蒋斌
 * @version 2015-01-29
 */
public class SetWeekday extends DataEntity<SetWeekday> {
	
	private static final long serialVersionUID = 1L;
	private String day;		// 工作日日期(格式：2015-01-06)
	
	public SetWeekday() {
		super();
	}

	public SetWeekday(String id){
		super(id);
	}

	@Length(min=0, max=10, message="工作日日期(格式：2015-01-06)长度必须介于 0 和 10 之间")
	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}
	
}