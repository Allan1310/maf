/**
 * Copyright &copy; 2012-2015 <a href="https://www.allinfnt.com">allinfnt.com</a> All rights reserved.
 */
package com.allinfnt.idc.modules.msg.web;

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
import com.allinfnt.idc.modules.msg.entity.Msginfo;
import com.allinfnt.idc.modules.msg.service.MsginfoService;

/**
 * 消息管理Controller
 * 
 * @author Peng
 * @version 2015-03-11
 */
@Controller
@RequestMapping(value = "${adminPath}/msg/msgMsginfo")
public class MsginfoController extends BaseController {

	@Autowired
	private MsginfoService msgMsginfoService;

	@ModelAttribute
	public Msginfo get(@RequestParam(required = false) String id) {
		Msginfo entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = msgMsginfoService.get(id);
		}
		if (entity == null) {
			entity = new Msginfo();
		}
		return entity;
	}

	@RequiresPermissions("msg:msgMsginfo:view")
	@RequestMapping(value = { "list", "" })
	public String list(Msginfo msgMsginfo, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Msginfo> page = msgMsginfoService.findPage(new Page<Msginfo>(
				request, response), msgMsginfo);
		model.addAttribute("page", page);
		return "modules/msg/MsginfoList";
	}

	/**
	 * 获取通知列表
	 * 
	 * @param msgMsginfo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "self")
	public String selfList(Msginfo msgMsginfo, HttpServletRequest request,
			HttpServletResponse response, Model model, String receiverId) {
		Page<Msginfo> page = msgMsginfoService.findByreceiverId(
				new Page<Msginfo>(request, response), msgMsginfo);
		model.addAttribute("page", page);
		return "modules/msg/MsginfoList";
	}

	@RequiresPermissions("msg:msgMsginfo:view")
	@RequestMapping(value = "form")
	public String form(Msginfo msgMsginfo, Model model) {
		if (msgMsginfo.getMsgType() != null) {
			if (msgMsginfo.getMsgType().equals("2")) {
				String msgmessage = msgMsginfo.getMessage();
				int index = msgmessage.indexOf("<body>");
				if (index >= 0) {
					String formsg = msgMsginfo.getMessage().substring(
							msgmessage.indexOf("<body>") + 6,
							msgmessage.lastIndexOf("</body>"));
					msgMsginfo.setMessage(formsg);
				} else {
					msgMsginfo.setReadFlag("4");
				}
			}
		}
		model.addAttribute("msgMsginfo", msgMsginfo);
		return "modules/msg/MsginfoForm";
	}

	/**
	 * 消息添加
	 * 
	 * @param msginfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("msg:msgMsginfo:edit")
	@RequestMapping(value = "save")
	public String save(Msginfo msginfo, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, msginfo)) {
			return form(msginfo, model);
		}

		msginfo.setSendMode("0");// 系统是0，用户个人是1
		msginfo.setSenderId("1");

		if (msginfo.getSendName() == null || msginfo.getSendName().equals("")) {
			msginfo.setSendName(msginfo.getCurrentUser().getName());
		} else {
			msginfo.setSendName(msginfo.getSendName());
		}
		msginfo.setReadFlag("0");// 0标识未读信息，1标识已读信息，仅限于站内信
		int reindex = msginfo.getReceiverId().indexOf(",");
		if (reindex >= 0) {
			String reid[] = msginfo.getReceiverId().split(",");
			for (int i = 0; i < reid.length; i++) {
				msginfo.setReceiverId(reid[i].trim());
			}
		}
		int reNameindex = msginfo.getReceiverName().indexOf(",");
		if (reNameindex >= 0) {
			String reName[] = msginfo.getReceiverName().split(",");
			for (int i = 0; i < reName.length; i++) {
				msginfo.setReceiverName(reName[i].trim());
			}
		}
		if (msginfo.getMsgType() != null && msginfo.getMsgType().equals("4")) {
			msgMsginfoService.letter(msginfo);
		} else {
			msginfo.setBackFlag("0");// 未发送为0，已发送是1
		}
		msgMsginfoService.save(msginfo);
		// msgMsginfoService.sendMsg(msginfo);
		addMessage(redirectAttributes, "消息保存成功");
		return "redirect:" + Global.getAdminPath() + "/msg/msgMsginfo/?repage";
	}

	@RequiresPermissions("msg:msgMsginfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Msginfo msgMsginfo,
			RedirectAttributes redirectAttributes) {
		msgMsginfoService.delete(msgMsginfo);
		addMessage(redirectAttributes, "消息删除成功");
		return "redirect:" + Global.getAdminPath() + "/msg/msgMsginfo/?repage";
	}

	@RequiresPermissions("msg:msgMsginfo:edit")
	@RequestMapping(value = "cancel")
	public String cancel(Msginfo msgMsginfo,
			RedirectAttributes redirectAttributes) {
		if (msgMsginfo.getBackFlag().equals("0")) {
			msgMsginfo.setBackFlag("4");
			msgMsginfoService.save(msgMsginfo);
			addMessage(redirectAttributes, "消息取消发送成功");
		} else {
			addMessage(redirectAttributes, "消息取消发送失败");
		}

		return "redirect:" + Global.getAdminPath() + "/msg/msgMsginfo/?repage";
	}

	/**
	 * 获取我的通知数目
	 */
	@RequestMapping(value = "self/count")
	@ResponseBody
	public String selfCount(String receiverId) {
		return String.valueOf(msgMsginfoService.findCount(receiverId));
	}

	/**
	 * 系统首页列表显示
	 */
	@RequiresPermissions("msg:msgMsginfo:view")
	@RequestMapping(value = { "msgList" })
	public String msgList(Msginfo msgMsginfo, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Msginfo> msgpage = msgMsginfoService.findPage(new Page<Msginfo>(
				request, response), msgMsginfo);
		model.addAttribute("msgpage", msgpage);
		return "modules/msg/MsginfoList_Index";
	}
}