/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项基线Entity
 * @author liujx
 * @version 2015-03-02
 */
public class CmBaseLine extends DataEntity<CmBaseLine> {
	
	private static final long serialVersionUID = 1L;
	private String baseVersion;		// 基线版本
	
	public CmBaseLine() {
		super();
	}

	public CmBaseLine(String id){
		super(id);
	}

	@Length(min=0, max=10, message="基线版本长度必须介于 0 和 10 之间")
	public String getBaseVersion() {
		return baseVersion;
	}

	public void setBaseVersion(String baseVersion) {
		this.baseVersion = baseVersion;
	}
	
}