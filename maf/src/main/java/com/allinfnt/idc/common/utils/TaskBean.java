package com.allinfnt.idc.common.utils;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;

import com.allinfnt.idc.modules.act.entity.IdcTaskHasten;

public class TaskBean {
	private Task task;
	private HistoricTaskInstance hisTask;
	private ProcessDefinition processDefinition;
	private HistoricProcessInstance historicProcessInstance;

	private String key;

	private String flag = "0";

	/**
	 * @param key
	 *            the key to set
	 */
	public void setKey(String key) {
		this.key = key;
	}

	private String processInstanceId;
	private String executionId;

	private String title;
	private String url;
	private Long applyId;
	private String applyName;

	private IdcTaskHasten hastenTask;

	/**
	 * @return the task
	 */
	public Task getTask() {
		return task;
	}

	/**
	 * @param task
	 *            the task to set
	 */
	public void setTask(Task task) {
		this.task = task;
	}

	/**
	 * @return the hisTask
	 */
	public HistoricTaskInstance getHisTask() {
		return hisTask;
	}

	/**
	 * @param hisTask
	 *            the hisTask to set
	 */
	public void setHisTask(HistoricTaskInstance hisTask) {
		this.hisTask = hisTask;
	}

	/**
	 * @return the processDefinition
	 */
	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}

	/**
	 * @param processDefinition
	 *            the processDefinition to set
	 */
	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}

	/**
	 * @return the processInstanceId
	 */
	public String getProcessInstanceId() {
		if (task != null) {
			return task.getProcessInstanceId();
		}
		if (hisTask != null) {
			return hisTask.getProcessInstanceId();
		}
		if (historicProcessInstance != null) {
			return historicProcessInstance.getId();
		}
		return processInstanceId;
	}

	/**
	 * @return the executionId
	 */
	public String getExecutionId() {
		if (task != null) {
			return task.getExecutionId();
		}
		if (hisTask != null) {
			return hisTask.getExecutionId();
		}
		if (historicProcessInstance != null) {
			return historicProcessInstance.getId();
		}
		return executionId;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title
	 *            the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url
	 *            the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the applyId
	 */
	public Long getApplyId() {
		return applyId;
	}

	/**
	 * @param applyId
	 *            the applyId to set
	 */
	public void setApplyId(Long applyId) {
		this.applyId = applyId;
	}

	/**
	 * @return the applyName
	 */
	public String getApplyName() {
		return applyName;
	}

	/**
	 * @param applyName
	 *            the applyName to set
	 */
	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	/**
	 * @return the key
	 */
	public String getKey() {
		if (processDefinition != null) {
			return processDefinition.getKey();
		}
		return key;
	}

	/**
	 * @return the historicProcessInstance
	 */
	public HistoricProcessInstance getHistoricProcessInstance() {
		return historicProcessInstance;
	}

	/**
	 * @param historicProcessInstance
	 *            the historicProcessInstance to set
	 */
	public void setHistoricProcessInstance(
			HistoricProcessInstance historicProcessInstance) {
		this.historicProcessInstance = historicProcessInstance;
	}

	/**
	 * @return the hastenTask
	 */
	public IdcTaskHasten getHastenTask() {
		return hastenTask;
	}

	/**
	 * @param hastenTask
	 *            the hastenTask to set
	 */
	public void setHastenTask(IdcTaskHasten hastenTask) {
		this.hastenTask = hastenTask;
	}

	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag
	 *            the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

}
