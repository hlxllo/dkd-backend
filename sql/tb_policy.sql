create table tb_policy
(
	policy_id bigint auto_increment comment '策略id'
		primary key,
	policy_name varchar(30) null comment '策略名称',
	discount int null comment '策略方案，如：80代表8折',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '修改时间',
	constraint tb_policy_policy_name_uindex
		unique (policy_name)
)
comment '策略表';

