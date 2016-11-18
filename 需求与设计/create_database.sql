/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/11/16 22:58:31                          */
/*==============================================================*/


drop table if exists admin;

drop table if exists category;

drop table if exists collect_goods;

drop table if exists collect_shop;

drop table if exists goods;

drop table if exists goods_attribute;

drop table if exists goods_in_order;

drop table if exists goods_order;

drop table if exists receiver;

drop table if exists shop;

drop table if exists to_purchase;

drop table if exists transaction;

drop table if exists user;

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   admin_id             int not null,
   password             varchar(100) not null,
   admin_name           varchar(20),
   primary key (admin_id),
 );

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null,
   level_one            char(10) not null,
   level_two            char(10) not null,
   primary key (category_id)
);

/*==============================================================*/
/* Table: collect_goods                                         */
/*==============================================================*/
create table collect_goods
(
   user_id               int not null,
   goods_id              int not null,
   collect_goods_status  bool default true,
   primary key (user_id, goods_id)
);

/*==============================================================*/
/* Table: collect_shop                                          */
/*==============================================================*/
create table collect_shop
(
   user_id              int not null,
   shop_id              char(15) not null,
   collect_shop_status  bool default true,
   primary key (user_id, shop_id)
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             int not null,
   category_id          int not null,
   shop_id              char(15) not null,
   goods_name           varchar(20) not null,
   preview              varchar(20) ,
   sales                int default 0,
   discount_deadline    datetime,
   discount_rate        numeric(4,2) default 1.00,
   goods_status         bool default true,
   goods_describe       varchar(300),
   primary key (goods_id)
);

/*==============================================================*/
/* Table: goods_attribute                                       */
/*==============================================================*/
create table goods_attribute
(
   attribute_id         int not null,
   goods_id             int not null,
   attribute_value      varchar(10),
   inventory            int default 0,
   cost                 numeric(10,2) not null,
   price                numeric(10,2) not null,
   primary key (attribute_id)
);

/*==============================================================*/
/* Table: goods_in_order                                        */
/*==============================================================*/
create table goods_in_order
(
   goods_id             int not null,
   attribute_id         int not null,
   order_id             bigint not null,
   goods_num            int not null,
   cost                 numeric(10,2) not null,
   actual_price         numeric(10,2) not null,
   content              varchar(100),
   evaculate_score      smallint,
   evaculate_time       datetime,
   primary key (attribute_id, order_id)
);

/*==============================================================*/
/* Table: goods_order                                           */
/*==============================================================*/
create table goods_order
(
   order_id             bigint not null,
   shop_id              char(15) not null,
   user_id              int not null,
   order_status         char(10) not null,
   tracking_number      bigint,
   pay_method           char(8) not null,
   order_time           datetime not null,
   complete_time        datetime,
   annotation           varchar(100),
   total                numeric(10,2) not null,
   receiver_id          int not null,
   primary key (order_id),
   check(order_status in('待付款','待发货','待收货','待评价','已完成','已取消')),
   check(pay_method in('货到付款','在线支付'))
);

/*==============================================================*/
/* Table: receiver                                              */
/*==============================================================*/
create table receiver
(
   receiver_id          int not null,
   user_id              int not null,
   name                 varchar(20) not null,
   address              varchar(100) not null,
   phone                char(11) not null,
   used_times           int not null,
   primary key (receiver_id)
);

/*==============================================================*/
/* Table: shop                                                  */
/*==============================================================*/
create table shop
(
   shop_id              char(15) not null,
   user_id              int not null,
   shop_name            varchar(30) not null,
   address              varchar(100) not null,
   phone                char(11) not null,
   announcement         varchar(200) default '暂无公告',
   evaluate_sum         bigint default 0,
   evaluate_number      bigint default 0,
   shop_describe        varchar(300) default '暂无描述',
   primary key (shop_id)
);

/*==============================================================*/
/* Table: to_purchase                                           */
/*==============================================================*/
create table to_purchase
(
   user_id              int not null,
   goods_id             int not null,
   goods_num            int,
   to_purchase_status   bool default true,
   primary key (user_id, goods_id)
);

/*==============================================================*/
/* Table: transaction                                           */
/*==============================================================*/
create table transaction
(
   transaction_id       int not null,
   admin_id             int,
   user_id              int not null,
   transaction_type     char(10) not null,
   transaction_status   char(10) not null,
   content              varchar(300) not null,
   commit_time          datetime not null default now(),
   complete_time        datetime,
   annotation           varchar(100),
   primary key (transaction_id),
   check(transaction_status in('未处理','已通过','已拒绝')),
   check(transaction_type in('开店申请','用户投诉'))
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null AUTO_INCREMENT,
   shop_id              char(15),
   usename              varchar(20) not null,
   phone                char(11) unique not null,
   password             varchar(100) not null,
   nickname             varchar(20),
   avatar               varchar(20),
   sex                  char(4),
   birthday             date,
   primary key (user_id)，
   check(sex in('男','女','保密'))
);

alter table collect_goods add constraint FK_collect_goods foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table collect_goods add constraint FK_collect_goods foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table collect_shop add constraint FK_collect_shop foreign key (shop_id)
      references shop (shop_id) on delete restrict on update restrict;

alter table collect_shop add constraint FK_collect_shop foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods add constraint FK_refer foreign key (category_id)
      references category (category_id) on delete restrict on update restrict;

alter table goods add constraint FK_sell foreign key (shop_id)
      references shop (shop_id) on delete restrict on update restrict;

alter table goods_attribute add constraint FK_contain_attribute foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table goods_in_order add constraint FK_contain_goods foreign key (order_id)
      references goods_order (order_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_manage_order foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_process_order foreign key (shop_id)
      references shop (shop_id) on delete restrict on update restrict;

alter table receiver add constraint FK_manage_receiver foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table shop add constraint FK_manage foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table to_purchase add constraint FK_to_purchase foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table to_purchase add constraint FK_to_purchase foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table transaction add constraint FK_apply foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table transaction add constraint FK_handle foreign key (admin_id)
      references admin (admin_id) on delete restrict on update restrict;

alter table user add constraint FK_manage foreign key (shop_id)
      references shop (shop_id) on delete restrict on update restrict;

