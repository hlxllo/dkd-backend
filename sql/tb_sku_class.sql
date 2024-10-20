create table tb_sku_class
(
	class_id int auto_increment comment '主键'
		primary key,
	class_name varchar(50) default '' null comment '类别名称',
	parent_id int default 0 null comment '上级id',
	constraint tb_sku_class_class_name_uindex
		unique (class_name)
)
comment '商品类型表';

