/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdef.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;
import com.allinfnt.idc.modules.sys.entity.Menu;

/**
 * 首页自定义配置Entity
 * @author zx
 * @version 2015-03-25
 */
public class BcmMenu extends DataEntity<BcmMenu> {
	
	private static final long serialVersionUID = 1L;
	private String menuId;		// 菜单id(关联菜单)
	private String menuShow;		// 默认显示
	private String menuShowType;		// 是否显示
	private String menuExpandType;		// 是否放大
	private String menuReloadType;		// 是否刷新
	private String menuHideType;		// 是否收缩
	private String menuCloseType;		// 是否关闭
	private String modelColor;		// 类别
	
	private Menu menu;   //菜单对象
	
	public BcmMenu() {
		super();
	}

	public BcmMenu(String id){
		super(id);
	}

	@Length(min=1, max=200, message="菜单id(关联菜单)长度必须介于 1 和 200 之间")
	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
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

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public String getModelColor() {
		return modelColor;
	}

	public void setModelColor(String modelColor) {
		this.modelColor = modelColor;
	}
	
}