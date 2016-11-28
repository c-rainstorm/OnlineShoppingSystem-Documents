/*==============================================================*/
/* DBMS name:      MySQL                                        */
/* Created on:     2016/11/28                                   */
/*==============================================================*/

grant select, insert, update, delete
  on OSS.*
  to 'groupnine'@'localhost' identified by 'groupnine';
flush privileges;

drop database if exists OSS;
create database OSS
      character set utf8mb4
      collate utf8mb4_unicode_ci;

use OSS;

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null AUTO_INCREMENT,
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
   is_valid             bool not null default true,
   primary key (user_id),
   index (username),
   check(sex in('男','女','保密'))
);


/*==============================================================*/
/* Table: receiver                                              */
/*==============================================================*/
create table receiver
(
   receiver_id          int not null AUTO_INCREMENT,
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
   transaction_id       int not null AUTO_INCREMENT,
   user_id              int not null,
   admin_id             int,
   transaction_type     varchar(16) not null,
   transaction_status   varchar(10) not null,
   comment              varchar(300) not null,
   commit_time          datetime not null,
   complete_time        datetime,
   annotation           varchar(300),
   is_valid             bool not null default true,
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
   shop_id              int not null AUTO_INCREMENT,
   user_id              int not null,
   apply_status         varchar(10) not null default '待审核',
   shop_name            varchar(90) not null,
   address              varchar(150) not null,
   phone                char(11) not null,
   shop_describe        varchar(300) default '暂无描述',
   announcement         varchar(300) default '暂无公告',
   evaluate_sum         bigint default 0,
   evaluate_number      bigint default 0,
   is_valid             bool not null default true,
   primary key (shop_id),

   index (user_id),

   constraint FK_shop_to_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,

   check(apply_status in('待审核','已通过','未通过'))
);



/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             int not null AUTO_INCREMENT,
   category_id          int not null,
   shop_id              int not null,
   goods_name           varchar(90) not null,
   sales                int not null default 0,
   discount_deadline    datetime default '2000-01-01 00:00:00',
   discount_rate        double default 1.00,
   is_valid             bool not null default true,
   goods_describe       varchar(300),
   primary key (goods_id),

   constraint FK_refer foreign key (category_id)
      references category (category_id) on delete restrict on update CASCADE,
   constraint FK_sell foreign key (shop_id)
      references shop (shop_id) on delete restrict on update CASCADE
);


/*==============================================================*/
/* Table: goods_image                                           */
/*==============================================================*/
create table goods_image
(
      image_id          int not null AUTO_INCREMENT,
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
   attribute_id         int not null AUTO_INCREMENT,
   attribute_value      varchar(90) not null,
   goods_id             int not null,
   cost                 double not null,
   price                double not null,
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
   order_id             bigint(16) not null AUTO_INCREMENT,
   user_id              int not null,
   shop_id              int not null,
   order_status         varchar(10) not null,
   tracking_number      char(12),
   pay_method           varchar(16) not null,
   order_time           datetime not null,
   complete_time        datetime,
   annotation           varchar(100),
   total                double not null,
   receiver_id          int not null,
   is_valid             bool not null default true,
   primary key (order_id),

   index (user_id),

   constraint FK_manage_order foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_process_order foreign key (shop_id)
      references shop (shop_id) on delete restrict on update CASCADE,

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
   cost                 double not null,
   actual_price         double not null,
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
       declare temp2 int;
    if new.evaluate_score != old.evaluate_score then
       set temp2 = (select shop_id from goods where goods_id = new.goods_id);/*获得店铺编号*/

       update shop set evaluate_sum = evaluate_sum + new.evaluate_score where shop_id = temp2;
       update shop set evaluate_number = evaluate_number + 1 where shop_id = temp2;

       update goods_in_order set evaluate_time = now()
	      where order_id = new.order_id and goods_id = new.goods_id and attribute_id = new.attribute_id;
    end if;
 END $
 DELIMITER ;


/*==============================================================*/
/* Table: favorite_shops                                          */
/*==============================================================*/
create table favorite_shops
(
   id                    bigint not null AUTO_INCREMENT,
   shop_id               int not null,
   user_id               int not null,
   is_valid              bool not null default true,
   primary key (id),

   index (user_id),

   constraint FK_favorite_shops_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_favorite_shops foreign key (shop_id)
      references shop (shop_id) on delete restrict on update CASCADE
);

/*==============================================================*/
/* Table: favorite_goods                                         */
/*==============================================================*/
create table favorite_goods
(
   id                    bigint not null AUTO_INCREMENT,
   goods_id              int not null,
   user_id               int not null,
   is_valid              bool not null default true,
   primary key (id),

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
   id                   bigint not null AUTO_INCREMENT,
   user_id              int not null,
   attribute_id         int not null,
   /* 为保证效率增加的 goods_id 冗余 */
   goods_id             int not null,
   goods_num            int not null,
   is_valid             bool not null default true,
   primary key (id),

   index (user_id),

   constraint FK_shopping_cart_user foreign key (user_id)
      references user (user_id) on delete restrict on update CASCADE,
   constraint FK_shopping_cart_attr foreign key (attribute_id)
      references goods_attribute (attribute_id) on delete restrict on update CASCADE,

   check(goods_num >= 0)
);

DELIMITER $
CREATE TRIGGER delete_shop
AFTER UPDATE ON shop
FOR EACH ROW
BEGIN
    if new.is_valid = false then
       update goods set is_valid = false where shop_id = new.shop_id ;
       update goods_order set is_valid = false where shop_id = new.shop_id ;
       update favorite_shops set is_valid = false where shop_id = new.shop_id;
    end if;
 END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER deal_transaction
AFTER UPDATE ON transaction
FOR EACH ROW
BEGIN
    declare user_shop_id int;
    set user_shop_id = (select shop_id from shop where user_id = new.user_id order by shop_id desc limit 1);
    if new.transaction_status = '已通过' and new.transaction_type = '开店申请' then
       update shop set apply_status = '已通过' where shop_id = user_shop_id ;
    end if; 
    if new.transaction_status = '已拒绝' and new.transaction_type = '开店申请' then
       update shop set apply_status = '未通过' where shop_id = user_shop_id ;
    end if;
 END $
 DELIMITER ;

DELIMITER $
CREATE TRIGGER delete_user
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
    if new.is_valid = false then
       update goods_order set is_valid = false where user_id = new.user_id ;
       update favorite_shops set is_valid = false where user_id = new.user_id;
       update receiver set is_valid = false where user_id = new.user_id ;
       update transaction set is_valid = false where user_id = new.user_id ;
       update favorite_goods set is_valid = false where user_id = new.user_id;
       update shop set is_valid = false where user_id = new.user_id ;
       update shopping_cart set is_valid = false where user_id = new.user_id ;
    end if;
 END $
 DELIMITER ;

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

DELIMITER $
CREATE TRIGGER `pay_order` 
AFTER UPDATE ON `goods_order` 
FOR EACH ROW 
BEGIN
    DECLARE attr_id, g_id, g_num INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur1 CURSOR FOR 
            SELECT attribute_id, goods_id, goods_num 
            from goods_in_order 
            where order_id = new.order_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;		
    if old.order_status = "待付款" and new.order_status = "待发货" then
        update receiver set used_times = used_times + 1 where receiver_id = new.receiver_id;
		open cur1;
        
        read_loop: LOOP
            FETCH cur1 INTO attr_id, g_id, g_num;
            IF done THEN
                LEAVE read_loop;
            end if;
            update goods_attribute set inventory = inventory - g_num where attribute_id = attr_id;
            update goods set sales = sales + g_num where goods_id = g_id;
        END LOOP;		

        CLOSE cur1;
        end if;
END $
DELIMITER ;
