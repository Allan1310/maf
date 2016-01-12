package com.allinfnt.idc.common.utils;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class JsonUtils2 {
	
	/**
	 * 
	 * @param data 数据
	 * @param count 总条数
	 * @param nextStartIndex 下一页
	 * @param response
	 */
	public void sendSuccess(Object data, long count, long nextStartIndex, HttpServletResponse response) {

        Result result = new Result();
        PageResult page = new PageResult();

        page.setCount(count);
        page.setNextStartIndex(nextStartIndex);
        page.setIsEnd((nextStartIndex <= 1) ? 1 : 0);
        page.setDataList(data);

        result.setData(page);

        try {
            this.sendObject(result, response);
        }
        catch (IOException e) {
        	e.printStackTrace();
        }
    }
	
	public void sendSuccess(Object data, HttpServletResponse response) {
        Result result = new Result();
        result.setData(data);
        try {
            this.sendObject(result, response);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	private void sendObject(Result result, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");

        String jsonMessage = this.toJson(result, null);
        OutputStream out = null;
        try {
            out = response.getOutputStream();
            out.write(jsonMessage.getBytes("utf-8"));
            out.flush();
        }
        catch (IOException e) {
            throw e;
        }
        finally {
            if (out != null) {
                out.close();
            }
        }
    }
	
	private String toJson(Object obj, String[] excludes) {
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
        jsonConfig.setExcludes(excludes);
        JSONObject json = JSONObject.fromObject(obj, jsonConfig);
        String string = json.toString();
        return string;
    }
}
