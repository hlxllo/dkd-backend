create table tb_job
(
	id int auto_increment comment '主键'
		primary key,
	alert_value int default 0 null comment '警戒值百分比'
)
comment '自动补货任务' collate=utf8mb4_unicode_ci;

