INSERT INTO sys_menu VALUES ('cm_13', 'cm_9', '0,1,cm_1,cm_3,cm_9,', '配置项报表', 160, '/cm/cmCiInstance/report?status=1', '', '', '1', '', '1', '2015-3-31 14:03:49', '1', '2015-3-31 14:03:49', '', '0');
INSERT INTO sys_role_menu VALUES ('cm_1', 'cm_13');
INSERT INTO sys_role_menu VALUES ('cm_2', 'cm_13');

--菜单增加首页配置
INSERT INTO `sys_menu` VALUES ('33d26325dec047b3941daa963e377b27', '28', '0,1,27,28,', '首页配置', '100', '/indexdef/bcmMenu', '', '', '1', 'indexdef:bcmMenu:view', '1', '2015-03-31 17:33:09', '1', '2015-03-31 17:33:09', '', '0');
--增加菜单首页
INSERT INTO `sys_menu` VALUES ('3096b871a3eb46e4915db3515734b70a', '28', '0,1,27,28,', '首页', '130', '/indexdef/bcmMenu/indexdata', '', '', '1', 'indexdef:bcmMenu:view', '1', '2015-03-31 17:37:02', '1', '2015-03-31 17:37:02', '', '0');
--增加隐藏菜单通知发布
INSERT INTO `sys_menu` VALUES ('3662f60683e444b28a2fbe7967f3cc47', 'a3b01586291c4adf9064e267775417af', '0,1,a3b01586291c4adf9064e267775417af,', '通知发布', '30', '/indexdef/bcmMenu/hashBordTest', '', '', '0', 'indexdef:bcmMenu:view', '1', '2015-03-30 17:10:24', '1', '2015-03-30 17:10:24', 'to_index', '0');
--给首页配置插入数据
INSERT INTO `bcm_menu` VALUES ('436994d1e69245babdcee93bae50fc66', '3662f60683e444b28a2fbe7967f3cc47', '1', null, '1', '1', '1', '1', '1', '2015-03-30 17:10:52', '1', '2015-03-30 17:10:52', '');