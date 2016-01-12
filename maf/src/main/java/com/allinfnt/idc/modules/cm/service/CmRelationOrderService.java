/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.cm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.cm.dao.CmCiApplyDao;
import com.allinfnt.idc.modules.cm.dao.CmRelationOrderDao;
import com.allinfnt.idc.modules.cm.entity.CmCiApply;
import com.allinfnt.idc.modules.cm.entity.CmCiInstance;
import com.allinfnt.idc.modules.cm.entity.CmRelationOrder;

/**
 * 配置项关联工单Service
 * @author liujx
 * @version 2015-03-13
 */
@Service
@Transactional(readOnly = true)
public class CmRelationOrderService extends CrudService<CmRelationOrderDao, CmRelationOrder> {
	
	@Autowired
	private CmCiApplyDao cmCiApplyDao;
	
	public CmRelationOrder get(String id) {
		return super.get(id);
	}
	
	public List<CmRelationOrder> findList(CmRelationOrder cmRelationOrder) {
		return super.findList(cmRelationOrder);
	}
	
	public Page<CmRelationOrder> findPage(Page<CmRelationOrder> page, CmRelationOrder cmRelationOrder) {
		return super.findPage(page, cmRelationOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(CmRelationOrder cmRelationOrder) {
		super.save(cmRelationOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(CmRelationOrder cmRelationOrder) {
		super.delete(cmRelationOrder);
	}
	
	/**
	 * 新增工单与配置项的关联
	 * @param ciId 配置项编号
	 * @param orderId 工单编号
	 * @param orderType 工单类型
	 */
	@Transactional(readOnly = false)
	public void addRelationOrder(String ciId ,String orderId ,String orderType){
		CmRelationOrder relation= new CmRelationOrder();
		if(orderType.equals("1")){
			CmCiApply apply = cmCiApplyDao.get(orderId);
			relation.setOrderId("<a href=\""+StringUtils.getHost()+"/cm/cmCiApply/form?id="+apply.getId()+"\">"+apply.getApplyNumber()+"</a>");
		}
		relation.setCiInstance(new CmCiInstance(ciId));
		relation.setOrderType(orderType);
		super.save(relation);
	}
}