/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.sys.dao.SysIdentityDao;
import com.allinfnt.idc.modules.sys.entity.SysIdentity;

/**
 * 流水号信息表Service
 * 
 * @author rocliao
 * @version 2015-01-29
 */
@Service
@Transactional(readOnly = true)
public class SysIdentityService extends
		CrudService<SysIdentityDao, SysIdentity> {

	@Override
	public SysIdentity get(String id) {
		return super.get(id);
	}

	@Override
	public List<SysIdentity> findList(SysIdentity sysIdentity) {
		return super.findList(sysIdentity);
	}

	@Override
	public Page<SysIdentity> findPage(Page<SysIdentity> page,
			SysIdentity sysIdentity) {
		return super.findPage(page, sysIdentity);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(SysIdentity sysIdentity) {
		super.save(sysIdentity);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(SysIdentity sysIdentity) {
		super.delete(sysIdentity);
	}

	@Transactional(readOnly = false)
	public synchronized String nextId(String alias) {
		SysIdentity identity = dao.findByAlias(alias);
		String rule = identity.getRule();
		int step = identity.getStep();
		int genEveryDay = Integer.valueOf(identity.getGenEveryDay());
		Integer curValue = identity.getCurValue();
		if (curValue == null) {
			curValue = identity.getInitValue();
		}
		// genEveryDay 0唯一 1每天 2每月 3每年
		if (genEveryDay == 1) {
			String curDate = getCurDate();
			String oldDate = identity.getCurDate();
			if (!curDate.equals(oldDate)) {
				identity.setCurDate(curDate);
				curValue = identity.getInitValue();
			} else {
				curValue = Integer.valueOf(curValue.intValue() + step);
			}
		} else if (genEveryDay == 2) {
			String curDate = getCurDate().substring(0, 7);
			String oldDate = identity.getCurDate();
			if (!curDate.equals(oldDate)) {
				identity.setCurDate(curDate);
				curValue = identity.getInitValue();
			} else {
				curValue = Integer.valueOf(curValue.intValue() + step);
			}
		} else if (genEveryDay == 3) {
			String curDate = getCurDate().substring(0, 4);
			String oldDate = identity.getCurDate();
			if (!curDate.equals(oldDate)) {
				identity.setCurDate(curDate);
				curValue = identity.getInitValue();
			} else {
				curValue = Integer.valueOf(curValue.intValue() + step);
			}
		} else {
			curValue = Integer.valueOf(curValue.intValue() + step);
		}
		identity.setCurValue(curValue);

		save(identity);

		String rtn = getByRule(rule, identity.getNoLength().intValue(),
				curValue.intValue()).toUpperCase();

		return rtn;
	}

	public static String getCurDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(new Date());
	}

	private String getByRule(String rule, int length, int curValue) {
		Calendar calendar = Calendar.getInstance();

		String year = calendar.get(Calendar.YEAR) + "";
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
		String longMonth = String.format("%1$02d", month);

		String seqNo = getSeqNo(rule, curValue, length);

		String longDay = String.format("%1$02d", day);

		String rtn = rule.replace("{YYYY}", year).replace("{yyyy}", year)
				.replace("{MM}", longMonth).replace("{mm}", longMonth)
				.replace("{DD}", longDay).replace("{dd}", longDay)
				.replace("{NO}", seqNo).replace("{no}", seqNo);

		return rtn;
	}

	private static String getSeqNo(String rule, int curValue, int length) {
		return String.format("%1$0" + length + "d", curValue);
	}

	/**
	 * @param alias
	 * @return
	 */
	public boolean isAliasExisted(String alias) {
		if (dao.findByAlias(alias) != null) {
			return true;
		}
		return false;
	}

	/**
	 * 根据别名获取
	 * 
	 * @param alias
	 * @return
	 */
	public SysIdentity getByAlias(String alias) {
		return dao.findByAlias(alias);
	}

}