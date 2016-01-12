/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.entity;


import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 项目管理Entity
 * @author xusuojian
 * @version 2015-11-25
 */
public class ItemManage extends DataEntity<ItemManage> {
	
	private static final long serialVersionUID = 1L;
	
	private String name ;  //项目名称
	private String version;  //项目版本
	
	
	public ItemManage() {
		super();
	}

	public ItemManage(String id){
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

}