/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.service;

import me.chanjar.weixin.common.util.http.Utf8ResponseHandler;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.service.BaseService;
import com.allinfnt.idc.modules.msg.entity.Msginfo;

/**
 * 短信Service
 * 
 * @author allinfnt
 * @version 2015-03-20
 */
@Service
@Transactional(readOnly = true)
public class SmsService extends BaseService {

	/**
	 * 发送短信消息
	 * 
	 * @param msginfo
	 * @throws Exception
	 */
	public boolean sendMsg(Msginfo msginfo) throws Exception {
		boolean isSuccess = false;

		CloseableHttpClient client = HttpClients.createDefault();
		String msg = msginfo.getMessage();

		msg = java.net.URLEncoder.encode(msg, "UTF-8");

		String uri = Global.getConfig("sms.send.url") + "&c=" + msg + "&m="
				+ msginfo.getReceiverId();

		HttpGet httpGet = new HttpGet(uri);

		CloseableHttpResponse response = client.execute(httpGet);
		String result = Utf8ResponseHandler.INSTANCE.handleResponse(response);
		String flag = result.substring(29, 30);
		if (flag.equals("1")) {
			isSuccess = true;
		} else {
			logger.error("短信发送失败：" + result);
			throw new Exception("短信发送失败：" + result);
		}
		return isSuccess;
	}

	public static void main(String[] args) {
		SmsService sms = new SmsService();
		Msginfo msginfo = new Msginfo();
		msginfo.setMessage("有一份新的任务需要您处理");
		msginfo.setReceiverId("13162796265");
		try {
			sms.sendMsg(msginfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
