/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.service.TreeService;
import com.allinfnt.idc.modules.sys.dao.OfficeDao;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * 
 * @author allinfnt
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {
	@Autowired
	private OfficeDao officeDao;
	public List<Office> findAll() {
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll) {
		if (isAll != null && isAll) {
			return UserUtils.getOfficeAllList();
		} else {
			return UserUtils.getOfficeList();
		}
	}

	@Transactional(readOnly = true)
	public List<Office> findList(Office office) {
		// office.setParentIds(office.getParentIds()+"%");
		return dao.findByParentIdsLike(office);
	}

	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public List<Office> findUserBySubdepartment() {
		return officeDao.findUserBySubdepartment();
	}

	@Transactional(readOnly = false)
	public Office findBuUserName(String userName) {
		return officeDao.findBuUserName(userName);
	}

	@Transactional(readOnly = false)
	public Office findByDeptName(String userName) {
		return officeDao.findByDeptName(userName);
	}
	
	/**
	 * @author 作者：蒋斌
	 * @version 创建时间：2015年4月7日下午5:37:39
	 * @params 参数:
	 * @return: List<Office>
	 * @memo 说明:校验机构编码是否一致
	 */
	public List<Office> findByCodeList(String code) {
		return officeDao.findByCodeList(code);
	}
	
	/**
	 * 根据机构ID获得机构
	 */
	public Office get(String id){
		return dao.get(id);
	}

	/**
	 * 根据父节点的ID所有的子节点
	 * @param id
	 * @return
	 */
	public List<Office> findSubList(String id) {
		// TODO Auto-generated method stub
		return officeDao.findSubList(id);
	}

	public Office findByName(String name) {
		// TODO Auto-generated method stub
		return officeDao.findByName(name);
	}
}
