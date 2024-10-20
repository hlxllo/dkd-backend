create table tb_order_collect
(
	id bigint not null comment 'Id',
	partner_id int null comment '合作商Id',
	partner_name varchar(100) null comment '合作商名称',
	order_total_money bigint null comment '日订单收入总金额(平台端总数)',
	order_date date null comment '发生日期',
	total_bill int default 0 null comment '分成总金额',
	node_id int null,
	node_name varchar(50) null comment '点位',
	order_count int null comment '订单数',
	ratio int null comment '分成比例',
	region_name varchar(50) null comment '区域名称',
	constraint tb_order_collect_id_uindex
		unique (id)
)
comment '合作商订单汇总表';

alter table tb_order_collect
	add primary key (id);

