
/* Drop Tables */

DROP TABLE bpm_delegate_apply;
DROP TABLE cm_audit_track;
DROP TABLE cm_audit_apply;
DROP TABLE cm_base_code;
DROP TABLE cm_base_line;
DROP TABLE cm_ci_apply;
DROP TABLE cm_ci_instance_hi;
DROP TABLE cm_ci_property;
DROP TABLE cm_ci_relation;
DROP TABLE cm_ci_instance;
DROP TABLE cm_property_group;
DROP TABLE cm_ci_group;
DROP TABLE cm_ci_property_hi;
DROP TABLE cm_graph_icon;
DROP TABLE cm_handle_log;
DROP TABLE cm_property_manage;
DROP TABLE cm_relation_order;
DROP TABLE idc_task_hasten;




/* Create Tables */

CREATE TABLE bpm_delegate_apply
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 申请人
	apply_user varchar(64) COMMENT '申请人',
	-- 委托人
	assignee varchar(64) COMMENT '委托人',
	-- 委托开始时间
	start_time varchar(20) COMMENT '委托开始时间',
	-- 委托结束时间
	end_time varchar(20) COMMENT '委托结束时间',
	-- 流程模板编号
	template_id varchar(1000) COMMENT '流程模板编号',
	-- 状态（是否可用0：可执行，1：已注销）
	status char(1) COMMENT '状态（是否可用0：可执行，1：已注销）',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_audit_apply
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 审计申请编号
	audit_number varchar(50) COMMENT '审计申请编号',
	-- 流程编号
	proc_ins_id varchar(64) COMMENT '流程编号',
	-- 审计对象
	audit_object varchar(20) COMMENT '审计对象',
	-- 审计项目
	audit_project varchar(50) COMMENT '审计项目',
	-- 审计时间
	audit_time varchar(20) COMMENT '审计时间',
	-- 审计人员
	audit_user varchar(64) COMMENT '审计人员',
	-- 审计条件
	audit_condition varchar(50) COMMENT '审计条件',
	-- 审计范围
	audit_scope varchar(255) COMMENT '审计范围',
	-- 审计数据收集方法
	audit_data_methods varchar(255) COMMENT '审计数据收集方法',
	-- 审计方式
	audit_mode varchar(50) COMMENT '审计方式',
	-- 审计安排
	audit_plan varchar(500) COMMENT '审计安排',
	-- 审计步骤
	audit_steps varchar(1000) COMMENT '审计步骤',
	-- 状态
	status char(1) COMMENT '状态',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	-- 审计目的
	audit_purpose varchar(64) COMMENT '审计目的',
	-- 审计结果
	audit_result char(1) COMMENT '审计结果',
	-- 审计报告
	audit_report varchar(255) COMMENT '审计报告',
	-- 签名审计员
	audit_sign varchar(50) COMMENT '签名审计员',
	-- 报告编号
	audit_reportNumber varchar(64) COMMENT '报告编号',
	PRIMARY KEY (id)
);


CREATE TABLE cm_audit_track
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 审计编号
	audit_id varchar(64) COMMENT '审计编号',
	-- 问题
	question varchar(255) COMMENT '问题',
	-- 配置项编号(多个配置项编号以英文逗号分隔)
	ci_id varchar(4000) COMMENT '配置项编号(多个配置项编号以英文逗号分隔)',
	-- 配置项名称
	ci_name varchar(4000) COMMENT '配置项名称',
	-- 责任人
	duty_officer varchar(64) COMMENT '责任人',
	-- 解决状态
	solve_status varchar(50) COMMENT '解决状态',
	-- 计划解决时间
	plan_solve_time varchar(20) COMMENT '计划解决时间',
	-- 实际解决时间
	reality_solve_time varchar(20) COMMENT '实际解决时间',
	-- 状态
	status char(1) COMMENT '状态',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_base_code
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 名称
	code_name varchar(50) COMMENT '名称',
	-- 值
	code_value varchar(100) COMMENT '值',
	-- 标注
	note varchar(10) COMMENT '标注',
	PRIMARY KEY (id)
);


CREATE TABLE cm_base_line
(
	-- 基线ID
	id varchar(64) NOT NULL COMMENT '基线ID',
	-- 基线版本
	base_version varchar(10) COMMENT '基线版本',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_ci_apply
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 申请编号
	apply_number varchar(64) COMMENT '申请编号',
	-- 配置项编号
	ci_number varchar(1000) COMMENT '配置项编号',
	-- 配置项编号
	ci_id varchar(1000) COMMENT '配置项编号',
	-- 流程编号
	proc_ins_id varchar(64) COMMENT '流程编号',
	-- 申请人
	user_id varchar(64) COMMENT '申请人',
	-- 申请人部门
	office_id varchar(64) COMMENT '申请人部门',
	-- 操作（0：新增，1：修改）
	handle char(1) COMMENT '操作（0：新增，1：修改）',
	-- 状态
	status char(1) COMMENT '状态',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_ci_group
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 父编号
	parent_id varchar(64) COMMENT '父编号',
	-- 所有父编号
	parent_ids varchar(2000) COMMENT '所有父编号',
	-- 分类编号
	group_number varchar(50) COMMENT '分类编号',
	-- 分类名称
	group_name varchar(50) COMMENT '分类名称',
	-- 分类描述
	group_desc varchar(100) COMMENT '分类描述',
	-- 状态
	status char(1) COMMENT '状态',
	-- 排序
	sort decimal(10,0) COMMENT '排序',
	-- 图标ID
	icon_id varchar(64) COMMENT '图标ID',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_ci_instance
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 配置项名称
	ci_name varchar(50) COMMENT '配置项名称',
	-- 配置项编号
	ci_number varchar(50) COMMENT '配置项编号',
	-- 配置项版本号
	ci_version varchar(10) COMMENT '配置项版本号',
	-- 分类ID
	group_id varchar(64) COMMENT '分类ID',
	-- 配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）
	ci_status_a char(1) COMMENT '配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）',
	-- 配置项状态（9：借用，10：借出，11：开发）
	ci_status_b char(2) COMMENT '配置项状态（9：借用，10：借出，11：开发）',
	-- 状态
	status char(1) COMMENT '状态',
	-- 图标ID
	icon_id varchar(64) COMMENT '图标ID',
	-- 创建者
	create_by varchar(64) COMMENT '创建者',
	-- 创建日期
	create_date datetime COMMENT '创建日期',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注
	remarks varchar(255) COMMENT '备注',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	-- 扩展字段1
	ext1 varchar(100) COMMENT '扩展字段1',
	-- 扩展字段2
	ext2 varchar(100) COMMENT '扩展字段2',
	PRIMARY KEY (id)
);


CREATE TABLE cm_ci_instance_hi
(
	-- 编号
	id varchar(64) COMMENT '编号',
	-- 配置项名称
	ci_name varchar(50) COMMENT '配置项名称',
	-- 配置项编号
	ci_number varchar(50) COMMENT '配置项编号',
	-- 配置项版本号
	ci_version varchar(10) COMMENT '配置项版本号',
	-- 分类ID
	group_id varchar(64) COMMENT '分类ID',
	-- 配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）
	ci_status_a char(1) COMMENT '配置项状态（1：已入库，2：已安装，3：测试中，4：运行中，5：维护中，6：已报废，7：已丢失，8：已闲置）',
	-- 配置项状态（9：借用，10：借出，11：开发）
	ci_status_b char(2) COMMENT '配置项状态（9：借用，10：借出，11：开发）',
	-- 状态
	status char(1) COMMENT '状态',
	-- 图标ID
	icon_id varchar(64) COMMENT '图标ID',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	-- 扩展字段1
	ext1 varchar(1000) COMMENT '扩展字段1',
	-- 扩展字段2
	ext2 varchar(1000) COMMENT '扩展字段2'
);


CREATE TABLE cm_ci_property
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 配置项实例ID
	ci_id varchar(64) COMMENT '配置项实例ID',
	-- 配置项实例版本
	ci_version varchar(10) COMMENT '配置项实例版本',
	-- 属性ID
	property_id varchar(64) COMMENT '属性ID',
	-- 属性值
	property_value varchar(255) COMMENT '属性值',
	-- 属性更改值
	property_update_value varchar(255) COMMENT '属性更改值',
	-- 操作类型（0：新增，1：修改，3：删除）
	handle char(1) COMMENT '操作类型（0：新增，1：修改，3：删除）',
	-- 状态
	status char(1) COMMENT '状态',
	-- 操作状态（0：未变更，1：正在变更）
	handle_status char(1) COMMENT '操作状态（0：未变更，1：正在变更）',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_ci_property_hi
(
	-- 编号
	id varchar(64) COMMENT '编号',
	-- 配置项实例ID
	ci_id varchar(64) COMMENT '配置项实例ID',
	-- 配置项实例版本
	ci_version varchar(10) COMMENT '配置项实例版本',
	-- 属性ID
	property_id varchar(64) COMMENT '属性ID',
	-- 属性值
	property_value varchar(255) COMMENT '属性值',
	-- 属性更改值
	property_update_value varchar(255) COMMENT '属性更改值',
	-- 操作类型（0：新增，1：修改，3：删除）
	handle char(1) COMMENT '操作类型（0：新增，1：修改，3：删除）',
	-- 状态
	status char(1) COMMENT '状态',
	-- 操作状态（0：未变更，1：正在变更）
	handle_status char(1) COMMENT '操作状态（0：未变更，1：正在变更）',
	-- 创建者 
	create_by varchar(64) COMMENT '创建者 ',
	-- 创建时间
	create_date datetime COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) COMMENT '更新者',
	-- 更新时间
	update_date datetime COMMENT '更新时间',
	-- 备注
	remarks varchar(255) COMMENT '备注',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）'
);


CREATE TABLE cm_ci_relation
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 配置项版本号
	ci_version varchar(10) COMMENT '配置项版本号',
	-- 配置项编号
	ci_id varchar(64) COMMENT '配置项编号',
	-- 关系配置项编号
	relation_ci_id varchar(64) COMMENT '关系配置项编号',
	-- 关系类型（详细见字典表）
	relation_type char(2) COMMENT '关系类型（详细见字典表）',
	-- 状态
	status char(1) COMMENT '状态',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


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


CREATE TABLE cm_handle_log
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 操作申请编号
	ci_apply_id varchar(20) COMMENT '操作申请编号',
	-- 实体编号
	entity_id varchar(64) COMMENT '实体编号',
	-- 操作人（默认记录发起人）
	handler varchar(64) COMMENT '操作人（默认记录发起人）',
	-- 操作日期
	handle_time varchar(20) COMMENT '操作日期',
	-- 创建时间
	create_time datetime COMMENT '创建时间',
	-- 备注
	remarks varchar(255) COMMENT '备注',
	PRIMARY KEY (id)
);


CREATE TABLE cm_property_group
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 分类编号
	group_id varchar(64) COMMENT '分类编号',
	-- 属性编号
	property_id varchar(64) COMMENT '属性编号',
	-- 状态（0：可用，1：不可用）
	status char(1) COMMENT '状态（0：可用，1：不可用）',
	-- 标示
	node varchar(4) COMMENT '标示',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_property_manage
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 属性编号
	property_number varchar(50) COMMENT '属性编号',
	-- 属性名称
	property_name varchar(50) COMMENT '属性名称',
	-- 属性描述
	property_desc varchar(100) COMMENT '属性描述',
	-- 属性类型（TYSX:通用属性，ZYSX：专有属性）
	property_type varchar(4) COMMENT '属性类型（TYSX:通用属性，ZYSX：专有属性）',
	-- 数据类型
	data_type varchar(20) COMMENT '数据类型',
	-- 是否必填（0：必填，1：非必填）
	is_null char(1) COMMENT '是否必填（0：必填，1：非必填）',
	-- 属性状态（0：可用，1：已删除）
	status char(1) COMMENT '属性状态（0：可用，1：已删除）',
	-- 扩展字段1
	ext1 varchar(255) COMMENT '扩展字段1',
	-- 扩展字段2
	ext2 varchar(255) COMMENT '扩展字段2',
	-- 排序
	sort decimal(10,0) COMMENT '排序',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE cm_relation_order
(
	-- 关联ID
	id varchar(64) NOT NULL COMMENT '关联ID',
	-- 配置项编号
	ci_id varchar(64) COMMENT '配置项编号',
	-- 工单编号
	order_id varchar(255) COMMENT '工单编号',
	-- 工单类型（1：变更工单，2：时间工单，3：问题工单）
	order_type varchar(50) COMMENT '工单类型（1：变更工单，2：时间工单，3：问题工单）',
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
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);


CREATE TABLE idc_task_hasten
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 任务ID
	task_id varchar(64) COMMENT '任务ID',
	-- 上次催办时间
	last_hasten_time varchar(20) COMMENT '上次催办时间',
	-- 催办人
	last_hasten_users varchar(100) COMMENT '催办人',
	-- 催办总次数
	count int COMMENT '催办总次数',
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
	del_flag char(1) COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
);



