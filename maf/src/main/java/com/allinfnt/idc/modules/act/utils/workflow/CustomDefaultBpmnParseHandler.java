/*
 *  Copyright 2012, ALLINFNT Co., Ltd.  All right reserved.
 *
 *  THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF ALLINFNT CO.,
 *  LTD.  THE CONTENTS OF THIS FILE MAY NOT BE DISCLOSED TO THIRD
 *  PARTIES, COPIED OR DUPLICATED IN ANY FORM, IN WHOLE OR IN PART,
 *  WITHOUT THE PRIOR WRITTEN PERMISSION OF ALLINFNT CO., LTD
 *
 *  Module Name:CustomDefaultBpmnParseHandlers.java,v 1.0 2015-3-22 Created by 廖鹏
 *
 *  Edit History:
 *
 *  2015-3-22 Created by 廖鹏
 */
package com.allinfnt.idc.modules.act.utils.workflow;

import org.activiti.bpmn.model.ActivitiListener;
import org.activiti.bpmn.model.ImplementationType;
import org.activiti.bpmn.model.UserTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.impl.bpmn.parser.BpmnParse;
import org.activiti.engine.impl.bpmn.parser.handler.UserTaskParseHandler;
import org.activiti.engine.impl.task.TaskDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author 廖鹏
 * 
 */
public class CustomDefaultBpmnParseHandler extends UserTaskParseHandler {
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	protected void executeParse(BpmnParse bpmnParse, UserTask userTask) {
		logger.info("bpmnParse : {}, userTask : {}", bpmnParse, userTask);
		super.executeParse(bpmnParse, userTask);

		TaskDefinition taskDefinition = (TaskDefinition) bpmnParse
				.getCurrentActivity().getProperty(PROPERTY_TASK_DEFINITION);

		//任务委托
		ActivitiListener activitiDelegateListener = new ActivitiListener();
		activitiDelegateListener.setEvent(TaskListener.EVENTNAME_CREATE);
		activitiDelegateListener
				.setImplementationType(ImplementationType.IMPLEMENTATION_TYPE_CLASS);
		activitiDelegateListener.setImplementation(DelegateTaskListener.class.getName());
		taskDefinition.addTaskListener(
				TaskListener.EVENTNAME_CREATE,
				bpmnParse.getListenerFactory().createClassDelegateTaskListener(
						activitiDelegateListener));
		
		
		// 任务创建时给任务处理人通知
		ActivitiListener activitiListener = new ActivitiListener();
		activitiListener.setEvent(TaskListener.EVENTNAME_CREATE);
		activitiListener
				.setImplementationType(ImplementationType.IMPLEMENTATION_TYPE_CLASS);
		activitiListener.setImplementation(GlobalTaskListener.class.getName());
		taskDefinition.addTaskListener(
				TaskListener.EVENTNAME_CREATE,
				bpmnParse.getListenerFactory().createClassDelegateTaskListener(
						activitiListener));

		// 任务完成时给任务发起人
		ActivitiListener activitiComplateListener = new ActivitiListener();
		activitiComplateListener.setEvent(TaskListener.EVENTNAME_COMPLETE);
		activitiComplateListener
				.setImplementationType(ImplementationType.IMPLEMENTATION_TYPE_CLASS);
		activitiComplateListener
				.setImplementation(GlobalTaskCompleteListener.class.getName());
		taskDefinition.addTaskListener(
				TaskListener.EVENTNAME_COMPLETE,
				bpmnParse.getListenerFactory().createClassDelegateTaskListener(
						activitiComplateListener));
	}

}
