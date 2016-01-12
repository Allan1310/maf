/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.item.entity.ItemManage;
import com.allinfnt.idc.modules.item.dao.ItemManageDao;

/**
 * 项目管理Service
 * @author xusuojian
 * @version 2015-11-25
 */
@Service
@Transactional(readOnly = true)
public class ItemManageService extends CrudService<ItemManageDao, ItemManage> {

	public ItemManage get(String id) {
		return super.get(id);
	}
	
	public List<ItemManage> findList(ItemManage itemManage) {
		return super.findList(itemManage);
	}
	
	public Page<ItemManage> findPage(Page<ItemManage> page, ItemManage itemManage) {
		itemManage.getSqlMap().put("af", dataScopeFilter(itemManage.getCurrentUser(), "o", "u", "cs"));
		itemManage.setPage(page);
        List<ItemManage> list = this.dao.findList(itemManage);
        page.setList(list);
        return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ItemManage itemManage) {
		super.save(itemManage);
	}
	
	@Transactional(readOnly = false)
	public void delete(ItemManage itemManage) {
		super.delete(itemManage);
	}
	
}