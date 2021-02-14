/*
SQLyog Ultimate v9.30 
MySQL - 5.5.15 : Database - hotel2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE IF NOT EXISTS `hotel`;
USE `hotel`;

/*Table structure for table `tb_dinner_table` */

DROP TABLE IF EXISTS `tb_dinner_table`;

CREATE TABLE `tb_dinner_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_Name` varchar(20) DEFAULT NULL COMMENT 'Table name',
  `table_status` int(11) DEFAULT '0' COMMENT '0 unused 1 in use',
  `begin_use_date` datetime DEFAULT NULL COMMENT 'table start in use',
  `create_date` datetime DEFAULT NULL COMMENT 'start time of table',
  `update_date` datetime DEFAULT NULL COMMENT 'time of updateing information of table',
  `disabled` int(11) DEFAULT '0' COMMENT '1 is delete',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_dinner_table` */

insert  into `tb_dinner_table`(`id`,`table_Name`,`table_status`,`begin_use_date`,`create_date`,`update_date`,`disabled`) values (1,'Table No.1',1,NULL,'2020-03-29 00:00:00','2020-03-29 15:14:53',0),(2,'Table No.2',1,NULL,'2020-03-29 00:00:00','2020-03-29 14:44:44',0),(3,'Table No.3',1,NULL,'2020-03-29 00:00:00','2020-03-29 16:05:52',0);

/*Table structure for table `tb_food` */

DROP TABLE IF EXISTS `tb_food`;

CREATE TABLE `tb_food` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(20) DEFAULT NULL COMMENT 'food name',
  `foodType_id` int(11) DEFAULT NULL COMMENT 'food type id',
  `price` double DEFAULT NULL COMMENT 'price',
  `discount` double DEFAULT '1' COMMENT 'discount',
  `remark` varchar(200) DEFAULT NULL COMMENT 'Note',
  `img` varchar(100) DEFAULT NULL COMMENT 'image of food',
  `create_date` datetime DEFAULT NULL COMMENT 'creat time of food',
  `update_date` datetime DEFAULT NULL COMMENT 'updated time of food',
  `disabled` int(11) DEFAULT '0' COMMENT '0 remained  1 deleted',
  PRIMARY KEY (`id`),
  KEY `fk_food_foodType_id` (`foodType_id`),
  CONSTRAINT `fk_food_foodType_id` FOREIGN KEY (`foodType_id`) REFERENCES `tb_food_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `tb_food` */

insert  into `tb_food`(`id`,`food_name`,`foodType_id`,`price`,`discount`,`remark`,`img`,`create_date`,`update_date`,`disabled`) values (1,'Chili Crab',1,99,0.9,'','1.jpg','2020-03-29 13:15:33','2020-03-29 14:00:15',0),(2,'Tomato & egg soup',5,39,0.9,'','2.jpg','2020-03-29 13:16:22','2020-03-29 13:19:41',0),(3,'spicy chicken wings',1,79,0.8,'','3.jpg','2020-03-29 13:18:38','2020-03-29 13:58:09',0),(4,'Honey lemon tea',2,29,0.9,'','4.jpg','2020-03-29 13:19:17',NULL,0),(5,'Papaya milk',3,39,0.9,'','5.jpg','2020-03-29 13:20:15',NULL,0),(6,'Spicy boiled fish',1,99,0.9,'','6.jpg','2020-03-29 14:40:36',NULL,0);

/*Table structure for table `tb_food_type` */

DROP TABLE IF EXISTS `tb_food_type`;

CREATE TABLE `tb_food_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) DEFAULT NULL COMMENT 'food type name',
  `create_date` datetime DEFAULT NULL COMMENT 'create time of food type',
  `update_date` datetime DEFAULT NULL COMMENT 'update time of food type',
  `disabled` int(11) DEFAULT '0' COMMENT '0 remained  1 deleted',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tb_food_type` */

insert  into `tb_food_type`(`id`,`type_name`,`create_date`,`update_date`,`disabled`) values (1,'Special menu','2020-03-29 13:14:22','2020-03-29 13:15:06',0),(2,'Beverage','2020-03-29 13:14:28',NULL,0),(3,'Dessert','2020-03-29 13:14:31',NULL,0),(4,'Appetizer','2020-03-29 13:14:36',NULL,0),(5,'Soup','2020-03-29 13:19:34',NULL,0);

/*Table structure for table `tb_order` */

DROP TABLE IF EXISTS `tb_order`;

CREATE TABLE `tb_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_code` varchar(255) DEFAULT NULL COMMENT 'order code',
  `table_id` int(11) DEFAULT NULL COMMENT 'table id of order',
  `total_Price` double DEFAULT NULL COMMENT 'total price',
  `order_Status` int(11) DEFAULT '0' COMMENT '0 ordered not paid  1 paid',
  `order_Date` datetime DEFAULT NULL COMMENT 'order created time',
  `pay_date` datetime DEFAULT NULL COMMENT 'pay time',
  `disabled` int(11) DEFAULT '0' COMMENT '0 remained  1 deleted',
  `update_date` date DEFAULT NULL,
  `create_userId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_table_id` (`table_id`),
  CONSTRAINT `order_table_id` FOREIGN KEY (`table_id`) REFERENCES `tb_dinner_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_order` */

insert  into `tb_order`(`id`,`order_code`,`table_id`,`total_Price`,`order_Status`,`order_Date`,`pay_date`,`disabled`,`update_date`,`create_userId`) values (1,'OP-20200329144344061bb5e6-0ebd-4547-918e-39ed9fffdc28',2,152.3,1,'2020-03-29 14:43:44','2020-03-29 00:00:00',0,'2020-03-29','1'),(2,'OP-20200329144445245c6ab1-51a4-43bd-8b20-e59bc76e2f28',2,35.1,0,'2020-03-29 14:44:45',NULL,0,NULL,'1'),(3,'OP-2020032915145361981643-1005-4121-bbda-bcf0d36debb1',1,89.10000000000001,0,'2020-03-29 15:14:53',NULL,0,NULL,'6');

/*Table structure for table `tb_order_detail` */

DROP TABLE IF EXISTS `tb_order_detail`;

CREATE TABLE `tb_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL COMMENT 'order id',
  `food_id` int(11) DEFAULT NULL COMMENT 'food id',
  `buyNum` int(11) DEFAULT NULL COMMENT 'buy number',
  `disabled` int(11) DEFAULT '0' COMMENT '0 normal 1 deleted',
  `discount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orderDetail_order_id` (`orderId`),
  KEY `orderDetail_food_id` (`food_id`),
  CONSTRAINT `orderDetail_food_id` FOREIGN KEY (`food_id`) REFERENCES `tb_food` (`id`),
  CONSTRAINT `orderDetail_order_id` FOREIGN KEY (`orderId`) REFERENCES `tb_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tb_order_detail` */

insert  into `tb_order_detail`(`id`,`orderId`,`food_id`,`buyNum`,`disabled`,`discount`) values (1,1,1,1,0,0.9),(2,1,3,1,0,0.8),(3,2,3,1,1,0.8),(4,2,5,1,0,0.9),(5,3,1,1,0,0.9);

/*Table structure for table `tb_user` */

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(50) DEFAULT NULL COMMENT 'Login name',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT 'Password',
  `EMAIL` varchar(50) DEFAULT NULL COMMENT 'Email',
  `PHONE` varchar(20) DEFAULT NULL COMMENT 'Phone',
  `CREATE_DATE` datetime DEFAULT NULL COMMENT 'create time',
  `DISABLED` tinyint(1) DEFAULT '0' COMMENT '0 normal 1 deleted',
  `create_userId` int(11) DEFAULT NULL COMMENT 'create user id',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `LOGIN_NAME` (`LOGIN_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `tb_user` */

insert  into `tb_user`(`ID`,`LOGIN_NAME`,`PASSWORD`,`EMAIL`,`PHONE`,`CREATE_DATE`,`DISABLED`,`create_userId`) values (1,'admin','111','test1@qq.com','13539909241','2020-03-19 12:55:44',0,NULL),(2,'Si Li','123456','10965@qq.com','13539909241','2020-03-19 13:01:02',0,1),(3,'Han Wu','111','1095402822@qq.com','13539909241','2020-03-29 14:52:35',0,1),(4,'Helen Zha','111','1095402821@qq.com','13539909241','2020-03-29 14:53:49',0,1),(5,'Jeffery Banks','111','1095402829@qq.com','13539909242','2020-03-29 15:06:06',0,1),(6,'Tim Wang','111','2095402822@qq.com','13539909241','2020-03-29 15:07:24',0,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
