create table tb_emp
(
	id int auto_increment comment '主键',
	user_name varchar(50) not null comment '员工名称',
	region_id int null comment '所属区域Id',
	region_name varchar(50) null comment '区域名称',
	role_id int null comment '角色id',
	role_code varchar(10) null comment '角色编号',
	role_name varchar(50) null comment '角色名称',
	mobile varchar(15) null comment '联系电话',
	image varchar(500) null comment '员工头像',
	status tinyint default 1 null comment '是否启用',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '修改时间',
	constraint tb_user_Id_uindex
		unique (id),
	constraint tb_user_mobile_uindex
		unique (mobile),
	constraint tb_user_user_name_uindex
		unique (user_name),
	constraint tb_emp_ibfk_1
		foreign key (role_id) references tb_role (role_id),
	constraint tb_emp_ibfk_2
		foreign key (region_id) references tb_region (id)
)
comment '工单员工表';

create index region_id
	on tb_emp (region_id);

create index role_id
	on tb_emp (role_id);

alter table tb_emp
	add primary key (id);

