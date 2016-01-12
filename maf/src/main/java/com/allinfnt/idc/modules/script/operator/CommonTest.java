package com.allinfnt.idc.modules.script.operator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.allinfnt.idc.modules.script.maker.GlobalSettings;





public abstract class CommonTest {
	
	protected TestCaseOperator tco;
	
	protected HashMap<String, String> resmap;
	
	protected HashMap<String, String> pushMap;
	protected List<?> pushList;
	
	protected static Logger logger = Logger.getLogger(CommonTest.class.getName());
	
	protected Map<String,String> caseData;
	
	private int tokenlen = GlobalSettings.TOKEN_CASE_METHODS.length();
	
	public static void main(String[] args) {
		String input = "#abc#";
		String value = input.substring(1,input.length()-1);
		System.out.println(value);
	}
	
	
	protected String getValue(String input){
		
		String value = input;
		String ret;
		
		if(pushMap!=null){
			ret = pushMap.get(value);
			if(ret!=null){
				return ret;		
			}
			
			ret = pushMap.get(value+"1");
			if(ret!=null){
				return ret;
			}
		}
		
		ret = caseData.get(value);
		
		if(pushMap!=null){
			int i1 = ret.indexOf(GlobalSettings.TOKEN_CASE_METHODS);
			int i2 = ret.lastIndexOf(GlobalSettings.TOKEN_CASE_METHODS);
			if(i1==0 && i1!=i2){
				ret = ret.substring(tokenlen,ret.length()-tokenlen);
				ret = pushMap.get(ret);
			}
		}
		return ret;
	}
	
	/*protected void initPushMap() {
		if(this.pushMap==null){
			this.pushMap = new HashMap<String, String>();
			for (int i = 0; i < pushList.size(); i++) {
				Map<String,Object> map = (Map<String,Object>) pushList.get(i);
				for (String key : map.keySet()) {
					this.pushMap.put(MConstant.FLAG_PUSHMAP_VALUE+(i+1)+"."+key,map.get(key).toString());
				}
			}	
		}
	}*/

	protected void setCurrentData(String[] input){
		caseData = new HashMap<String, String>();
		for (String str : input) {
			int ind1 = -1 ;
			int ind2 = -1;
			if(str.indexOf("#=")>-1){
				ind1 = str.indexOf("#=");
				ind2 = ind1 +2;
			}else if(str.indexOf("# =")>-1){
				ind1 = str.indexOf("# =");
				ind2 = ind1 + 3;
			}
			
			if(ind1!=-1){
				caseData.put(str.substring(1,ind1),str.substring(ind2,str.length()).trim());
			}
		}
		
	
		System.out.println(caseData.size());
	
	}
	
	protected void repeatOn(Integer no,Integer last) throws Exception{
		int count = 0;
		String ret;
		do {
			if(count!=0){
				//tco.pause(""+MConstant.RETRY_LONG_INTERVAL);
			}
			repeatStep(last);
			ret = repeatStep(no);
			count++;
			if(count>GlobalSettings.RETRY_LONG_COUNT){
				throw new Exception("MAX RETRY COUNT! ERROR");
			}
		} while (ret!=null);
	}
	
	protected String repeatStep(Integer no) throws Exception {
		return null;
	}
	
	
}
