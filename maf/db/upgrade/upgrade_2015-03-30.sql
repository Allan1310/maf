--排班管理新增字段
ALTER TABLE sm_dutybase ADD team_names VARCHAR(2000);
--修改duty_teammatename的长度
alter table sm_dutyvo modify column duty_teammatename varchar(2000) ;

