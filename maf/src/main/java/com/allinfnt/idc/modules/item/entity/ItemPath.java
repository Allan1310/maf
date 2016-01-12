/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.entity;


import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 路径管理Entity
 * @author xusuojian
 * @version 2015-11-26
 */
public class ItemPath extends DataEntity<ItemPath> {
	
	private static final long serialVersionUID = 1L;
	private String itemName ;   //项目名称
	private String itemId;   //项目Id
	private String itemPath;  //项目路径
	private String expression;  //路径表达式
	
	public ItemPath() {
		super();
	}

	public ItemPath(String id){
		super(id);
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemPath() {
		return itemPath;
	}

	public void setItemPath(String itemPath) {
		this.itemPath = itemPath;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	
}