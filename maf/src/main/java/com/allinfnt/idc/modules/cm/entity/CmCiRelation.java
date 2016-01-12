/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项关联关系Entity
 * @author liujx
 * @version 2015-02-03
 */
public class CmCiRelation extends DataEntity<CmCiRelation> {
	
	private static final long serialVersionUID = 1L;
	private String ciVersion;		// 配置项版本号
	private CmCiInstance ciInstance;		// 配置项编号
	private CmCiInstance reCiInstance;		// 关系配置项编号
	private String relationType;		// 关系类型（详细见字典表）
	private String status;		// 状态
	
	public CmCiRelation() {
		super();
	}

	public CmCiRelation(String id){
		super(id);
	}

	@Length(min=0, max=10, message="配置项版本号长度必须介于 0 和 10 之间")
	public String getCiVersion() {
		return ciVersion;
	}

	public void setCiVersion(String ciVersion) {
		this.ciVersion = ciVersion;
	}
	
	public CmCiInstance getCiInstance() {
		return ciInstance;
	}

	public void setCiInstance(CmCiInstance ciInstance) {
		this.ciInstance = ciInstance;
	}

	public CmCiInstance getReCiInstance() {
		return reCiInstance;
	}

	public void setReCiInstance(CmCiInstance reCiInstance) {
		this.reCiInstance = reCiInstance;
	}

	@Length(min=0, max=2, message="关系类型（详细见字典表）长度必须介于 0 和 2 之间")
	public String getRelationType() {
		return relationType;
	}

	public void setRelationType(String relationType) {
		this.relationType = relationType;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}