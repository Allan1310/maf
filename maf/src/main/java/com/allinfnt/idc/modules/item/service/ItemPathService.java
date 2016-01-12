/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.item.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.item.entity.ItemPath;
import com.allinfnt.idc.modules.item.dao.ItemPathDao;

/**
 * 路径管理Service
 * @author xusuojian
 * @version 2015-11-26
 */
@Service
@Transactional(readOnly = true)
public class ItemPathService extends CrudService<ItemPathDao, ItemPath> {

	public ItemPath get(String id) {
		return super.get(id);
	}
	
	public List<ItemPath> findList(ItemPath itemPath) {
		return super.findList(itemPath);
	}
	
	public Page<ItemPath> findPage(Page<ItemPath> page, ItemPath itemPath) {
		itemPath.getSqlMap().put("af", dataScopeFilter(itemPath.getCurrentUser(), "o", "u", "cs"));
		itemPath.setPage(page);
        List<ItemPath> list = this.dao.findList(itemPath);
        page.setList(list);
        return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ItemPath itemPath) {
		super.save(itemPath);
	}
	
	@Transactional(readOnly = false)
	public void delete(ItemPath itemPath) {
		super.delete(itemPath);
	}
	
}