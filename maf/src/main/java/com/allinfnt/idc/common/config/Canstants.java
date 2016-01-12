package com.allinfnt.idc.common.config;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;

import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cm.entity.CmPropertyManage;
import com.allinfnt.idc.modules.sys.dao.OfficeDao;
import com.allinfnt.idc.modules.sys.dao.UserDao;
import com.allinfnt.idc.modules.sys.entity.Dict;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.DictUtils;

/**
 * 常量配置
 * @author liujx
 * @version 2015-1-19
 */
public final class Canstants {
	
	private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
	
	/*
	 * 时间转换
	 */
	/**
	 * return yyyy-MM-dd HH:mm:ss
	 */
	public final static SimpleDateFormat DATEFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * return yyyy-MM-dd HH:mm
	 */
	public final static SimpleDateFormat DATEFORMAT_2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	/**
	 * return yyyy-MM-dd
	 */
	public final static SimpleDateFormat DATEFORMAT_3 = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * return yyyyMMdd
	 */
	public final static SimpleDateFormat DATEFORMAT_4 = new SimpleDateFormat("yyyyMMdd");
	public final static SimpleDateFormat DATEFORMAT_EXPORT = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * return yyyy
	 */
	public final static SimpleDateFormat DATEFORMAT_yyyy = new SimpleDateFormat("yyyy");
	
	/**
	 * return MM
	 */
	public final static SimpleDateFormat DATEFORMAT_MM = new SimpleDateFormat("MM");
	
	/**
	 * return dd
	 */
	public final static SimpleDateFormat DATEFORMAT_DD = new SimpleDateFormat("dd");

	/*
	 * 部门常量
	 */
	public final static String office_type_ZCB="总裁办";
	public final static String office_type_SCB="市场部";
	public final static String office_type_SJZX="数据中心";
	public final static String office_type_DZJRB="电子金融部";
	public final static String office_type_FXGLB="风险管理部";
	public final static String office_type_YJFZB="研究发展部";
	public final static String office_type_ZHGLB="综合管理部";
	public final static String office_type_JHCWB="计划财务部";
	
	/*
	 * 报销国内一线城市
	 */
	public final static String fin_inland_city="北京;上海;深圳;天津;重庆;哈尔滨;长春;沈阳;大连;呼和浩特;石家庄;乌鲁木齐;兰州;西宁;西安;银川;郑州;济南;太原;合肥;武汉;长沙;南京;成都;贵阳;昆明;南宁;拉萨;杭州;南昌;广州;福州;海口;青岛;宁波;厦门";
	
	/*
	 * 报销国外一线城市
	 */
	public final static String fin_foreign_city="欧洲;美国;日本";
	
	/*
	 * 报销国外二线城市
	 */
	public final static String fin_foreign_city_sec="香港;澳门;台湾;东南亚";
	
	/*
	 * 
	 */
	public final static String fin_Province_city = "北京;上海;深圳;天津;重庆;香港;澳门;台湾;";
	
	/*
	 * 
	 */
	public final static String fin_money_code="1:元;2:十;3:百;4:千;5:万;6:十万;7:百万;8:角;9:分";
	
	/*
	 * 货币单位
	 */
	public final static String CURRENCY_RMB="人民币";
	
	public final static String withDraw_result="0:撤销成功;1:流程结束;2:下一结点已经通过,不能撤销;4:会签节点";
	
	/*
	 * 属性类型
	 */
	public final static String cm_property_TY="TYSX";
	public final static String cm_property_ZY="ZYSX";
	
	/*
	 * 接口类型
	 */
	public final static String cm_find_service="";
	/**
	 * 工作日缓存名称
	 */
	public final static String SYS_WEEK_DAY_CACHE_NAME = "weekDay";
	/**
	 * 工作日缓存KEY
	 */
	public final static String SYS_WEEK_DAY_CACHE_KEY = "weekDayKey";
	/**
	 * 获取键值对
	 * @param finalStr
	 * @param str
	 * @return
	 */
	public static String getStringFromFinal(String finalStr,String str){
		if((null!=str&&!str.equals(""))&&(null!=finalStr&&!finalStr.equals(""))){
			
			String[] finalStrs = finalStr.split(";");
			if(finalStrs.length>0){
				for(int i=0;i<finalStrs.length;i++){
					String[] newStrs = finalStrs[i].split(":");
					if(newStrs.length>0){
						if(str.equals(newStrs[0])){
							return newStrs[1];
						}
					}
				}
				
			}
		}
		return null;
	}
	
	/**
	 * 校验城市是否属于直辖市与港澳台
	 * @param city
	 * @return
	 */
	public static boolean isProvince(String city){
		String[] province = fin_Province_city.split(";");
		if(isInTheArray(city,province)){
			return true;
		}
		return false;
		
	}
	
	/**
	 * 校验城市是否属于国内一线城市
	 * @param city
	 * @return
	 */
	public static boolean isInlandCity(String city){
		String[] inlandCity = fin_inland_city.split(";");
		if(isInTheArray(city,inlandCity)){
			return true;
		}
		return false;
		
	}
	
	/**
	 * 校验城市是否属于国外一线城市
	 * @param city
	 * @return
	 */
	public static boolean isForeignCity(String city){
		String[] foreignCity = fin_foreign_city.split(";");
		if(isInTheArray(city,foreignCity)){
			return true;
		}
		return false;
		
	}
	
	/**
	 * 校验城市是否属于国外二线城市
	 * @param city
	 * @return
	 */
	public static boolean isForeignCitySec(String city){
		String[] foreignCity = fin_foreign_city_sec.split(";");
		if(isInTheArray(city,foreignCity)){
			return true;
		}
		return false;
		
	}
	
	/**
	 * 
	 * @param str
	 * @param array
	 * @return
	 */
	public static boolean isInTheArray(String str,String[] array){
		
		if(array.length>0){
			for(int i=0;i<array.length;i++){
				if(array[i].equals(str)){
					return true;
				}
			}
		}
		
		return false;
		
	}
	
	/**
	 * 
	 * @param obj
	 * @return  Double
	 */
	public static Double getNotNullSum(Double obj){
		Double db = 0.0;
		if(obj==null){
			return db;
		}
		return obj;
		
	}
	
	/**
	 * 
	 * @param obj
	 * @return  Double
	 */
	public static Double getNotNullSum(String obj){
		if(obj.equals("")){
			obj="0";
		}
		return Double.valueOf(obj);
		
	}
	
	/**
	 * 
	 * @param obj
	 * @return
	 */
	public static String getNotNullString(Object obj){
		if(obj==null){
			return "";
		}
		return obj.toString();
		
	}
	
	/**
	 * 返回钱的数字和位数的对照
	 * @param money
	 * @return
	 */
	public static Map<String,String> getMoneyMap(Double money){
		String newMoney="";
		Map<String ,String> moneyMap = new HashMap<String, String>();
		if(null!=money){
			newMoney=String.valueOf(money).substring(0,String.valueOf(money).indexOf("."));
			String[] newMoneys = newMoney.split("");
			int j=0;
			for(int i=newMoney.length();i>0;i--){
				j++;
				String moneyKey = getStringFromFinal(fin_money_code, String.valueOf(i));
				if(j<newMoneys.length){
					moneyMap.put(moneyKey, newMoneys[j]);
				}
				
			}
			
			newMoneys = String.valueOf(money).substring(String.valueOf(money).indexOf(".")+1,String.valueOf(money).length()).split("");
			int k=0;
			for(int y=8;y<10;y++){
				k++;
				String moneyKey = getStringFromFinal(fin_money_code, String.valueOf(y));
				if(k<newMoneys.length){
					moneyMap.put(moneyKey, newMoneys[k]);
				}
			}
		}
		return moneyMap;
		
	}
	
	/**
	 * 获取出差天数
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static String getEvectionDays(String startTime,String endTime){
		Date d1;
		Date d2;
		long daysBetween=0;
		try {
			d1 = DATEFORMAT_3.parse(startTime);
			d2 = DATEFORMAT_3.parse(endTime);
			daysBetween=(d2.getTime()-d1.getTime()+1000000)/(3600*24*1000);  
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		
		return String.valueOf(daysBetween+1);
		
	}
	
	public static String getSubString(String str){
		if(StringUtils.isNotBlank(str)){
			int a = str.indexOf("：");
			if(a>0){
				String subStr = str.substring(0, a);
				return subStr;
			}
			return "";
		}
		return "";
	}
	
	/**
	 * 读取offer内容
	 * @param file
	 * @return
	 */
	public static String readOfferDesc(String file){
		String offerDesc="";
		try {
			OPCPackage opcPackage = POIXMLDocument.openPackage(file);
			POIXMLTextExtractor extractor = new XWPFWordExtractor(opcPackage);
			offerDesc = extractor.getText();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return offerDesc;
	}
	
	/**
	 * 判断一个时间是否在两个时间之间
	 * @param date
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static boolean checkDateInTime(String date,String startTime,String endTime){
		boolean flag = false;
		 try {
			 Calendar checkDate = Calendar.getInstance();
			 checkDate.setTime(DATEFORMAT_2.parse(date));
			 
			 Calendar startDate = Calendar.getInstance();
			 startDate.setTime(DATEFORMAT_2.parse(startTime));
			 
			 Calendar endDate = Calendar.getInstance();
			 endDate.setTime(DATEFORMAT_2.parse(endTime));
			 System.out.println(checkDate.after(startDate));
			 if(checkDate.after(startDate)&&checkDate.before(endDate)){
				 flag = true;
			 }
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 动态获取表单
	 * @param type
	 * @param dynamicType 0:填值，1：不填值
	 * @param propertyValue
	 * @return
	 */
	public static String dynamicFormByType(CmPropertyManage property,String dynamicType,String propertyValue,int num){
		
		StringBuffer formType = new StringBuffer();
		if(property.getDataType().equals("0")){
			formType.append("<input type='text' name='PT"+property.getId()+"' htmlEscape=\"false\" ");
			if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
				formType.append(" class=\"required\" ");
			}
			if(dynamicType.equals("0")){
				formType.append("value='"+propertyValue+"' ");
			}
			formType.append("/>");
		}else if(property.getDataType().equals("1")){
			formType.append("<textarea rows='3' name='PT"+property.getId()+"'  htmlEscape=\"false\" ");
			if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
				formType.append(" class=\"required\" ");
			}
			if(dynamicType.equals("0")){
				formType.append(">"+propertyValue+"</textarea>");
			}else{
				formType.append("></textarea>");
			}
		}else if(property.getDataType().equals("2")){
			List<Dict> dicts = DictUtils.getDictList(property.getExt1());
			formType.append("<select style='width:220px;' name='PT"+property.getId()+"' >");
			for(Dict dict:dicts){
				if(dynamicType.equals("0")){
					if(dict.getLabel().equals(propertyValue)){
						formType.append("<option selected=\"selected\" value='"+dict.getLabel()+"'>"+dict.getLabel()+"</option>");
					}else{
						formType.append("<option value='"+dict.getLabel()+"'>"+dict.getLabel()+"</option>");
					}
				}else{
					formType.append("<option value='"+dict.getLabel()+"'>"+dict.getLabel()+"</option>");
				}
			}
			
			formType.append("</select>");
		}else{
			if(Canstants.getNotNullString(property.getExt2()).equals("7")){
				if(dynamicType.equals("0")){
					formType.append("<input type=\"text\" value='"+propertyValue+"' style='width:205px;' name='PT"+property.getId()+"'  maxlength=\"20\" readonly=\"readonly\" class=\"Wdate required input-medium\"  onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});\"/>");
				}else{
					formType.append("<input type=\"text\"  style='width:205px;' name='PT"+property.getId()+"'  maxlength=\"20\" readonly=\"readonly\" class=\"Wdate required input-medium\"  onclick=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});\"/>");
				}
			}else if(Canstants.getNotNullString(property.getExt2()).equals("8")){
				formType.append("<input type='text' name='PT"+property.getId()+"' htmlEscape=\"false\" class=\"number ");
				if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
					formType.append(" required\" ");
				}
				if(dynamicType.equals("0")){
					formType.append("value='"+propertyValue+"' ");
				}
				formType.append("\"/>");
			}else  if(Canstants.getNotNullString(property.getExt2()).equals("10")){
				formType.append("<div class=\"input-append\"> ");
				if(dynamicType.equals("0")){
					formType.append("  <input id=\"PhysicalLocation\" name='PT"+property.getId()+"' readonly=\"readonly\" type=\"text\" value='"+propertyValue+"' class=\" ");
				}else{
					formType.append("  <input id=\"PhysicalLocation\" name='PT"+property.getId()+"' readonly=\"readonly\" type=\"text\" value=\"\" class=\" ");
				}
				
				if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
					formType.append(" required\" ");
				}
				
				formType.append(" style=\"\"/><a  href=\"javascript:\" class=\"btn  \" onclick=\"getPhysicalLocation()\" >&nbsp;<i class=\"icon-search\"></i>&nbsp;</a>&nbsp;&nbsp;");
				formType.append(" <input id=\"pregion\" type=\"hidden\" >");
				formType.append(" <input id=\"floorXY\" type=\"hidden\" >");
				formType.append("</div>");
			}else  if(Canstants.getNotNullString(property.getExt2()).equals("11")){
				formType.append("<div class=\"input-append\"> ");
				if(dynamicType.equals("0")){
					Office office = officeDao.get(propertyValue);
					formType.append("  <input id=\"officeId"+num+"\" name='PT"+property.getId()+"' class=\"\" type=\"hidden\" value='"+propertyValue+"' />");
					formType.append("  <input id=\"officeName"+num+"\" name='PT"+property.getId()+"' readonly=\"readonly\" type=\"text\" value='"+office.getName()+"' class=\" ");
				}else{
					formType.append("  <input id=\"officeId"+num+"\" name='PT"+property.getId()+"' class=\"\" type=\"hidden\" value=\"\"/>");
					formType.append("  <input id=\"officeName"+num+"\" name='PT"+property.getId()+"' readonly=\"readonly\" type=\"text\" value=\"\" class=\" ");
				}
				
				if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
					formType.append(" required\" ");
				}
				
				formType.append(" style=\"\"/><a id='officeButton' onclick=\"getoffice("+num+")\" href=\"javascript:\" class=\"btn  \"  >&nbsp;<i class=\"icon-search\"></i>&nbsp;</a>&nbsp;&nbsp;");
				formType.append("</div>");
			}else if(Canstants.getNotNullString(property.getExt2()).equals("9")){
				formType.append("<div class=\"input-append\"> ");
				if(dynamicType.equals("0")){
					User user = userDao.get(propertyValue);
					formType.append("  <input id=\"userId"+num+"\" name='PT"+property.getId()+"' class=\"required\" type=\"hidden\" value='"+propertyValue+"' />");
					formType.append("  <input id=\"userName"+num+"\" name=\"user.name\" readonly=\"readonly\" type=\"text\" value='"+user.getName()+"'  ");
				}else{
					formType.append("  <input id=\"userId"+num+"\" name='PT"+property.getId()+"' class=\"required\" type=\"hidden\" value=\"\"/>");
					formType.append("  <input id=\"userName"+num+"\" name=\"user.name\" readonly=\"readonly\" type=\"text\" value=\"\"  ");
				}
				
				formType.append("  class=\"required\" style=\"\"/><a id=\"userButton"+num+"\" onclick=\"getUserName("+num+")\" href=\"javascript:\" class=\"btn  \" style=\"\">&nbsp;<i class=\"icon-search\"></i>&nbsp;</a>&nbsp;&nbsp;");
				formType.append("</div>");
			}else{
				formType.append("<input type='text' name='PT"+property.getId()+"' htmlEscape=\"false\" ");
				if(null!=property.getIsNull()&&property.getIsNull().equals("0")){
					formType.append(" class=\"required\" ");
				}
				if(dynamicType.equals("0")){
					formType.append("value='"+propertyValue+"' ");
				}
				formType.append("/>");
			}
			
		}
		return formType.toString();
		
	}
	
	/**
	 * 获取版本字符串
	 * @param version
	 * @return
	 */
	public static String getVersionString(String version){
		String result="";
		if(null==version||version.equals("")){
			result="V1.0";
		}else{
			Double num = Double.valueOf(version.substring(1, version.length()));
			DecimalFormat   df   =   new   DecimalFormat("###,##0.0");
			result = "V"+String.valueOf(df.format(num+0.1));
		}
		return result;
		
	}
	
	/**
	 * 去小数点后一位
	 * @param version
	 * @return
	 */
	public static String getNewVersionStr(String version){
		Double num = Double.valueOf(version.substring(1, version.length()));
		DecimalFormat   df   =   new   DecimalFormat("###,##0.0");
		return "V"+String.valueOf(df.format(num));
	}
	
	/**
	 * 校验版本号
	 * @param newVer
	 * @param oldVer
	 * @return
	 */
	public static String checkOutVersion(String newVer ,String oldVer){
		if(newVer.equals(oldVer)){
			return "OK";
		}
		
		Double newNum = Double.valueOf(newVer.substring(1, newVer.length()));
		Double oldNum = Double.valueOf(oldVer.substring(1, oldVer.length()));
		if(newNum<oldNum){
			return "更改后的版本号必须大于当前版本号（"+oldVer+"）";
		}
		return "OK";
		
	}
	
	/**
	 * 接受json数据
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getJsonContext(HttpServletRequest request) throws Exception{
		return request.getParameter("paraValue");
		
	}
	
	/**
	 * 返回json结果
	 * @param flag
	 * @param result
	 * @return
	 */
	public static String getJsonResult(boolean flag ,String result){
		StringBuffer jsonResult = new StringBuffer();
		if(flag){
			jsonResult.append("{\"rspCode\":\"0\",\"rspValue\":");
			jsonResult.append(result);
		}else{
			jsonResult.append("{\"rspCode\":\"1\",\"rspValue\":");
			jsonResult.append("\""+result+"\"");
		}
		
		jsonResult.append("}");
		
		return jsonResult.toString();
		
	}
	
	/**
	 * 把Str转成MAP
	 * @param remark
	 * @return
	 */
	public static Map<String ,String> readStringtoMap(String remark){
		
		return null;
		
	}
}
