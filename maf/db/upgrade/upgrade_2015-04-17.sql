---by zx

alter table index_menu_user drop primary key;
alter table index_menu_user add primary key(`menu_id`, `user_id`);

ALTER TABLE rm_vs_application_information add doors VARCHAR(500);


--通知管理权限菜单
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('95', '90', '0,1,62,88,90,', '查看', 30, '', '', '', '0', 'oa:oaNotify:view', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('96', '90', '0,1,62,88,90,', '修改', 60, '', '', '', '0', 'oa:oaNotify:edit', '1', now(), '1', now(), '', '0');
