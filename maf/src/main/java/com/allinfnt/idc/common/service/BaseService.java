/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.common.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.sys.entity.Role;
import com.allinfnt.idc.modules.sys.entity.User;
import com.google.common.collect.Lists;

/**
 * Service基类
 * 
 * @author allinfnt
 * @version 2014-05-16
 */
@Transactional(readOnly = true)
public abstract class BaseService {

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * 数据范围过滤
	 * 
	 * @param user
	 *            当前用户对象，通过“entity.getCurrentUser()”获取
	 * @param officeAlias
	 *            机构表别名，多个用“,”逗号隔开。
	 * @param userAlias
	 *            用户表别名，多个用“,”逗号隔开，传递空，忽略此参数
	 * @return 标准连接条件对象
	 */
	public static String dataScopeFilter(User user, String officeAlias,
			String userAlias, String module) {

		StringBuilder sqlString = new StringBuilder();

		// 进行权限过滤，多个角色权限范围之间为或者关系。
		List<String> dataScope = Lists.newArrayList();

		// 超级管理员，跳过权限过滤
		if (!user.isAdmin()) {
			boolean isDataScopeAll = false;
			for (Role r : user.getRoleList()) {
				if (StringUtils.isNotBlank(r.getModule())
						&& !r.getModule().equals("all")) {
					if (StringUtils.isBlank(module)) {
						continue;
					} else if (!module.equals("all")
							&& !r.getModule().equals(module)) {
						continue;
					}
				}
				for (String oa : StringUtils.split(officeAlias, ",")) {
					if (!dataScope.contains(r.getDataScope())
							&& StringUtils.isNotBlank(oa)) {
						if (Role.DATA_SCOPE_ALL.equals(r.getDataScope())) {
							isDataScopeAll = true;
						} else if (Role.DATA_SCOPE_COMPANY_AND_CHILD.equals(r
								.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '"
									+ user.getCompany().getId() + "'");
							sqlString.append(" OR " + oa + ".parent_ids LIKE '"
									+ user.getCompany().getParentIds()
									+ user.getCompany().getId() + ",%'");
						} else if (Role.DATA_SCOPE_COMPANY.equals(r
								.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '"
									+ user.getCompany().getId() + "'");
							// 包括本公司下的部门 （type=1:公司；type=2：部门）
							sqlString.append(" OR (" + oa + ".parent_id = '"
									+ user.getCompany().getId() + "' AND " + oa
									+ ".type = '2')");
						} else if (Role.DATA_SCOPE_OFFICE_AND_CHILD.equals(r
								.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '"
									+ user.getOffice().getId() + "'");
							sqlString.append(" OR " + oa + ".parent_ids LIKE '"
									+ user.getOffice().getParentIds()
									+ user.getOffice().getId() + ",%'");
						} else if (Role.DATA_SCOPE_OFFICE.equals(r
								.getDataScope())) {
							sqlString.append(" OR " + oa + ".id = '"
									+ user.getOffice().getId() + "'");
						} else if (Role.DATA_SCOPE_CUSTOM.equals(r
								.getDataScope())) {
							String officeIds = StringUtils.join(
									r.getOfficeIdList(), "','");
							if (StringUtils.isNotEmpty(officeIds)) {
								sqlString.append(" OR " + oa + ".id IN ('"
										+ officeIds + "')");
							}
						}
						// else if
						// (Role.DATA_SCOPE_SELF.equals(r.getDataScope())){
						dataScope.add(r.getDataScope());
					}
				}

			}
			// 如果没有全部数据权限，并设置了用户别名，则当前权限为本人；如果未设置别名，当前无权限为已植入权限
			if (!isDataScopeAll) {
				if (StringUtils.isNotBlank(userAlias)) {
					for (String ua : StringUtils.split(userAlias, ",")) {
						sqlString.append(" OR " + ua + ".id = '" + user.getId()
								+ "'");
					}
				} else {
					for (String oa : StringUtils.split(officeAlias, ",")) {
						// sqlString.append(" OR " + oa + ".id  = " +
						// user.getOffice().getId());
						sqlString.append(" OR " + oa + ".id IS NULL");
					}
				}
			} else {
				// 如果包含全部权限，则去掉之前添加的所有条件，并跳出循环。
				sqlString = new StringBuilder();
			}
		}
		if (StringUtils.isNotBlank(sqlString.toString())) {
			return " AND (" + sqlString.substring(4) + ")";
		}
		return "";
	}

	/**
	 * 数据范围过滤
	 * 
	 * @param user
	 *            当前用户对象，通过“entity.getCurrentUser()”获取
	 * @param officeAlias
	 *            机构表别名，多个用“,”逗号隔开。
	 * @param userAlias
	 *            用户表别名，多个用“,”逗号隔开，传递空，忽略此参数
	 * @return 标准连接条件对象
	 */
	public static String dataScopeFilter(User user, String officeAlias,
			String userAlias) {
		return dataScopeFilter(user, officeAlias, userAlias, "");

	}
}
