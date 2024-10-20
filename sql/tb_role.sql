create table tb_role
(
	role_id int auto_increment
		primary key,
	role_code varchar(50) null comment '角色编码
',
	role_name varchar(50) null comment '角色名称
',
	constraint tb_role_role_code_uindex
		unique (role_code),
	constraint tb_role_role_name_uindex
		unique (role_name)
)
comment '工单角色表';

