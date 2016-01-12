/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.sys.entity.User;

/**
 * 用户DAO接口
 * 
 * @author allinfnt
 * @version 2014-05-16
 */
@MyBatisDao
public interface UserDao extends CrudDao<User> {

	/**
	 * 根据登录名称查询用户
	 * 
	 * @param loginName
	 * @return
	 */
	public User getByLoginName(User user);

	/**
	 * 通过OfficeId获取用户列表，仅返回用户id和name（树查询用户时用）
	 * 
	 * @param user
	 * @return
	 */
	public List<User> findUserByOfficeId(User user);

	/**
	 * 通过offid 和 name 查询用户信息
	 */
	public List<User> findUserinfo(User user);

	/**
	 * 查询全部用户数目
	 * 
	 * @return
	 */
	public long findAllCount(User user);

	/**
	 * 更新用户密码
	 * 
	 * @param user
	 * @return
	 */
	public int updatePasswordById(User user);

	/**
	 * 更新登录信息，如：登录IP、登录时间
	 * 
	 * @param user
	 * @return
	 */
	public int updateLoginInfo(User user);

	/**
	 * 删除用户角色关联数据
	 * 
	 * @param user
	 * @return
	 */
	public int deleteUserRole(User user);

	/**
	 * 插入用户角色关联数据
	 * 
	 * @param user
	 * @return
	 */
	public int insertUserRole(User user);

	/**
	 * 更新用户信息
	 * 
	 * @param user
	 * @return
	 */
	public int updateUserInfo(User user);

	/**
	 * 根据用户名称查询用户
	 * 
	 * @param name
	 * @return
	 */
	public User getUserByName(String name);

	/**
	 * 根据用户名称查询用户列表
	 * 
	 * @param name
	 * @return
	 */
	public List<User> getUserName(User user);

	/**
	 * 获取某个部门的岗位职位
	 * 
	 * @param position
	 * @return
	 */
	public List<User> findByPosition(String position);

	/**
	 * 查询角色对应的人员
	 * 
	 * @param roleId
	 * @return
	 */
	public List<User> findUserByRoleId(@Param(value = "roleId") String roleId);

	/**
	 * 根据用户名称查询用户
	 * 
	 * @param name
	 * @return
	 */
	public User getUserByLoginName(String loginName);

	/**
	 * 查询所有角色的工号
	 */
	public List<String> findAllNo();

	/**
	 * 根据工号查询角色
	 * 
	 * @param no
	 * @return
	 */
	public User getUserByNo(@Param(value = "no") String no);

	public List<String> findRoleIdByUserId(
			@Param(value = "userId") String userId);

}
