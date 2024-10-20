create table tb_task_collect
(
	id int auto_increment
		primary key,
	user_id int null,
	finish_count int default 0 null comment '当日工单完成数',
	progress_count int default 0 null comment '当日进行中的工单数',
	cancel_count int default 0 null comment '当日取消工单数',
	collect_date date null comment '汇总的日期'
)
comment '工单按日统计表' collate=utf8mb4_unicode_ci;

