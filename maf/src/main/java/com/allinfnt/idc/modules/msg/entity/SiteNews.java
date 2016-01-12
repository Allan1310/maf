/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 新闻管理Entity
 * 
 * @author liufan
 * @version 2015-01-27
 */
public class SiteNews extends DataEntity<SiteNews> {

	private static final long serialVersionUID = 1L;
	private String type; // 类型
	private String title; // 标题
	private String content; // 内容
	private String files; // 附件
	private Date newsDate; // 发布时间
	private String introduction;// 新闻简介
	private String status; // 状态
	private String readState; // 阅读状态

	public SiteNews() {
		super();
	}

	public SiteNews(String id) {
		super(id);
	}

	@Length(min = 0, max = 1, message = "类型长度必须介于 0 和 1 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min = 0, max = 200, message = "标题长度必须介于 0 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Length(min = 0, max = 2000, message = "附件长度必须介于 0 和 2000 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	@Length(min = 0, max = 1, message = "状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getNewsDate() {
		return newsDate;
	}

	public void setNewsDate(Date newsDate) {
		this.newsDate = newsDate;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getReadState() {
		return readState;
	}

	public void setReadState(String readState) {
		this.readState = readState;
	}

	public String getCreateName() {
		if (super.getCreateBy() != null
				&& super.getCreateBy().getName() != null) {
			return super.getCreateBy().getName();
		} else {
			return "";
		}
	}

}