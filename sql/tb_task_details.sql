create table tb_task_details
(
	details_id bigint auto_increment
		primary key,
	task_id bigint null comment '工单Id',
	channel_code varchar(10) null comment '货道编号',
	expect_capacity int default 0 not null comment '补货期望容量',
	sku_id bigint null comment '商品Id',
	sku_name varchar(50) null,
	sku_image varchar(500) null,
	constraint taskdetails_task_TaskId_fk
		foreign key (task_id) references tb_task (task_id)
)
comment '工单详情，只有补货工单才有' collate=utf8mb4_unicode_ci;

