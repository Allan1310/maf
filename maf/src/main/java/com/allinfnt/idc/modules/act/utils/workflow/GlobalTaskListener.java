package com.allinfnt.idc.modules.act.utils.workflow;

import java.util.List;
import java.util.Map;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.IdentityLinkEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.IdentityLinkType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.msg.entity.Msginfo;
import com.allinfnt.idc.modules.msg.service.MailService;
import com.allinfnt.idc.modules.msg.service.MsginfoService;
import com.allinfnt.idc.modules.sys.entity.Role;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SystemService;
import com.google.common.base.Strings;
import com.google.common.collect.Maps;

public class GlobalTaskListener implements TaskListener {

	private static final long serialVersionUID = 2395786011013434767L;

	protected Logger logger = LoggerFactory.getLogger(getClass());

	private final SystemService systemService = SpringContextHolder.getBean("systemService");

	@Autowired
	private MailService mailService;
	@Autowired
	private MsginfoService msginfoService;
	@Autowired
	private ActTaskService actTaskService;

	/*
	 * {@inheritDoc}
	 */
	@Override
	public void notify(DelegateTask delegateTask) {
		TaskEntity task = (TaskEntity) delegateTask;

		String assignee = task.getAssignee();
		List<IdentityLinkEntity> identityLinks = task.getIdentityLinks();

		String flowName = Context.getProcessEngineConfiguration()
				.getRepositoryService().createProcessDefinitionQuery()
				.processDefinitionId(task.getProcessDefinitionId())
				.singleResult().getName();

		String title = "工作提醒：【" + flowName + "-" + task.getName() + "】需要您来处理";


		if (assignee != null && assignee.length() > 0) {
			User user = systemService.getUserByLoginName(assignee);
			sendNotifyMessage(user, title, task);
		}

		for (IdentityLinkEntity link : identityLinks) {
			if (link.getType().equals(IdentityLinkType.CANDIDATE)) {
				if (link.isUser()) {
					User user = systemService.getUser(link.getUserId());
					if (user != null) {// 判断下用户不为空
						sendNotifyMessage(user, title, task);
					}
				}
				if (link.isGroup()) {
					
					Role role = systemService.getRoleByEnname(link.getGroupId());
					List<User> users = systemService.findUserByRoleId(role.getId());
					for (User user : users) {
						sendNotifyMessage(user, title, task);
					}
				}
			}
		}

		// CANDIDATE为唯一用户的，自动签收。
		User uniqueCANDIDATE = null;
		int candidateNum = 0;
		for (IdentityLinkEntity link : identityLinks) {
			if (link.getType().equals(IdentityLinkType.CANDIDATE)) {
				if (link.isUser()) {
					/**
					 * User user = Context.getProcessEngineConfiguration()
					 * .getIdentityService().createUserQuery()
					 * .userId(link.getUserId()).singleResult();
					 **/
					User user = systemService.getUser(link.getUserId());

					if (user != null) {// 判断下用户不为空,发送邮件通知
						uniqueCANDIDATE = user;
						candidateNum++;
					}

				}
			}
		}
		if (candidateNum == 1) {// 如果candidate为一，直接assign
			task.setAssignee(uniqueCANDIDATE.getId() + "");
		}

	}

	/**
	 * @param variables
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String getMessage(TaskEntity task) {
		
		if (actTaskService == null) {
			actTaskService = SpringContextHolder.getBean("actTaskService");
		}
		
		// 获取流程XML上的表单KEY
		String formKey = actTaskService.getFormKey(task.getProcessDefinitionId(),task.getTaskDefinitionKey());
				
		StringBuffer message = new StringBuffer("");
		message.append("有一项工作需要您来处理：");
		message.append("<a href='" + StringUtils.getHost() + "/");
		message.append(formKey);
		message.append("?id=");
		String[] busKeyStrs = task.getProcessInstance().getBusinessKey()
				.split("_");
		message.append(busKeyStrs[0]);
		message.append("&taskid=");
		message.append(task.getId());
		message.append("&tkey=");
		message.append(task.getTaskDefinitionKey());

		message.append("&category=inbox\'>");
		message.append(task.getName());
		message.append("</a></br></br>");

		Map<String, Object> datamap = (Map<String, Object>) task.getVariable("datamap");
		
		if (datamap == null) {
			List<HistoricVariableInstance> listVariables = Context
					.getProcessEngineConfiguration().getHistoryService()
					.createHistoricVariableInstanceQuery()
					.processInstanceId(task.getProcessInstanceId()).list();
			for (HistoricVariableInstance v : listVariables) {
				if (v.getVariableName().equalsIgnoreCase("datamap")) {
					datamap = (Map<String, Object>) v.getValue();
					break;
				}
			}
		}
		if (datamap != null) {

			message.append("<table >");
			for (String key : datamap.keySet()) {
				message.append("<tr>");
				message.append("<td><b>" + key + "</b></td>");
				message.append("<td>" + datamap.get(key) + "</td>");
				message.append("</tr>");
			}
			message.append("</table><br/>");

		}

		return message.toString();
	}

	/**
	 * @param variables
	 * @return
	 */
	@SuppressWarnings("unused")
	private String getMessageUrl(TaskEntity task, String weixinId) {
		return weixinId;
	}

	/**
	 * 发送消息.
	 * 
	 */
	private void sendNotifyMessage(User user, String title, TaskEntity task) {
		String message = getMessage(task);
		if (msginfoService == null) {
			msginfoService = SpringContextHolder.getBean("msginfoService");
		}
		
		if (mailService == null) {
			mailService = SpringContextHolder.getBean("mailService");
		}
		
		if (Strings.isNullOrEmpty(user.getEmail())) {
			return;
		}
		try {
			Map<String, String> map = Maps.newHashMap();
			map.put("subject", title);
			map.put("template", "mailBmpTemplate.ftl");
			map.put("mailTo", user.getEmail());
			map.put("userName", user.getName());
			map.put("message", message);
			map.put("sendEmail", "true");
			
			String mailMsg = mailService.generateContent(map);
			Msginfo msgInfo = new Msginfo();
			msgInfo.setMsgType("2");//邮件
			msgInfo.setReceiverId(user.getEmail());
			msgInfo.setMsgTitle(title);
			msgInfo.setMessage(mailMsg);
			msgInfo.setReceiverName(user.getName());
			
			//邮件发送
			msginfoService.sendMsg(msgInfo);
			sendNotifyWeixinMessage(user, title, task);
		} catch (Exception e) {
			logger.error("邮件发送失败", e);
		}

	}

	private void sendNotifyWeixinMessage(User user, String title,TaskEntity task) {
		
		try {
			Msginfo msgInfo = new Msginfo();
			msgInfo.setMsgType("3");
			msgInfo.setReceiverId(user.getLoginName());
			msgInfo.setReceiverName(user.getName());
			msgInfo.setMessage(title);
			msginfoService.sendMsg(msgInfo);
		} catch (Exception e) {
			logger.error("微信消息发送失败", e);
		}

	}
}
