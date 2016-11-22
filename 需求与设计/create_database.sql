/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/11/20                                   */
/*==============================================================*/

drop database if exists OSS;

create database OSS 
      character set utf8mb4 
      collate utf8mb4_unicode_ci;

use OSS;

drop table if exists admin;

drop table if exists category;

drop table if exists favorite_goods;

drop table if exists favorite_shops;

drop table if exists goods;

drop table if exists goods_attribute;

drop table if exists goods_in_order;

drop table if exists goods_order;

drop table if exists receiver;

drop table if exists shop;

drop table if exists shopping_cart;

drop table if exists transaction;

drop table if exists user;

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null,
   level_one            varchar(30) not null,
   level_two            varchar(30) not null,
   is_valid             bool not null default true,
   primary key (category_id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null AUTO_INCREMENT,
   username             varchar(25) not null unique,
   password             varchar(120) not null,
   nickname             varchar(20),
   phone                char(11) unique not null,
   avatar               varchar(50),
   sex                  varchar(8),
   birthday             date,
   primary key (user_id),
   index (username),
   check(sex in('男','女','保密'))
);

/*==============================================================*/
/* Table: receiver                                              */
/*==============================================================*/
create table receiver
(
   receiver_id          int not null,
   user_id              int not null,
   name                 varchar(30) not null,
   address              varchar(150) not null,
   phone                char(11) not null,
   used_times           int not null,
   is_valid             bool not null default true,
   primary key (receiver_id),

   index (user_id),
  
   constraint FK_manage_receiver foreign key (user_id)
      references user (user_id) on delete restrict on update restrict
);


/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   admin_id             int not null,
   password             varchar(120) not null,
   admin_name           varchar(20),
   primary key (admin_id)
 );

/*==============================================================*/
/* Table: transaction                                           */
/*==============================================================*/
create table transaction
(
   transaction_id       int not null,
   user_id              int not null,
   admin_id             int,
   transaction_type     varchar(16) not null,
   transaction_status   varchar(10) not null,
   comment              varchar(300) not null,
   commit_time          datetime not null default now(),
   complete_time        datetime,
   annotation           varchar(300),
   primary key (transaction_id),
   
   constraint FK_apply foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_handle foreign key (admin_id)
      references admin (admin_id) on delete restrict on update CASCADE,
   
   check(transaction_status in('未处理','已通过','已拒绝')),
   check(transaction_type in('开店申请','用户投诉'))
);

/*==============================================================*/
/* Table: shop                                                  */
/*==============================================================*/
create table shop
(
   registration_id      char(15) not null,
   user_id              int not null,
   shop_name            varchar(90) not null,
   address              varchar(150) not null,
   phone                char(11) not null,
   shop_describe        varchar(300) default '暂无描述',
   announcement         varchar(300) default '暂无公告',
   evaluate_sum         bigint default 0,
   evaluate_number      bigint default 0,
   primary key (registration_id),

   index (user_id),

   constraint FK_shop_to_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             int not null,
   category_id          int not null,
   registration_id      char(15) not null,
   goods_name           varchar(90) not null,
   sales                int not null default 0,
   discount_deadline    datetime,
   discount_rate        numeric(4,2) default 1.00,
   is_valid             bool not null default true,
   goods_describe       varchar(300),
   primary key (goods_id),

   constraint FK_refer foreign key (category_id)
      references category (category_id) on delete restrict on update CASCADE,
   constraint FK_sell foreign key (registration_id)
      references shop (registration_id) on delete restrict on update CASCADE
);

DELIMITER $
CREATE TRIGGER delete_goods
AFTER UPDATE ON goods
FOR EACH ROW
BEGIN
    if new.is_valid = false then
       update favorite_goods set is_valid = false where goods_id = new.goods_id ;
       update goods_attribute set is_valid = false where goods_id = new.goods_id ;
       update shopping_cart set is_valid = false where goods_id = new.goods_id;
       update goods_image set is_valid = false where goods_id = new.goods_id;
    end if;
 END $
 DELIMITER ;

create table goods_image
(
      image_id          int not null,
      goods_id          int not null,
      image_addr        varchar(50) not null default 'images/avatars/default.jpg',
      is_valid          bool not null default true,
      primary key (image_id),

      index (goods_id),

      constraint FK_goods_image foreign key (goods_id)
            references goods (goods_id) on delete restrict on update CASCADE
);


/*==============================================================*/
/* Table: goods_attribute                                       */
/*==============================================================*/
create table goods_attribute
(
   attribute_id         int not null,
   attribute_value      varchar(90) not null,
   goods_id             int not null,
   cost                 numeric(10,2) not null,
   price                numeric(10,2) not null,
   inventory            int default 0,
   is_valid             bool not null default true,
   primary key (attribute_id),

   index (goods_id),

   constraint FK_attribute foreign key (goods_id)
      references goods (goods_id) on delete restrict on update CASCADE,

   check(inventory >= 0)
);

/*==============================================================*/
/* Table: goods_order                                           */
/*==============================================================*/
create table goods_order
(
   order_id             bigint not null,
   user_id              int not null,
   registration_id      char(15) not null,
   order_status         varchar(10) not null,
   tracking_number      char(12),
   pay_method           varchar(16) not null,
   order_time           datetime not null,
   complete_time        datetime,
   annotation           varchar(100),
   total                numeric(10,2) not null,
   receiver_id          int not null,
   primary key (order_id),

   index (user_id),

   constraint FK_manage_order foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_process_order foreign key (registration_id)
      references shop (registration_id) on delete restrict on update CASCADE,

   check(order_status in('待付款','待发货','待收货','待评价','已完成','已取消')),
   check(pay_method in('货到付款','在线支付'))
);

/*==============================================================*/
/* Table: goods_in_order                                        */
/*==============================================================*/
create table goods_in_order
(
   order_id             bigint not null,
   attribute_id         int not null,
   goods_id             int not null,
   goods_num            int not null,
   cost                 numeric(10,2) not null,
   actual_price         numeric(10,2) not null,
   comment              varchar(300),
   evaluate_score       smallint,
   evaluate_time        datetime,
   primary key (attribute_id, order_id),

   constraint FK_contained_order foreign key (order_id)
      references goods_order (order_id) on delete restrict on update CASCADE,
   constraint FK_goods_id foreign key (goods_id)
      references goods (goods_id) on delete restrict on update CASCADE,
   constraint FK_attr_id foreign key (attribute_id)
      references goods_attribute (attribute_id) on delete restrict on update CASCADE,
  
   check(evaluate_score >= 0 and evaluate_score < 6)
);

DELIMITER $
CREATE TRIGGER update_score
AFTER UPDATE ON goods_in_order
FOR EACH ROW
BEGIN
       declare temp2 char(15);
    if new.evaluate_score != old.evaluate_score then
       set temp2 = (select registration_id from goods where goods_id = new.goods_id);/*获得店铺编号*/

       update shop set evaluate_sum = evaluate_sum + new.evaluate_score where registration_id = temp2;
       update shop set evaluate_number = evaluate_number + 1 where registration_id = temp2;

       update goods_in_order set evaluate_time = now()
	      where order_id = new.order_id and goods_id = new.goods_id and attribute_id = new.attribute_id;
    end if;
 END $
 DELIMITER ;


/*==============================================================*/
/* Table: favorite_shop                                          */
/*==============================================================*/
create table favorite_shops
(
   registration_id       char(15) not null,
   user_id               int not null,
   is_valid              bool not null default true,
   primary key (user_id, registration_id),

   index (user_id),

   constraint FK_favorite_shops_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_favorite_shops foreign key (registration_id)
      references shop (registration_id) on delete restrict on update CASCADE
);

/*==============================================================*/
/* Table: favorite_goods                                         */
/*==============================================================*/
create table favorite_goods
(
   goods_id              int not null,
   user_id               int not null,
   is_valid              bool default true,
   primary key (user_id, goods_id),

   index (user_id),

   constraint FK_favorite_goods_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_favorite_goods foreign key (goods_id)
      references goods (goods_id) on delete restrict on update CASCADE
);

/*==============================================================*/
/* Table: shopping_cart                                           */
/*==============================================================*/
create table shopping_cart
(
   user_id              int not null,
   attribute_id         int not null,
   /* 为保证效率增加的 goods_id 冗余 */
   goods_id             int not null,
   goods_num            int not null,
   is_valid             bool not null default true,
   primary key (user_id, attribute_id),

   index (user_id),

   constraint FK_shopping_cart_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_shopping_cart_attr foreign key (attribute_id)
      references goods_attribute (attribute_id) on delete restrict on update CASCADE,
   
   check(goods_num >= 0)
);


