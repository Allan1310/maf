/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.entity;


import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 对象管理Entity
 * @author xusuojian
 * @version 2015-12-01
 */
public class ObjManage extends DataEntity<ObjManage> {
	
	private static final long serialVersionUID = 1L;
	
	private String itemId; //关联的项目id
	private String itemName; //关联的项目名称
	private String pathId; //路径关联ID
	private String pathName; //关联路径名称
	private String objName; //对象名称
	private String xpathCode; //xpath表达式
	private String jqueryCode; //jquery表达式
	
	public ObjManage() {
		super();
	}

	public ObjManage(String id){
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

	public String getPathId() {
		return pathId;
	}

	public void setPathId(String pathId) {
		this.pathId = pathId;
	}

	public String getPathName() {
		return pathName;
	}

	public void setPathName(String pathName) {
		this.pathName = pathName;
	}

	public String getObjName() {
		return objName;
	}

	public void setObjName(String objName) {
		this.objName = objName;
	}

	public String getXpathCode() {
		return xpathCode;
	}

	public void setXpathCode(String xpathCode) {
		this.xpathCode = xpathCode;
	}

	public String getJqueryCode() {
		return jqueryCode;
	}

	public void setJqueryCode(String jqueryCode) {
		this.jqueryCode = jqueryCode;
	}

}