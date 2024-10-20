create table tb_sku
(
	sku_id bigint auto_increment comment '主键'
		primary key,
	sku_name varchar(50) not null comment '商品名称',
	sku_image varchar(500) not null comment '商品图片',
	brand_Name varchar(50) not null comment '品牌',
	unit varchar(20) null comment '规格(净含量)',
	price int default 1 not null comment '商品价格，单位分',
	class_id int not null comment '商品类型Id',
	is_discount tinyint(1) default 0 null comment '是否打折促销',
	create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
	update_time timestamp default CURRENT_TIMESTAMP null comment '修改时间',
	constraint tb_sku_sku_name_uindex
		unique (sku_name),
	constraint tb_sku_ibfk_1
		foreign key (class_id) references tb_sku_class (class_id)
)
comment '商品表';

create index sku_sku_class_ClassId_fk
	on tb_sku (class_id);

