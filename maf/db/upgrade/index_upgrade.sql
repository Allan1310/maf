--增加系统菜单
INSERT INTO `sys_menu` VALUES ('index_1', '28', '0,1,27,28,', '用户首页', '10', '/indexdef/bcmMenu/indexdata', '', '', '1', 'indexdef:bcmMenu:view', '1', '2015-03-31 17:37:02', '1', '2015-03-31 17:37:02', '', '0');
INSERT INTO `sys_menu` VALUES ('index_2', '28', '0,1,27,28,', '首页配置', '20', '/indexdef/bcmMenu', '', '', '1', 'indexdef:bcmMenu:view', '1', '2015-03-31 17:33:09', '1', '2015-03-31 17:33:09', '', '0');

INSERT INTO `sys_menu` VALUES ('index_3', 'index_2', '0,1,27,28,index_3,', '修改', '30', '', '', '', '0', 'indexdef:bcmMenu:edit', '1', '2015-03-30 16:57:30', '1', '2015-03-30 16:57:30', '', '0');


INSERT INTO `sys_menu` VALUES ('index_9', 'index_2', '0,1,27,28,index_9,', '待办任务', '20', '/indexdef/bcmMenu/todoList', '', '', '0', 'indexdef:bcmMenu:view', '1', '2015-04-14 17:33:09', '1', '2015-04-14 17:33:09', 'to_index', '0');

