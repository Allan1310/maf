/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.dao;

import java.util.List;

import com.allinfnt.idc.common.persistence.CrudDao;
import com.allinfnt.idc.common.persistence.annotation.MyBatisDao;
import com.allinfnt.idc.modules.msg.entity.SiteNews;

/**
 * 新闻管理DAO接口
 * 
 * @author liufan
 * @version 2015-01-27
 */
@MyBatisDao
public interface SiteNewsDao extends CrudDao<SiteNews> {
	/**
	 * 获取公告数目
	 * 
	 * @param siteNews
	 * @return
	 */
	public Long findCount(SiteNews siteNews);

	/**
	 * 已发布的新闻公告
	 */
	public List<SiteNews> findReNews(SiteNews siteNews);
}