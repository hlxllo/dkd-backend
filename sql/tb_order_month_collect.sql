create table tb_order_month_collect
(
	id bigint not null comment 'id',
	partner_id int null comment '合作商Id',
	partner_name varchar(100) null comment '合作商名称',
	region_id int null comment '区域Id',
	region_name varchar(50) null comment '地区名称',
	order_total_money bigint null comment '订单总金额',
	order_total_count bigint null comment '订单总数',
	month int null comment '月份',
	year int null comment '年份',
	constraint tb_order_month_collect_id_uindex
		unique (id)
)
comment '按月统计各公司销售情况表';

alter table tb_order_month_collect
	add primary key (id);

