/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.ActEntity;

/**
 * 配置项审计Entity
 * @author liuzk
 * @version 2015-02-03
 */
public class CmAuditApply extends ActEntity<CmAuditApply> {
	
	private static final long serialVersionUID = 1L;
	private String auditNumber;		// 审计申请编号
	private String auditObject;		// 审计对象
	private String auditProject;	// 审计项目
	private String auditTime;		// 审计时间
	private String auditUser;		// 审计人员
	private String auditCondition;	// 审计条件
	private String auditScope;		// 审计范围
	private String auditDataMethods;// 审计数据收集方法
	private String auditMode;		// 审计方式
	private String auditPlan;		// 审计安排
	private String auditSteps;		// 审计步骤
	private String status;			// 状态
	private String auditPurpose;    //审计目的
	private String auditResult; 	//审计结果
	private String auditReport; 	//报告日期
	private String auditSign;   	//审计员签名
	private String auditReportNumber;  //报告编号
	
	public CmAuditApply() {
		super();
	}

	public CmAuditApply(String id){
		super(id);
	}

	@Length(min=0, max=50, message="审计申请编号长度必须介于 0 和 50 之间")
	public String getAuditNumber() {
		return auditNumber;
	}

	public void setAuditNumber(String auditNumber) {
		this.auditNumber = auditNumber;
	}
	
	@Length(min=0, max=20, message="审计对象长度必须介于 0 和 20 之间")
	public String getAuditObject() {
		return auditObject;
	}

	public void setAuditObject(String auditObject) {
		this.auditObject = auditObject;
	}
	
	@Length(min=0, max=50, message="审计项目长度必须介于 0 和 50 之间")
	public String getAuditProject() {
		return auditProject;
	}

	public void setAuditProject(String auditProject) {
		this.auditProject = auditProject;
	}
	
	@Length(min=0, max=20, message="审计时间长度必须介于 0 和 20 之间")
	public String getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}
	
	@Length(min=0, max=64, message="审计人员长度必须介于 0 和 64 之间")
	public String getAuditUser() {
		return auditUser;
	}

	public void setAuditUser(String auditUser) {
		this.auditUser = auditUser;
	}
	
	@Length(min=0, max=50, message="审计条件长度必须介于 0 和 50 之间")
	public String getAuditCondition() {
		return auditCondition;
	}

	public void setAuditCondition(String auditCondition) {
		this.auditCondition = auditCondition;
	}
	
	@Length(min=0, max=255, message="审计范围长度必须介于 0 和 255 之间")
	public String getAuditScope() {
		return auditScope;
	}

	public void setAuditScope(String auditScope) {
		this.auditScope = auditScope;
	}
	
	@Length(min=0, max=255, message="审计数据收集方法长度必须介于 0 和 255 之间")
	public String getAuditDataMethods() {
		return auditDataMethods;
	}

	public void setAuditDataMethods(String auditDataMethods) {
		this.auditDataMethods = auditDataMethods;
	}
	
	@Length(min=0, max=50, message="审计方式长度必须介于 0 和 50 之间")
	public String getAuditMode() {
		return auditMode;
	}

	public void setAuditMode(String auditMode) {
		this.auditMode = auditMode;
	}
	
	@Length(min=0, max=500, message="审计安排长度必须介于 0 和 500 之间")
	public String getAuditPlan() {
		return auditPlan;
	}

	public void setAuditPlan(String auditPlan) {
		this.auditPlan = auditPlan;
	}
	
	@Length(min=0, max=1000, message="审计步骤长度必须介于 0 和 1000 之间")
	public String getAuditSteps() {
		return auditSteps;
	}

	public void setAuditSteps(String auditSteps) {
		this.auditSteps = auditSteps;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min=0, max=1000, message="审计目的长度必须介于 0 和 1000 之间")
	public String getAuditPurpose() {
		return auditPurpose;
	}

	public void setAuditPurpose(String auditPurpose) {
		this.auditPurpose = auditPurpose;
	}

	@Length(min=0, max=1, message="结果长度必须介于 0 和 1 之间")
	public String getAuditResult() {
		return auditResult;
	}

	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}

	@Length(min=0, max=255, message="报告长度必须介于 0 和 255 之间")
	public String getAuditReport() {
		return auditReport;
	}

	public void setAuditReport(String auditReport) {
		this.auditReport = auditReport;
	}

	@Length(min=0, max=50, message="签名长度必须介于 0 和 1 之间")
	public String getAuditSign() {
		return auditSign;
	}

	public void setAuditSign(String auditSign) {
		this.auditSign = auditSign;
	}
	
	@Length(min=0, max=50, message="报告编号长度介于0和64之间")
	public String getAuditReportNumber() {
		return auditReportNumber;
	}

	public void setAuditReportNumber(String auditReportNumber) {
		this.auditReportNumber = auditReportNumber;
	}
	
}