/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.webPanel.web;

import java.lang.ProcessBuilder.Redirect;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.allinfnt.idc.common.config.Global;
import com.allinfnt.idc.common.web.BaseController;
import com.allinfnt.idc.modules.sys.dao.UserDao;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.utils.DictUtils;


@Controller
@RequestMapping(value = "${adminPath}/webPanel")
public class WebpanelController extends BaseController {

    @Autowired
	private UserDao userDao;


    
    
	@RequestMapping(value = "webpanel")
	public String webpanel(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/web/webPanel/webPanel";
	}
	@RequestMapping(value = "webpanelChild")
	public String webpanelChild(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/web/webPanel/webpanelChild";
	}
	@RequestMapping(value = "webpanelTab")
	public String webpanelTab(HttpServletRequest request, HttpServletResponse response, Model model) {
		String btn = request.getParameter("btn");
		String view = "";
		// 修改
		if("1".equals(btn)){
			model.addAttribute("btn", "1");
			view = "webPanelTable";
		}
		// 查看
		else if("2".equals(btn)){
			model.addAttribute("btn", "2");
			view = "webPanelTable2";
		}
		// 
		else if("3".equals(btn)){
			model.addAttribute("btn", "3");
			view = "webPanelTable";
		}
		
		return "modules/web/webPanel/"+view;
	}
	@RequestMapping(value = "webpanelList")
	public String webpanelList(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		return "modules/web/webPanel/webPanelList";
	}
	@RequestMapping(value = "webUserForm")
	public String webUserForm(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/web/webPanel/webUserForm";
	}
	@RequestMapping(value = "webUserPs")
	public String webUserPs(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/web/webPanel/webUserPs";
	}
	@RequestMapping(value = "newsDetail")
	public String newsDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/web/webPanel/newsDetail";
	}

}