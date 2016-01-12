/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.indexdef.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.allinfnt.idc.modules.act.entity.Act;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.indexdef.entity.BcmMenu;
import com.allinfnt.idc.modules.indexdef.entity.BcmMenuData;
import com.allinfnt.idc.modules.indexdef.service.BcmMenuService;
import com.allinfnt.idc.modules.indexdefuser.entity.BcmMenuUser;
import com.allinfnt.idc.modules.indexdefuser.service.BcmMenuUserService;
import com.allinfnt.idc.modules.sys.dao.MenuDao;
import com.allinfnt.idc.modules.sys.entity.Menu;
import com.allinfnt.idc.modules.sys.entity.Office;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SystemService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;

/**
 * 首页自定义配置Controller
 * 
 * @author zx
 * @version 2015-03-25
 */
@Controller
@RequestMapping(value = "${adminPath}/indexdef/bcmMenu")
public class BcmMenuController extends BaseController {

	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private BcmMenuService bcmMenuService;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private BcmMenuUserService bcmMenuUserService;
	@Autowired
	private SystemService systemService;

	@ModelAttribute
	public BcmMenu get(@RequestParam(required = false) String id) {
		BcmMenu entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = bcmMenuService.get(id);
		}
		if (entity == null) {
			entity = new BcmMenu();
		}
		return entity;
	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = { "list", "" })
	public String list(BcmMenu bcmMenu, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<BcmMenu> page = bcmMenuService.findPage(new Page<BcmMenu>(request,
				response), bcmMenu);
		model.addAttribute("page", page);
		return "modules/indexdef/bcmMenuList";
	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "form")
	public String form(BcmMenu bcmMenu, Model model) {
		Menu menu = new Menu();

		BcmMenu bcmMenu_ = new BcmMenu();
		menu.setRemarks("to_index");
		List<Menu> menuList = menuDao.findListBymarks(menu);
		if (bcmMenu != null && bcmMenu.getId() != null) {
			List<BcmMenu> eidtMwnuList = bcmMenuService.findList(bcmMenu);
			for (int m = 0; m < menuList.size(); m++) {
				for (int n = 0; n < eidtMwnuList.size(); n++) {
					if (menuList.get(m).getId()
							.equals(eidtMwnuList.get(n).getMenuId())) {
						menu = menuList.get(m);
					}
				}
			}

		}
		List<BcmMenu> newMwnuList = bcmMenuService.findList(bcmMenu_);
		List<Menu> menuListNow = new ArrayList<Menu>();
		for (int i = 0; i < menuList.size(); i++) {
			boolean containbol = true;
			for (int j = newMwnuList.size() - 1; j >= 0; j--) {
				if (menuList.get(i).getId()
						.equals(newMwnuList.get(j).getMenuId())) {
					containbol = false;
					break;
				}
			}
			if (containbol) {
				menuListNow.add(menuList.get(i));
			}
		}
		if (bcmMenu != null && bcmMenu.getId() != null) {
			menuListNow.add(menu);
		}
		model.addAttribute("menuList", menuListNow);
		model.addAttribute("bcmMenu", bcmMenu);
		return "modules/indexdef/bcmMenuForm";
	};

	@RequiresPermissions("indexdef:bcmMenu:edit")
	@RequestMapping(value = "save")
	public String save(BcmMenu bcmMenu, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bcmMenu)) {
			return form(bcmMenu, model);
		}
		bcmMenuService.save(bcmMenu);
		addMessage(redirectAttributes, "保存首页自定义配置成功");
		return "redirect:" + Global.getAdminPath()
				+ "/indexdef/bcmMenu/?repage";
	}

	@RequiresPermissions("indexdef:bcmMenu:edit")
	@RequestMapping(value = "delete")
	public String delete(BcmMenu bcmMenu, RedirectAttributes redirectAttributes) {
		bcmMenuService.delete(bcmMenu);
		BcmMenuUser bcmMenuUser = new BcmMenuUser();
		bcmMenuUser.setMenuId(bcmMenu.getMenuId());
		bcmMenuUserService.deleteMenu(bcmMenuUser);
		addMessage(redirectAttributes, "删除首页自定义配置成功");
		return "redirect:" + Global.getAdminPath()
				+ "/indexdef/bcmMenu/?repage";
	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "linkurldata")
	@ResponseBody
	public String linkurldata(BcmMenu bcmMenu, String menuId,
			RedirectAttributes redirectAttributes) {
		Menu menu = menuDao.get(menuId);
		String linkurl = menu.getHref();
		return linkurl;
	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "indexdata")
	public String indexdata(BcmMenu bcmMenu, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.get(UserUtils.getPrincipal().getId());
		List<Menu> menuList = new ArrayList<Menu>();
		if (user.isAdmin()) {
			Menu m = new Menu();
			m.setRemarks("to_index");
			menuList = menuDao.findAllList(m);
		} else {
			Menu m = new Menu();
			m.setUserId(user.getId());
			m.setRemarks("to_index");
			menuList = menuDao.findByUserId(m);
		}
		if (menuList.size() > 0)
			return "modules/indexdefuser/index";
		else
			return "modules/indexdefuser/index_empty";

	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "listData")
	@ResponseBody
	public List<List<BcmMenuData>> listData(BcmMenu bcmMenu,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<List<BcmMenuData>> menuLists = new ArrayList<List<BcmMenuData>>();
		User user = UserUtils.get(UserUtils.getPrincipal().getId());
		List<Menu> menuList = null;
		List<BcmMenuData> newMenuList = new ArrayList<BcmMenuData>();
		List<BcmMenuData> oldMenuList = new ArrayList<BcmMenuData>();
		if (user.isAdmin()) {
			Menu m = new Menu();
			m.setRemarks("to_index");
			menuList = menuDao.findAllList(m);
		} else {
			Menu m = new Menu();
			m.setUserId(user.getId());
			m.setRemarks("to_index");
			menuList = menuDao.findByUserId(m);
		}
		BcmMenuUser bcmMenuUser = new BcmMenuUser();
		bcmMenuUser.setUser(user);
		List<BcmMenuUser> menuUserList = bcmMenuUserService
				.findList(bcmMenuUser);
		List<BcmMenu> bcmMenuList = bcmMenuService.findList(bcmMenu);

		for (int i = 0; i < menuList.size(); i++) {
			for (int j = 0; j < bcmMenuList.size(); j++) {
				if (menuList.get(i).getId()
						.equals(bcmMenuList.get(j).getMenuId())) {
					BcmMenuData bcmMenuData = new BcmMenuData();
					bcmMenuData.setId(bcmMenuList.get(j).getMenuId());
					bcmMenuData.setTitle(menuList.get(i).getName());
					bcmMenuData.setUrl(menuList.get(i).getHref());
					bcmMenuData.setMenuCloseType(bcmMenuList.get(j)
							.getMenuCloseType());
					bcmMenuData.setMenuExpandType(bcmMenuList.get(j)
							.getMenuExpandType());
					bcmMenuData.setMenuHideType(bcmMenuList.get(j)
							.getMenuHideType());
					bcmMenuData.setMenuReloadType(bcmMenuList.get(j)
							.getMenuReloadType());
					bcmMenuData.setMenuShowType(bcmMenuList.get(j)
							.getMenuShowType());
					bcmMenuData.setMenuShow(bcmMenuList.get(j).getMenuShow());
					bcmMenuData.setModelColor(bcmMenuList.get(j)
							.getModelColor());
					newMenuList.add(bcmMenuData);
				}

			}
		}
		for (int n = 0; n < menuUserList.size(); n++) {
			for (int m = 0; m < menuList.size(); m++) {
				if (menuList.get(m).getId()
						.equals(menuUserList.get(n).getMenuId())) {
					BcmMenuData bcmMenuData_ = new BcmMenuData();
					bcmMenuData_.setId(menuUserList.get(n).getMenuId());
					bcmMenuData_.setTitle(menuList.get(m).getName());
					bcmMenuData_.setUrl(menuList.get(m).getHref());
					bcmMenuData_.setMenuCloseType(menuUserList.get(n)
							.getMenuCloseType());
					bcmMenuData_.setMenuExpandType(menuUserList.get(n)
							.getMenuExpandType());
					bcmMenuData_.setMenuHideType(menuUserList.get(n)
							.getMenuHideType());
					bcmMenuData_.setMenuReloadType(menuUserList.get(n)
							.getMenuReloadType());
					bcmMenuData_.setMenuShowType(menuUserList.get(n)
							.getMenuShowType());
					bcmMenuData_.setMenuShow(menuUserList.get(n).getMenuShow());
					bcmMenuData_.setColumnType(menuUserList.get(n)
							.getColumnType());
					bcmMenuData_.setRowType(menuUserList.get(n).getRowType());
					bcmMenuData_.setModelColor(menuUserList.get(n)
							.getModelColor());
					oldMenuList.add(bcmMenuData_);
				}

			}
		}
		menuLists.add(newMenuList);
		menuLists.add(oldMenuList);
		return menuLists;

	}

	@RequiresPermissions("indexdef:bcmMenu:edit")
	@RequestMapping(value = "saveData")
	@ResponseBody
	public void saveData(BcmMenu bcmMenu, String types, Model model,
			RedirectAttributes redirectAttributes) {
		User user = UserUtils.getUser();
		BcmMenuUser bcmMenuUser_ = new BcmMenuUser();
		bcmMenuUser_.setUser(user);
		bcmMenuUserService.delete(bcmMenuUser_);
		String[] typesArr = types.split(",");
		for (int i = 0; i < typesArr.length; i++) {
			BcmMenuUser bcmMenuUser = new BcmMenuUser();
			bcmMenuUser.setColumnType(typesArr[i].split(";")[1]);
			bcmMenuUser.setMenuId(typesArr[i].split(";")[0]);
			bcmMenuUser.setRowType(typesArr[i].split(";")[2]);
			bcmMenuUser.setModelColor(typesArr[i].split(";")[3]);
			bcmMenuUser.setUser(user);
			bcmMenuUserService.save(bcmMenuUser);
		}

	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "hashBordTest")
	public String hashBordTest(BcmMenu bcmMenu, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<BcmMenu> page = bcmMenuService.findPage(new Page<BcmMenu>(request,
				response), bcmMenu);
		model.addAttribute("page", page);
		return "modules/indexdef/hashBordTest";
	}

	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = "todoList")
	public String todoList(Act act, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Act> list = actTaskService.todoList(act);
		model.addAttribute("list", list);
		return "modules/indexdef/todoList";
	}

	/**
	 * 通信录，首页列表
	 * 
	 * @throws UnsupportedEncodingException
	 */
	@RequiresPermissions("indexdef:bcmMenu:view")
	@RequestMapping(value = { "userlist" })
	public String userList(String name, String offid,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws UnsupportedEncodingException {
		String view = "modules/indexdef";
		List<User> list = new ArrayList<User>();
		User user = new User();
		if (name != null && name != "") {
			if (offid != null && offid != "") {
				user.setName(name);
				Office off = new Office();
				off.setId(offid);
				user.setOffice(off);
				list = bcmMenuService.findUserinfo(user);
				model.addAttribute("list", list);
				return view + "/userList_Index";
			} else {
				user.setName(name);
				list = bcmMenuService.getUserName(user);
				if (list.size() == 0) {
					user.setMobile(Global.getConfig("company.fax"));
					user.setEmail(Global.getConfig("company.email"));
					user.setPhone(Global.getConfig("company.phone"));
					user.setName(Global.getConfig("company.address"));
					user.setNo("1");
					list.add(user);
					model.addAttribute("list", list);
					return view + "/userList_Index";
				} else if (list.size() == 1) {
					model.addAttribute("list", list);
					return view + "/userList_Index";
				} else if (list.size() > 1) {
					model.addAttribute("Ulist", list);
					return view + "/userList_Index_two";
				}
			}
		} else {
			user.setMobile(Global.getConfig("company.fax"));
			user.setEmail(Global.getConfig("company.email"));
			user.setPhone(Global.getConfig("company.phone"));
			user.setName(Global.getConfig("company.address"));
			user.setNo("1");
			list.add(user);
			model.addAttribute("list", list);
			return view + "/userList_Index";
		}
		return view;
	}
}