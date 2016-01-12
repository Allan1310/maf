SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS msg_msginfo;
DROP TABLE IF EXISTS site_news;




/* Create Tables */

-- 消息管理信息表
CREATE TABLE msg_msginfo
(
	id varchar(64) NOT NULL COMMENT '编号',
	send_mode varchar(10) COMMENT '发送方式',
	sender_id varchar(1000) COMMENT '发送人编号',
	send_name varchar(64) COMMENT '发送人姓名',
	receiver_id varchar(1000) COMMENT '接收人编号',
	receiver_name varchar(64) COMMENT '接收人姓名',
	Ccopyer_id varchar(1000) COMMENT '抄送人编号',
	Blinder_id varchar(1000) COMMENT '密送人编号',
	msg_title varchar(100) COMMENT '消息标题',
	message text COMMENT '信息内容',
	msg_type varchar(100) COMMENT '消息类型',
	back_flag varchar(10) COMMENT '发送状态',
	plan_time datetime COMMENT '计划发送时间',
	actual_time datetime COMMENT '实际发送时间',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	read_flag varchar(10) COMMENT '阅读标记',
	time_delivery char COMMENT '及时发送',
	PRIMARY KEY (id)
) COMMENT = '消息管理信息表';


-- 新闻公告表
CREATE TABLE site_news
(
	id varchar(64) NOT NULL COMMENT '编号',
	type char(3) COMMENT '新闻类型',
	title varchar(1000) COMMENT '新闻标题',
	content text COMMENT '新闻内容',
	files varchar(1000) COMMENT '文件',
	news_date datetime COMMENT '发布时间',
	introduction text COMMENT '新闻简介',
	status char(3) COMMENT '发布状态',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) COMMENT = '新闻公告表';



