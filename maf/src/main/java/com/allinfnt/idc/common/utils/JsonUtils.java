package com.allinfnt.idc.common.utils;

import java.io.IOException;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Component;

import com.allinfnt.idc.common.mapper.JsonMapper;

/**
 * @author 作者 E-mail: 蒋斌
 * @version 创建时间：2015年1月26日 上午10:35:32
 * @memo 说明：json工具类
 */
@Component("jsonUtils")
public class JsonUtils {
	private static ObjectMapper objectMapper = new ObjectMapper();
	
	@SuppressWarnings("rawtypes")
	public static JSONObject mapToJson(Map map) {
		JSONObject jsonObject = JSONObject.fromObject(map);
		return jsonObject;
	}
	
	/**
	 * ObjectתJson
	 * @param obj
	 * @return JSONObject
	 */
	public static JSONObject ObjectToJson(Object obj) {
		JSONObject jsonObject = JSONObject.fromObject(obj);
		return jsonObject;
	}
	
	/**
	 * JsonתMap
	 * @param jsonStr
	 * @return Map
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	@SuppressWarnings("rawtypes")
	public static Map jsonToMap(String jsonStr) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.readValue(jsonStr, Map.class);
	}
	
	
	public static JSONArray ObjectToJsonArray(Object objs){
		JSONArray jsonArray = JSONArray.fromObject(objs);
		return jsonArray;
	}
	
	/**
	 * 读取json数据转成MAP
	 * @author liujx
	 * @see jackson
	 * @param jsonData
	 * @return
	 * @version 2015-02-25
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> readJson2Map(String jsonData){
		Map<String, Object> maps = null;
		try {
	        maps = objectMapper.readValue(jsonData, Map.class);
	    } catch (JsonParseException e) {
	        e.printStackTrace();
	    } catch (JsonMappingException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
		return maps;
	}
	
	/**
	 * 将实体转成json数据
	 * @author liujx
	 * @see jackson
	 * @param obj
	 * @return
	 * @version 2015-02-25
	 */
	public static String writeEntityJSON(Object obj){
		String jsonResult = "";
		try {
			jsonResult = objectMapper.writeValueAsString(obj);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jsonResult;
	}
}
