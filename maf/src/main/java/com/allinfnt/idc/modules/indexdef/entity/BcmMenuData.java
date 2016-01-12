
package com.allinfnt.idc.modules.indexdef.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 首页自定义配置Entity
 * @author zx
 * @version 2015-03-17
 */
@SuppressWarnings("serial")
public class BcmMenuData extends DataEntity<BcmMenu> {
	private String id;			// 菜单id
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	private String title;		// 菜单名称
	private String url;		   // 链接地址
	private String menuShowType;		// 是否显示
	private String menuShow;		// 是否默认显示
	private String menuExpandType;		// 是否放大
	private String menuReloadType;		// 是否刷新
	private String menuHideType;		// 是否收缩
	private String menuCloseType;		// 是否关闭
	private String columnType;		// 类别
	private String rowType;		// 类别
	private String modelColor;		// 类别

		
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMenuShow() {
		return menuShow;
	}

	public void setMenuShow(String menuShow) {
		this.menuShow = menuShow;
	}

	public String getModelColor() {
		return modelColor;
	}

	public void setModelColor(String modelColor) {
		this.modelColor = modelColor;
	}

	
}