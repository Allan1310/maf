/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdefuser.entity;

import org.hibernate.validator.constraints.Length;
import com.allinfnt.idc.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 首页自定义用户配置Entity
 * @author zx
 * @version 2015-03-17
 */
public class BcmMenuUser extends DataEntity<BcmMenuUser> {
	
	private static final long serialVersionUID = 1L;
	private String menuId;		// 自定义菜单id
	private User user;		// 用户编号id
	private String menuShow;		// 默认显示
	private String menuShowType;		// 是否显示
	private String menuExpandType;		// 是否放大
	private String menuReloadType;		// 是否刷新
	private String menuHideType;		// 是否收缩
	private String menuCloseType;		// 是否关闭
	private String columnType;		// 类别
	private String rowType;		//行别别
	private String modelColor;		//行别别
	
	public BcmMenuUser() {
		super();
	}

	public BcmMenuUser(String id){
		super(id);
	}

	@Length(min=1, max=64, message="自定义菜单id长度必须介于 1 和 64 之间")
	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	@NotNull(message="用户编号id不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	@Length(min=0, max=2, message="默认显示长度必须介于 0 和 2 之间")
	public String getMenuShow() {
		return menuShow;
	}

	public void setMenuShow(String menuShow) {
		this.menuShow = menuShow;
	}
	
	@Length(min=0, max=2, message="是否显示长度必须介于 0 和 2 之间")
	public String getMenuShowType() {
		return menuShowType;
	}

	public void setMenuShowType(String menuShowType) {
		this.menuShowType = menuShowType;
	}
	
	@Length(min=0, max=2, message="是否放大长度必须介于 0 和 2 之间")
	public String getMenuExpandType() {
		return menuExpandType;
	}

	public void setMenuExpandType(String menuExpandType) {
		this.menuExpandType = menuExpandType;
	}
	
	@Length(min=0, max=2, message="是否刷新长度必须介于 0 和 2 之间")
	public String getMenuReloadType() {
		return menuReloadType;
	}

	public void setMenuReloadType(String menuReloadType) {
		this.menuReloadType = menuReloadType;
	}
	
	@Length(min=0, max=2, message="是否收缩长度必须介于 0 和 2 之间")
	public String getMenuHideType() {
		return menuHideType;
	}

	public void setMenuHideType(String menuHideType) {
		this.menuHideType = menuHideType;
	}
	
	@Length(min=0, max=2, message="是否关闭长度必须介于 0 和 2 之间")
	public String getMenuCloseType() {
		return menuCloseType;
	}

	public void setMenuCloseType(String menuCloseType) {
		this.menuCloseType = menuCloseType;
	}
	
	@Length(min=0, max=2, message="类别长度必须介于 0 和 2 之间")
	public String getColumnType() {
		return columnType;
	}

	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}

	public String getRowType() {
		return rowType;
	}

	public void setRowType(String rowType) {
		this.rowType = rowType;
	}

	public String getModelColor() {
		return modelColor;
	}

	public void setModelColor(String modelColor) {
		this.modelColor = modelColor;
	}
	
}