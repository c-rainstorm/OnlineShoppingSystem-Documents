/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/11/20                                   */
/*==============================================================*/

drop table if exists admin;

drop table if exists category;

drop table if exists favorite_goods;

drop table if exists favorite_shop;

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
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null AUTO_INCREMENT,
   registration_id      char(15),
   user_name            varchar(20) not null unique,
   password             varchar(100) not null,
   nickname             varchar(20),
   phone                char(11) unique not null,
   avatar               varchar(20),
   sex                  char(4),
   birthday             date,
   primary key (user_id),
   check(sex in('男','女','保密'))
);

/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   admin_id             int not null,
   password             varchar(100) not null,
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
   transaction_type     char(10) not null,
   transaction_status   char(10) not null,
   comment              varchar(300) not null,
   commit_time          datetime not null default now(),
   complete_time        datetime,
   annotation           varchar(100),
   primary key (transaction_id),
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
   shop_name            varchar(30) not null,
   address              varchar(100) not null,
   phone                char(11) not null,
   shop_describe        varchar(300) default '暂无描述',
   announcement         varchar(200) default '暂无公告',
   evaluate_sum         bigint default 0,
   evaluate_number      bigint default 0,
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
   /*preview            varchar(20) ,     预览图？*/
   preview_num          smallint check(preview_num>=0 and preview_num<=6),
   sales                int not null default 0,
   discount_deadline    datetime,
   discount_rate        numeric(4,2) default 1.00,
   goods_is_valid       bool not null default true,
   goods_describe       varchar(300),
   primary key (goods_id)
);

DELIMITER $
CREATE TRIGGER delete_goods
AFTER UPDATE ON goods
FOR EACH ROW
BEGIN
    if new.goods_is_valid = false then
       update favorite_goods set goods_is_valid = false where goods_id = new.goods_id ;
       update goods_attribute set attribute_is_valid = false where goods_id = new.goods_id ;
       update shopping_cart set cart_is_valid = false where goods_id = new.goods_id;
    end if;   
 END $
 DELIMITER ;

/*==============================================================*/
/* Table: goods_attribute                                       */
/*==============================================================*/
create table goods_attribute
(
   attribute_id         int not null,
   attribute_value      varchar(40) not null,
   goods_id             int not null,
   cost                 numeric(10,2) not null,
   price                numeric(10,2) not null,
   inventory            int default 0,
   attribute_is_valid   bool not null default true,
   primary key (attribute_id)
);

/*==============================================================*/
/* Table: goods_order                                           */
/*==============================================================*/
create table goods_order
(
   order_id             bigint not null,
   user_id              int not null,
   registration_id      char(15) not null,
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
   comment              varchar(100),
   evaluate_score       smallint,
   evaluate_time        datetime,
   primary key (attribute_id, order_id)
);

DELIMITER $
CREATE TRIGGER update_score
AFTER UPDATE ON goods_in_order
FOR EACH ROW
BEGIN
       declare temp1 bigint;
       declare temp2 char(15); 
    if new.evaluate_score != old.evaluate_score then
       set temp2 = (select registration_id from goods where goods_id = new.goods_id);/*获得店铺编号*/
       set temp1 = (select evaluate_sum from shop where registration_id = temp2);  /*获得店铺当前总评分*/
       update shop set evaluate_sum = temp1 + new.evaluate_score where registration_id = temp2;
       set temp1 = (select evaluate_number from shop where registration_id = temp2);  /*获得店铺当前评分人数*/
       update shop set evaluate_number = temp1 + 1 where registration_id = temp2;
       update goods_in_order set evaluate_time = now() 
              where goods_id = new.goods_id and attribute_id = new.attribute_id and order_id = new.order_id;
    end if;
 END $
 DELIMITER ;

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
   receiver_is_valid    bool not null default true,
   primary key (receiver_id)
);

/*==============================================================*/
/* Table: favorite_shop                                          */
/*==============================================================*/
create table favorite_shop
(
   registration_id       char(15) not null,
   user_id               int not null,
   primary key (user_id, registration_id)
);

/*==============================================================*/
/* Table: favorite_goods                                         */
/*==============================================================*/
create table favorite_goods
(
   goods_id              int not null,
   user_id               int not null,
   goods_is_valid        bool default true,
   primary key (user_id, goods_id)
);

/*==============================================================*/
/* Table: shopping_cart                                           */
/*==============================================================*/
create table shopping_cart
(
   user_id              int not null,
   attribute_id         int not null,
   goods_id             int not null,
   goods_num            int not null,
   cart_is_valid        bool not null default true,
   primary key (user_id, attribute_id),
   check(goods_num >= 0)
);

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null,
   level_one            varchar(10) not null,
   level_two            varchar(10) not null,
   primary key (category_id)
);


alter table transaction add constraint FK_apply foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table transaction add constraint FK_handle foreign key (admin_id)
      references admin (admin_id) on delete restrict on update restrict;

alter table user add constraint FK_user_to_shop foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;

alter table shop add constraint FK_shop_to_user foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods_attribute add constraint FK_attribute foreign key (goods_id)
      references goods (goods_id) on delete cascade on update restrict;

alter table receiver add constraint FK_manage_receiver foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_manage_order foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table goods_order add constraint FK_process_order foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;

alter table goods add constraint FK_refer foreign key (category_id)
      references category (category_id) on delete cascade on update cascade;

alter table goods add constraint FK_sell foreign key (registration_id)
      references shop (registration_id) on delete restrict on update restrict;