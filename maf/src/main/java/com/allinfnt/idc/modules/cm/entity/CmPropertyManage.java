/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;
import com.allinfnt.idc.common.utils.excel.annotation.ExcelField;

/**
 * 属性管理Entity
 * @author liujx
 * @version 2015-01-18
 */
public class CmPropertyManage extends DataEntity<CmPropertyManage> {
	
	private static final long serialVersionUID = 1L;
	private String propertyNumber;		// 属性编号
	private String propertyName;		// 属性名称
	private String propertyDesc;		// 属性描述
	private String propertyType;		// 属性类型（TYSX:通用属性，ZYSX：专有属性）
	private String dataType;		// 数据类型
	private String isNull;		// 是否必填（0：必填，1：必填）
	private String status;		// 属性状态（0：可用，1：已删除）
	private String ext1;		// 扩展字段1
	private String ext2;		// 扩展字段2
	private Integer sort; 	// 排序
	private String remarks;
	public CmPropertyManage() {
		super();
	}

	public CmPropertyManage(String id){
		super(id);
	}

	@Length(min=0, max=50, message="属性编号长度必须介于 0 和 50 之间")
	public String getPropertyNumber() {
		return propertyNumber;
	}

	public void setPropertyNumber(String propertyNumber) {
		this.propertyNumber = propertyNumber;
	}
	
	@ExcelField(title = "属性名称", align = 1, sort = 10)
	@Length(min=0, max=50, message="属性名称长度必须介于 0 和 50 之间")
	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	
	@Length(min=0, max=100, message="属性描述长度必须介于 0 和 100 之间")
	public String getPropertyDesc() {
		return propertyDesc;
	}

	public void setPropertyDesc(String propertyDesc) {
		this.propertyDesc = propertyDesc;
	}
	
	@Length(min=0, max=4, message="属性类型（TYSX:通用属性，ZYSX：专有属性）长度必须介于 0 和 4 之间")
	public String getPropertyType() {
		return propertyType;
	}

	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}
	
	@ExcelField(title = "数据类型", align = 2, sort = 20)
	@Length(min=0, max=20, message="数据类型长度必须介于 0 和 20 之间")
	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	
	@ExcelField(title = "是否必填", align = 2, sort = 30)
	@Length(min=0, max=1, message="是否必填（0：必填，1：必填）长度必须介于 0 和 1 之间")
	public String getIsNull() {
		return isNull;
	}

	public void setIsNull(String isNull) {
		this.isNull = isNull;
	}
	
	@Length(min=0, max=1, message="属性状态（0：可用，1：已删除）长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=255, message="扩展字段1长度必须介于 0 和 255 之间")
	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}
	
	@Length(min=0, max=255, message="扩展字段2长度必须介于 0 和 255 之间")
	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	@ExcelField(title = "属性值", align = 2, sort = 40)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	@NotNull
	public Integer getSort() {
		return sort;
	}
	
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}