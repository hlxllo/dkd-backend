create table tb_task
(
	task_id bigint auto_increment comment '工单ID'
		primary key,
	task_code varchar(40) not null comment '工单编号',
	task_status int null comment '工单状态',
	create_type int null comment '创建类型 0：自动 1：手动',
	inner_code varchar(15) null comment '售货机编码',
	user_id int null comment '执行人id',
	user_name varchar(50) null comment '执行人名称',
	region_id bigint null comment '所属区域Id',
	`desc` varchar(200) null comment '备注',
	product_type_id int default 1 null comment '工单类型id',
	assignor_id int null comment '指派人Id',
	addr varchar(200) null comment '地址',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '更新时间',
	constraint tb_task_task_code_uindex
		unique (task_code)
)
comment '工单表' collate=utf8mb4_unicode_ci;

create index task_productiontype_TypeId_fk
	on tb_task (product_type_id);

create index task_taskstatustype_StatusID_fk
	on tb_task (task_status);

create index task_tasktype_TypeId_fk
	on tb_task (create_type);

