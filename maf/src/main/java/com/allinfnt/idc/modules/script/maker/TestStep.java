package com.allinfnt.idc.modules.script.maker;

public class TestStep {
	
	private int stepNumber = 0;
	private String systemName = null;
	private String pageName = null;
	private String pagePath = null;
	private String object = null;
	private String action = null;
	private String data = null;
	private String method = null;
	private String xpathExpress = null;
	private int flag = 0;
	private int paraCount = 0;
	private int waitNumber = 0;
	private int needScreenShot = 0;
	private String returnValue = null;
	
	TestStep() {
		
	}
	
	
	public String getMethod() {
		return method;
	}
	
	
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getPagePath() {
		return pagePath;
	}
	public void setPagePath(String pagePath) {
		this.pagePath = pagePath;
	}
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}


	public String getXpathExpress() {
		return xpathExpress;
	}


	public void setXpathExpress(String xpathExpress) {
		this.xpathExpress = xpathExpress;
	}


	public void setMethod(String method) {
		this.method = method;
	}


	public int getFlag() {
		return flag;
	}


	public void setFlag(int flag) {
		this.flag = flag;
	}


	public int getParaCount() {
		return paraCount;
	}


	public void setParaCount(int paraCount) {
		this.paraCount = paraCount;
	}


	public int getStepNumber() {
		return stepNumber;
	}


	public void setStepNumber(int stepNumber) {
		this.stepNumber = stepNumber;
	}


	public int getWaitNumber() {
		return waitNumber;
	}


	public void setWaitNumber(int waitNumber) {
		this.waitNumber = waitNumber;
	}


	public int getNeedScreenShot() {
		return needScreenShot;
	}


	public void setNeedScreenShot(int needScreenShot) {
		this.needScreenShot = needScreenShot;
	}


	public String getReturnValue() {
		return returnValue;
	}


	public void setReturnValue(String returnValue) {
		this.returnValue = returnValue;
	}
	
	
	
}
