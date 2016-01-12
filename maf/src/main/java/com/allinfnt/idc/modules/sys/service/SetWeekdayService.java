/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.config.Canstants;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.CacheUtils;
import com.allinfnt.idc.modules.sys.dao.SetWeekdayDao;
import com.allinfnt.idc.modules.sys.entity.SetWeekday;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;

/**
 * 工作日设置Service
 * @author 蒋斌
 * @version 2015-01-29
 */
@Service
@Transactional(readOnly = true)
public class SetWeekdayService extends CrudService<SetWeekdayDao, SetWeekday> {

	public SetWeekday get(String id) {
		return super.get(id);
	}
	
	public List<SetWeekday> findList(SetWeekday SetWeekday) {
		return super.findList(SetWeekday);
	}
	
	public Page<SetWeekday> findPage(Page<SetWeekday> page, SetWeekday SetWeekday) {
		return super.findPage(page, SetWeekday);
	}
	
	@Transactional(readOnly = false)
	public void save(SetWeekday SetWeekday,List<String> dataList) {
		Map<String, Object> weekDayMap = (Map<String,Object>)CacheUtils.get(Canstants.SYS_WEEK_DAY_CACHE_NAME, Canstants.SYS_WEEK_DAY_CACHE_KEY);
		if(weekDayMap == null){
			weekDayMap = new HashMap<String, Object>();
		}
		if(dataList != null && dataList.size() > 0){
			for(int i=0;i<dataList.size();i++){
				if(this.findDay(dataList.get(i))){
					SetWeekday setWeekday = new SetWeekday();
	//				setWeekday.setId(IdGen.uuid());
					setWeekday.setDay(dataList.get(i));
					setWeekday.setCreateBy(UserUtils.getUser());
					setWeekday.setCreateDate(new Date());
					setWeekday.setUpdateBy(UserUtils.getUser());
					setWeekday.setUpdateDate(new Date());
					super.save(setWeekday);
					weekDayMap.put(dataList.get(i), setWeekday);
				}
			}
		}else{
			if(this.findDay(SetWeekday.getDay())){
				super.save(SetWeekday);
				weekDayMap.put(SetWeekday.getDay(), SetWeekday);
			}
		}
		CacheUtils.put(Canstants.SYS_WEEK_DAY_CACHE_NAME, Canstants.SYS_WEEK_DAY_CACHE_KEY, weekDayMap);
	}
	
	@Transactional(readOnly = false)
	public void delete(SetWeekday SetWeekday) {
		super.delete(SetWeekday);
	}
	
	/**
	 * @author 作者：蒋斌
	 * @version 创建时间：2015年4月15日下午4:51:57
	 * @params 参数:
	 * @return: boolean
	 * @memo 说明:判断添加的工作日时候存在
	 */
	public boolean findDay(String day){
		boolean flag = true;
		List<SetWeekday> listDay = this.dao.findDay(day);
		if(listDay != null && listDay.size() > 0){
			flag = false;
		}
		return flag;
	}
	
	
	/**
	 * @author 作者：蒋斌
	 * @version 创建时间：2015年3月3日下午3:47:19
	 * @params 参数:
	 * @return: Map<String,Object>
	 * @memo 说明:用于存放全年的工作日数据，并且封装成Map，提供给系统判断当前的日期是否是工作日
	 */
	public Map<String, Object> getWeekDayMap(){
		SetWeekday setWeekday = new SetWeekday();
		Map<String, Object> weekDayMap = (Map<String,Object>)CacheUtils.get(Canstants.SYS_WEEK_DAY_CACHE_NAME, Canstants.SYS_WEEK_DAY_CACHE_KEY);
		if(weekDayMap == null || weekDayMap.size() == 0){
			List<SetWeekday> weekDayList = super.findList(setWeekday);
			Map tempMap = Maps.newHashMap();
			for(SetWeekday weekday : weekDayList){
				tempMap.put(weekday.getDay(), weekday);
			}
			weekDayMap = tempMap;
			CacheUtils.put(Canstants.SYS_WEEK_DAY_CACHE_NAME, Canstants.SYS_WEEK_DAY_CACHE_KEY, weekDayMap);
		}
		return weekDayMap;
	}
}