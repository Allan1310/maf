--更改BUG
insert into cm_base_code values ('cm_3','groupSortNum','10','1');

INSERT INTO `cm_property_manage` VALUES ('cm_2', '20150305160253', '设备编号', 'CI的编号', 'TYSX', '0', '0', '0', 'ci_brand', '4', 20, '1', '2015-3-5 16:02:54', '1', '2015-3-5 16:02:54', NULL, '0');
INSERT INTO `cm_property_manage` VALUES ('cm_1', '20150305160232', '设备名称', 'CI的名称（同标签名称）', 'TYSX', '0', '0', '0', 'ci_brand', '4', 10, '1', '2015-3-5 16:02:33', '1', '2015-3-5 16:02:33', NULL, '0');
INSERT INTO `cm_property_manage` VALUES ('cm-3', '20150305160421', '设备序列号', 'CI的序列号', 'TYSX', '0', '1', '0', 'ci_brand', '4', 30, '1', '2015-3-5 16:04:21', '1', '2015-3-5 16:04:21', NULL, '0');


---
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
