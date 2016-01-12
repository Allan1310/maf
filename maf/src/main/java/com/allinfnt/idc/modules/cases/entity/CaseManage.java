/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cases.entity;


import java.beans.Transient;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 用例管理Entity
 * @author xusuojian
 * @version 2015-12-08
 */
public class CaseManage extends DataEntity<CaseManage> {
	
	private static final long serialVersionUID = 1L;
	
	private CaseList parent;  //父级编号 
	private String caseName; //用例名称 
	private String stepDetail; //用例步骤
	private String testData; //测试数据
	
	public CaseManage() {
		super();
	}

	public CaseManage(String id){
		super(id);
	}

	public String getCaseName() {
		return caseName;
	}

	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}

	public String getStepDetail() {
		return stepDetail;
	}

	public void setStepDetail(String stepDetail) {
		this.stepDetail = stepDetail;
	}

	public String getTestData() {
		return testData;
	}

	public void setTestData(String testData) {
		this.testData = testData;
	}
	
	@Transient
	public CaseList getParent() {
		return parent;
	}
	
	public void setParent(CaseList parent) {
		this.parent = parent;
	}
	
	
}