package com.allinfnt.idc.common.utils;

import java.util.Map;

public class PageResult {

    private int    isEnd = 0;
    private long    nextStartIndex;
    private long   count;
    private Map    variableMap;
    private Object dataList;
    private Object list1;
    private Object list2;

    public Map getVariableMap() {
        return variableMap;
    }

    public void setVariableMap(Map variableMap) {
        this.variableMap = variableMap;
    }

    public Object getDataList() {
        return dataList;
    }

    public void setDataList(Object dataList) {
        this.dataList = dataList;
    }

    public Object getList1() {
        return list1;
    }

    public void setList1(Object list1) {
        this.list1 = list1;
    }

    public Object getList2() {
        return list2;
    }

    public void setList2(Object list2) {
        this.list2 = list2;
    }

    public int getIsEnd() {
        return isEnd;
    }

    public void setIsEnd(int isEnd) {
        this.isEnd = isEnd;
    }

	public long getNextStartIndex() {
		return nextStartIndex;
	}

	public void setNextStartIndex(long nextStartIndex) {
		this.nextStartIndex = nextStartIndex;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

}
