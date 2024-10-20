create table tb_task_type
(
	type_id int not null
		primary key,
	type_name varchar(20) null comment '类型名称',
	type int default 1 null comment '工单类型。1:维修工单;2:运营工单'
)
comment '工单类型' collate=utf8mb4_unicode_ci;

