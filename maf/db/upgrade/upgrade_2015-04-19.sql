--删除原有的新闻公告菜单
delete from sys_menu where id='index_5'
delete from sys_menu where id='new_two_1'
delete from sys_menu where id='new_two_2'


--增加的新闻公告菜单
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_1', '88', '0,1,62,88,', '新闻公告管理', 110, '/site/siteNews', '', '', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_2', 'news_1', '0,1,62,88,news_1,', '查看', 80, '', '', '', '0', 'site:siteNews:view', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_3', 'news_1', '0,1,62,88,news_1,', '修改', 80, '', '', '', '0', 'site:siteNews:edit', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_4', '88', '0,1,62,88,', '新闻公告', 140, '/site/siteNews/reNews', '', '', '1', 'site:siteNews:view', '1', now(), '1', now(), '', '0');
--角色
ALTER TABLE sys_role ADD module VARCHAR(10);
INSERT INTO sys_dict VALUES ('sys_1', 'all', '全部模块', 'sys_module_type', '模块配置', 10, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '','0');
INSERT INTO sys_dict VALUES ('sys_2', 'cm', '配置管理', 'sys_module_type', '模块配置', 20, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '', '0');
INSERT INTO sys_dict VALUES ('sys_3', 'sm', '排班管理', 'sys_module_type', '模块配置', 30, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '','0');
INSERT INTO sys_dict VALUES ('sys_4', 'hm', '作业管理', 'sys_module_type', '模块配置', 40, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '', '0');
INSERT INTO sys_dict VALUES ('sys_5', 'rm', '机房管理', 'sys_module_type', '模块配置', 50, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '', '0');
INSERT INTO sys_dict VALUES ('sys_6', 'msg', '消息管理', 'sys_module_type', '模块配置', 60, '0', '0','1', '2015-4-19 09:24:58', '1', '2015-4-19 10:32:53', '','0');

INSERT INTO `sys_role` VALUES ('rm_1', '1', NULL, '机房负责人', 'rmResponsible', 'assignment', '8', '1', '1', '1', '2015-3-5 17:14:15', '1', '2015-4-19 15:44:27', '机房负责人', '0');
