create table tb_vending_machine
(
	id bigint auto_increment comment '主键'
		primary key,
	inner_code varchar(15) default '000' null comment '设备编号',
	channel_max_capacity int null comment '设备容量',
	node_id int not null comment '点位Id',
	addr varchar(100) null comment '详细地址',
	last_supply_time datetime default '2000-01-01 00:00:00' not null comment '上次补货时间',
	business_type int not null comment '商圈类型',
	region_id int not null comment '区域Id',
	partner_id int not null comment '合作商Id',
	vm_type_id int default 0 not null comment '设备型号',
	vm_status int default 0 not null comment '设备状态，0:未投放;1-运营;3-撤机',
	running_status varchar(100) null comment '运行状态',
	longitudes double default 0 null comment '经度',
	latitude double default 0 null comment '维度',
	client_id varchar(50) null comment '客户端连接Id,做emq认证用',
	policy_id bigint null comment '策略id',
	create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '修改时间',
	constraint vendingmachine_VmId_uindex
		unique (inner_code),
	constraint tb_vending_machine_ibfk_1
		foreign key (vm_type_id) references tb_vm_type (id),
	constraint tb_vending_machine_ibfk_2
		foreign key (node_id) references tb_node (id),
	constraint tb_vending_machine_ibfk_3
		foreign key (policy_id) references tb_policy (policy_id)
)
comment '设备表';

create index policy_id
	on tb_vending_machine (policy_id);

create index vendingmachine_node_Id_fk
	on tb_vending_machine (node_id);

create index vendingmachine_vmtype_TypeId_fk
	on tb_vending_machine (vm_type_id);

