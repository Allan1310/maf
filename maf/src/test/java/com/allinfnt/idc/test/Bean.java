package com.allinfnt.idc.test;

import java.util.ArrayList;
import java.util.List;

public class Bean {
	private int id;
    private int sortId;
    private int parentId;
    private List<Bean> children = new ArrayList<Bean>();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSortId() {
		return sortId;
	}
	public void setSortId(int sortId) {
		this.sortId = sortId;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public List<Bean> getChildren() {
		return children;
	}
	public void setChildren(List<Bean> children) {
		this.children = children;
	}
	
}
