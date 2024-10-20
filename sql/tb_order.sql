create table tb_order
(
	id bigint not null comment '主键'
		primary key,
	order_no varchar(50) not null comment '订单编号',
	third_no varchar(34) null comment '第三方平台单号',
	inner_code varchar(15) null comment '机器编号',
	channel_code varchar(10) null comment '货道编号',
	sku_id bigint null comment 'skuId',
	sku_name varchar(20) null comment '商品名称',
	class_id int null comment '商品类别Id',
	status int null comment '订单状态:0-待支付;1-支付完成;2-出货成功;3-出货失败;4-已取消',
	amount int default 0 not null comment '支付金额',
	price int default 0 not null comment '商品金额',
	pay_type varchar(10) null comment '支付类型，1支付宝 2微信',
	pay_status int default 0 null comment '支付状态，0-未支付;1-支付完成;2-退款中;3-退款完成',
	bill int default 0 null comment '合作商账单金额',
	addr varchar(200) null comment '点位地址',
	region_id bigint null comment '所属区域Id',
	region_name varchar(50) null comment '区域名称',
	business_type int null comment '所属商圈',
	partner_id int null comment '合作商Id',
	open_id varchar(200) null comment '跨站身份验证',
	node_id bigint null comment '点位Id',
	node_name varchar(50) null comment '点位名称',
	cancel_desc varchar(200) default '' null comment '取消原因',
	create_time timestamp null comment '创建时间',
	update_time timestamp null comment '更新时间',
	constraint Order_OrderNo_uindex
		unique (order_no)
)
comment '订单表';

