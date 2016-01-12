/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdef.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.indexdef.dao.BcmMenuDao;
import com.allinfnt.idc.modules.indexdef.entity.BcmMenu;
import com.allinfnt.idc.modules.sys.dao.UserDao;
import com.allinfnt.idc.modules.sys.entity.User;

/**
 * 首页自定义配置Service
 * 
 * @author zx
 * @version 2015-03-25
 */
@Service
@Transactional(readOnly = true)
public class BcmMenuService extends CrudService<BcmMenuDao, BcmMenu> {
	@Autowired
	private UserDao userdao;

	@Override
	public BcmMenu get(String id) {
		return super.get(id);
	}

	@Override
	public List<BcmMenu> findList(BcmMenu bcmMenu) {
		return super.findList(bcmMenu);
	}

	@Override
	public Page<BcmMenu> findPage(Page<BcmMenu> page, BcmMenu bcmMenu) {
		return super.findPage(page, bcmMenu);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(BcmMenu bcmMenu) {
		super.save(bcmMenu);
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(BcmMenu bcmMenu) {
		super.delete(bcmMenu);
	}

	public List<User> getUserName(User user) {
		// TODO Auto-generated method stub
		return userdao.getUserName(user);
	}

	public List<User> findUserinfo(User user) {
		return userdao.findUserinfo(user);
	}
}