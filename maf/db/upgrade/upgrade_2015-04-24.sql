INSERT INTO `sys_identity` VALUES ('vs_1', '申请访问管理', 'RmVsInfo', 'VS-{yyyy}-{MM}-{dd}-{NO}', '0', 5, 1, NULL, NULL, 1, '1', now(), '1', now(), '', '0');
INSERT INTO `sys_identity` VALUES ('rm_17', '区域管理权限申请', 'rmApply', 'RM{yyyy}{MM}{dd}{NO}', '1', 4, 1, NULL, NULL, 1, '1', '2015-3-3 14:48:20', '1', '2015-3-3 14:48:20', '', '0');
INSERT INTO `sys_identity` VALUES ('rm_18', '访客申请', 'vsApplyId', 'RM{yyyy}{MM}{dd}{NO}', '1', 4, 1, NULL, NULL, 1, '1', '2015-3-3 14:48:20', '1', '2015-3-3 14:48:20', '', '0');

INSERT INTO `sys_menu` VALUES ('rm_m15','rm_m9', '0,1,rm_m9,rm_m8,', '查看', 30, '', '', '', '0', 'rm:rmRmApply:view', '1', '2015-2-6 13:50:11', '1', '2015-2-6 14:12:14', 'rm', '0');
INSERT INTO `sys_menu` VALUES ('rm_m16','rm_m9', '0,1,rm_m9,rm_m8,', '修改', 60, '', '', '', '0', 'rm:rmRmApply:edit', '1', '2015-2-6 13:50:11', '1', '2015-2-6 14:12:14', 'rm', '0');


--插入申请单号字段
ALTER TABLE `rm_vs_application_information`
ADD COLUMN `vsApply_Id`  varchar(64) NULL AFTER `id`;


