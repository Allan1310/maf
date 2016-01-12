/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.obj.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.obj.entity.ObjMethod;

/**
 * 对象方法管理DAO接口
 * @author xusuojian
 * @version 2015-12-03
 */
@MyBatisDao
public interface ObjMethodDao extends CrudDao<ObjMethod> {

	ObjMethod findDefaultValByMethodName(@Param("methodName") String methodName);

	
}