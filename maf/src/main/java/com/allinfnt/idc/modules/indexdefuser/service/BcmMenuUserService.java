/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdefuser.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.indexdefuser.entity.BcmMenuUser;
import com.allinfnt.idc.modules.indexdefuser.dao.BcmMenuUserDao;

/**
 * 首页自定义用户配置Service
 * @author zx
 * @version 2015-03-17
 */
@Service
@Transactional(readOnly = true)
public class BcmMenuUserService extends CrudService<BcmMenuUserDao, BcmMenuUser> {
	
	@Autowired
	private BcmMenuUserDao bcmMenuUserDao;

	public BcmMenuUser get(String id) {
		return super.get(id);
	}
	
	public List<BcmMenuUser> findList(BcmMenuUser bcmMenuUser) {
		return super.findList(bcmMenuUser);
	}
	
	public Page<BcmMenuUser> findPage(Page<BcmMenuUser> page, BcmMenuUser bcmMenuUser) {
		return super.findPage(page, bcmMenuUser);
	}
	
	@Transactional(readOnly = false)
	public void save(BcmMenuUser bcmMenuUser) {
		super.save(bcmMenuUser);
	}
	
	@Transactional(readOnly = false)
	public void delete(BcmMenuUser bcmMenuUser) {
		super.delete(bcmMenuUser);
	}
	@Transactional(readOnly = false)
	public void deleteMenu(BcmMenuUser bcmMenuUser) {
		// TODO Auto-generated method stub
		bcmMenuUserDao.deleteMenu(bcmMenuUser);
	}
	
}