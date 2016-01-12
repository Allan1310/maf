/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.allinfnt.idc.common.persistence.DataEntity;

/**
 * 流水号信息表Entity
 * 
 * @author rocliao
 * @version 2015-01-29
 */
public class SysIdentity extends DataEntity<SysIdentity> {

	private static final long serialVersionUID = 1L;
	private String name; // 名称
	private String alias; // 别名
	private String rule; // 生成规则
	private String genEveryDay; // 每天生成
	private Integer noLength; // 号码长度
	private Integer initValue; // 初始值
	private Integer curValue; // 当前值
	private String curDate; // 当前日期
	private Integer step; // 步长

	public SysIdentity() {
		super();
	}

	public SysIdentity(String id) {
		super(id);
	}

	@Length(min = 0, max = 50, message = "名称长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min = 0, max = 20, message = "别名长度必须介于 0 和 20 之间")
	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	@Length(min = 0, max = 100, message = "生成规则长度必须介于 0 和 100 之间")
	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	@Length(min = 0, max = 1, message = "每天生成长度必须介于 0 和 1 之间")
	public String getGenEveryDay() {
		return genEveryDay;
	}

	public void setGenEveryDay(String genEveryDay) {
		this.genEveryDay = genEveryDay;
	}

	public Integer getNoLength() {
		return noLength;
	}

	public void setNoLength(Integer noLength) {
		this.noLength = noLength;
	}

	public Integer getInitValue() {
		return initValue;
	}

	public void setInitValue(Integer initValue) {
		this.initValue = initValue;
	}

	public Integer getCurValue() {
		return curValue;
	}

	public void setCurValue(Integer curValue) {
		this.curValue = curValue;
	}

	@Length(min = 0, max = 10, message = "当前日期长度必须介于 0 和 10 之间")
	public String getCurDate() {
		return curDate;
	}

	public void setCurDate(String curDate) {
		this.curDate = curDate;
	}

	public Integer getStep() {
		return step;
	}

	public void setStep(Integer step) {
		this.step = step;
	}

}