package com.allinfnt.idc.modules.script.maker;

import java.util.ArrayList;

import com.allinfnt.idc.modules.script.db.MySQLHandler;


public class TestCase {
	
	private ArrayList<TestStep> stepList = new ArrayList<TestStep>();
	
	private String testStepDetail = null;
	private String testCaseName = null;
	private String functionName = null;
	private String testData = null;
	
	
	/*
	 * 1.步骤编号
	 * 2.步骤名称
	 * 3.xpath/jquery/defualt + 表达式
	 * 4.动作
	 * 5.参数1
	 * 6.等待时间
	 * 7.是否截图
	 * 
	 */
	TestCase() {
		//testStepDetail = "1$197a9fdb1abc42bda1d1124c15531027$0+ $openWebSite$http://www.baidu.com$1000$ret1$0|2$197a9fdb1abc42bda1d1124c15531027$1+//*[@id='ssousername']$setValue$#param3#$1000$ret2$0|3$197a9fdb1abc42bda1d1124c15531027$1+//*[@id='ssopassword']$setValue$#param4#$1000$ret3$0|4$197a9fdb1abc42bda1d1124c15531027$2+//*[@id='logInButton']$click$1000$ret4$0";
		testStepDetail = "1$tsgd$2+ $openWebSite$http://172.30.112.176:8001/HQ/myportal/HQ/$500$ret1$0|" +
				"2$tsgd$0+//*[@id='ssousername']$setValue$yw02135$500$ret2$0|" +
				"3$tsgd$0+//*[@id='ssopassword']$setValue$111111$500$ret3$0|" +
				"4$tsgd$0+//*[@id='logInButton']$click$6000$ret4$0|" +
				"5$tsgd$0+//span[contains(text(),'发起工单')]$click$500$ret5$0|" +
				"6$tsgd$0+//a[contains(text(),'投诉工单')]$click$500$ret6$0|" +
				"7$tsgd$1+~(\"input[id='ifReply_dic']\").val('否');~(\"input[id='ifReply']\").val('ifReply02');$sendstr1$500$ret7$0|" +
				"8$tsgd$0+//input[@id='cardNumber']$cardnoin$param1$500$ret8$0|" +
				"9$tsgd$2+ $execAction$param2$500$ret9$0|" +
				"10$tsgd$2+ $execAction$param3$4000$ret10$0|" +
				"11$tsgd$1+;$setValue$~(\"input[id='operationType_dic']\").val('卡片升级');~(\"input[id='operationType']\").val('operationType01')$500$ret11$0|" +
				"12$tsgd$1+~(\"input[id='cardType_dic']\").val('加速积分白金卡');~(\"input[id='cardType']\").val('U8401');$sendstr1$500$ret12$0|" +
				"13$tsgd$1+~(\"input[id='applicationReason_dic']\").val('银行主动');~(\"input[id='applicationReason']\").val('applicationReason01');$sendstr1$500$ret13$0|" +
				"14$tsgd$1+~(\"button[js='finish']\").eq(1).click();$sendstr1$1000$500$ret14$0|" +
				"15$tsgd$1+~(\"input[type='button']\").eq(0).click();$sendstr1$500$ret15$0|" ;
		//testStepDetail = MySQLHandler.getTestStepDetail("tc01");
		//testCaseName = MySQLHandler.getTestCaseName("tc01");
		testCaseName = "8fc033827b1d402c9d7ce190a4b986d8";
		//functionName = MySQLHandler.getFunctionName("tc01");
		//testData = MySQLHandler.getTestData("tc01");
		functionName = "tsgd";
		testData = "#param1#=6221765500022106,#param2#=keyPressEnter,#param2#=keyReleaseEnter";	
		//System.out.println(testData);
	}
	
	TestCase(String testCaseId) {
		//testStepDetail
		testStepDetail = MySQLHandler.getTestStepDetail(testCaseId).split("=_=")[1];
		//functionName
		functionName = MySQLHandler.getFunctionName(testCaseId);
		//testData
		testData = MySQLHandler.getTestData(testCaseId);
	}

	
	
	public void getTestStepList() {
		//testStepDetail = "1$8fc033827b1d402c9d7ce190a4b986d9$2+defaultnnn$get$param2$1|2$8fc033827b1d402c9d7ce190a4b986d9$0+//[id='userId']mm$set$param1$0";
		String[] step = testStepDetail.split("\\|");
		for (int i = 0; i < step.length; i++) {
			TestStep testStep = new TestStep();
			String stepDetail[] = step[i].split("\\$");
			int stepNumber = stepDetail.length;
			
			testStep.setStepNumber(Integer.parseInt(stepDetail[0]));
			testStep.setMethod(stepDetail[1]);
			testStep.setFlag(Integer.parseInt(stepDetail[2].split("\\+")[0]));
			testStep.setXpathExpress(stepDetail[2].split("\\+")[1]);
			testStep.setAction(stepDetail[3]);
			if(!(stepDetail[4].equals("null"))){
				testStep.setData(stepDetail[4]);
			}		
			testStep.setWaitNumber(Integer.parseInt(stepDetail[5]));
			testStep.setReturnValue(stepDetail[6]);
			testStep.setNeedScreenShot(Integer.parseInt(stepDetail[7]));
			stepList.add(testStep);
		}
	}
	
	public String getValues(String[]testDataList){
		StringBuffer sb = new StringBuffer();
		sb.append("new String[]{");
		for(int i=0;i<testDataList.length;i++){
			sb.append("\""+	testDataList[i] + "\"");
		}
		sb.append("}");
		return sb.toString();
	}
	
	public void printStep() {
		for (TestStep testStep : stepList) {
			System.out.println(testStep.getMethod() + testStep.getXpathExpress() + testStep.getAction() + testStep.getData());
			System.out.println();
		}
	}
	
	public static void main(String[]args) {
		TestCase testCase = new TestCase();
		testCase.getTestStepList();
		testCase.printStep();
	}

	public ArrayList<TestStep> getStepList() {
		return stepList;
	}

	public void setStepList(ArrayList<TestStep> stepList) {
		this.stepList = stepList;
	}

	public String getTestCaseName() {
		return testCaseName;
	}

	public void setTestCaseName(String testCaseName) {
		this.testCaseName = testCaseName;
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getTestData() {
		return testData;
	}

	public void setTestData(String testData) {
		this.testData = testData;
	}
	
}
