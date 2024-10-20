create table tb_partner
(
	id int auto_increment comment '主键ID'
		primary key,
	partner_name varchar(255) not null comment '合作商名称',
	contact_person varchar(255) null comment '联系人',
	contact_number varchar(15) null comment '联系电话',
	commission_rate int null comment '分成比例',
	account varchar(255) not null comment '账号',
	password varchar(255) not null comment '密码',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '修改时间',
	create_by varchar(255) null comment '创建人',
	update_by varchar(255) null comment '修改人',
	remark text null comment '备注'
)
comment '合作商表';

