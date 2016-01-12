package com.allinfnt.idc.modules.script.maker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;

import org.apache.commons.lang.StringUtils;

public class TestCaseMaker {
	
	
	private OutputStreamWriter osw;
	
	
	private Integer stepCount = GlobalSettings.BEGIN_OF_STEP_COUNT;
	
	private StringBuffer sbRepeatStep = new StringBuffer();
	
	private TestCase testCase;
	
	private PagePath pagePath;
	
	
	public TestCaseMaker(String caseId) {
		
		testCase = new TestCase(caseId);
		pagePath = new PagePath(caseId);
		testCase.getTestStepList();
		pagePath.getpagePathStepList();
		try {
			File file = new File("src/test/java/test/Test1"+".java");
			file.delete();
			file.createNewFile(); 
			FileOutputStream fos = new FileOutputStream(file);
			osw = new OutputStreamWriter(fos, "utf-8");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void create(){
		writeHeader();
		writeCases();
		writeMethods();
		writeRepeatStep();
		writeEnder();
		closeOutputStream();
	}
	
	
	private void writeHeader() {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("package com.spdbccc.test;"+ln());//package com.pactera.test;
		sb.append(ln());
		//sb.append("MConstant.PACKAGE_WEB_ELEMENT"+ln());//import com.tonyh.script.operator.webelement.*;
		sb.append("import com.spdbccc.script.operator.*;" + ln());//import com.tonyh.script.operator.*;
		sb.append("import com.spdbccc.script.maker.*;" + ln());//import com.tonyh.script.maker.*;
		sb.append("import java.util.HashMap;"+ ln());
		sb.append("import org.testng.annotations.Test;"+ln());
		sb.append("import org.testng.annotations.BeforeClass;"+ln());
		sb.append("import org.testng.annotations.AfterClass;"+ln());
		sb.append(ln());
		sb.append(annotation(""));
		sb.append("public class "+ "Test1" + " extends CommonTest {"+ln());
		
		try {
			osw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	private void writeCases() {
		
		StringBuffer sb = new StringBuffer();
		
	//	for (TestCaseVo caseVo : this.testCaseList) {
			//sb.append(ln()+lt()+"//"+caseVo.getDes()+ln());
		sb.append(lt()+"@Test");
		//	if(StringUtils.isNotBlank(caseVo.getDepends())){
		//		sb.append("(dependsOnMethods = {\""+caseVo.getDepends()+"\"})");
		//	}
		String[] testCaseDataLists = testCase.getTestData().split("\\|");
		int testCaseNumber = testCaseDataLists.length;
		for(int i=0;i<testCaseNumber;i++){
			sb.append(ln());
			sb.append(lt()+"public void "+ "_" + testCase.getTestCaseName()  + i + "() throws Exception {" + ln());
			sb.append(dt()+"setCurrentData(new String[]{");
			//testCase.getValues()
			String[] testCaseDataList = testCaseDataLists[i].split(",");
			for(int j=0;j<testCaseDataList.length;j++){
				sb.append("\"" + testCaseDataList[j] + "\"");
				if(j!=testCaseDataList.length - 1){
					sb.append(",");
				}
			}
			sb.append("});"+ln());
			String methods = "_" + testCase.getFunctionName();
			/*StringTokenizer st = new StringTokenizer(methods,MConstant.TOKEN_CASE_METHODS);
			while(st.hasMoreTokens()){
				sb.append(dt()+st.nextToken()+"();"+ln());
			}	*/	
			sb.append(dt() + methods + "();"+ln());
			sb.append(lt()+"}"+ln());
		}
		
		try {
			osw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void writeMethods() {
		
		StringBuffer sb = new StringBuffer();
		
		ArrayList<TestStep> stepList = testCase.getStepList();
		ArrayList<PagePathStep> pathStepList = pagePath.getPagePathStepList();
		/*for (TestSuiteVo suiteVo : this.testSuiteList) {
			stepList.addAll(suiteVo.getStepList());
		}*/
		
		String methodName = null ;
		//System.out.println(stepList.size());
		for (TestStep testStep : stepList) {
			if(!StringUtils.equals(testStep.getMethod(),methodName)){
				if(methodName!=null){
					sb.append(lt()+"}"+dn());
				}
				sb.append(ln()+lt()+"private void "+ "_" + testStep.getMethod()+"() throws Exception {"+ln());
				methodName = testStep.getMethod();
			}	
			
			parsePagePath(testStep.getStepNumber(),pathStepList);
			
			//System.out.println(parsePagePath(testStep.getStepNumber(),pathStepList));
			if(parsePagePath(testStep.getStepNumber(),pathStepList).isEmpty()){
				sb.append(parseStep(testStep));
			} else {
				sb.append(parsePagePath(testStep.getStepNumber(),pathStepList));
				sb.append(parseStep(testStep));
			}
			//sb.append(parseStep(testStep));
			/*if(!testStep.getEnable())
				continue;*/
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鎵撳紑",鐒跺悗鑾峰彇7-Suite1 sheet涓璂escription鍚嶅瓧.
			 * 
			 */
			//if(StringUtils.equals(MConstant.ACTION_OPEN_URL,stepVo.getFunction())){
			//if(StringUtils.equals("杈撳叆",testStep.getAction())){
				//sb.append(dt()+annotation(stepVo.getDes()));
				//sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				//sb.append(dt()+"tco.openWebSuite(\""+testStep.getData()+"\");\r\n");
				//sb.append(dt() + "");
				//sb.append(dt() + "tco.getWebElement(\""+testStep.getXpathExpress() + "\");\r\n");
				//if(stepVo.getScreenshot()){
				//	sb.append("\t\t"+"tco.screenShot(null);\r\n");
			//	}
			//	continue;
			//}
	
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"浠ｇ爜".
			 */
			/*if(StringUtils.equals(MConstant.ACTION_INSERT_CODE,stepVo.getFunction())){
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+stepVo.getValue1());
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				if(stepVo.getValue1().indexOf(";")<1)
					sb.append(";");
				sb.append("\r\n");
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鑿滃崟".
			 */
			/*if(StringUtils.equals(MConstant.ACTION_MENU,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.menu(\""+stepVo.getValue1()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鑴氭湰".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SENDSTRING,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.sendstr1(\""+stepVo.getValue1()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"IT鑵虫湰".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_IT3,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.autoit3(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"IT鑵虫湰qs".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_IT3q,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.autoit3qinsuan(\""+stepVo.getValue1()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"绛夊緟".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_PARSE,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.pause(\""+stepVo.getValue1()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*if(StringUtils.equals(MConstant.ACTION_SELENIUMCLICK,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.doActions(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鏂".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_ASSERT,stepVo.getFunction())){
				sb.append(dt()+annotation(stepVo.getDes()));
				String str1 = stepVo.getValue1().trim();
				String str2 = stepVo.getValue2().trim();
				
				String ret1 = parseToken(str1,MConstant.TOKEN_ASSERT);
				String ret2 = parseToken(str2,MConstant.TOKEN_ASSERT);
				
				if(ret1!=null){
					str1 = "resmap.get(\""+ret1+"\")";
				}else{
					str1 = "\""+str1+"\"";
				}
				
				if(ret2!=null){
					str2 = "resmap.get(\""+ret2+"\")";
				}else{
					str2 = "\""+str2+"\"";
				}
				
				str1 = "\""+str1+"\"";
				str2 = "\""+str2+"\""; 
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.assertEquals("+str1+","+str2+");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}
			*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"寮瑰嚭妗�.
			 *
			 */
			/*if(StringUtils.equals(MConstant.ACTION_PROMPT,stepVo.getPage()) && StringUtils.equals("鎸夐挳",stepVo.getWebelement())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.prompt(\""+stepVo.getLabel()+"\");\r\n");
				continue;
			}
			*/
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"瀵硅瘽妗�.
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_ALERT,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.alert(\""+stepVo.getLabel()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*if(StringUtils.equals(MConstant.ACTION_ALERTTEXT,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.getAlertText(\""+stepVo.getLabel()+"\");\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 *鍒ゆ柇Function鏄惁绛変簬"璺宠浆".
			 *
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SELWINDOW,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.selWindow(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"Selenium".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SNMJB,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.seleniumtest(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"妗嗘灦".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SELFRAME,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.selFrame(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"妗嗘灦path".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SELFRAME2,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.selFrame2(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鏂扮獥鍙�.
			 * 
			 
			if(StringUtils.equals(MConstant.ACTION_SELFRAMENEW,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.selFrameNew(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}		*/
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"鍗″彿澶勭悊".
			 * 
			 */
			/*if(StringUtils.equals(MConstant.ACTION_CARDNOIN,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.cardnoin(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}
			*/
			
			/*if(StringUtils.equals(MConstant.ACTION_CARDNOIN,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.cardnoin(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*if(StringUtils.equals(MConstant.ACTION_CODESPAN,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.codespan(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*if(StringUtils.equals(MConstant.ACTION_JIEGUO,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.jieguo(\""+stepVo.getValue1()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"杩斿洖".
			 * 
			 *
			 */
			/*if(StringUtils.equals(MConstant.ACTION_ROLLBACK,stepVo.getFunction()) && StringUtils.equals(MConstant.ACTION_BROWSER,stepVo.getWebelement())){	
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+"tco.rollback(\""+stepVo.getValue1()+"\",\""+stepVo.getValue2()+"\",\""+stepVo.getValue3()+"\");\r\n\r\n");
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			
			/*
			 * 鍒ゆ柇Function鏄惁绛変簬"sql".
			 * 
			 *
			 */
			/*if(StringUtils.equals(MConstant.ACTION_SQL,stepVo.getFunction().toLowerCase())){	
				sb.append(dt()+"tco.logInfo(\""+stepVo.getDes()+"\");\r\n");
				sb.append(dt()+annotation(stepVo.getDes()));
				sb.append(dt()+parseSql(stepVo)+dn());
				if(stepVo.getScreenshot()){
					sb.append("\t\t"+"tco.screenShot(null);\r\n");
				}
				continue;
			}*/
			
			/*String stepcontent = parseStepWithRepeat(testStep, emap,lmap);
			if(stepcontent==null){
				continue;
			}*/
			//sb.append(stepcontent);
			
		/*	if(testStep.getScreenshot()){
				sb.append("\t\t"+"tco.screenShot(null);\r\n\r\n");
			}*/
			
			methodName = testStep.getMethod();
			}
		
			sb.append(lt()+"}"+ln());
		
		try {
			osw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	private void writeRepeatStep() {
		
		StringBuffer sb = new StringBuffer();
		sb.append(ln());
		sb.append(lt()+"@Override"+ln());
		sb.append(lt()+"protected String repeatStep(Integer no) throws Exception{"+dn());
		sb.append(lt()+"String ret = null;"+ln());
		sb.append(lt()+"switch (no) {"+ln());
		sb.append(sbRepeatStep.toString());
		sb.append(lt()+"default:"+ln());
		sb.append(lt()+"break;"+ln());
		sb.append(lt()+"}"+ln());
		sb.append(lt()+"return ret;"+ln());
		sb.append(lt()+"}"+ln());
		try {
			osw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	private void writeEnder() {

		StringBuffer sb = new StringBuffer();

		sb.append(ln());

		sb.append(lt() + "@BeforeClass" + ln());
		sb.append(lt() + "public void setUp() throws Exception {" + ln());
		sb.append(lt()+"	resmap = new HashMap<String, String>();"+ln());
		
		sb.append(lt()+"	//initPushMap();"+ln());
		sb.append(lt()+"	tco = new TestCaseOperator();"+ln());
		sb.append(lt()+"}"+ln());
		sb.append(ln());
		
		sb.append(lt()+"@AfterClass(alwaysRun = true)"+ln());
		sb.append(lt()+"public void tearDown() {"+ln());
		
		sb.append(lt()+"	tco.clean();"+ln());
		sb.append(lt()+"	resmap = null;"+ln());
		sb.append(lt()+"	tco = null;"+ln());
		sb.append(lt()+"}"+ln());
		sb.append(ln());
		sb.append("}"+ln());

		try {
			osw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	private void closeOutputStream() {
		try {
			osw.flush();
			osw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public static String parseProperty(String input){
		InputValue iv = new InputValue(input, GlobalSettings.TOKEN_INPUTDATA);//TOKEN_ASSERT = "#"
		//String ret = iv.getResultString("\"+resmap.get(\"","\")+\"");
		//iv = new InputValue(ret, GlobalSettings.TOKEN_CASE);
		return iv.getResultString("\"+getValue(\"", "\")+\"");
	}
	
	private String parsePagePath(int stepNumber,ArrayList<PagePathStep> list) {
		
		StringBuffer sb = new StringBuffer();
		
		if(list.get(stepNumber-1).getStepNumber() == stepNumber) {//如果路径的编号和步骤编号不一样跳出循环。
			if((stepNumber-1) == 0) {//如果步骤是第一步，直接拼接对象。
				if(list.get(stepNumber-1).getPathName().equals("公共路径")){//如果是公共路径，直接返回null。
					//sb.append(dt()+"tco.logger(\""+"进入" + list.get(stepNumber-1).getPathName() +"\");\r\n");
					//sb.append(dt()+"tco.enterFrame(\""+list.get(stepNumber-1).getPathExpress()+"\");\r\n\r\n");
					sb.append("");
				} else {//如果不是公共路径，先进入iframe，在拼接对象。
					sb.append(dt()+annotation("进入" + list.get(stepNumber-1).getPathName()));
					sb.append(dt()+"tco.logger(\""+"进入" + list.get(stepNumber-1).getPathName() +"\");\r\n");
					sb.append(dt()+"tco.enterFrame(\""+list.get(stepNumber-1).getPathExpress()+"\");\r\n\r\n");
				}
			} else {//如果不是第一步。
				if(list.get(stepNumber-2).getPathName().equals(list.get(stepNumber-1).getPathName())){
					sb.append("");
				} else {
					if(list.get(stepNumber-2).getPathName().equals("公共路径")){
						sb.append(dt()+annotation("进入" + list.get(stepNumber-1).getPathName()));
						sb.append(dt()+"tco.logger(\""+"进入" + list.get(stepNumber-1).getPathName() +"\");\r\n");
						sb.append(dt()+"tco.enterFrame(\""+list.get(stepNumber-1).getPathExpress()+"\");\r\n\r\n");
					} else {
						sb.append(dt()+annotation("进入" + list.get(stepNumber-1).getPathName()));
						sb.append(dt()+"tco.logger(\""+"进入" + list.get(stepNumber-1).getPathName() +"\");\r\n");
						//rollback
						sb.append(dt()+"tco.rollback();\r\n");
						sb.append(dt()+"tco.enterFrame(\""+list.get(stepNumber-1).getPathExpress()+"\");\r\n\r\n");
					}
					
				}
			}
			//list.get(stepNumber).getPathName();
			//list.get(stepNumber).getPathExpress();
		}
		
		
		
		return sb.toString();
	}
	
	private String parseStep(TestStep testStep) {
		StringBuffer sb = new StringBuffer();

		//String elementName = "element" + this.stepCount;
		//this.stepCount++;
		//sb.append(dt() + annotation(stepVo.getDes()));

		/*String e = stepVo.getWebelement();
		char c = e.charAt(0);
		int xyz = 0;
		switch (c) {
		case 'x':
			xyz = MConstant.X;
			e = e.substring(1, e.length());
			break;
		case 'X':
			xyz = MConstant.X;
			e = e.substring(1, e.length());
			break;
		case 'y':
			xyz = MConstant.Y;
			e = e.substring(1, e.length());
			break;
		case 'Y':
			xyz = MConstant.Y;
			e = e.substring(1, e.length());
			break;
		case 'z':
			xyz = MConstant.Z;
			e = e.substring(1, e.length());
			break;
		case 'Z':
			xyz = MConstant.Z;
			e = e.substring(1, e.length());
			break;
		default:
			break;
		}
*/
		// 鑾峰緱瀵硅薄
		//sb.append(dt() + "CommonObject ");
		//sb.append(elementName);
		//sb.append(" = new CommonObject"+ "(");
		//sb.append(");" + ln());

		//String la = lmap.get(stepVo.getWebelement(), stepVo.getPage(), stepVo.getLabel());

		//if (la != null) {
			// 鍒濆鍖栧璞�
			//sb.append(dt() + elementName + ".init(tco,");
			//sb.append(testStep.getFlag());
			//sb.append("," + "\"" + testStep.getXpathExpress() +"\"" + ");" + ln());
			// logger.error("no label defined in labelmap
			// that"+stepVo.getWebelement()+" "+stepVo.getPage()+"
			// "+stepVo.getLabel());
		//} else {
		//	// 鍒濆鍖栧璞�
		//	sb.append(dt() + elementName + ".init(tco,-1,\"\"");
		//	sb.append("," + xyz + ");" + ln());
		//}

		/*sb.append(dt() + elementName + ".logger(\"" + stepVo.getMethod() + " " + stepVo.getNo() + ": " + stepVo.getDes()
				+ "\");");*/
		//sb.append(ln());

		sb.append(dt()+annotation(testStep.getAction() + "方法"));
		sb.append(dt()+"tco.logger(\""+testStep.getAction()+"\");");
		sb.append(ln());
		sb.append(dt()+"resmap.put(\""+testStep.getReturnValue()+"\",");
		sb.append("tco." + testStep.getAction() + "(");
		sb.append(testStep.getFlag() + ",");
		sb.append("\""  + testStep.getXpathExpress() + "\"" + ",");
		sb.append(cellValue(parseProperty(testStep.getData())));
		//sb.append(");" + ln());
		sb.append("));"+ln());
		sb.append(ln());
		//sb.append(dt() + "resmap.put(\"" + stepVo.getRet() + "\", ");
		//sb.append(dt());
		//sb.append(elementName + ".");
		//System.out.println(testStep.getAction());
		//System.out.println(MConstant.functionMap.get(testStep.getAction()));
		//sb.append(MConstant.functionMap.get(testStep.getAction())+ "(");
		//sb.append(cellValue(stepVo.getValue1()) + ",");
		//sb.append("\"" +  testStep.getData() + "\"");
		//sb.append("\"" +  "null" + "\""+ ",");
		//sb.append("\"" +  "null" + "\"");
		//sb.append(");" + ln());
		//sb.append(ln());
		//System.out.println(sb.toString());
		return sb.toString();
	}
	
	/*不须转换，返回null*/
	public static String parseToken(String input,String token){
		if(input==null){
			return input;
		}
		int i1 = input.indexOf(token);
		int i2 = input.lastIndexOf(token);
		if(i1>-1&&i2>-1&&i1!=i2){
			return input = input.substring(i1+1, i2).trim();
		}
		return null;
	}
	
	
	private String lt(){
		return "\t";
	}
	
	
	private String dt(){
		return "\t\t";
	}
	
	
	private String ln(){
		return "\r\n";
	}
	
	
	private String dn(){
		return "\r\n\r\n";
	}
	
	
	private String annotation(String input){
		return "//"+input+"\r\n";		
	}
	
	private String cellValue(String input){
		if(StringUtils.isNotBlank(input))
			return "\""+input+"\"";
		return "null";
	}
	
//	public static void main(String[]args) {
//		
//		TestCaseMaker testCaseMarker = new TestCaseMaker();
//		testCaseMarker.create();
//	}
	
}
