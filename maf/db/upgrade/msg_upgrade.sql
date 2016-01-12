
-- 消息管理菜单
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('msg_1', '88', '0,1,62,88,', '消息管理', 80, '/msg/msgMsginfo', '', '', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('msg_2', 'msg_1', '0,1,62,88,msg_1,', '查看', 80, '', '', '', '0', 'msg:msgMsginfo:view', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('msg_3', 'msg_1', '0,1,62,88,msg_1,', '修改', 80, '', '', '', '0', 'msg:msgMsginfo:edit', '1', now(), '1', now(), '', '0');

--消息管理类型字典
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_type_1','短信','1','msg_type','消息类型','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_type_2','邮件','2','msg_type','消息类型','20','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_type_3','微信','3','msg_type','消息类型','30','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_type_4','站内信','4','msg_type','消息类型','40','0','1',now(),'1',now(),NULL,'0');

-- 消息管理状态字典
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_status_0','待发送','0','msg_status','消息状态','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_status_1','发送中','1','msg_status','消息状态','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_status_2','已发送','2','msg_status','消息状态','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_status_3','发送失败','3','msg_status','消息状态','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('msg_status_4','已取消','4','msg_status','消息状态','10','0','1',now(),'1',now(),NULL,'0');


-- 新闻管理菜单
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_1', '88', '0,1,62,88,', '新闻公告管理', 110, '/site/siteNews', '', '', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_2', 'news_1', '0,1,62,88,news_1,', '查看', 80, '', '', '', '0', 'site:siteNews:view', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_3', 'news_1', '0,1,62,88,news_1,', '修改', 80, '', '', '', '0', 'site:siteNews:edit', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('news_4', '88', '0,1,62,88,', '新闻公告', 140, '/site/siteNews/reNews', '', '', '1', 'site:siteNews:view', '1', now(), '1', now(), '', '0');

--新闻公告字典
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('news_1','发布','1','post_status','新闻发布状态','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('news_2','草稿','2','post_status','新闻发布状态','20','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('news_3','新闻','1','site_new_type','新闻类型','10','0','1',now(),'1',now(),NULL,'0');
insert into `sys_dict` (`id`,`label`, `value`, `type`, `description`, `sort`,`modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) values('news_4','公告','2','site_new_type','新闻类型','20','0','1',now(),'1',now(),NULL,'0');


--首页通知公告
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('index_6', 'index_2', '0,1,27,28,index_6,', '通知公告', 30, '/site/siteNews/sitelist', '', '', '0', 'site:siteNews:view', '1', now(), '1', now(), 'to_index', '0');
--首页通信录
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('index_7', 'index_2', '0,1,27,28,index_7,', '通讯录', 60, '/indexdef/bcmMenu/userlist', '', '', '0', 'indexdef:bcmMenu:view', '1', now(), '1', now(), 'to_index', '0');


