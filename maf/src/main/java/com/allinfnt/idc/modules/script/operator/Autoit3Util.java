package com.allinfnt.idc.modules.script.operator;
import java.util.Locale;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.allinfnt.idc.modules.script.maker.GlobalSettings;
import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.Platform;
import com.sun.jna.WString;

public class Autoit3Util {

	private static Logger logger = Logger.getLogger(Autoit3Util.class.getName());
	static String autoit3;
	static int langIndex;

	
	static{
		Locale locale = Locale.getDefault();
    	String lang = locale.getLanguage();
		logger.info("locale lang is="+lang);
    	if(lang.toLowerCase().equals("en")){
    		langIndex = 1;
    	}else{
    		langIndex = 0;
    	}
    	
    	
		Properties props = System.getProperties();
		String os = props.getProperty("os.name");
		String arch =props.getProperty("os.arch");
		logger.info("操作系统的名称："+os);
		logger.info("操作系统的构架："+arch);
		if(arch.equals("x86")){
			logger.info("load config/lib/AutoItX3.dll");
			System.load(GlobalSettings.PATH_SYS+"lib/AutoItX3.dll");
			autoit3="AutoItX3";
		}else{
			logger.info("load config/lib/AutoItX3_x64.dll");
			System.load(GlobalSettings.PATH_SYS+"lib/AutoItX3_x64.dll");
			autoit3="AutoItX3_x64";
		}
	}
	
	public interface CLibrary extends Library  {		
		CLibrary INSTANCE = (CLibrary)
            Native.loadLibrary((Platform.isWindows() ? autoit3 : "c"),
                               CLibrary.class);
   
        int AU3_WinActive(WString title,WString i2);
        int AU3_WinClose(WString title,WString i2);
        int AU3_ControlSetText(WString title,WString text,WString object,WString objecttext);
        int AU3_WinMinimizeAll();
        int AU3_ControlClick(WString title,WString i2,WString i3,WString i4,Object... args);
        int AU3_MouseClick(WString string,Object... args);
    }
    
 
    public static void mainchooseFile(String args,String biaozhi) {

    	chooseFile(args, "File Upload", "[CLASS:Edit;INSTANCE:1]", "[CLASS:Button;text:打开(&O)]",biaozhi);
    	Locale locale = Locale.getDefault();
    	System.out.println(locale.getLanguage());
    }
    
    public static void mainchooseFile1(String args) {
    	chooseFile1(args, "选择要加载的文件", "[CLASS:Edit;INSTANCE:1]", "[CLASS:Button;INSTANCE:1;text:打开(&O)]");
    	Locale locale = Locale.getDefault();
    	System.out.println(locale.getLanguage());
    }
    
    public static void chooseFile1(String fileAbsolutePath,String wintitle,String textboxParam,String btnParam){
    	WString title = new WString(wintitle);
    	WString empty = new WString("");
    	String tb = textboxParam;
    	String bt = btnParam;
    	if(tb==null){
    		tb = "[CLASS:Edit;INSTANCE:1]";
    	}
    	if(bt==null){
    		bt ="[CLASS:Button;INSTANCE:1;text:&Open]";
    	}
    	logger.info("AutoIt3 "+title+"  "+bt);
    	WString textbox = new WString(tb);
    	WString btn = new  WString(bt);
    	WString file = new WString(fileAbsolutePath);
    	
		  try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	CLibrary.INSTANCE.AU3_WinActive(title,empty);
    	CLibrary.INSTANCE.AU3_ControlSetText(title,empty,textbox, file);
    	CLibrary.INSTANCE.AU3_ControlClick(title, empty, btn, new WString("left"));
   
		  try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	CLibrary.INSTANCE.AU3_WinActive(title,empty);
      	CLibrary.INSTANCE.AU3_ControlSetText(title,empty,textbox,file);
    	CLibrary.INSTANCE.AU3_ControlClick(title,empty,btn,empty,1,0,0);
    }
    
    
    
    public static void chooseFile(String fileAbsolutePath,String wintitle,String textboxParam,String btnParam,String biaozhi){
    	WString title = new WString(wintitle);
    	WString empty = new WString("");
    	String tb = textboxParam;
    	String bt = btnParam;
    	if(tb==null){
    		tb = "[CLASS:Edit;INSTANCE:1]";
    	}
    	if(bt==null){
    		bt ="[CLASS:Button;text:&Open]";
    	}
    	logger.info("AutoIt3 "+title+"  "+bt);
    	WString textbox = new WString(tb);
    	WString btn = new  WString(bt);
    	WString file = new WString(fileAbsolutePath);
    	
		  try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	CLibrary.INSTANCE.AU3_WinActive(new WString("浦发银行信用卡中心工单系统 - Mozilla Firefox"),empty);
    	if(biaozhi=="1"){
    	CLibrary.INSTANCE.AU3_MouseClick(new WString("left"),477,448,1,10);
    	}
    	if(biaozhi=="0"){
    	CLibrary.INSTANCE.AU3_MouseClick(new WString("left"),477,415,1,10);
    	}
		  try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	CLibrary.INSTANCE.AU3_WinActive(title,empty);
      	CLibrary.INSTANCE.AU3_ControlSetText(title,empty,textbox,file);
    	CLibrary.INSTANCE.AU3_ControlClick(title,empty,btn,empty,1,0,0);
    }
}
