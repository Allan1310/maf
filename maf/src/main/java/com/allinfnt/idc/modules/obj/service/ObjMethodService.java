/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.obj.entity.ObjMethod;
import com.allinfnt.idc.modules.obj.dao.ObjMethodDao;

/**
 * 对象方法管理Service
 * @author xusuojian
 * @version 2015-12-03
 */
@Service
@Transactional(readOnly = true)
public class ObjMethodService extends CrudService<ObjMethodDao, ObjMethod> {

	public ObjMethod get(String id) {
		return super.get(id);
	}
	
	public List<ObjMethod> findList(ObjMethod objMethod) {
		return super.findList(objMethod);
	}
	
	public Page<ObjMethod> findPage(Page<ObjMethod> page, ObjMethod objMethod) {
		objMethod.getSqlMap().put("af", dataScopeFilter(objMethod.getCurrentUser(), "o", "u", "cs"));
		objMethod.setPage(page);
        List<ObjMethod> list = this.dao.findList(objMethod);
        page.setList(list);
        return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ObjMethod objMethod) {
		super.save(objMethod);
	}
	
	@Transactional(readOnly = false)
	public void delete(ObjMethod objMethod) {
		super.delete(objMethod);
	}
	
	/**
	 * 查询所有的对象方法
	 * @return
	 */
	public List<ObjMethod> getAllObj() {
		ObjMethod objMethod = new ObjMethod();
		return this.dao.findList(objMethod);
	}
	
	public ObjMethod findDefaultValByMethodName(String methodName) {
		// TODO Auto-generated method stub
		return this.dao.findDefaultValByMethodName(methodName);
		
	}
	
}