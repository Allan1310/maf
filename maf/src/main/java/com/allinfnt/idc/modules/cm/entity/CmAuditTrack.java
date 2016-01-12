/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import java.util.List;
import java.util.Map;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.ActEntity;
import com.allinfnt.idc.modules.sys.entity.User;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 配置项审计跟踪Entity
 * @author liuzk
 * @version 2015-02-03
 */
public class CmAuditTrack extends ActEntity<CmAuditTrack> {
	
	private static final long serialVersionUID = 1L;
	private String auditId;			// 审计编号
	private String question;		// 问题
	private String ciId;			// 配置项编号(多个配置项编号以英文逗号分隔)
	private String ciName;          //配置项名称
	private User dutyOfficer;		// 责任人
	private String solveStatus;		// 解决状态
	private String planSolveTime;	// 计划解决时间
	private String realitySolveTime;// 实际解决时间
	private String status;			// 状态
	
	private List<Map<String,String>> maps;//配置项id与名称
	
	public CmAuditTrack() {
		super();
	}

	public CmAuditTrack(String id){
		super(id);
	}

	@Length(min=0, max=64, message="审计编号长度必须介于 0 和 64 之间")
	public String getAuditId() {
		return auditId;
	}

	public void setAuditId(String auditId) {
		this.auditId = auditId;
	}
	
	@Length(min=0, max=255, message="问题长度必须介于 0 和 255 之间")
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}
	
	public String getCiId() {
		return ciId;
	}

	public void setCiId(String ciId) {
		this.ciId = ciId;
	}

	public User getDutyOfficer() {
		return dutyOfficer;
	}

	public void setDutyOfficer(User dutyOfficer) {
		this.dutyOfficer = dutyOfficer;
	}

	@Length(min=0, max=1, message="解决状态长度必须介于 0 和 1 之间")
	public String getSolveStatus() {
		return solveStatus;
	}

	public void setSolveStatus(String solveStatus) {
		this.solveStatus = solveStatus;
	}
	
	@Length(min=0, max=20, message="计划解决时间长度必须介于 0 和 20 之间")
	public String getPlanSolveTime() {
		return planSolveTime;
	}

	public void setPlanSolveTime(String planSolveTime) {
		this.planSolveTime = planSolveTime;
	}
	
	@Length(min=0, max=20, message="实际解决时间长度必须介于 0 和 20 之间")
	public String getRealitySolveTime() {
		return realitySolveTime;
	}

	public void setRealitySolveTime(String realitySolveTime) {
		this.realitySolveTime = realitySolveTime;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCiName() {
		return ciName;
	}

	public void setCiName(String ciName) {
		this.ciName = ciName;
	}

	public List<Map<String, String>> getMaps() {
		if(ciId!=null&&!ciId.equals("")){
			List<Map<String, String>> listMap = Lists.newArrayList();
			String[] ids =  ciId.split(",");
			String[] names = ciName.split(",");
			for(int i=0;i<ids.length;i++){
				Map<String, String> map = Maps.newHashMap();
				map.put("ciId", ids[i]);
				map.put("ciName", names[i]);
				listMap.add(map);
			}
			
			return listMap;
		}else{
			return this.maps;
		}
	}

	public void setMaps(List<Map<String, String>> maps) {
			this.maps = maps;
		
	}
	
	
}