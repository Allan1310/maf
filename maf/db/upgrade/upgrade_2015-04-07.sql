--by liujx 2015-04-07
INSERT INTO sys_menu VALUES ('cm_14', 'cm_3', '0,1,cm_1,cm_3,', '字典管理', 180, '/sys/dict/?modules=1', '', '', '1', 'sys:dict:view,sys:dict:edit', '1', '2015-4-07 10:35:42', '1', '2015-4-07 11:01:50', '', '0');
INSERT INTO sys_menu VALUES ('cm_15', 'cm_3', '0,1,cm_1,cm_3,', '图标管理', 190, '/cm/cmGraphIcon', '', '', '1', 'cm:cmGraphIcon:view,cm:cmGraphIcon:edit', '1', '2015-4-07 10:35:42', '1', '2015-4-07 11:01:50', '', '0');
INSERT INTO sys_role_menu VALUES ('cm_1', 'cm_14');
INSERT INTO sys_role_menu VALUES ('cm_2', 'cm_14');
INSERT INTO sys_role_menu VALUES ('cm_1', 'cm_15');
INSERT INTO sys_role_menu VALUES ('cm_2', 'cm_15');

--by bujh 
--排班表添加字段
ALTER TABLE sm_duty ADD all_teammateid VARCHAR(2000);
--排班预览表添加字段
ALTER TABLE sm_dutyvo ADD duty_teammateid VARCHAR(2000);