/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.entity;


import com.allinfnt.idc.common.persistence.TreeEntity;
/**
 * 用例集管理Entity
 * @author xusuojian
 * @version 2015-12-07
 */
public class CaseList extends TreeEntity<CaseList> {
	
	private static final long serialVersionUID = 1L;
	
	private String itemId;  //关联项目id
	private String itemName; //关联项目名称
	private CaseList parent;		// 父级编号
	private String parentIds;		// 所有父级编号
	private String name;		// 名称
	private Integer sort;		// 排序
	public CaseList() {
		super();
	}

	public CaseList(String id){
		super(id);
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	
	public CaseList getParent() {
		return parent;
	}

	public void setParent(CaseList parent) {
		this.parent = parent;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
	
}