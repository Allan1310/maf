/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.persistence.Page;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.msg.entity.SiteNews;
import com.allinfnt.idc.modules.msg.service.SiteNewsService;

/**
 * 新闻管理Controller
 * 
 * @author liufan
 * @version 2015-01-27
 */
@Controller
@RequestMapping(value = "${adminPath}/site/siteNews")
public class SiteNewsController extends BaseController {

	@Autowired
	private SiteNewsService siteNewsService;

	@ModelAttribute
	public SiteNews get(@RequestParam(required = false) String id) {
		SiteNews entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = siteNewsService.get(id);
		}
		if (entity == null) {
			entity = new SiteNews();
		}
		return entity;
	}

	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = { "list", "" })
	public String list(SiteNews siteNews, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		siteNews.setCreateBy(siteNews.getCurrentUser());
		Page<SiteNews> page = siteNewsService.findPage(new Page<SiteNews>(
				request, response), siteNews);
		model.addAttribute("page", page);
		return "modules/msg/siteNewsList";
	}

	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = { "reNews" })
	public String listRe(SiteNews siteNews, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<SiteNews> page = siteNewsService.findReNews(new Page<SiteNews>(
				request, response), siteNews);
		model.addAttribute("page", page);
		return "modules/msg/siteNewsList-re";
	}

	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = "form")
	public String form(SiteNews siteNews, Model model) {
		if (StringUtils.isNotBlank(siteNews.getId())) {
			siteNews = siteNewsService.get(siteNews);
		}
		model.addAttribute("siteNews", siteNews);
		return "modules/msg/siteNewsForm";
	}
	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = "show")
	public String show(SiteNews siteNews, Model model,HttpServletRequest request,
			HttpServletResponse response) {
			siteNews = siteNewsService.get(siteNews);
			if(siteNews.getFiles()!=null && siteNews.getFiles()!=""){
			String Config = request.getRequestURL().toString();
			String[] path = Config.split("idc");
			String file = siteNews.getFiles().substring(2);
			siteNews.setFiles(path[0]+file);
			}
		model.addAttribute("siteNews", siteNews);
		return "modules/msg/siteNewsShow";
	}

	@RequiresPermissions("site:siteNews:edit")
	@RequestMapping(value = "save")
	public String save(SiteNews siteNews, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, siteNews)) {
			return form(siteNews, model);
		}
		/*
		 * if (StringUtils.isNotBlank(siteNews.getId())) { SiteNews e =
		 * siteNewsService.get(siteNews.getId()); if ("1".equals(e.getStatus()))
		 * { addMessage(redirectAttributes, "已发布，不能操作！"); return "redirect:" +
		 * Global.getAdminPath() + "/site/siteNews/form?id=" + siteNews.getId();
		 * } }
		 */
		siteNews.setStatus("1");
		siteNews.setNewsDate(new Date());
		siteNews.setContent(StringEscapeUtils.unescapeHtml4(siteNews
				.getContent()));
		siteNewsService.save(siteNews);
		addMessage(redirectAttributes, "保存新闻" + siteNews.getTitle() + "成功");
		return "redirect:" + Global.getAdminPath() + "/site/siteNews/?repage";
	}

	@RequiresPermissions("site:siteNews:edit")
	@RequestMapping(value = "delete")
	public String delete(SiteNews siteNews,
			RedirectAttributes redirectAttributes) {
		siteNewsService.delete(siteNews);
		addMessage(redirectAttributes, "删除新闻管理成功");
		return "redirect:" + Global.getAdminPath() + "/site/siteNews/?repage";
	}

	/**
	 * @author 作者：彭振
	 * @version 创建时间：2015年4月312日
	 * @params 参数:
	 * @return: Page<SiteNews>
	 * @memo 说明:手机端新闻列表数据查询
	 */
	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = { "m/list" })
	@ResponseBody
	public Page<SiteNews> listMobile(SiteNews siteNews,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<SiteNews> page = siteNewsService.findReNews(new Page<SiteNews>(
				request, response), siteNews);
		return page;
	}

	/**
	 * @author 作者：彭振
	 * @version 创建时间：2015年4月312日
	 * @params 参数:
	 * @return: SiteNews
	 * @memo 说明:手机端新闻列表数据详情
	 */
	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = { "m/form" })
	@ResponseBody
	public SiteNews formMobile(String id, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SiteNews sitenewa = siteNewsService.get(id);
		return sitenewa;
	}

	/**
	 * @author 作者：彭振
	 * @version 创建时间：2015年4月312日
	 * @params 参数:
	 * @return: void
	 * @memo 说明:首页信息显示
	 */
	@RequiresPermissions("site:siteNews:view")
	@RequestMapping(value = { "sitelist" })
	public String sitelist(SiteNews siteNews, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<SiteNews> page = siteNewsService.findReNews(new Page<SiteNews>(
				request, response), siteNews);
		model.addAttribute("page", page);
		return "modules/msg/siteNewsList_index";
	}
}