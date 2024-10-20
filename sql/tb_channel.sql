create table tb_channel
(
	id bigint auto_increment comment '主键'
		primary key,
	channel_code varchar(10) not null comment '货道编号',
	sku_id bigint default 0 null comment '商品Id',
	vm_id bigint not null comment '售货机Id',
	inner_code varchar(15) not null comment '售货机软编号',
	max_capacity int default 0 not null comment '货道最大容量',
	current_capacity int default 0 null comment '货道当前容量',
	last_supply_time datetime null comment '上次补货时间',
	create_time datetime null comment '创建时间',
	update_time datetime null comment '修改时间',
	constraint tb_channel_ibfk_1
		foreign key (vm_id) references tb_vending_machine (id)
)
comment '售货机货道表';

create index channel_vendingmachine_Id_fk
	on tb_channel (vm_id);

create index tb_channel_inner_code_index
	on tb_channel (inner_code);

