create table tb_vm_type
(
	id int auto_increment comment '主键'
		primary key,
	name varchar(15) not null comment '型号名称',
	model varchar(20) null comment '型号编码',
	image varchar(500) null comment '设备图片',
	vm_row int default 1 not null comment '货道行',
	vm_col int default 1 not null comment '货道列',
	channel_max_capacity int default 0 null comment '设备容量',
	constraint tb_vm_type_model_uindex
		unique (model),
	constraint tb_vm_type_name_uindex
		unique (name)
)
comment '设备类型表';

