/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.ActEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 消息管理Entity
 * 
 * @author Peng
 * @version 2015-03-11
 */
public class Msginfo extends ActEntity<Msginfo> {

	private static final long serialVersionUID = 1L;
	private String sendMode; // 发送方式
	private String senderId; // 发送人编号
	private String sendName; // 发送人姓名
	private String receiverId; // 接收人编号
	private String receiverName; // 接收人姓名
	private String ccopyerId; // 抄送人编号
	private String blinderId; // 密送人编号
	private String msgTitle; // 消息标题
	private String message; // 信息内容
	private String msgType; // 消息类型

	/**
	 * 发送状态 0待发送 1发送中 2已发送 3发送失败 4已取消
	 */
	private String backFlag; // 发送状态
	private Date planTime; // 计划发送时间
	private Date actualTime; // 实际发送时间
	private String readFlag;

	public Msginfo() {
		super();
	}

	public Msginfo(String id) {
		super(id);
	}

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}

	@Length(min = 0, max = 10, message = "发送方式长度必须介于 0 和 10 之间")
	public String getSendMode() {
		return sendMode;
	}

	public void setSendMode(String sendMode) {
		this.sendMode = sendMode;
	}

	public String getSenderId() {
		return senderId;
	}

	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	public String getSendName() {
		return sendName;
	}

	public void setSendName(String sendName) {
		this.sendName = sendName;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getCcopyerId() {
		return ccopyerId;
	}

	public void setCcopyerId(String ccopyerId) {
		this.ccopyerId = ccopyerId;
	}

	public String getBlinderId() {
		return blinderId;
	}

	public void setBlinderId(String blinderId) {
		this.blinderId = blinderId;
	}

	public String getMsgTitle() {
		return msgTitle;
	}

	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}

	@Length(min = 0, max = 1000, message = "信息内容长度必须介于 0 和 1000 之间")
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Length(min = 0, max = 100, message = "消息类型长度必须介于 0 和 100 之间")
	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	@Length(min = 0, max = 10, message = "发送状态长度必须介于 0 和 10 之间")
	public String getBackFlag() {
		return backFlag;
	}

	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPlanTime() {
		return planTime;
	}

	public void setPlanTime(Date planTime) {
		this.planTime = planTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getActualTime() {
		return actualTime;
	}

	public void setActualTime(Date actualTime) {
		this.actualTime = actualTime;
	}

}