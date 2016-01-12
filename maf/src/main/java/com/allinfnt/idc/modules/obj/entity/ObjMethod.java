/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.entity;


import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 对象方法管理Entity
 * @author xusuojian
 * @version 2015-12-03
 */
public class ObjMethod extends DataEntity<ObjMethod> {
	
	private static final long serialVersionUID = 1L;
	
	private String objType; //对象类型
	private String methodName; //方法名称
	private String defaultVal; //默认值
	private String methodCode; //方法code
	
	public ObjMethod() {
		super();
	}

	public ObjMethod(String id){
		super(id);
	}

	public String getObjType() {
		return objType;
	}

	public void setObjType(String objType) {
		this.objType = objType;
	}

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getMethodCode() {
		return methodCode;
	}

	public void setMethodCode(String methodCode) {
		this.methodCode = methodCode;
	}

	public String getDefaultVal() {
		return defaultVal;
	}

	public void setDefaultVal(String defaultVal) {
		this.defaultVal = defaultVal;
	}
	
	
}