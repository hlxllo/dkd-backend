create table tb_vendout_running
(
	id bigint auto_increment comment 'id'
		primary key,
	order_no varchar(38) default '' not null comment '订单编号',
	inner_code varchar(15) not null comment '售货机编号',
	channel_code varchar(10) null comment '货道编号',
	status char null comment '状态',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '更新时间'
)
comment '出货流水';

