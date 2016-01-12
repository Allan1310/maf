/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项基础配置表Entity
 * @author liujx
 * @version 2015-02-03
 */
public class CmBaseCode extends DataEntity<CmBaseCode> {
	
	private static final long serialVersionUID = 1L;
	private String codeName;		// 名称
	private String codeValue;		// 值
	private String note;		// 标注
	
	public CmBaseCode() {
		super();
	}

	public CmBaseCode(String id){
		super(id);
	}

	@Length(min=0, max=50, message="名称长度必须介于 0 和 50 之间")
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	@Length(min=0, max=100, message="值长度必须介于 0 和 100 之间")
	public String getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}
	
	@Length(min=0, max=10, message="标注长度必须介于 0 和 10 之间")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
}