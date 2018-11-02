CREATE DATABASE  IF NOT EXISTS `fetchr_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fetchr_db`;
-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: fetchr_db
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `favorites` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`, `product_id`),
  CONSTRAINT `favorites_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `favorites_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Order_Summary`
--

DROP TABLE IF EXISTS `Order_Summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Order_Summary` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Summary`
--

LOCK TABLES `Order_Summary` WRITE;
/*!40000 ALTER TABLE `Order_Summary` DISABLE KEYS */;
INSERT INTO `Order_Summary` VALUES (1,3,5), (1,2,3), (1,7,3), (1,4,5), (1,9,2), (2,1,1), (3,3,3), (3,2,1), (3,6,2), (4,5,3), (4,4,4), (5,6,1), (5,2,1), (5,3,3), (6,7,1), (6,6,100), (6,2,1), (7,3,2), (7,2,1), (8,2,2), (8,4,2), (8,5,2), (8,7,2), (8,8,2), (9,10,1), (9,2,2), (9,11,2), (10,3,3), (10,2,2), (11,12,1), (11,1,1), (12,12,4), (12,7,1), (12,6,1), (12,5,1), (12,4,1), (12,3,1), (12,2,1), (12,1,1), (13,5,4), (13,4,4), (13,3,4), (13,1,1), (13,11,2), (14,2,5), (14,3,7), (14,5,8), (14,1,1), (15,1,1), (16,1,1), (17,1,1), (18,1,1), (19,1,1), (20,12,1), (20,2,1), (20,3,1), (20,1,1), (21,1,1), (22,6,4), (22,7,2), (22,3,4), (22,9,3), (22,4,1), (23,9,6), (23,8,4), (23,4,4), (23,5,1), (23,1,1), (24,5,8), (24,4,8), (24,3,8), (24,2,1), (25,1,1), (26,1,1), (26,4,5), (27,2,5), (27,4,7), (27,6,9), (27,8,1), (28,1,1), (29,1,1), (30,5,6), (30,3,7), (30,9,8), (30,1,1), (31,1,1), (32,1,1), (33,5,9), (33,4,6), (33,2,8), (33,1,1), (34,21,2), (34,12,7), (34,1,1), (35,11,2), (35,1,1), (36,9,3), (36,6,4), (36,4,4), (36,1,1), (37,1,1), (38,32,1), (38,23,1), (38,1,1), (39,16,1), (40,13,1), (41,1,1), (42,15,1), (43,1,1), (44,1,1), (45,1,1), (46,2,9), (46,5,9), (46,31,1), (47,11,1), (48,21,1), (49,16,1), (50,1,1), (50,2,2), (50,4,52), (50,6,2), (50,8,2), (50,22,4);
/*!40000 ALTER TABLE `Order_Summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `delivery_status` varchar(15) DEFAULT NULL,
  `time_delivered` datetime,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_total` decimal(5,2),
  PRIMARY KEY (`order_id`),
  KEY `courier_fk_idx` (`courier_id`),
  KEY `customer_fk_idx` (`customer_id`),
  CONSTRAINT `courier_fk` FOREIGN KEY (`courier_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,11,6,'pending','2011-12-18 13:17:17','2011-12-18 13:17:17',2.50),(2,11,4,'delivered','2011-12-18 13:17:18','2011-12-18 13:17:18',2.36),(3,10,15,'in-progress','2011-12-18 13:17:19','2011-12-18 13:17:19',2.51),(4,6,4,'pending','2011-12-18 13:17:20','2011-12-18 13:17:20',7.67),(5,9,10,'delivered','2011-12-18 13:17:21','2011-12-18 13:17:21',6.26),(6,5,4,'in-progress','2011-12-18 13:17:22','2011-12-18 13:17:22',6.74),(7,3,15,'pending','2011-12-18 13:17:23','2011-12-18 13:17:23',6.15),(8,10,3,'delivered','2011-12-18 13:17:24','2011-12-18 13:17:24',8.84),(9,2,1,'in-progress','2011-12-18 13:17:25','2011-12-18 13:17:25',4.19),(10,5,2,'pending','2011-12-18 13:17:26','2011-12-18 13:17:26',8.84),(11,6,5,'delivered','2011-12-18 13:17:27','2011-12-18 13:17:27',6.48),(12,2,13,'in-progress','2011-12-18 13:17:28','2011-12-18 13:17:28',6.59),(13,3,5,'pending','2011-12-18 13:17:29','2011-12-18 13:17:29',6.70),(14,1,11,'delivered','2011-12-18 13:17:30','2011-12-18 13:17:30',0.89),(15,6,13,'in-progress','2011-12-18 13:17:31','2011-12-18 13:17:31',7.50),(16,10,5,'pending','2011-12-18 13:17:32','2011-12-18 13:17:32',8.38),(17,5,14,'delivered','2011-12-18 13:17:33','2011-12-18 13:17:33',6.15),(18,10,11,'in-progress','2011-12-18 13:17:34','2011-12-18 13:17:34',1.52),(19,6,15,'pending','2011-12-18 13:17:35','2011-12-18 13:17:35',5.29),(20,4,6,'delivered','2011-12-18 13:17:36','2011-12-18 13:17:36',3.50),(21,14,3,'in-progress','2011-12-18 13:17:37','2011-12-18 13:17:37',2.48),(22,7,9,'pending','2011-12-18 13:17:38','2011-12-18 13:17:38',0.27),(23,8,5,'delivered','2011-12-18 13:17:39','2011-12-18 13:17:39',6.14),(24,3,4,'in-progress','2011-12-18 13:17:40','2011-12-18 13:17:40',7.97),(25,2,5,'pending','2011-12-18 13:17:41','2011-12-18 13:17:41',4.57),(26,1,7,'delivered','2011-12-18 13:17:42','2011-12-18 13:17:42',8.94),(27,15,4,'in-progress','2011-12-18 13:17:43','2011-12-18 13:17:43',9.00),(28,14,12,'pending','2011-12-18 13:17:44','2011-12-18 13:17:44',0.22),(29,3,7,'delivered','2011-12-18 13:17:45','2011-12-18 13:17:45',0.57),(30,9,5,'in-progress','2011-12-18 13:17:46','2011-12-18 13:17:46',0.36),(31,1,14,'pending','2011-12-18 13:17:47','2011-12-18 13:17:47',4.89),(32,5,8,'delivered','2011-12-18 13:17:48','2011-12-18 13:17:48',3.82),(33,15,7,'in-progress','2011-12-18 13:17:49','2011-12-18 13:17:49',2.35),(34,2,8,'pending','2011-12-18 13:17:50','2011-12-18 13:17:50',0.18),(35,14,7,'delivered','2011-12-18 13:17:51','2011-12-18 13:17:51',4.99),(36,6,5,'in-progress','2011-12-18 13:17:52','2011-12-18 13:17:52',6.90),(37,8,11,'pending','2011-12-18 13:17:53','2011-12-18 13:17:53',6.09),(38,3,4,'delivered','2011-12-18 13:17:54','2011-12-18 13:17:54',0.51),(39,15,8,'in-progress','2011-12-18 13:17:55','2011-12-18 13:17:55',7.94),(40,15,10,'pending','2011-12-18 13:17:56','2011-12-18 13:17:56',1.50),(41,2,8,'delivered','2011-12-18 13:17:57','2011-12-18 13:17:57',0.31),(42,7,2,'in-progress','2011-12-18 13:17:58','2011-12-18 13:17:58',5.58),(43,12,2,'pending','2011-12-18 13:17:59','2011-12-18 13:17:59',7.11),(44,7,11,'delivered','2011-12-18 13:17:00','2011-12-18 13:17:50',8.32),(45,2,3,'in-progress','2011-12-18 13:17:00','2011-12-18 13:17:00',5.80),(46,11,12,'pending','2011-12-18 13:17:01','2011-12-18 13:17:02',7.81),(47,3,2,'delivered','2011-12-18 13:17:01','2011-12-18 13:17:03',1.73),(48,5,15,'in-progress','2011-12-18 13:17:01','2011-12-18 13:17:04',8.75),(49,13,5,'pending','2011-12-18 13:17:01','2011-12-18 13:17:05',2.50),(50,10,8,'delivered','2011-12-18 13:17:01','2011-12-18 13:17:06',1.11);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(45) NOT NULL,
  `product_url` varchar(200),
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'Arizona Tea',0.99,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(2,'Dunkin Iced Coffee',1.08,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(3,'Bai ',1.81,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(4,'Coca Cola',2.42,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(5,'Pepsi',3.38,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(6,'Sprite',2.33,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(7,'Root Beer',1.49,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(8,'Milk',1.17,'drinks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(9,'Doritos Small',2.50,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(10,'Pringles',2.57,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(11,'Oreos',3.57,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(12,'Pretzels',3.08,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(13,'Cheetos',2.70,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(14,'Cheez-It',1.21,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(15,'Fritos',1.77,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(16,'Snickers',2.30,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(17,'Chex Mix',4.35,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(18,'Popcorn',2.46,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(19,'Indomie',3.52,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(20,'Ice Cream',2.10,'snacks','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(21,'Pencils',3.00,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(22,'Eraser',1.12,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(23,'Stapler',1.88,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(24,'Pen',0.92,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(25,'Notebooks',1.17,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(26,'Hole Puncher',2.85,'school_supplies','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(27,'Nyquil',5.99,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(28,'Advil',2.01,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(29,'Umbrella',1.26,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(30,'Toilet Paper',3.70,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(31,'Tissues',1.02,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg'),(32,'Sewing Kit',3.96,'misc','https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email_address` varchar(75) NOT NULL,
  `password` varchar(60) NOT NULL,
  `room_num` varchar(4) NOT NULL,
  `is_courier` tinyint(4) NOT NULL DEFAULT 0,
  `wallet` decimal(5,2) NOT NULL DEFAULT '0.00',
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `phone_number` varchar(11),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `users_cc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_cc` (
  `cc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`cc_id`, `user_id`),
  KEY `cc_fk_idx` (`cc_id`),
  KEY `user_fk_idx` (`user_id`),
  CONSTRAINT `cc_fk` FOREIGN KEY (`cc_id`) REFERENCES `cc_info` (`cc_id`),
  CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

insert into `users_cc` values (1,11),(2,11),(2,12),(1,13),(2,14),(3,16),(4,17),(2,18),(1,19),(4,1),(5,2),(6,3),(7,4),(14,5),(13,6),(18,7),(15,8),(14,9),(13,4),(17,22),(19,23),(10,24),(15,25),(13,26),(22,26),(21,26),(24,26),(27,27),(29,28),(20,29);

DROP TABLE IF EXISTS `Cc_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Cc_info` (
  `cc_id` int(11) NOT NULL AUTO_INCREMENT, 
  `credit_card_number` varchar(25) NOT NULL,
  `ccv` varchar(4) NOT NULL,
  `exp_date` varchar(4) NOT NULL,
  PRIMARY KEY (`cc_id`),
  UNIQUE KEY `cc_id_unique` (`cc_id`),
  UNIQUE KEY `credit_card_number_unique` (`credit_card_number`) 
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

insert into `Cc_info` (credit_card_number, ccv, exp_date) values ('3566002040360500','459','1219'),('5547899423555470','802','1220'),('3566002020860500','422','1221'),('5547819433555470','242','1222'),('3566003020360500','265','1223'),('5547899833555470','544','1224'),('3566002120360500','226','1225'),('5147899433555470','419','1226'),('3566005020360500','911','1227'),('5547899333555470','238','1228'),('3566002720360500','964','1229'),('5590899423555470','677','1230'),('3566002021360500','885','1211'),('5542899433555470','260','1212'),('3566002020368500','707','1213'),('8547899433555470','461','1214'),('3526002020360500','889','1215'),('5554899433555470','371','1216'),('3236002020360500','955','1217'),('5547888833555470','742','1218'),('8888002020360500','677','1219'),('1237899433555470','928','1210'),('3216002020360500','628','1201'),('2317899433555470','509','1202'),('4446002020360500','283','1203'),('5542349433555470','312','1204'),('9966002020360500','406','1205'),('5547833433555470','609','1206'),('3566002440360500','961','1207'),('5547894433555470','229','1208');
--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'2018-09-25 09:22:11','nec@lectuspedeet.ca',':(lTD3I0','3353',1,12.75,'Joya  ','Short', 1,'19073948827'),(2,'2018-09-25 09:22:11','velit.in.aliquet@at.edu',':(lTD3I1','1531',0,3.70,'Damaris  ','Stanley', 1,'19073948827'),(3,'2018-09-25 09:22:11','nulla.ante@Duis.co.uk',':(lTD3I2','4156',1,12.11,'Debbie  ','Novak', 1,'19073948827'),(4,'2018-09-25 09:22:11','Phasellus.ornare.Fusce@Fuscediamnunc.co.uk',':(lTD3I3','1743',1,9.28,'Yolanda  ','Weiss', 1,'19073948827'),(5,'2018-09-25 09:22:11','Phasellus.dapibus.quam@sit.net',':(lTD3I4','2038',0,13.32,'Mina  ','Best', 1,'19073948827'),(6,'2018-09-25 09:22:11','lectus@tortorat.co.uk',':(lTD3I5','5233',1,6.49,'Hollis  ','Guzman', 1,'19073948827'),(7,'2018-09-25 09:22:11','in.aliquet.lobortis@congue.ca',':(lTD3I6','1167',1,6.24,'Hilario  ','Hill', 1,'19073948827'),(8,'2018-09-25 09:22:11','Mauris.blandit@dignissimpharetra.org',':(lTD3I7','1877',0,7.72,'Cami  ','Daniel', 1,'19073948827'),(9,'2018-09-25 09:22:11','Ut.tincidunt.orci@enim.ca',':(lTD3I8','4488',1,5.06,'Gerardo  ','Gutierrez', 1,'19073948827'),(10,'2018-09-25 09:22:11','sed.turpis@massaQuisqueporttitor.org',':(lTD3I9','2452',0,14.69,'Britni  ','Drake', 1,'19073948827'),(11,'2018-09-25 09:22:11','fringilla.euismod@quisurnaNunc.co.uk',':(lTD3I10','2282',1,20.90,'Sixta  ','Hickman', 1,'19073948827'),(12,'2018-09-25 09:22:11','vulputate.magna@Cumsociisnatoque.net',':(lTD3I11','1742',1,18.59,'Rudolf  ','Cardenas', 1,'19073948827'),(13,'2018-09-25 09:22:11','Ut@Donec.net',':(lTD3I12','4870',0,8.63,'Janette  ','Hodges', 1,'19073948827'),(14,'2018-09-25 09:22:11','et@et.edu',':(lTD3I13','2807',0,23.34,'Rich  ','Bolton', 1,'19073948827'),(15,'2018-09-25 09:22:11','elit.Nulla.facilisi@aliquamadipiscing.edu',':(lTD3I14','6208',1,15.31,'Cherry  ','Carney', 1,'19073948827'),(16,'2018-09-25 09:22:11','ipsum@suscipitnonummyFusce.ca',':(lTD3I15','3639',0,18.49,'Enedina  ','Tyler', 1,'19073948827'),(17,'2018-09-25 09:22:11','libero.lacus.varius@parturientmontes.com',':(lTD3I16','1444',1,19.00,'Shane  ','Farley', 1,'19073948827'),(18,'2018-09-25 09:22:11','Vivamus.sit.amet@cursuset.ca',':(lTD3I17','1644',1,1.93,'Bess  ','Brennan', 1,'19073948827'),(19,'2018-09-25 09:22:11','luctus.et.ultrices@Duisatlacus.com',':(lTD3I18','5822',0,5.49,'Lyndsay  ','Hanson', 1,'19073948827'),(20,'2018-09-25 09:22:11','Duis.ac@tinciduntdui.edu',':(lTD3I19','6476',1,3.93,'Hwa  ','Hardy', 1,'19073948827'),(21,'2018-09-25 09:22:11','eget@rutrum.edu',':(lTD3I20','4272',1,13.77,'Jasmine  ','Dorsey', 1,'19073948827'),(22,'2018-09-25 09:22:11','amet.luctus@mipedenonummy.net',':(lTD3I21','5168',0,11.60,'Bethann  ','Blake', 1,'19073948827'),(23,'2018-09-25 09:22:11','dolor@ligulaNullam.org',':(lTD3I22','3263',1,17.95,'Drucilla  ','Walton', 1,'19073948827'),(24,'2018-09-25 09:22:11','egestas.lacinia@morbitristique.co.uk',':(lTD3I23','6008',0,7.20,'Lourie  ','Wilkins', 1,'19073948827'),(25,'2018-09-25 09:22:11','quis.tristique@eunibh.net',':(lTD3I24','6240',1,15.95,'Ching  ','Myers', 1,'19073948827'),(26,'2018-09-25 09:22:11','augue@eumetusIn.net',':(lTD3I25','1925',1,17.44,'Kattie  ','Duarte', 1,'19073948827'),(27,'2018-09-25 09:22:11','lectus@Maurismagna.org',':(lTD3I26','3920',0,16.14,'Morris  ','Parrish', 1,'19073948827'),(28,'2018-09-25 09:22:11','quis@Maurisblandit.co.uk',':(lTD3I27','2868',0,8.59,'Makeda  ','Vaughan', 1,'19073948827'),(29,'2018-09-25 09:22:11','Nunc.ullamcorper@iaculisneceleifend.org',':(lTD3I28','2424',0,9.66,'Ashlie  ','Gibson', 1,'19073948827'),(30,'2018-09-25 09:22:11','ut.quam.vel@molestietellusAenean.com',':(lTD3I29','2782',1,12.73,'Malorie  ','Craig', 1,'19073832737');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

CREATE view fetchr_db.product_records as
SELECT Products.*,  ifnull(sum(Order_Summary.quantity),0) as 'total_sold' 
  FROM fetchr_db.Products left OUTER JOIN fetchr_db.Order_summary
    ON Order_Summary.product_id = Products.product_id
 group by product_id;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-28 12:32:53
