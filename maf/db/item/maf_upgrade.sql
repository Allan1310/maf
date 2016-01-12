-- 菜单
--delete from sys_menu where id like 'item_%';
--delete from sys_menu where id like 'obj_%';

INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_1', '1', '0,1,', '外包服务', 5030, '', '', 'eye-close', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_2', 'es_1', '0,1,es_1,', '服务商资源', 10, '', '', '', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_3', 'es_1', '0,1,es_1,', '服务商考评', 20, '', '', '', '1', '', '1', now(), '1', now(), '', '0');

INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_4', 'es_2', '0,1,es_1,es_2,', '服务商资源管理', '10', '/es/esSpManage', '', '', '1', '', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_17', 'es_4', '0,1,es_1,es_2,es_4,', '查看', '30', '', '', '', '0', 'es:esSpManage:view', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `sort`, `href`, `target`, `icon`, `is_show`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_18', 'es_4', '0,1,es_1,es_2,es_4,', '增删改', '60', '', '', '', '0', 'es:esSpManage:edit', '1', now(), '1', now(), '', '0');

-- 数据字典
INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `parent_id`, `modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('obj_1', '0', 'xpath', 'obj_type', '对象类型', '10', '0', '0', '1', now(), '1', now(), '', '0');
INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `parent_id`, `modules`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('obj_2', '1', 'jquery', 'obj_type', '对象类型', '20', '0', '0', '1', now(), '1', now(), '', '0');

-- 用户角色
INSERT INTO `sys_role` (`id`, `office_id`, `module`, `name`, `enname`, `role_type`, `data_scope`, `is_sys`, `useable`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES ('es_report_1', '1', '', '外包管理员', 'esManage', 'assignment', '8', '1', '1', '1', now(), '1', now(), '', '0');


