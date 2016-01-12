package com.allinfnt.idc.modules.script.maker;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import com.allinfnt.idc.modules.script.utils.StringUtils;





public class InputValue {
	private String value;
	private String token;
	private boolean isString;
	private List<String> values;
	
	public static void print(Object o) {
		System.out.println(o);
	}

	public InputValue(String value, String token) {
		if (StringUtils.isNotBlank(value)) {
			this.value = value.trim();
			this.token = token;
			values = new ArrayList<String>();
			
			int i1 = value.indexOf(token);
			int i2 = value.lastIndexOf(token);
			if (i1 < 0 || i1 == i2 || i2 - i1 == 1) {
				isString = true;//"","$","$$"
			} else {
				int count = 0;
				int beginI = 1;
				boolean tokenEnd = false;
				if (this.value.lastIndexOf(token) == this.value.length() - 1) {
					tokenEnd = true;
				}
				if (this.value.indexOf(token) == 0) {
					beginI = 0;
				}
				StringBuffer sb = new StringBuffer();
				StringTokenizer st = new StringTokenizer(value, token);
				while (st.hasMoreElements()) {
					String val = (String) st.nextElement();
					if (count == beginI && (tokenEnd || st.hasMoreElements())) {
						values.add(val);
						beginI = beginI + 2;
						sb.append(GlobalSettings.FLAG);
					} else {
						sb.append(val);
					}
					count++;
				}
				this.value = sb.toString();
			}
		}
	}
	
	public String getResultString(String begin,String end){
		if(value==null||isString)
			return value;
		
		String ret = value;
		for (String str : values) {
			ret = ret.replaceFirst("=_=",begin+str+end);
		}
		return ret;
	}
	
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public List<String> getValues() {
		return values;
	}

	public void setValues(List<String> values) {
		this.values = values;
	}

	public static void main(String[] args) {
		InputValue iv = null; 
		//iv = new InputValue("$aa$","$");
		//System.out.println(iv.getResultString("\"+getValue(\"", "\")+\""));//begin = "+getValue("  end = ")+"
		
		//iv = new InputValue("$aa$bb$adf$ddd$eee$aaa","$");
		//System.out.println(iv.getResultString("\"+getValue(\"", "\")+\""));//
		
		iv = new InputValue("#aa#bb#adf#ddd#eee#aaa","#");
		System.out.println(iv.getResultString("\"+getValue(\"", "\")+\""));
	}
}
