package com.allinfnt.idc.modules.msg.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class UtilString {
	
	public static String Utilstr(){
		String str = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");// 设置日期格式
		 Random rand = new Random();
		 int randstr = rand.nextInt(1000);
	        if(Integer.toString(randstr).toString().length()<4){
	        	StringBuffer sb = new StringBuffer("");
	        	for(int i=0;i<(4-Integer.toString(randstr).toString().length());i++){
	        	   sb.append("0");
	        	}
	        	str = df.format(new Date())+sb+Integer.toString(randstr);
	        }
		return str;
	}
}
