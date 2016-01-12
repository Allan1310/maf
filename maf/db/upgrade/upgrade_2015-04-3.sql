-- 2015-4-3
--换班申请添加字段
ALTER TABLE sm_apply ADD apply_duty_time VARCHAR(20);
ALTER TABLE sm_apply ADD taker_duty_time VARCHAR(20);

ALTER TABLE `sys_dict`
MODIFY COLUMN `modules`  char(1)  NULL DEFAULT '0' COMMENT '模块' AFTER `parent_id`;