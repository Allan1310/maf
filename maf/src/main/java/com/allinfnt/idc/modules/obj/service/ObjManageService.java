/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.obj.entity.ObjManage;
import com.allinfnt.idc.modules.item.entity.ItemPath;
import com.allinfnt.idc.modules.obj.dao.ObjManageDao;

/**
 * 对象管理Service
 * @author xusuojian
 * @version 2015-12-01
 */
@Service
@Transactional(readOnly = true)
public class ObjManageService extends CrudService<ObjManageDao, ObjManage> {

	public ObjManage get(String id) {
		return super.get(id);
	}
	
	public List<ObjManage> findList(ObjManage objManage) {
		return super.findList(objManage);
	}
	
	public Page<ObjManage> findPage(Page<ObjManage> page, ObjManage objManage) {
		objManage.getSqlMap().put("af", dataScopeFilter(objManage.getCurrentUser(), "o", "u", "cs"));
		objManage.setPage(page);
        List<ObjManage> list = this.dao.findList(objManage);
        page.setList(list);
        return page;
	}
	
	@Transactional(readOnly = false)
	public void save(ObjManage objManage,HttpServletRequest request) {
		
		String flag = request.getParameter("flag");
		//对象内容
		String[] objNames = request.getParameterValues("objName");   
		String[] xpathCodes = request.getParameterValues("xpathCode");
		String[] jqueryCodes = request.getParameterValues("jqueryCode");
		
		if(null != flag && flag.equals("update")){
			super.save(objManage);
		}else{
			for (int i = 0; i < objNames.length; i++) {
				ObjManage obm = new ObjManage();
				
				obm.setItemId(objManage.getItemId());
				obm.setItemName(objManage.getItemName());  //关联的项目
				obm.setPathId(objManage.getPathId());
				obm.setPathName(objManage.getPathName());  //关联的路径
				
				//对象内容
				obm.setObjName(objNames[i]);
				obm.setXpathCode(xpathCodes[i]);
				obm.setJqueryCode(jqueryCodes[i]);
				
				super.save(obm);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(ObjManage objManage) {
		super.delete(objManage);
	}
	
	/**
	 * 根据itemId查询所有的objManage对象
	 * @param page 
	 * @param itemId
	 * @return
	 */
	public Page<ObjManage> findObjManageListByItemId(Page<ObjManage> page, String itemId) {
		List<ObjManage> list = this.dao.findObjManageListByItemId(itemId);
		page.setList(list);
		return page;
	}
	
}