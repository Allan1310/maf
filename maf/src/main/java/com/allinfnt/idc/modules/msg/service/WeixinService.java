/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.service;

import me.chanjar.weixin.cp.api.WxCpInMemoryConfigStorage;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.api.WxCpServiceImpl;
import me.chanjar.weixin.cp.bean.WxCpMessage;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.service.BaseService;
import com.allinfnt.idc.modules.msg.entity.Msginfo;

/**
 * 微信Service
 * 
 * @author allinfnt
 * @version 2015-03-20
 */
@Service
@Transactional(readOnly = true)
public class WeixinService extends BaseService {

	WxCpService wxCpService = new WxCpServiceImpl();

	public WeixinService() {
		WxCpInMemoryConfigStorage config = new WxCpInMemoryConfigStorage();
		config.setCorpId(Global.getConfig("wx.cp.corpId"));
		config.setCorpSecret(Global.getConfig("wx.cp.corpSecret"));
		config.setAgentId(Global.getConfig("wx.cp.agentId"));
		config.setToken(Global.getConfig("wx.cp.token"));
		config.setAesKey(Global.getConfig("wx.cp.aesKey"));
		config.setOauth2redirectUri(Global.getConfig("wx.cp.redirect.url"));
		wxCpService.setWxCpConfigStorage(config);
	}

	/**
	 * 发送微信消息
	 * 
	 * @param msginfo
	 * @return
	 */
	public boolean sendMsg(Msginfo msginfo) throws Exception {
		boolean isSuccess = false;
		String userIds[] = msginfo.getReceiverId().toString().split(",");
		for (int i = 0; i < userIds.length; i++) {
			WxCpMessage message = WxCpMessage.TEXT()
					.agentId(Global.getConfig("wx.cp.agentId"))
					.toUser(userIds[i]).content(msginfo.getMessage()).build();
			wxCpService.messageSend(message);
			isSuccess = true;
		}
		return isSuccess;
	}
}
