create table tb_node
(
	id int auto_increment comment '主键ID'
		primary key,
	node_name varchar(255) not null comment '点位名称',
	address varchar(255) null comment '详细地址',
	business_type int null comment '商圈类型',
	region_id int null comment '区域ID',
	partner_id int null comment '合作商ID',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
	create_by varchar(255) null comment '创建人',
	update_by varchar(255) null comment '修改人',
	remark text null comment '备注',
	constraint tb_node_ibfk_1
		foreign key (region_id) references tb_region (id),
	constraint tb_node_ibfk_2
		foreign key (partner_id) references tb_partner (id)
)
comment '点位表';

