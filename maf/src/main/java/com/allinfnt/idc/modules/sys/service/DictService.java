/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.CacheUtils;
import com.allinfnt.idc.modules.sys.dao.DictDao;
import com.allinfnt.idc.modules.sys.entity.Dict;
import com.allinfnt.idc.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @author allinfnt
 * @version 2014-05-16
 */
@Service
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(Dict dict){
		return dao.findTypeList(dict);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
	/**
	 * 查询所有数据字典的类型
	 * @return
	 */
	public List<Dict> findDictType(){
		return dao.findDictType();
	}

}
