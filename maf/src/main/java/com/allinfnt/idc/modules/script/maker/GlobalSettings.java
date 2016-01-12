package com.allinfnt.idc.modules.script.maker;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Properties;

import com.allinfnt.idc.modules.script.utils.SystemUtils;


public class GlobalSettings {
	
	public static String getSysPath(){
		/*String path = System.getenv("ProjectUtil");
		System.out.println(path);
		if(StringUtils.isNotBlank(path)){
			return path+"/";
		}*/
		String ret = System.getProperty("user.dir").toString();
		ret = ret.replace("\\","/") + "/";
		return ret;
	}
	
	public static Properties prop = getProperties();
	
	public static int browserCoreType = Integer.parseInt(prop.getProperty("BrowserCoreType", "2"));
	
	public static String baseUrl = prop.getProperty("baseUrl", "http://192.168.200.13:6001/web-suite");
	
	
	public static final String PATH_SYS = SystemUtils.getSysPath();
	
	public static final String PATH_CONFIG_PROPERTIES = getSysPath()+ "config/properties/";
	
	public static String FireFoxPath=prop.getProperty("FirefoxPath", "C:/Program Files/Firefox/firefox.exe");
	public static String chromeDriverPath =getSysPath()+ prop.getProperty("ChromeDriverPath", "./chromedriver-2.9/windows/chromedriver.exe");
	public static String ieDriverPath =getSysPath()+ prop.getProperty("IEDriverPath", "res/iedriver_32.exe");
	
	//public static String StepInterval = prop.getProperty("StepInterval", "500");
	
	public static final Integer stepInterval = 500;
	
	public static String Timeout = prop.getProperty("Timeout", "30000");
	
	public static final String PATH_CONFIG_DBXMLS =getSysPath()+ "config/dbxml/";
	public static final String PATH_CONFIG_DTDS =getSysPath()+ "config/dtd/";
	
	
	//public static String timeout = prop.getProperty("Timeout", "30000");
	//public static String timeout = "30000";
	
	
	/*
	public static String dbUrl = prop.getProperty("url", "jdbc\\:oracle\\:thin\\:@192.168.200.10\\:1521\\:cccstaging");
	public static String  dbUser = prop.getProperty("userName", "ESTTEST");
	public static String dbPassword = prop.getProperty("password", 
			"reinspection1234");*/
	
	
	
	
	
	//public static final String LABELMAP_EXCEL=getSysPath()+"data/excel/清算系统/LabelMap - anlizhixing.xlsx";
	//public static final String LABELMAP_EXCEL=getSysPath()+"data/excel/二代工单/LabelMap_工单.xlsx";
	//public static final String URL="http://192.168.200.13:6001/web-suite/";
	
	public static final String FLAG = "=_=";
	
	public static final String TOKEN_SQL_PARAM = ":";
	public static final String TOKEN_INPUTDATA ="#";
	public static final String TOKEN_CASE ="$";
	public static final String TOKEN_JQUERY ="~";
	public static final String TOKEN_CASE_METHODS = ",";
	
	public static final String FLAG_PUSHMAP_VALUE = "value";
	
	/*packages*/
	public static final String PACKAGE_TEST_CASE = "package com.pactera.test;";
	public static final String PACKAGE_WEB_ELEMENT = "import com.tonyh.script.operator.webelement.*;";
	public static final String PACKAGE_LABELS = "import com.tonyh.script.operator.*;";
	public static final String PACKAGE_MAKER = "import com.tonyh.script.maker.*;";
	
	
	public static final int SQL_TYPE_LONG = 1;
	public static final int SQL_TYPE_STRING = 2;
	
	public static final int BEGIN_OF_CASE_COUNT = 10000;
	public static final int BEGIN_OF_STEP_COUNT = 0;
	
	/*重试的次数和间隔*/
	
	public static final int RETRY_LONG_COUNT = 20;
	public static final int RETRY_LONG_INTERVAL = 6000;
	public static final int RETRY_SHORT_COUNT = 10;
	public static final int RETRY_SHORT_INTERVAL = 1000;
	
	/*public static final String ACTION_BROWSER = "浏览器";
	public static final String ACTION_PROMPT = "弹出框"; 
	public static final String ACTION_ALERT = "对话框";*/
/*	public static final String ACTION_ALERTTEXT = "对话框取值";*/
	/*public static final String ACTION_SELWINDOW = "跳转";
	public static final String ACTION_ROLLBACK = "返回";
	public static final String ACTION_SELFRAME = "框架";
	public static final String ACTION_SELFRAME2 = "框架path";
	public static final String ACTION_SELFRAMENEW = "新窗口";
	public static final String ACTION_SQL = "sql";
	public static final String ACTION_CARDNOIN = "卡号处理";*/
	//public static final String ACTION_CODESPAN = "获取编号";
	//public static final String ACTION_JIEGUO = "获取结果";
	/*public static final String ACTION_SNMJB = "Selenium";*/
	//public static final String ACTION_ROLLBACKWINDOW = "返回";
	/*testCase actions*/
	/*public static final String ACTION_OPEN_URL = "打开";
	public static final String ACTION_INSERT_CODE = "代码";
	public static final String ACTION_PARSE = "等待";
	public static final String ACTION_MENU = "菜单";
	public static final String ACTION_SENDSTRING = "脚本";
	public static final String ACTION_IT3 = "IT腳本";
	public static final String ACTION_IT3q = "IT腳本qs";
	public static final String ACTION_ASSERT = "断言";
	public static final String ACTION_SELENIUMCLICK = "selenium点击";*/
	
	/*map of step functions*/
	public static HashMap<String, String> functionMap;
	
	/*map of webElement type of step*/
	/*public static HashMap<String,String> webElementMap;

	public static final String KEY_TESTCASENAME = "Test Suite Class";
	public static final String KEY_TESTCASE_DESC = "Test Suite Description";
	public static final String KEY_DBCHECK_CONFIG = "DBCheck Configuration";
	public static final String KEY_DBCHECK_CLAIM_CONFIG = "DBCheck Claim Configuration";
	public static final String KEY_INTERFACE_PUSH_TIEM = "Interface Push Times";
	public static final String KEY_INTERFACE_PUSH_TYPE = "Interface Push Type";*/
	
	/*excel sheet index*/ 
/*	public static final Integer EXCEL_SHEETIND_OF_LABEL = 1;
	public static final Integer EXCEL_SHEETIND_OF_WEBELEMENT = 2;
	public static final Integer EXCEL_SHEETIND_OF_SQL = 3;
	public static final Integer EXCEL_SHEETIND_OF_INFO = 1;
	public static final Integer EXCEL_SHEETIND_OF_SUITES = 2;
	public static final Integer EXCEL_SHEETIND_OF_CASES = 3;
	public static final Integer EXCEL_SHEETIND_OF_DB_CONFIG = 4;
	public static final Integer EXCEL_SHEETIND_OF_DB_CLAIM_CONFIG = 5;
	public static final Integer EXCEL_SHEETIND_OF_PUSH = 6;*/
	
	/*ConfigUpdateVo*/
	/*public static final int VO_CONFIGUPDATE_BEGIN = 2;
	public static final int VO_CONFIGCLAIM_BEGIN = 2;*/
	
	/*VO CASEINFO INDEX*/
	/*public static final int VO_CASEINFO_NO = 0;
	public static final int VO_CASEINFO_KEY = 1;
	public static final int VO_CASEINFO_VALUE = 2;
	public static final int VO_CASEINFO_COMMENTS = 3;*/
	
	/*VO column index*/
	/*public static final int VO_ELEMAP_PAGE = 0;
	public static final int VO_ELEMAP_LABEL = 1;
	public static final int VO_ELEMAP_WEBELEMENT = 2;
	public static final int VO_ELEMAP_CLASSNAME = 3;*/
	
	/*VO column index*/
	/*public static final int VO_SUITE_SHEETINDEX = 1;
	public static final int VO_SUITE_DES = 2;
	public static final int VO_SUITE_NAME = 3;*/
	
	/*VO column index*/
	/*public static final int VO_LABELMAP_PAGE = 0;
	public static final int VO_LABELMAP_LABEL = 1;
	public static final int VO_LABELMAP_WEBELEMENT = 2;
	public static final int VO_LABELMAP_CLASS = 3;
	public static final int VO_LABELMAP_FUNCTION = 5;
	public static final int VO_LABELMAP_FLAG = 4;*/
	
	/*VO column SQL*/
	/*public static final int VO_SQL_NO = 0;
	public static final int VO_SQL_PARAM_COUNT = 1;
	public static final int VO_SQL_NAME = 2;
	public static final int VO_SQL_DES = 3;
	public static final int VO_SQL_RET_TYPE = 4;
	public static final int VO_SQL = 5;*/
	
	/*VO column index*/
	/*public static final int VO_STEP_NO = 0;
	public static final int VO_STEP_METHOD = 1;
	public static final int VO_STEP_DES = 2;
	public static final int VO_STEP_PAGE = 3;
	public static final int VO_STEP_LABEL = 4;
	public static final int VO_STEP_WEBELEMENT = 5;
	public static final int VO_STEP_FUNCTION = 6;
	public static final int VO_STEP_VALUE1 = 7;
	public static final int VO_STEP_VALUE2 = 8;
	public static final int VO_STEP_VALUE3 = 9;
	public static final int VO_STEP_ENABLE = 10;
	public static final int VO_STEP_RETURN = 11;
	public static final int VO_STEP_SCREENSHOT = 12;
	
	public static final int VO_TESTCASE_NO = 0;
	public static final int VO_TESTCASE_NAME = 1;
	public static final int VO_TESTCASE_DES = 2;
	public static final int VO_TESTCASE_METHODS = 3;
	public static final int VO_TESTCASE_DEPENDS = 4;
	public static final int VO_TESTCASE_VALUES = 5;*/
	
	//public static final String STR1=" =============== ";

	//用来定位element的参数个数
	public static final int X = 1;
	public static final int Y = 2;
	public static final int Z = 3;
	
	static {
		functionMap = new HashMap<String, String>();
		functionMap.put("action01","setValue");
		functionMap.put("action02","openWebSuite");
		functionMap.put("action03","click");
		functionMap.put("action04","doAction");
		functionMap.put("action05", "dbclick");
		functionMap.put("action06","getValue");
		functionMap.put("action07","weGetAttribute");
		functionMap.put("action08", "alertText");
		functionMap.put("action09","checked");
		functionMap.put("action10", "execScript");
		functionMap.put("action11", "execAction");
		functionMap.put("action12", "isDisplayed");
	}
		
		/*webElementMap = new HashMap<String, String>();
		webElementMap.put("文本框","TextBox");
		webElementMap.put("下拉框","DropDown");
		webElementMap.put("按钮","WebButton");
		webElementMap.put("网格","GridCell");
		webElementMap.put("单选","Radio");
		webElementMap.put("选项卡","Tab");
		webElementMap.put("勾选框","CheckBox");
		webElementMap.put("区域","Span");
		webElementMap.put("超链接","Link");
		webElementMap.put("点选框","ClickBox");
		webElementMap.put("js对象","JElement");
		webElementMap.put("Robot对象","RobotElement");
		webElementMap.put("提示框","Alert");
		//webElementMap.put("X区域","XPathX");
	}*/
	
	public static String getProperty(String Property) {
		return prop.getProperty(Property);
	}
	
	public static Properties getProperties() {
		Properties prop = new Properties();
		try {
			FileInputStream file = new FileInputStream("./prop.properties");
			prop.load(file);
			file.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return prop;
	}
	
	public static void main(String[]args) {
		GlobalSettings globalSettings = new GlobalSettings();
		System.out.println(globalSettings.getSysPath());
	}
}
