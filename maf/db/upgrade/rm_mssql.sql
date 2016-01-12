-- sqlserver 门禁中间接口表  /////////////

create table fk_authorization_opt  
(  
	idNo varchar(64) primary key  ,   -- 编号
	ctlDeviceId varchar(64), -- 设备id
	applicationInformationId varchar(64)not null, -- 申请单id
	userName varchar(64)not null  ,   -- 姓名
	idCardNo varchar(64) not null  , -- 证件号码
	departNo varchar(64),  -- 部门编号
	cardNo varchar(64), -- 门禁卡号
	doorGroup varchar(1000), -- 通行门组	
	optType char(1), -- 操作类型	绑卡授权0 退卡收权 1
	optStatus char(1), -- 操作状态 待处理0 处理成功 1 处理失败 2
	optTime datetime -- 操作时间
)  COMMENT = '门禁中间接口表';