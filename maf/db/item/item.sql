SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS case_list;
DROP TABLE IF EXISTS case_manage;
DROP TABLE IF EXISTS case_steps;
DROP TABLE IF EXISTS item_manage;
DROP TABLE IF EXISTS item_path;
DROP TABLE IF EXISTS obj_manage;
DROP TABLE IF EXISTS obj_method;
DROP TABLE IF EXISTS scene_manage;




/* Create Tables */

CREATE TABLE case_list
(
	id varchar(64) NOT NULL,
	-- 关联项目id
	item_id varchar(64) COMMENT '关联项目id',
	-- 关联项目名称
	item_name varchar(60) COMMENT '关联项目名称',
	-- 父级编号
	parent_id varchar(64) NOT NULL COMMENT '父级编号',
	-- 所有父级编号
	parent_ids varchar(2000) NOT NULL COMMENT '所有父级编号',
	-- 名称
	name varchar(100) NOT NULL COMMENT '名称',
	-- 排序
	sort decimal(10,0) NOT NULL COMMENT '排序',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE case_manage
(
	id varchar(64) NOT NULL,
	-- 关联用例集id
	parent_id varchar(64) COMMENT '关联用例集id',
	-- 用例名称
	case_name varchar(60) COMMENT '用例名称',
	-- 用例步骤
	step_detail text COMMENT '用例步骤',
	-- 测试数据
	test_data text COMMENT '测试数据',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE case_steps
(
	id varchar(64) NOT NULL,
	-- 关联用例id
	case_id varchar(64) COMMENT '关联用例id',
	-- 步骤顺序
	sort varchar(10) COMMENT '步骤顺序',
	-- 对象名称
	obj_name varchar(200) COMMENT '对象名称',
	-- 对象寻址类型
	type char(1) COMMENT '对象寻址类型',
	-- 参数
	param varchar(200) COMMENT '参数',
	-- 动作
	motion char(1) COMMENT '动作',
	-- 是否截图
	screenshot char(1) COMMENT '是否截图',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE item_manage
(
	id varchar(64) NOT NULL,
	-- 项目名称
	name varchar(60) COMMENT '项目名称',
	-- 版本
	version varchar(30) COMMENT '版本',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE item_path
(
	id varchar(64) NOT NULL,
	-- 项目名称
	item_name varbinary(60) COMMENT '项目名称',
	-- 项目名称Id
	item_id varchar(64) COMMENT '项目名称Id',
	-- 路径名称
	item_path varchar(60) COMMENT '路径名称',
	-- 路径表达式
	expression varchar(200) COMMENT '路径表达式',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE obj_manage
(
	-- 主键
	id varchar(64) NOT NULL COMMENT '主键',
	-- 关联项目id
	item_id varchar(64) COMMENT '关联项目id',
	-- 关联项目名称
	item_name varchar(60) COMMENT '关联项目名称',
	-- 路径关联ID
	path_id varchar(64) COMMENT '路径关联ID',
	-- 关联路径名称
	path_name varchar(60) COMMENT '关联路径名称',
	-- 对象名称
	obj_name varchar(100) COMMENT '对象名称',
	-- xpath表达式
	xpath_code varchar(255) COMMENT 'xpath表达式',
	-- jquery表达式
	jquery_code varchar(255) COMMENT 'jquery表达式',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE obj_method
(
	-- ID
	id varchar(64) NOT NULL COMMENT 'ID',
	-- 对象类型
	obj_type char(1) COMMENT '对象类型',
	-- 方法名称
	method_name varchar(60) COMMENT '方法名称',
	-- 默认值
	default_val varchar(100) COMMENT '默认值',
	-- 方法code
	method_code text COMMENT '方法code',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE scene_manage
(
	id varchar(64) NOT NULL,
	PRIMARY KEY (id)
);



