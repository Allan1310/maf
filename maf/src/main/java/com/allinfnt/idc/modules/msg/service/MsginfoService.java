/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.msg.dao.MsginfoDao;
import com.allinfnt.idc.modules.msg.entity.Msginfo;
import com.allinfnt.idc.modules.oa.entity.OaNotify;
import com.allinfnt.idc.modules.oa.entity.OaNotifyRecord;
import com.allinfnt.idc.modules.oa.service.OaNotifyService;
import com.allinfnt.idc.modules.sys.entity.User;
import com.google.common.collect.Maps;

/**
 * 消息管理Service
 * 
 * @author Peng
 * @version 2015-03-11
 */
@Service
@Transactional(readOnly = true)
public class MsginfoService extends CrudService<MsginfoDao, Msginfo> {

	@Autowired
	private MsginfoDao msgMsginfodao;

	@Autowired
	private WeixinService weixinService;

	@Autowired
	private OaNotifyService oaNotifyService;

	@Autowired
	private SmsService smsService;

	@Autowired
	private MailService mailService;

	@Override
	public Msginfo get(String id) {
		return super.get(id);
	}

	@Override
	public List<Msginfo> findList(Msginfo msgMsginfo) {
		msgMsginfo.getSqlMap().put("dsf",
				dataScopeFilter(msgMsginfo.getCurrentUser(), "o", "u"));
		return super.findList(msgMsginfo);
	}

	@Override
	public Page<Msginfo> findPage(Page<Msginfo> page, Msginfo msgMsginfo) {
		msgMsginfo.getSqlMap().put("dsf",
				dataScopeFilter(msgMsginfo.getCurrentUser(), "o", "u"));
		return super.findPage(page, msgMsginfo);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(Msginfo msgMsginfo) {
		if (get(msgMsginfo.getId()) == null) {
			msgMsginfo.preInsert();
			msgMsginfodao.insert(msgMsginfo);

		} else {
			msgMsginfo.preUpdate();
			msgMsginfodao.update(msgMsginfo);
		}
		// super.save(msgMsginfo);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(Msginfo msgMsginfo) {
		super.delete(msgMsginfo);
	}

	public List<Msginfo> findBybackflag(String backflag) {
		return msgMsginfodao.findBybackflag(backflag);
	}

	/**
	 * 外部调用信息发送接口
	 * 
	 * @param msginfo
	 * @return
	 */
	@Transactional(readOnly = false)
	public String sendMsg(Msginfo msginfo) {
		// 如果是站内信 实时发送
		if (msginfo.getMsgType() != null && msginfo.getMsgType().equals("4")) {
			letter(msginfo);
		} else {
			// 如果计划发送时候小于当前时间 立即发送
			if (msginfo.getPlanTime() != null
					&& msginfo.getPlanTime().before(new Date())) {
				msginfo.setBackFlag("1");
				realSendMsg(msginfo);
			} else {
				msginfo.setBackFlag("0");//
			}
		}

		if (msginfo.getSendName() == null || msginfo.getSendName().equals("")) {
			msginfo.setSendName(msginfo.getCurrentUser().getName());
			msginfo.setSenderId("0");
		} else {
			msginfo.setSenderId("1");
		}

		if (msginfo.getSendMode() == null || msginfo.getSenderId() == null) {
			msginfo.setSendMode("0");

		}
		if (msginfo.getPlanTime() == null || msginfo.getPlanTime().equals("")) {
			msginfo.setPlanTime(new Date());
		}
		msginfo.setDelFlag("0");
		msginfo.setReadFlag("0");// 0标识未读信息，1标识已读信息，仅限于站内信
		if (msginfo.getCreateBy() == null || msginfo.getCreateBy().equals("")) {
			User user = new User();
			user.setId("1");
			msginfo.setCreateBy(user);
		}
		if (msginfo.getCreateDate() == null
				|| msginfo.getCreateDate().equals("")) {
			msginfo.setCreateDate(new Date());
		}
		if (msginfo.getUpdateBy() == null || msginfo.getUpdateBy().equals("")) {
			User user = new User();
			user.setId("1");
			msginfo.setUpdateBy(user);
		}
		if (msginfo.getUpdateDate() == null
				|| msginfo.getUpdateDate().equals("")) {
			msginfo.setUpdateDate(new Date());
		}
		this.save(msginfo);

		return "true";
	}

	/**
	 * 线程发送消息
	 * 
	 * @param msginfo
	 */
	public void realSendMsg(Msginfo msginfo) {
		Thread thread = new Thread(new MsgSendThread(msginfo));
		thread.start();
	}

	/**
	 * 查询站内信数量
	 * 
	 * @param receiverId
	 */
	public Long findCount(String receiverId) {
		return msgMsginfodao.findCount(receiverId);
	}

	/**
	 * 查询站内信详细数据信息
	 * 
	 * @param receiverId
	 */
	public Page<Msginfo> findByreceiverId(Page<Msginfo> page, Msginfo msgMsginfo) {
		msgMsginfo.setPage(page);
		page.setList(dao.findByreceiverId(msgMsginfo));
		return page;
	}

	/**
	 * 站内信调用接口传值
	 */
	@Transactional(readOnly = false)
	public void letter(Msginfo msginfo) {
		// OaNotity实体赋值
		OaNotify oa = new OaNotify();
		oa.setTitle(msginfo.getMsgTitle());
		oa.setContent(msginfo.getMessage());
		oa.setType("1");
		oa.setStatus("1");
		// oaNotifyRecordList数据添加
		List<OaNotifyRecord> oaNotifyRecordList = new ArrayList<OaNotifyRecord>();
		OaNotifyRecord oare = new OaNotifyRecord();
		User userRecord = new User();
		userRecord.setId(msginfo.getReceiverId());
		oare.setUser(userRecord);
		oare.preInsert();
		oare.setOaNotify(oa);
		oare.setReadFlag("0");
		oaNotifyRecordList.add(oare);
		oa.setOaNotifyRecordList(oaNotifyRecordList);
		oaNotifyService.save(oa);
		msginfo.setBackFlag("2");
		msginfo.setActualTime(new Date());
	}

	/**
	 * 消息发送线程
	 * 
	 * @author 廖鹏
	 * 
	 */
	class MsgSendThread implements Runnable {
		private final Msginfo msginfo;

		public MsgSendThread(Msginfo msginfo) {
			this.msginfo = msginfo;
		}

		/*
		 * {@inheritDoc}
		 */
		@Override
		@Transactional(readOnly = false)
		public void run() {

			String testMode = Global.getConfig("testMode");

			if (testMode == null || testMode.equalsIgnoreCase("true")) {
				logger.debug("测试模式不真正发送");
				msginfo.setBackFlag("4");

			} else {
				boolean isSendOk = false;
				try {
					if (msginfo.getMsgType().equals("1")) {
						isSendOk = smsService.sendMsg(msginfo);
					} else if (msginfo.getMsgType().equals("2")) {
						Map<String, String> map = Maps.newHashMap();
						map.put("mailTo", msginfo.getReceiverId());
						map.put("mailCc", msginfo.getCcopyerId());
						map.put("subject", msginfo.getMsgTitle());
						map.put("userName", msginfo.getReceiverName());
						map.put("message", msginfo.getMessage());
						map.put("context", msginfo.getMessage());
						map.put("sendEmail", "true");
						map.put("template", "mailTemplate.ftl");
						isSendOk = mailService.sendTemplateMail(map);

					} else if (msginfo.getMsgType().equals("3")) {
						isSendOk = weixinService.sendMsg(msginfo);
					}
				} catch (Exception e) {
					e.printStackTrace();
					// msginfo.setRemarks(e.getMessage());
					logger.debug(e.getMessage());
					logger.info("======消息发送失败======");
				}

				if (isSendOk) {
					msginfo.setBackFlag("2");
					msginfo.setActualTime(new Date());
					logger.debug("=====消息发送成功=====");
					logger.info("=====消息发送成功=====");
				} else {
					if (msginfo.getMsgType().equals("1")) {
						msginfo.setRemarks("短信消息发送失败");
					} else if (msginfo.getMsgType().equals("2")) {
						msginfo.setRemarks("邮件消息发送失败");
					} else if (msginfo.getMsgType().equals("3")) {
						msginfo.setRemarks("微信消息发送失败");
					}
					msginfo.setBackFlag("3");
				}

			}
			save(msginfo);
		}
	}
}