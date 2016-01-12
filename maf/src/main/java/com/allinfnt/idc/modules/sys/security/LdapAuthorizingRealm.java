package com.allinfnt.idc.modules.sys.security;

import javax.naming.ldap.LdapContext;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.realm.ldap.JndiLdapRealm;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.servlet.ValidateCodeServlet;
import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SystemService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.allinfnt.idc.modules.sys.web.LoginController;

/**
 * 系统安全AD认证实现类
 * 
 * @author peng.liao
 * @version 2013-11-11
 */
@Service
// @DependsOn({"userDao","roleDao","menuDao"})
public class LdapAuthorizingRealm extends JndiLdapRealm {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private SystemService systemService;

	/**
	 * 认证回调函数, 登录时调用
	 */
	@Override
	protected AuthenticationInfo createAuthenticationInfo(
			AuthenticationToken authcToken, Object ldapPrincipal,
			Object ldapCredentials, LdapContext ldapContext) {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;

		int activeSessionSize = getSystemService().getSessionDao()
				.getActiveSessions(false).size();
		if (logger.isDebugEnabled()) {
			logger.debug("login submit, active session size: {}, username: {}",
					activeSessionSize, token.getUsername());
		}

		// 校验登录验证码
		if (LoginController.isValidateCodeLogin(token.getUsername(), false,
				false)) {
			Session session = UserUtils.getSession();
			String code = (String) session
					.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
			if (token.getCaptcha() == null
					|| !token.getCaptcha().toUpperCase().equals(code)) {
				throw new AuthenticationException("msg:验证码错误, 请重试.");
			}
		}

		// 校验用户名密码
		User user = getSystemService().getUserByLoginName(token.getUsername());
		// AD帐号密码登录
		if (user != null
				&& (user.getLoginType() != null && user.getLoginType().equals(
						"1"))) {
			if (Global.NO.equals(user.getLoginFlag())) {
				throw new AuthenticationException("msg:该已帐号禁止登录.");
			}
			return new SimpleAuthenticationInfo(
					new SystemAuthorizingRealm.Principal(user,
							token.isMobileLogin()), token.getCredentials(),
					getName());
		} else {
			return null;
		}
	}

	/**
	 * 获取系统业务对象
	 */
	public SystemService getSystemService() {
		if (systemService == null) {
			systemService = SpringContextHolder.getBean(SystemService.class);
		}
		return systemService;
	}

}
