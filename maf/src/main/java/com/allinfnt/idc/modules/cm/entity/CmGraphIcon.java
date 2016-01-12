/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 配置项图标Entity
 * @author liujx
 * @version 2015-04-07
 */
public class CmGraphIcon extends DataEntity<CmGraphIcon> {
	
	private static final long serialVersionUID = 1L;
	private String iconName;		// 图标名称
	private String iconFile;		// 图标路径
	
	public CmGraphIcon() {
		super();
	}

	public CmGraphIcon(String id){
		super(id);
	}

	@Length(min=0, max=50, message="图标名称长度必须介于 0 和 50 之间")
	public String getIconName() {
		return iconName;
	}

	public void setIconName(String iconName) {
		this.iconName = iconName;
	}
	
	@Length(min=0, max=255, message="图标路径长度必须介于 0 和 255 之间")
	public String getIconFile() {
		return iconFile;
	}

	public void setIconFile(String iconFile) {
		this.iconFile = iconFile;
	}
	
}