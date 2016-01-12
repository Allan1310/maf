SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE index_menu_user;
DROP TABLE index_menu;




/* Create Tables */

CREATE TABLE index_menu
(
	id varchar(64) NOT NULL COMMENT '自定义菜单id',
	menu_id varchar(200) NOT NULL COMMENT '菜单id(关联菜单)',
	menu_show varchar(2) COMMENT '默认显示',
	menu_show_type varchar(2) COMMENT '是否显示',
	menu_expand_type varchar(2) COMMENT '是否放大',
	menu_reload_type varchar(2) COMMENT '是否刷新',
	menu_hide_type varchar(2) COMMENT '是否收缩',
	menu_close_type varchar(2) COMMENT '是否关闭',
	model_color varchar(64) COMMENT '模块颜色',
	create_by varchar(64) COMMENT '创建者',
	create_date datetime COMMENT '创建时间',
	update_by varchar(64) COMMENT '更新者',
	update_date datetime COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	PRIMARY KEY (id)
) COMMENT = '首页自定义';


CREATE TABLE index_menu_user
(
	menu_id varchar(64) NOT NULL COMMENT '自定义菜单id',
	user_id varchar(64) NOT NULL COMMENT '用户编号id',
	menu_show varchar(2) COMMENT '默认显示',
	menu_show_type varchar(2) COMMENT '是否显示',
	menu_expand_type varchar(2) COMMENT '是否放大',
	menu_reload_type varchar(2) COMMENT '是否刷新',
	menu_hide_type varchar(2) COMMENT '是否收缩',
	menu_close_type varchar(2) COMMENT '是否关闭',
	model_color varchar(64) COMMENT '模块颜色',
	column_type int(2) COMMENT '类别',
	row_typw int(5) COMMENT '行别',
	create_by varchar(64) COMMENT '创建者',
	create_date datetime COMMENT '创建时间',
	update_by varchar(64) COMMENT '更新者',
	update_date datetime COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	PRIMARY KEY (menu_id, user_id)
) COMMENT = '用户首页自定义';



