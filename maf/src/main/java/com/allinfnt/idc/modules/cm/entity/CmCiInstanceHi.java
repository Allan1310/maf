/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项历史版本Entity
 * @author liujx
 * @version 2015-02-01
 */
public class CmCiInstanceHi extends DataEntity<CmCiInstanceHi> {
	
	private static final long serialVersionUID = 1L;
	private String ciNumber;		// 配置项编号
	private String ciName;		// 配置项名称
	private String ciVersion;		// 配置项版本号
	private CmCiGroup cmCiGroup;		// 分类编号
	private String status;		// 状态
	private String ciStatusA;		// 配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）
	private String ciStatusB;		// 配置项状态（9：借用，10：借出，11：开发）
	private CmGraphIcon cmGraphIcon; //配置项图标
	private String ext1;		// 扩展字段1
	private String ext2;		// 扩展字段2
	
	public CmCiInstanceHi() {
		super();
	}

	public CmCiInstanceHi(String id){
		super(id);
	}

	@Length(min=0, max=50, message="配置项编号长度必须介于 0 和 50 之间")
	public String getCiNumber() {
		return ciNumber;
	}

	public void setCiNumber(String ciNumber) {
		this.ciNumber = ciNumber;
	}
	
	@Length(min=0, max=50, message="配置项名称长度必须介于 0 和 50 之间")
	public String getCiName() {
		return ciName;
	}

	public void setCiName(String ciName) {
		this.ciName = ciName;
	}
	
	@Length(min=0, max=10, message="配置项版本号长度必须介于 0 和 10 之间")
	public String getCiVersion() {
		return ciVersion;
	}

	public void setCiVersion(String ciVersion) {
		this.ciVersion = ciVersion;
	}
	
	public CmCiGroup getCmCiGroup() {
		return cmCiGroup;
	}

	public void setCmCiGroup(CmCiGroup cmCiGroup) {
		this.cmCiGroup = cmCiGroup;
	}

	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=1, message="配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）长度必须介于 0 和 1 之间")
	public String getCiStatusA() {
		return ciStatusA;
	}

	public void setCiStatusA(String ciStatusA) {
		this.ciStatusA = ciStatusA;
	}
	
	@Length(min=0, max=2, message="配置项状态（9：借用，10：借出，11：开发）长度必须介于 0 和 2 之间")
	public String getCiStatusB() {
		return ciStatusB;
	}

	public void setCiStatusB(String ciStatusB) {
		this.ciStatusB = ciStatusB;
	}
	
	@Length(min=0, max=1000, message="扩展字段1长度必须介于 0 和 1000 之间")
	public String getExt1() {
		return ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}
	
	@Length(min=0, max=1000, message="扩展字段2长度必须介于 0 和 1000 之间")
	public String getExt2() {
		return ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public CmGraphIcon getCmGraphIcon() {
		return cmGraphIcon;
	}

	public void setCmGraphIcon(CmGraphIcon cmGraphIcon) {
		this.cmGraphIcon = cmGraphIcon;
	}
	
}