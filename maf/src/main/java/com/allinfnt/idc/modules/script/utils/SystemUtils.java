package com.allinfnt.idc.modules.script.utils;



public class SystemUtils {
	
	public static String getSysPath(){
		String path = System.getenv("testsuitefold");
		if(StringUtils.isNotBlank(path)){
			return path+"/";
		}
		String ret = System.getProperty("user.dir").toString();
		ret = ret.replace("\\","/") + "/";
		return ret;
	}
}
