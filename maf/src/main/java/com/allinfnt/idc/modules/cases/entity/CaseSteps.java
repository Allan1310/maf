/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.entity;


import java.beans.Transient;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 用例步骤Entity
 * @author xusuojian
 * @version 2015-12-08
 */
public class CaseSteps extends DataEntity<CaseSteps> {
	
	private static final long serialVersionUID = 1L;
	
	private String caseId;  //关联用例ID
	private String sort;  //步骤顺序
	private String objName; //对象名称
	private String type; //对象寻址类型
	private String param; //参数
	private String motion; //动作
	private String screenshot; //是否截图
	
	
	public CaseSteps() {
		super();
	}

	public CaseSteps(String id){
		super(id);
	}

	public String getCaseId() {
		return caseId;
	}

	public void setCaseId(String caseId) {
		this.caseId = caseId;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getObjName() {
		return objName;
	}

	public void setObjName(String objName) {
		this.objName = objName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getMotion() {
		return motion;
	}

	public void setMotion(String motion) {
		this.motion = motion;
	}

	public String getScreenshot() {
		return screenshot;
	}

	public void setScreenshot(String screenshot) {
		this.screenshot = screenshot;
	}


	
}