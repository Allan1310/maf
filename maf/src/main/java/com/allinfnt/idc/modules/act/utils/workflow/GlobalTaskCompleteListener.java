package com.allinfnt.idc.modules.act.utils.workflow;

import java.util.List;
import java.util.Map;

import org.activiti.engine.RepositoryService;
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

import com.allinfnt.idc.common.enums.OaPositionEnums;
import com.allinfnt.idc.common.utils.SpringContextHolder;
import com.allinfnt.idc.common.utils.StringUtils;
import com.allinfnt.idc.modules.act.service.ActTaskService;
import com.allinfnt.idc.modules.msg.entity.Msginfo;
import com.allinfnt.idc.modules.msg.service.MailService;
import com.allinfnt.idc.modules.msg.service.MsginfoService;
import com.allinfnt.idc.modules.sys.entity.Role;
import com.allinfnt.idc.modules.sys.entity.User;
import com.allinfnt.idc.modules.sys.service.SystemService;
import com.allinfnt.idc.modules.sys.utils.UserUtils;
import com.google.common.base.Strings;
import com.google.common.collect.Maps;

public class GlobalTaskCompleteListener implements TaskListener {

	private static final long serialVersionUID = 2395786011013434767L;

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private MailService mailService;
	@Autowired
	private MsginfoService msginfoService;

	private final SystemService systemService = SpringContextHolder.getBean("systemService");

	private ActTaskService actTaskService;
	@Autowired
	protected RepositoryService repositoryService;

	/*
	 * {@inheritDoc}
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void notify(DelegateTask delegateTask) {
		TaskEntity task = (TaskEntity) delegateTask;
		String assignee = task.getAssignee();
		List<IdentityLinkEntity> identityLinks = task.getIdentityLinks();

		String flowName = Context.getProcessEngineConfiguration()
				.getRepositoryService().createProcessDefinitionQuery()
				.processDefinitionId(task.getProcessDefinitionId())
				.singleResult().getName();
		String title = "工作追踪：【" + flowName + "-" + task.getName()+ "】状态已经改变，请悉知";

		String ownerid = (String) task.getVariable("applyUserId");
		if (ownerid == null) {
			return;
		}
		User owner = systemService.getUserByLoginName(ownerid);
		sendNotifyMessage(owner, title, getMessage(task));

		if (task.getTaskDefinitionKey().equalsIgnoreCase("departLeaderAudit")) {
			List<User> depdepartLeaderList = systemService.findByPosition(owner
					.getOffice().getId(), OaPositionEnums.POSITION_BMLD.getCode());
			
			if (depdepartLeaderList != null && depdepartLeaderList.size() > 1) {
				for (User u : depdepartLeaderList) {
					if (assignee != u.getId()) {
						sendNotifyMessage(u, title, getMessage(task));
					}
				}
			}
		} else if (task.getTaskDefinitionKey().equalsIgnoreCase("signDeptAudit")) {
			// 驳回通知部门领导和会签人员
			boolean isOk = (Boolean) task.getVariable("signDeptAuditPass");
			if (!isOk) {
				User auditUser = systemService.getUser(assignee);
				title = "工作追踪：【" + flowName + "-" + task.getName() + "】已被"
						+ auditUser.getOffice().getName() + "驳回，请悉知";
				List<String> signDeptList = (List<String>) task.getVariable("signDeptList");
				signDeptList.remove(assignee);
				List<User> depdepartLeaderList = systemService.findByPosition(
						owner.getOffice().getId(),OaPositionEnums.POSITION_BMLD.getCode());
				for (String id : signDeptList) {
					depdepartLeaderList.add(systemService.getUser(id));
				}
				for (User u : depdepartLeaderList) {
					sendNotifyMessage(u, title, getMessage(task));
				}
			}

		}

		// 邮件通知其它办理人
		for (IdentityLinkEntity link : identityLinks) {
			if (link.getType().equals(IdentityLinkType.CANDIDATE)) {
				if (link.isUser()) {
					User user = org.apache.commons.lang.StringUtils
							.isNotBlank(link.getUserId()) ? systemService
							.getUser(link.getUserId()) : null;
					if (user != null&& user.getId() != UserUtils.getUser().getId()) {// 判断是别的用户，发提示邮件
						sendNotifyMessage(user, title, getMessage(task));
					}
				}
				if (link.isGroup()) {
					Role role = systemService.getRoleByEnname(link.getGroupId());
					List<User> users = systemService.findUserByRoleId(role.getId());
					for (User u : users) {
						User user = systemService.getUser(u.getId());
						if (user.getId() != UserUtils.getUser().getId()) {// 如果不是自己，发邮件。
							sendNotifyMessage(user, title, getMessage(task));
						}
					}

				}
			}
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
		
		StringBuffer message = new StringBuffer("");
		// 获取流程XML上的表单KEY
		String formKey = actTaskService.getFormKey(task.getProcessDefinitionId(),task.getTaskDefinitionKey());
				
		message.append("有一项工作状态已经变化，请悉知，【" + task.getName() + "】"+ UserUtils.getByLoginName(task.getAssignee()).getName()+ "已经处理，");
		message.append("<a href='" + StringUtils.getHost() + "/");
		message.append(formKey);
		message.append("?id=");
		String[] busKeyStrs = task.getProcessInstance().getBusinessKey()
				.split("_");
		message.append(busKeyStrs[0]);
		message.append("&taskid=");
		message.append(task.getId());
		message.append("&tkey=view");
		message.append("&category=inbox\'>");
		message.append("查看详情");
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
		message.append("<table >");
		if (datamap != null) {
			for (String key : datamap.keySet()) {
				message.append("<tr>");
				message.append("<td style='text-align:right;' ><b>" + key
						+ "</b></td>");
				message.append("<td style='text-align:left;'>"
						+ datamap.get(key) + "</td>");
				message.append("</tr>");
			}
		}
		message.append("</table><br/>");

		return message.toString();
	}

	/**
	 * 发送消息.
	 * 
	 */
	private void sendNotifyMessage(User user, String title, String message) {
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
			msgInfo.setReceiverId(systemService.getUser(user.getId()).getEmail());
			msgInfo.setMsgTitle(title);
			msgInfo.setMessage(mailMsg);
			msgInfo.setReceiverName(user.getName());
			
			//邮件发送
			msginfoService.sendMsg(msgInfo);
			//微信发送
			sendNotifyWeixinMessage(user,title);
		} catch (Exception e) {
			logger.error("消息发送失败", e);
		}
	}
	
	private void sendNotifyWeixinMessage(User user, String title) {
		
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
