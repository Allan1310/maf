package com.allinfnt.idc.modules.script.operator;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.Point;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.Augmenter;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import com.spdbccc.script.maker.GlobalSettings;
import com.thoughtworks.selenium.Wait;


public class TestCaseOperator {
	
	private static final int TYPE_XPATH = 0;
	private static final int TYPE_JQUERY = 1;
	
	private int type;
	private String xpath;
	private String jelement;
	private WebElement webElement;
	private boolean isElementOK = false;
	private boolean checkElement = true;
	
	private RemoteWebDriver browserCore;
	private ChromeDriverService chromeServer;
	private JavascriptExecutor javaScriptExecutor;
	private int stepInterval = GlobalSettings.stepInterval;
	private int timeout = Integer.parseInt(GlobalSettings.Timeout);
	
	private String windowHandle;
	private String currentWindow;
	WebElement we;
	
	
	//private List<String> reportlogList = new ArrayList<String>();
	//private String windowHandle;
	//private String windowHandleNew;
	//private String currentWindow;
	//private boolean selectWindowFlag = false;
	private static TestCaseOperator tco;
	//private LabelPage labelPage;
	private static Logger logger = Logger.getLogger(TestCaseOperator.class.getName());
	
	public TestCaseOperator() {
		setupBrowserCoreType(2);
		javaScriptExecutor = (JavascriptExecutor) browserCore;
		logger.info("Started BrowserEmulator");
		if(tco==null)
			tco = this;
	}
	
	
	public String init(int type,String input) {
		this.type = type;
		switch (type) {
		case TYPE_XPATH: //xpath 
			xpath = input;
			try {
				checkElementExist(GlobalSettings.RETRY_SHORT_COUNT, GlobalSettings.RETRY_SHORT_INTERVAL);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (webElement == null)
				webElement = browserCore.findElement(By.xpath(input));
			isElementOK = true;
			break;
		case TYPE_JQUERY: //jquery
			jelement = input;
			try {
				checkElementExist(GlobalSettings.RETRY_SHORT_COUNT, GlobalSettings.RETRY_SHORT_INTERVAL);
			} catch (Exception e) {
				e.printStackTrace();
			}
			isElementOK = true;
			break;
		default:
			break;
		}
		return null;
	}
	
	public void logger(String lo) {
		logger.info("步骤:::  "+lo);
	}
	
	WebElement initWebElement(String xp){
		//expect.expectElementExistOrNot(true, xp);
		WebElement we1 = browserCore.findElement(By.xpath(xp));
		logger.info("indexof1 :="+xp.indexOf(":"));
		return we1;
	}
	
	public String execAction(int type,String path,String input) {
		// TODO Auto-generated m ethod stub
		return null;
	}
	
	// 接上面，滚回windowHandle
	public String rollback() {
		browserCore.switchTo().window(windowHandle);
		return null;
	}
	
	//执行脚本
	public String execScript(int type,String path,String input) {
		String result = null;
		try {
			String str = input.replace(GlobalSettings.TOKEN_JQUERY,GlobalSettings.TOKEN_CASE);
			logger.info("Jquery is " + str);
			javaScriptExecutor.executeScript(str);
			result = (String)(javaScriptExecutor.executeScript(str));
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to send input " + input);
		}
		logger.info("Opened input " + input);
		return result;
	}
	
	public void selenuimDbClick(){
		Actions action = new Actions(browserCore); 
		action.doubleClick(we);
	}
	
	public void clickUntilOk(WebElement we){
		try{
			we.click();
		}catch (Exception e) {
			clickUntilClickable();
		}
	}
	
	public void clickUntilClickable(){
		new Wait() {
			
			public boolean until() {
				boolean ret = false;
				try {
					we.click();
					ret = true;
				} catch (Exception e) {
					logger.info("element is unclickable,tryagain");
				}
				return ret;
				}
			}.wait("element is unclick",15000,1000);
	}
	
	public void checkElementIsDisplayed(){
		if(we!=null&&we.isDisplayed()){
			new Wait() {
				
				public boolean until() {
					boolean ret = we.isDisplayed();
					if(!ret)
						logger.info("element not displayed,retry");
					return ret;
				}
			}.wait("wait " + GlobalSettings.RETRY_SHORT_INTERVAL + "for next time we.isDisplayed()",GlobalSettings.RETRY_SHORT_INTERVAL*GlobalSettings.RETRY_SHORT_COUNT, GlobalSettings.RETRY_SHORT_INTERVAL);
		}
	}
	
	private void checkElementExist(int retrytime,int retryinterval) throws Exception {
		if(!checkElement)	
			return;		
			if(isElementPresent()){
				return;
			}else{
				new ElementWait().wait("wait " + retrytime*retryinterval + " for next time search element", retrytime*retryinterval,retryinterval);
			}
	}
	
	private class ElementWait extends Wait {

		public boolean until() {
			return isElementPresent();
		}
	}
	
	public boolean isElementPresent() {
		
		boolean isPresent = false;
		String path=null;
		
		switch (type) {
		case TYPE_XPATH:
			path = xpath;
			try {
				webElement = browserCore.findElement(By.xpath(xpath));
				isPresent = true;
			} catch (Exception e) {
				isPresent = false;
			}
			break;
		case TYPE_JQUERY:
			path = jelement;
			String script = "return "+jelement;
			WebElement element = null ;
			boolean isArray = javaScriptExecutor.executeScript(script).getClass().equals(ArrayList.class);
			if(isArray){
				if(((List)(javaScriptExecutor.executeScript(script))).size()>0){
					element = (WebElement)((List)(javaScriptExecutor.executeScript(script))).get(0);
				}
			}else{
				element = (WebElement)(javaScriptExecutor.executeScript(script));
			}
			
			if(element != null){
				isPresent = true;
			}
			break;
		default:
			break;
		}
		
		if(isPresent){
			logger.info("find element: "+path);
		}else{
			logger.info("not find element,retry: "+path);
		}
		return isPresent;
	}
	
	/*public void checkInput(String input, String input2, String input3) throws Exception {
		value1 = null;
		value2 = null;
		value3 = null;
		String[] args = null;
		switch (xyzType) {
		case MConstant.X:args=new String[]{input};
						value1 = input2;
						value2 = input3;
			break;
		case MConstant.Y:args=new String[]{input,input2};
						value1 = input3;
			break;
		case MConstant.Z:args=new String[]{input,input2,input3};
			break;
		case 0:
						value1 = input;
						value2 = input2;
						value3 = input3;
			return;
		}
		if(type==TYPE_XPATH){
			for (String str : args) {
				if(str==null)
					break;
				xpath = xpath.replaceFirst(FLAG,str);
			}
		}else if(type==TYPE_JQUERY){
			for (String str : args) {
				if(str==null)
					break;
				jelement = jelement.replaceFirst(FLAG,str);
			}
		}
		
		if(isElementPresent()){
			return;
		}else{
			new ElementWait().wait("wait " + MConstant.RETRY_SHORT_INTERVAL + "for next time search element",MConstant.RETRY_SHORT_INTERVAL*MConstant.RETRY_SHORT_COUNT, MConstant.RETRY_SHORT_INTERVAL);
		}
		if(type==TYPE_XPATH){
			logger.info("xpath= "+xpath);
		}else if(type==TYPE_JQUERY){
			logger.info("jquery= "+jelement);
		}
		
		logger.info("can't find element!");
		throw new Exception("can't find element!");
	}*/

//	public void intoReport(String input){
//		reportlogList.add(input);
//	}
//	
//	public List<String> getReportLogList() {
//		return reportlogList;
//	}

	public static TestCaseOperator getInstance(){
		return tco;
	}
	
	public void logInfo(String input){
		logger.info(input);
	}
	
	
	
	public WebElement getWebElement(String Xpath) {
		return browserCore.findElementByXPath(Xpath);
	}
	
	//输入事件
	public String setValue(int type,String path,String input) {
		try {
			if(type == 0){
				this.init(0,path);
				browserCore.findElementByXPath(path).sendKeys(input);
			} else if(type == 1) {
				this.init(1,path);
				String jQueryStr = jelement + ".val('" + input + "');";
				javaScriptExecutor.executeScript(jQueryStr);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//点击事件
	public String click(int type,String path,String input) {
		try {
			if(type == 1) {
				browserCore.findElementByXPath(path).click();
			} else if (type == 2) {
				String jQueryStr = path + ".click();";
				javaScriptExecutor.executeScript(jQueryStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	//切换窗口iframe
	public String enterFrame(String path){
		pause(stepInterval);
		windowHandle = browserCore.getWindowHandle();
		browserCore.switchTo().frame(browserCore.findElement(By.xpath(xpath)));
		logger.info("Entered iframe " + xpath);
		return null;
	}
	
	//鼠标点击事件
	public String doActions(int type,String path,String input) {
		Actions action = new Actions(browserCore);
		WebElement we = browserCore.findElementByXPath(path);
		action.click(we).perform();
		return null;
	}
		
	//切换新窗口
	public String selFrameNew(int type,String path,String input){
		currentWindow = browserCore.getWindowHandle();
		Set<String> handles = browserCore.getWindowHandles();
		Iterator<String> it = handles.iterator();
		while(it.hasNext()){
			String handle=it.next();
		if(currentWindow.equals(handle))
			continue;
		browserCore.switchTo().window(handle);
		}
        try {
			Thread.sleep(1000);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
		
	/*public String assertEquals(String input,String input2){
		try {
			Assert.assertEquals(input, input2);
		} catch (Exception e) {
			logger.error("Assert error:"+input+" and "+input2);
			e.printStackTrace();
		}
		logger.info("Assert pass" + input +" and "+input2);
		return null;
	}*/
	
	
	/*public String menu(String input){
		if(selectWindowFlag && windowHandle!=null){
			browserCore.switchTo().window(windowHandle);
			selectWindowFlag = false;
		}
		String url = labelPage.getMenuBarTabURL(input);
		try {
			browser.open(url);
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to open url " + url);
		}
		logger.info("Opened url " + url);
		return null;
	}*/
	
	
//	public String prompt(String input){
//		pause(stepInterval);
//		try {
//			String js = promptPage.getButtonOfPrompt(input);
//			javaScriptExecutor.executeScript(js);
//		} catch (Exception e) {
//			e.printStackTrace();
//			handleFailure("Failed to Click Button of Prompt");
//		}
//		logger.info("Click Button of Prompt succeed");
//		return null;
//	}
	
	
	public String alert(String input){
		pause(stepInterval);
		String value = "确定";
		if (value.equalsIgnoreCase(input)) {
			browserCore.switchTo().alert().accept();
			logger.info("Clicked on 确定");
		} else if(!value.equalsIgnoreCase(input)) {
			browserCore.switchTo().alert().dismiss();
			logger.info("Clicked on 取消");
		}else {
			handleFailure("Fialed to deal with Alert");
		}
		return null;
	}
	
	
	public String getAlertText(String input){
		Alert alert = browserCore.switchTo().alert();
		String text = alert.getText();
		System.out.println(text);
		return text;
	}
	
	/**
	 * Open the URL
	 * @param url
	 *            the target URL
	 */
	public String openWebSite(int type,String path,String url){
		pause(stepInterval);
		try {
			browserCore.get(url);
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to open url " + url);
		}
		logger.info("Opened url:" + url);
		return null;
	}
	
	/**
	 * Quit the browser
	 */
	public void quit() {
		pause(stepInterval);
		browserCore.quit();
		browserCore=null;
		logger.info("Quitted BrowserEmulator");
	}

	public String sendstr1(String str1){
		String result = null;
		try {
			String str = str1.replace(GlobalSettings.TOKEN_JQUERY,GlobalSettings.TOKEN_CASE);
			logger.info("Jquery is " + str);
			javaScriptExecutor.executeScript(str);
			result = (String)(javaScriptExecutor.executeScript(str));
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to send str1 " + str1);
		}
		logger.info("Opened str1 " + str1);
		return result;
	}

	
	public String screenShot(String input){
		String dir =GlobalSettings.getSysPath()+ "screenshot"; 
		String time = new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date());
		String filePath = dir + File.separator + time + ".png";

		WebDriver augmentedDriver = null;
		try {
			augmentedDriver = getAugmentedDriver(this);
			File inFile = ((TakesScreenshot) augmentedDriver).getScreenshotAs(OutputType.FILE);
			File outFile = new File(filePath);
			FileInputStream inStream = new FileInputStream(inFile);
			FileOutputStream outStream = new FileOutputStream(outFile);
			byte[] inOutb = new byte[inStream.available()];
			inStream.read(inOutb);  
			outStream.write(inOutb);
			inStream.close();
			outStream.close();
			String log = " >> capture screenshot at " + filePath;
			logger.info(log);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Close the WEB Browser
	 * 
	 */
	public void clean(){
		try{
		browserCore.quit();
		if(chromeServer!=null&&chromeServer.isRunning())
			chromeServer.stop();
		tco = null;
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * Get the WebDriver instance embedded
	 * @return a WebDriver instance
	 */
	public RemoteWebDriver getBrowserCore() {
		return browserCore;
	}
	
	/**
	 * Select the WEB Browser
	 * @param select number
	 * 
	 */
	private void setupBrowserCoreType(int type) {
		if(browserCore==null) {
			logger.info("Begin to load Driver...");
			if (type == 1) {
				System.setProperty ("webdriver.firefox.bin" ,GlobalSettings.FireFoxPath);
				browserCore = new FirefoxDriver();
				browserCore.manage().window().maximize();
				logger.info("Using Firefox");
				return;
			}
			if (type == 2) {
				chromeServer = new ChromeDriverService.Builder().usingDriverExecutable(new File(GlobalSettings.chromeDriverPath)).usingAnyFreePort().build();
				try {
					chromeServer.start();
				} catch (IOException e) {
					e.printStackTrace();
				}
				DesiredCapabilities capabilities = DesiredCapabilities.chrome();
				capabilities.setCapability("chrome.switches",Arrays.asList("--start-maximized"));
				browserCore = new RemoteWebDriver(chromeServer.getUrl(),capabilities);
				logger.info("Using Chrome");
				return;
			}
			if (type == 3) {
				System.setProperty("webdriver.ie.driver",GlobalSettings.ieDriverPath);
				DesiredCapabilities capabilities = DesiredCapabilities.internetExplorer();
				capabilities.setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS,true);
				browserCore = new InternetExplorerDriver(capabilities);
				logger.info("Using IE");
				return;
			}
		}
		

		//Assert.fail("Incorrect browser type");
	}
	
	/**
	 * Pause
	 * @param time in millisecond
	 */
	private void pause(int time) {
		if (time <= 0) {
			return;
		}
		try {
			Thread.sleep(time);
			logger.info("Pause " + time + " ms");
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Click the page element
	 * 
	 * @param we
	 *            the element
	 */
	/*public void click(WebElement we) {
		pause(stepInterval);

		try {
			clickTheClickable(we, System.currentTimeMillis(), 30000);
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to click " + we);
		}
		logger.info("Clicked " + we);
	}*/
	
	/**
	 * 
	 * 
	 * @param element
	 *            the element to be located
	 * @param value
	 *            the value of the element to be clicked
	 * @param index
	 *            the index of element in the Grid
	 * @return
	 */
	/*public static String gridCellToClick(String element, String value, String index) {
		String jsScript = null;

		jsScript = "$($(\"[" + element + "='" + value + "']\")["
				+ index
				+ "]).click()";

		logger.info("jsScript is:" + jsScript);

		return jsScript;
	}*/
	
	/**
	 * Click an element until it's clickable or timeout
	 * 
	 * @param we
	 * @param startTime
	 * @param timeout
	 *            in millisecond
	 * @throws Exception
	 */
	public void clickTheClickable(WebElement we, long startTime, int timeout) throws Exception {
		try {
			we.click();
		} catch (Exception e) {
			((JavascriptExecutor) browserCore).executeScript("arguments[0].scrollIntoView();", we);
			if (System.currentTimeMillis() - startTime > timeout) {
				logger.info("Element " + we + " is unclickable");
				throw new Exception(e);
			} else {
				Thread.sleep(500);
				logger.info("Element " + we + " is unclickable, try again");
				clickTheClickable(we, startTime, timeout);
			}
		}
	}
	
	
	public static WebDriver getAugmentedDriver(TestCaseOperator tco) throws Exception{
		WebDriver augmentedDriver = null;
		if (GlobalSettings.browserCoreType == 1 || GlobalSettings.browserCoreType == 3) {
			augmentedDriver = tco.browserCore;
			augmentedDriver.manage().window().setPosition(new Point(0, 0));
			augmentedDriver.manage().window().setSize(new Dimension(9999, 9999));
		} else if (GlobalSettings.browserCoreType == 2) {
			augmentedDriver = new Augmenter().augment(tco.browserCore);
		} else {
			throw new Exception("Incorrect browser type");
		}
		return augmentedDriver;
	}
	
	private void handleFailure(String notice) {
		screenShot(notice);
		//throw new TestNGException("handleFailure: "+notice);
	}

	


	public ChromeDriverService getChromeServer() {
		return chromeServer;
	}
	
	/**
	 * Get the JavascriptExecutor instance embedded
	 * @return a JavascriptExecutor instance
	 */
	public JavascriptExecutor getJavaScriptExecutor() {
		return javaScriptExecutor;
	}
	
	/**
	 * Double Click the Element by JQuery
	 * 
	 * @param element
	 *            the element to be Double Clicked
	 */
	/*public void dbClickJS(String element) {
		pause(stepInterval);

		try {
			String js = getDBCLickJS(element);
			javaScriptExecutor.executeScript(js);
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to double click: " + element);
		}

		logger.info("Double click: " + element);
	}*/
	
	/**
	 * 
	 * @param element
	 *            the element to be Double Clicked
	 * @return
	 */
	/*private static String getDBCLickJS(String element) {
		String jsScript = null;

		jsScript = "$(\"[id='" + element + "']\").trigger(\"dblclick\")";

		logger.info("jsScript is:" + jsScript);

		return jsScript;
	}*/
	
	/*
	 * Select Radio Button
	 * 
	 * @param radioToSelect the radio to be selected
	 * 
	 * @param firstRadio the element of first Radio
	 * 
	 * @param secondRadio the element second Radio
	 */
	/*public void selectRadio(WebElement yesRadio, WebElement noRadio,
			String radioToSelect) {
		pause(stepInterval);

		if (yesRadio.isSelected()) {
			logger.info("Before: Yes Radio is Selected and No Radio is not Selected");
		} else {
			logger.info("Before: Yes Radio is Not Selected and No Radio is Selected");
		}

		if (RadioName.YES.toString().equals(radioToSelect)) {
			try {
				clickTheClickable(yesRadio, System.currentTimeMillis(), 2500);
			} catch (Exception e) {
				e.printStackTrace();
				handleFailure("Failed to select " + yesRadio);
			}
			logger.info("Selected " + yesRadio);
		} else if (RadioName.NO.toString().equals(radioToSelect)) {
			try {
				clickTheClickable(noRadio, System.currentTimeMillis(), 2500);
			} catch (Exception e) {
				e.printStackTrace();
				handleFailure("Failed to select " + noRadio);
			}
			logger.info("Selected " + noRadio);
		} else {
			handleFailure("No such Radio, Failed to select");
		}

		if (yesRadio.isSelected()) {
			logger.info("After: Yes Radio is Selected and No Radio is not Selected");
		} else {
			logger.info("After: Yes Radio is Not Selected and No Radio is Selected");
		}

	}*/
	
	/**
	 * Type text at the page element<br>
	 * Before typing, try to clear existed text
	 * 
	 * @param we
	 *            the element
	 * @param text
	 *            the input text
	 */
	public void type(WebElement we, final String text) {
		pause(stepInterval);

		try {
			we.clear();
		} catch (Exception e) {
			logger.warn("Failed to clear text at " + we);
		}
		try {
			we.sendKeys(text);
		} catch (Exception e) {
			e.printStackTrace();
			handleFailure("Failed to type " + text + " at " + we);
		}

		logger.info("Type " + text + " at " + we);

	}
}
