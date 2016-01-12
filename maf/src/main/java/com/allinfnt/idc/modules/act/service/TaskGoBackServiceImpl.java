package com.allinfnt.idc.modules.act.service;

import java.util.Map;

import org.activiti.engine.impl.ServiceImpl;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TaskGoBackServiceImpl extends ServiceImpl implements TaskGoBackService{

	@Autowired
	private SpringProcessEngineConfiguration processEngineConfiguration;
	
	@Override
	public void complete(String taskId, Map<String, Object> variables,String toTaskKey,String type) {
		this.setCommandExecutor(processEngineConfiguration.getCommandExecutor());
		this.commandExecutor.execute(new TaskCommitCmd(taskId,toTaskKey,type,variables));
		
	}

}



interface TaskGoBackService{
	
	/**
	 * 回退到流程上一节点、跳转到任意节点
	 * @param taskId 当前节点实例ID
	 * @param variables 参数
	 * @param toTaskKey 回退节点ID
	 */
	public abstract void complete(String taskId,Map<String, Object> variables,String toTaskKey,String type);
}