/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.service.CrudService;
import com.allinfnt.idc.modules.msg.dao.SiteNewsDao;
import com.allinfnt.idc.modules.msg.entity.SiteNews;

/**
 * 新闻管理Service
 * 
 * @author liufan
 * @version 2015-01-27
 */
@Service
@Transactional(readOnly = true)
public class SiteNewsService extends CrudService<SiteNewsDao, SiteNews> {

	@Override
	public SiteNews get(String id) {
		SiteNews entity = dao.get(id);
		return entity;
	}

	@Override
	public List<SiteNews> findList(SiteNews siteNews) {
		return super.findList(siteNews);
	}

	public Page<SiteNews> find(Page<SiteNews> page, SiteNews siteNews) {
		siteNews.setPage(page);
		page.setList(dao.findList(siteNews));
		return page;
	}

	/**
	 * 已发布新闻公告
	 */
	public Page<SiteNews> findReNews(Page<SiteNews> page, SiteNews siteNews) {
		siteNews.setPage(page);
		page.setList(dao.findReNews(siteNews));
		return page;
	}

	/**
	 * 获取新闻数目
	 * 
	 * @param oaNotify
	 * @return
	 */
	public Long findCount(SiteNews siteNews) {
		return dao.findCount(siteNews);

	}

	@Override
	public Page<SiteNews> findPage(Page<SiteNews> page, SiteNews siteNews) {
		return super.findPage(page, siteNews);
	}

	@Override
	@Transactional(readOnly = false)
	public void save(SiteNews siteNews) {
		super.save(siteNews);
	}

}