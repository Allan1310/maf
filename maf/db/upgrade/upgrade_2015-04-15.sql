INSERT INTO `sys_menu` VALUES ('index_9', 'index_2', '0,1,27,28,index_9,', '代办任务', '20', '/indexdef/bcmMenu/todoList', '', '', '0', 'indexdef:bcmMenu:view', '1', '2015-04-14 17:33:09', '1', '2015-04-14 17:33:09', 'to_index', '0');



INSERT INTO sys_menu VALUES ('cm_116', 'cm_15', '0,1,cm_1,cm_3,cm_15,', '查询', 30, '', '', '', '0', 'cm:cmGraphIcon:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_117', 'cm_15', '0,1,cm_1,cm_3,cm_15,', '修改', 30, '', '', '', '0', 'cm:cmGraphIcon:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_114', 'cm_14', '0,1,cm_1,cm_3,cm_14,', '查询', 30, '', '', '', '0', 'sys:dict:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_115', 'cm_14', '0,1,cm_1,cm_3,cm_14,', '修改', 30, '', '', '', '0', 'sys:dict:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');

INSERT INTO sys_menu VALUES ('cm_110', 'cm_10', '0,1,cm_1,cm_16,cm_10,', '查询', 30, '', '', '', '0', 'cm:cmAuditApply:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_111', 'cm_10', '0,1,cm_1,cm_16，cm_10,', '修改', 30, '', '', '', '0', 'cm:cmAuditApply:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_100', 'cm_8', '0,1,cm_1,cm_3,cm_8,', '查询', 30, '', '', '', '0', 'cm:cmPropertyManage:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_101', 'cm_8', '0,1,cm_1,cm_3,cm_8,', '修改', 30, '', '', '', '0', 'cm:cmPropertyManage:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_106', 'cm_7', '0,1,cm_1,cm_3,cm_9,cm_7,', '查询', 30, '', '', '', '0', 'cm:cmCiInstance:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_107', 'cm_7', '0,1,cm_1,cm_3，cm_9,cm_7,', '修改', 30, '', '', '', '0', 'cm:cmCiInstance:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_104', 'cm_6', '0,1,cm_1,cm_3,cm_9,cm_6,', '查询', 30, '', '', '', '0', 'cm:cmCiApply:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_105', 'cm_6', '0,1,cm_1,cm_3，cm_9,cm_6,', '修改', 30, '', '', '', '0', 'cm:cmCiApply:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_102', 'cm_5', '0,1,cm_1,cm_3,cm_8,cm_5,', '查询', 30, '', '', '', '0', 'cm:cmCiGroup:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_103', 'cm_5', '0,1,cm_1,cm_3,cm_8,cm_5,', '修改', 30, '', '', '', '0', 'cm:cmCiGroup:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_108', 'cm_2', '0,1,cm_1,cm_3,cm_9,cm_2,', '查询', 30, '', '', '', '0', 'cm:cmCiInstance:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_109', 'cm_2', '0,1,cm_1,cm_3，cm_9,cm_2,', '修改', 30, '', '', '', '0', 'cm:cmCiInstance:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_112', 'cm_12', '0,1,cm_1,cm_3,cm_9,cm_12,', '查询', 30, '', '', '', '0', 'cm:cmBaseLine:view', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');
INSERT INTO sys_menu VALUES ('cm_113', 'cm_12', '0,1,cm_1,cm_3，cm_9,cm_12,', '修改', 30, '', '', '', '0', 'cm:cmBaseLine:edit', '1', '2015-4-15 09:11:48', '1', '2015-4-15 09:11:48', '', '0');


--权限申请自动流水号
INSERT INTO `sys_identity` VALUES ('rm_1', '区域管理权限申请', 'rmApply', 'RM-{yyyy}{MM}{dd}{NO}', '1', 5, 1, NULL, NULL, 1, '1', '2015-3-3 14:48:20', '1', '2015-3-3 14:48:20', '', '0');

--数据字典
INSERT INTO sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag,modules) VALUES ('rm_22', '1', '已使用', 'rm_status', '已使用', 10, '0', '1', '2015-4-15 14:41:27', '1', '2015-4-15 14:42:15', '', '0', '0');
INSERT INTO sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag,modules) VALUES ('rm_23', '0', '未使用', 'rm_status', '未使用', 20, '0', '1', '2015-4-15 14:41:42', '1', '2015-4-15 14:42:39', '', '0', '0');

--换班申请添加字段
ALTER TABLE sm_apply ADD proc_ins_id VARCHAR(64);

--消息管理添加字段
ALTER TABLE msg_msginfo ADD time_delivery char COMMENT '及时发送';
