/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/11/13 20:55:52                          */
/*==============================================================*/


drop table if exists admin;

drop table if exists transaction;

drop table if exists category;

drop table if exists favorite_goods;

drop table if exists favorite_shop;

drop table if exists goods;

drop table if exists goods_in_order;

drop table if exists goods_order;

drop table if exists user;

drop table if exists receiver;

drop table if exists shop;

drop table if exists shopping_cart;

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   admin_id             int not null,
   password             varchar(100) not null,
   admin_name           varchar(20),
   primary key (admin_id),
   check(len(password)>=6 and len(password)<=20)
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
/* Table: favorite_goods                                        */
/*==============================================================*/
create table favorite_goods
(
   goods_id             int not null,
   user_id              int,
   primary key (goods_id)
);

/*==============================================================*/
/* Table: favorite_shop                                         */
/*==============================================================*/
create table favorite_shop
(
   registration_id      char(15) not null,
   user_id              int,
   primary key (registration_id)
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             int not null,
   category_id          int not null,
   registration_id      char(15) not null,
   goods_name           varchar(20) not null,
   preview              varchar(20) default 'none.jpg',
   cost                 numeric(10,2) not null,
   price                numeric(10,2) not null,
   sales                int default 0,
   inventory            int default 0,
   discount_deadline    datetime,
   discount_rate        numeric(4,2),
   goods_status         bool default false,
   goods_describe       varchar(300),
   primary key (goods_id)
);

/*==============================================================*/
/* Table: goods_in_order                                        */
/*==============================================================*/
create table goods_in_order
(
   goods_id             int not null,
   order_id             int not null,
   goods_num            int not null,
   cost                 numeric(10,2) not null,
   actual_price         numeric(10,2) not null,
   content              varchar(100),
   evaculate_score      int,
   evaculate_time       datetime,
   primary key (goods_id)
);

/*==============================================================*/
/* Table: goods_order                                           */
/*==============================================================*/
create table goods_order
(
   order_id             int not null,
   registration_id      char(15),
   user_id              int,
   order_status         char(10) not null,
   tracking_number      int,
   pay_method           char(8) not null,
   order_time           datetime not null default now(),
   complete_time        datetime,
   annotation           varchar(100),
   total                numeric(10,2) not null,
   receiver_id          int not null,
   check(order_status in('未付款','已付款','已发货','已收货')),
   check(pay_method in('货到付款','在线支付')),
   primary key (order_id)
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
   used_times           int not null default 0,
   primary key (receiver_id)
);

/*==============================================================*/
/* Table: shop                                                  */
/*==============================================================*/
create table shop
(
   registration_id      char(15) not null,
   user_id              int not null,
   shop_name            varchar(30),
   address              varchar(100),
   phone                char(11) not null,
   announcement         varchar(200) default '暂无公告',
   evaluate_avg         int default 0,
   evaluate_number      int default 0,
   shop_describe        varchar(300) default '暂无描述',
   primary key (registration_id)
);

/*==============================================================*/
/* Table: shopping_cart                                          */
/*==============================================================*/
create table shopping_cart
(
   goods_id             int not null,
   user_id              int,
   goods_num            int,
   primary key (goods_id)
);

/*==============================================================*/
/* Table: transaction                                           */
/*==============================================================*/
create table transaction
(
   transaction_id       int not null,
   user_id              int not null,
   admin_id             int,
   transaction_type     char(10) not null,
   transaction_status   char(10) not null,
   content              varchar(300) not null,
   commit_time          datetime not null default now(),
   complete_time        datetime,
   annotation           varchar(100),
   check(transaction_status in('提交中','已受理','已处理')),
   check(transaction_type in('开店申请','商家投诉','意见反馈')),
   primary key (transaction_id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null AUTO_INCREMENT,
   registration_id      char(15),
   phone                char(11) unique not null,
   password             varchar(100) not null,
   user_name             varchar(20),
   avatar               varchar(20) default 'none.jpg',
   sex                  char(4) ,
   birthday             date,
   primary key (user_id),
   check(sex in('男','女','保密')),
   check(len(password)>=6 and len(password)<=20)
);

alter table favorite_goods add constraint FK_manage_goods foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table favorite_shop add constraint FK_manage_shop foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods add constraint FK_refer foreign key (category_id)
      references category (category_id) on delete restrict on update restrict;

alter table goods add constraint FK_sell foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;

alter table goods_in_order add constraint FK_contain foreign key (order_id)
      references goods_order (order_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_manage_order foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_shop_order foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;

alter table receiver add constraint FK_manage_receiver foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table shop add constraint FK_shop_to_user foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table shopping_cart add constraint FK_manage_shoppingcart foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table transaction add constraint FK_apply foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table transaction add constraint FK_handle foreign key (admin_id)
      references admin (admin_id) on delete restrict on update restrict;

alter table user add constraint FK_user_to_shop foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;