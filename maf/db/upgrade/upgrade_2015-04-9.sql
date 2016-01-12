---by liujx   上午
ALTER TABLE cm_ci_group ADD icon_id VARCHAR(64);
ALTER TABLE cm_ci_instance ADD icon_id VARCHAR(64);
ALTER TABLE cm_ci_instance_hi ADD icon_id VARCHAR(64);

CREATE TABLE cm_graph_icon
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 图标名称
	icon_name varchar(50) COMMENT '图标名称',
	-- 图标路径
	icon_file varchar(255) COMMENT '图标路径',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注
	remarks varchar(255) COMMENT '备注',
	-- 删除标记（0：正常，1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常，1：删除）',
	PRIMARY KEY (id)
);

INSERT INTO sys_menu VALUES ('cm_15', 'cm_3', '0,1,cm_1,cm_3,', '图标管理', 190, '/cm/cmGraphIcon', '', '', '1', 'cm:cmGraphIcon:view,cm:cmGraphIcon:edit', '1', '2015-4-07 10:35:42', '1', '2015-4-07 11:01:50', '', '0');
INSERT INTO sys_role_menu VALUES ('cm_1', 'cm_15');
INSERT INTO sys_role_menu VALUES ('cm_2', 'cm_15');


--by liujx  下午

INSERT INTO sys_dict VALUES ('cm_43', '10', '物理位置', 'cm_property_widget', '属性数据类型', 40, '0', '1','1', '2015-4-9 09:24:58', '1', '2015-4-9 10:32:53', '', '0');
