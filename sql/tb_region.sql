create table tb_region
(
	id int auto_increment comment '主键ID'
		primary key,
	region_name varchar(255) not null comment '区域名称',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
	create_by varchar(255) null comment '创建人',
	update_by varchar(255) null comment '修改人',
	remark text null comment '备注'
)
comment '区域表';

