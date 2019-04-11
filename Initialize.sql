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
-- Table structure for table `order_summary`
--

DROP TABLE IF EXISTS `order_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_summary` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_summary`
--

LOCK TABLES `order_summary` WRITE;
/*!40000 ALTER TABLE `order_summary` DISABLE KEYS */;
INSERT INTO `order_summary` VALUES (1,3,5), (1,2,3), (1,7,3), (1,4,5), (1,9,2), (2,1,1), (3,3,3), (3,2,1), (3,6,2), (4,5,3), (4,4,4), (5,6,1), (5,2,1), (5,3,3), (6,7,1), (6,6,100), (6,2,1), (7,3,2), (7,2,1), (8,2,2), (8,4,2), (8,5,2), (8,7,2), (8,8,2), (9,10,1), (9,2,2), (9,11,2), (10,3,3), (10,2,2), (11,12,1), (11,1,1), (12,12,4), (12,7,1), (12,6,1), (12,5,1), (12,4,1), (12,3,1), (12,2,1), (12,1,1), (13,5,4), (13,4,4), (13,3,4), (13,1,1), (13,11,2), (14,2,5), (14,3,7), (14,5,8), (14,1,1), (15,1,1), (16,1,1), (17,1,1), (18,1,1), (19,1,1), (20,12,1), (20,2,1), (20,3,1), (20,1,1), (21,1,1), (22,6,4), (22,7,2), (22,3,4), (22,9,3), (22,4,1), (23,9,6), (23,8,4), (23,4,4), (23,5,1), (23,1,1), (24,5,8), (24,4,8), (24,3,8), (24,2,1), (25,1,1), (26,1,1), (26,4,5), (27,2,5), (27,4,7), (27,6,9), (27,8,1), (28,1,1), (29,1,1), (30,5,6), (30,3,7), (30,9,8), (30,1,1), (31,1,1), (32,1,1), (33,5,9), (33,4,6), (33,2,8), (33,1,1), (34,21,2), (34,12,7), (34,1,1), (35,11,2), (35,1,1), (36,9,3), (36,6,4), (36,4,4), (36,1,1), (37,1,1), (38,32,1), (38,23,1), (38,1,1), (39,16,1), (40,13,1), (41,1,1), (42,15,1), (43,1,1), (44,1,1), (45,1,1), (46,2,9), (46,5,9), (46,31,1), (47,11,1), (48,21,1), (49,16,1), (50,1,1), (50,2,2), (50,4,52), (50,6,2), (50,8,2), (50,22,4);
/*!40000 ALTER TABLE `order_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `delivery_status` varchar(15) DEFAULT NULL,
  `time_delivered` datetime,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_total` decimal(6,2),
  PRIMARY KEY (`order_id`),
  KEY `courier_fk_idx` (`courier_id`),
  KEY `customer_fk_idx` (`customer_id`),
  CONSTRAINT `courier_fk` FOREIGN KEY (`courier_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,11,6,'pending','2011-12-18 13:17:17','2011-12-18 13:17:17',2.50),(2,11,4,'delivered','2011-12-18 13:17:18','2011-12-18 13:17:18',2.36),(3,10,15,'in-progress','2011-12-18 13:17:19','2011-12-18 13:17:19',2.51),(4,6,4,'pending','2011-12-18 13:17:20','2011-12-18 13:17:20',7.67),(5,9,10,'delivered','2011-12-18 13:17:21','2011-12-18 13:17:21',6.26),(6,5,4,'in-progress','2011-12-18 13:17:22','2011-12-18 13:17:22',6.74),(7,3,15,'pending','2011-12-18 13:17:23','2011-12-18 13:17:23',6.15),(8,10,3,'delivered','2011-12-18 13:17:24','2011-12-18 13:17:24',8.84),(9,2,1,'in-progress','2011-12-18 13:17:25','2011-12-18 13:17:25',4.19),(10,5,2,'pending','2011-12-18 13:17:26','2011-12-18 13:17:26',8.84),(11,6,5,'delivered','2011-12-18 13:17:27','2011-12-18 13:17:27',6.48),(12,2,13,'in-progress','2011-12-18 13:17:28','2011-12-18 13:17:28',6.59),(13,3,5,'pending','2011-12-18 13:17:29','2011-12-18 13:17:29',6.70),(14,1,11,'delivered','2011-12-18 13:17:30','2011-12-18 13:17:30',0.89),(15,6,13,'in-progress','2011-12-18 13:17:31','2011-12-18 13:17:31',7.50),(16,10,5,'pending','2011-12-18 13:17:32','2011-12-18 13:17:32',8.38),(17,5,14,'delivered','2011-12-18 13:17:33','2011-12-18 13:17:33',6.15),(18,10,11,'in-progress','2011-12-18 13:17:34','2011-12-18 13:17:34',1.52),(19,6,15,'pending','2011-12-18 13:17:35','2011-12-18 13:17:35',5.29),(20,4,6,'delivered','2011-12-18 13:17:36','2011-12-18 13:17:36',3.50),(21,14,3,'in-progress','2011-12-18 13:17:37','2011-12-18 13:17:37',2.48),(22,7,9,'pending','2011-12-18 13:17:38','2011-12-18 13:17:38',0.27),(23,8,5,'delivered','2011-12-18 13:17:39','2011-12-18 13:17:39',6.14),(24,3,4,'in-progress','2011-12-18 13:17:40','2011-12-18 13:17:40',7.97),(25,2,5,'pending','2011-12-18 13:17:41','2011-12-18 13:17:41',4.57),(26,1,7,'delivered','2011-12-18 13:17:42','2011-12-18 13:17:42',8.94),(27,15,4,'in-progress','2011-12-18 13:17:43','2011-12-18 13:17:43',9.00),(28,14,12,'pending','2011-12-18 13:17:44','2011-12-18 13:17:44',0.22),(29,3,7,'delivered','2011-12-18 13:17:45','2011-12-18 13:17:45',0.57),(30,9,5,'in-progress','2011-12-18 13:17:46','2011-12-18 13:17:46',0.36),(31,1,14,'pending','2011-12-18 13:17:47','2011-12-18 13:17:47',4.89),(32,5,8,'delivered','2011-12-18 13:17:48','2011-12-18 13:17:48',3.82),(33,15,7,'in-progress','2011-12-18 13:17:49','2011-12-18 13:17:49',2.35),(34,2,8,'pending','2011-12-18 13:17:50','2011-12-18 13:17:50',0.18),(35,14,7,'delivered','2011-12-18 13:17:51','2011-12-18 13:17:51',4.99),(36,6,5,'in-progress','2011-12-18 13:17:52','2011-12-18 13:17:52',6.90),(37,8,11,'pending','2011-12-18 13:17:53','2011-12-18 13:17:53',6.09),(38,3,4,'delivered','2011-12-18 13:17:54','2011-12-18 13:17:54',0.51),(39,15,8,'in-progress','2011-12-18 13:17:55','2011-12-18 13:17:55',7.94),(40,15,10,'pending','2011-12-18 13:17:56','2011-12-18 13:17:56',1.50),(41,2,8,'delivered','2011-12-18 13:17:57','2011-12-18 13:17:57',0.31),(42,7,2,'in-progress','2011-12-18 13:17:58','2011-12-18 13:17:58',5.58),(43,12,2,'pending','2011-12-18 13:17:59','2011-12-18 13:17:59',7.11),(44,7,11,'delivered','2011-12-18 13:17:00','2011-12-18 13:17:50',8.32),(45,2,3,'in-progress','2011-12-18 13:17:00','2011-12-18 13:17:00',5.80),(46,11,12,'pending','2011-12-18 13:17:01','2011-12-18 13:17:02',7.81),(47,3,2,'delivered','2011-12-18 13:17:01','2011-12-18 13:17:03',1.73),(48,5,15,'in-progress','2011-12-18 13:17:01','2011-12-18 13:17:04',8.75),(49,13,5,'pending','2011-12-18 13:17:01','2011-12-18 13:17:05',2.50),(50,10,8,'delivered','2011-12-18 13:17:01','2011-12-18 13:17:06',1.11);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(45) NOT NULL,
  `product_url` varchar(200) NOT NULL,
  `is_active` varchar(5) NOT NULL DEFAULT 'TRUE',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1, 'Arizona Tea', 0.99, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Arizona%20Iced%20Tea.png', 'TRUE');
INSERT INTO `products` VALUES (2, 'Dunkin Iced Coffee', 2.25, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Dunkin%20Iced%20Coffee.png', 'TRUE');
INSERT INTO `products` VALUES (3, 'Bai ', 1.81, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Bai.png', 'TRUE');
INSERT INTO `products` VALUES (4, 'Coca Cola', 1.77, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Coca%20Cola.png', 'TRUE');
INSERT INTO `products` VALUES (5, 'Pepsi', 1.77, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pepsi.png', 'TRUE');
INSERT INTO `products` VALUES (6, 'Sprite', 1.57, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sprite.png', 'TRUE');
INSERT INTO `products` VALUES (7, 'Root Beer', 1.49, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Root%20Beer.png', 'TRUE');
INSERT INTO `products` VALUES (8, 'Milk', 3.98, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Milk.png', 'TRUE');
INSERT INTO `products` VALUES (9, 'Doritos Small', 0.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Doritos.png', 'TRUE');
INSERT INTO `products` VALUES (10, 'Pringles', 1.49, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pringles.png', 'TRUE');
INSERT INTO `products` VALUES (11, 'Oreos', 3.28, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Oreo.png', 'TRUE');
INSERT INTO `products` VALUES (12, 'Pretzels', 3.08, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pretzels.png', 'TRUE');
INSERT INTO `products` VALUES (13, 'Cheetos', 3.70, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Cheetos.png', 'TRUE');
INSERT INTO `products` VALUES (14, 'Cheez-It', 2.09, 'snacks', 'https://s3.us-east-2.amazonaws.com/fetchrapp/Product+Photos/cheeze-it.jpeg', 'TRUE');
INSERT INTO `products` VALUES (16, 'Snickers', 1.32, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Snickers.png', 'TRUE');
INSERT INTO `products` VALUES (17, 'Chex Mix', 2.35, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Chex%20Mix.png', 'TRUE');
INSERT INTO `products` VALUES (18, 'Popcorn', 3.46, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Popcorn.png', 'TRUE');
INSERT INTO `products` VALUES (19, 'Indomie', 0.47, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Indomie.png', 'TRUE');
INSERT INTO `products` VALUES (20, 'Ice Cream', 2.10, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Ice%20Cream.png', 'TRUE');
INSERT INTO `products` VALUES (21, 'Pencils', 0.53, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pencils.png', 'TRUE');
INSERT INTO `products` VALUES (22, 'Eraser', 0.22, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Eraser.png', 'TRUE');
INSERT INTO `products` VALUES (23, 'Stapler', 1.88, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Stapler.png', 'TRUE');
INSERT INTO `products` VALUES (24, 'Pen', 0.82, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pen.png', 'TRUE');
INSERT INTO `products` VALUES (25, 'Notebooks', 0.60, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Notebooks.png', 'TRUE');
INSERT INTO `products` VALUES (26, 'Hole Puncher', 4.85, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Hole%20Puncher.png', 'TRUE');
INSERT INTO `products` VALUES (27, 'Nyquil', 5.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Nyquil.png', 'TRUE');
INSERT INTO `products` VALUES (28, 'Advil', 3.41, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Advil.png', 'TRUE');
INSERT INTO `products` VALUES (29, 'Umbrella', 8.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Umbrella.png', 'TRUE');
INSERT INTO `products` VALUES (30, 'Toilet Paper', 3.70, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Toilet%20Paper.png', 'TRUE');
INSERT INTO `products` VALUES (31, 'Tissues', 4.02, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Tissues.png', 'TRUE');
INSERT INTO `products` VALUES (32, 'Sewing Kit', 5.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sewing%20Kit.png', 'TRUE');
INSERT INTO `products` VALUES (33, 'Air Freshener', 2.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/air_freshener.jpg', 'TRUE');
INSERT INTO `products` VALUES (34, 'Apple', 2.87, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/apple.jpg', 'TRUE');
INSERT INTO `products` VALUES (35, 'Bag', 13.58, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bag.jpg', 'TRUE');
INSERT INTO `products` VALUES (36, 'Balloon', 0.69, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/balloon.jpg', 'TRUE');
INSERT INTO `products` VALUES (37, 'Bananas', 2.65, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bananas.jpg', 'TRUE');
INSERT INTO `products` VALUES (38, 'Bed', 49.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bed.jpg', 'TRUE');
INSERT INTO `products` VALUES (39, 'Beef', 28.23, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/beef.jpg', 'TRUE');
INSERT INTO `products` VALUES (40, 'Blanket', 9.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blanket.jpg', 'TRUE');
INSERT INTO `products` VALUES (41, 'Blouse', 7.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blouse.jpg', 'TRUE');
INSERT INTO `products` VALUES (42, 'Book', 14.86, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/book.jpg', 'TRUE');
INSERT INTO `products` VALUES (43, 'Bookmark', 8.35, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bookmark.jpg', 'TRUE');
INSERT INTO `products` VALUES (44, 'Boom Box', 17.45, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/boom_box.jpg', 'TRUE');
INSERT INTO `products` VALUES (45, 'Bottle Cap', 0.20, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle_cap.jpg', 'TRUE');
INSERT INTO `products` VALUES (46, 'Bottle', 8.72, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle.jpg', 'TRUE');
INSERT INTO `products` VALUES (47, 'Bow', 31.77, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bow.jpg', 'TRUE');
INSERT INTO `products` VALUES (48, 'Bowl', 2.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bowl.jpg', 'TRUE');
INSERT INTO `products` VALUES (49, 'Box', 6.46, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/box.jpg', 'TRUE');
INSERT INTO `products` VALUES (50, 'Bracelet', 0.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bracelet.jpg', 'TRUE');
INSERT INTO `products` VALUES (51, 'Bread', 5.18, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bread.jpg', 'TRUE');
INSERT INTO `products` VALUES (52, 'Brocolli', 3.26, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/brocolli.jpg', 'TRUE');
INSERT INTO `products` VALUES (53, 'Buckle', 13.04, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/buckel.jpg', 'TRUE');
INSERT INTO `products` VALUES (54, 'Button', 7.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/button.jpg', 'TRUE');
INSERT INTO `products` VALUES (55, 'Camera', 47.92, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/camera.jpg', 'TRUE');
INSERT INTO `products` VALUES (56, 'Candle', 0.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candle.jpg', 'TRUE');
INSERT INTO `products` VALUES (57, 'Candy Wrapper', 0.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candy_wrapper.jpg', 'TRUE');
INSERT INTO `products` VALUES (58, 'Canvas', 4.81, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/canvas.jpg', 'TRUE');
INSERT INTO `products` VALUES (59, 'Car', 937.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/car.jpg', 'TRUE');
INSERT INTO `products` VALUES (60, 'Carrots', 5.80, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/carrots.jpg', 'TRUE');
INSERT INTO `products` VALUES (61, 'Cat', 14.49, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cat.jpg', 'TRUE');
INSERT INTO `products` VALUES (62, 'Cd', 0.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cd.jpg', 'TRUE');
INSERT INTO `products` VALUES (63, 'Cell Phone', 24.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cell_phone.jpg', 'TRUE');
INSERT INTO `products` VALUES (64, 'Chair', 12.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chair.jpg', 'TRUE');
INSERT INTO `products` VALUES (65, 'Chalk', 1.28, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chalk.jpg', 'TRUE');
INSERT INTO `products` VALUES (66, 'Chapter Book', 4.37, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chapter_book.jpg', 'TRUE');
INSERT INTO `products` VALUES (67, 'Charger', 16.51, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/charger.jpg', 'TRUE');
INSERT INTO `products` VALUES (68, 'Checkbook', 8.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/checkbook.jpg', 'TRUE');
INSERT INTO `products` VALUES (69, 'Chocolate', 6.41, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chocolate.jpg', 'TRUE');
INSERT INTO `products` VALUES (70, 'Cinder Block', 17.99, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cinder_block.jpg', 'TRUE');
INSERT INTO `products` VALUES (71, 'Clamp', 7.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clamp.jpg', 'TRUE');
INSERT INTO `products` VALUES (72, 'Clay Pot', 5.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clay_pot.jpg', 'TRUE');
INSERT INTO `products` VALUES (73, 'Clock', 25.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clock.jpg', 'TRUE');
INSERT INTO `products` VALUES (74, 'Clothes', 19.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clothes.jpg', 'TRUE');
INSERT INTO `products` VALUES (75, 'Coasters', 22.94, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/coasters.jpg', 'TRUE');
INSERT INTO `products` VALUES (76, 'Computer', 121.71, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/computer.jpg', 'TRUE');
INSERT INTO `products` VALUES (77, 'Conditioner', 9.05, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/conditioner.jpg', 'TRUE');
INSERT INTO `products` VALUES (78, 'Controller', 25.93, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/controller.jpg', 'TRUE');
INSERT INTO `products` VALUES (79, 'Cookie Jar', 7.76, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cookie_jar.jpg', 'TRUE');
INSERT INTO `products` VALUES (80, 'Cork', 6.41, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cork.jpg', 'TRUE');
INSERT INTO `products` VALUES (81, 'Couch', 74.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/couch.jpg', 'TRUE');
INSERT INTO `products` VALUES (82, 'Credit Card', 49.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/credit_card.jpg', 'TRUE');
INSERT INTO `products` VALUES (83, 'Cup', 6.36, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cup.jpg', 'TRUE');
INSERT INTO `products` VALUES (84, 'Deodorant ', 0.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/deodorant_.jpg', 'TRUE');
INSERT INTO `products` VALUES (85, 'Desk', 12.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/desk.jpg', 'TRUE');
INSERT INTO `products` VALUES (86, 'Doll', 6.57, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/doll.jpg', 'TRUE');
INSERT INTO `products` VALUES (87, 'Door', 34.59, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/door.jpg', 'TRUE');
INSERT INTO `products` VALUES (88, 'Drawer', 26.09, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/drawer.jpg', 'TRUE');
INSERT INTO `products` VALUES (91, 'Eye Liner', 7.26, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/eye_liner.jpg', 'TRUE');
INSERT INTO `products` VALUES (92, 'Face Wash', 13.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/face_wash.jpg', 'TRUE');
INSERT INTO `products` VALUES (93, 'Fake Flowers', 3.70, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fake_flowers.jpg', 'TRUE');
INSERT INTO `products` VALUES (94, 'Flag', 9.55, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flag.jpg', 'TRUE');
INSERT INTO `products` VALUES (96, 'Flowers', 28.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flowers.jpg', 'TRUE');
INSERT INTO `products` VALUES (98, 'Fork', 3.21, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fork.jpg', 'TRUE');
INSERT INTO `products` VALUES (99, 'Fridge', 394.34, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fridge.jpg', 'TRUE');
INSERT INTO `products` VALUES (100, 'Glass', 26.04, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glass.jpg', 'TRUE');
INSERT INTO `products` VALUES (101, 'Glasses', 17.43, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glasses.jpg', 'TRUE');
INSERT INTO `products` VALUES (102, 'Glow Stick', 5.78, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glow_stick.jpg', 'TRUE');
INSERT INTO `products` VALUES (103, 'Greeting Card', 1.55, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/greeting_card.jpg', 'TRUE');
INSERT INTO `products` VALUES (104, 'Grid Paper', 0.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/grid_paper.jpg', 'TRUE');
INSERT INTO `products` VALUES (105, 'Hair Brush', 1.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_brush.jpg', 'TRUE');
INSERT INTO `products` VALUES (106, 'Hair Tie', 0.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_tie.jpg', 'TRUE');
INSERT INTO `products` VALUES (107, 'Hanger', 0.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hanger.jpg', 'TRUE');
INSERT INTO `products` VALUES (108, 'Headphones', 12.65, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/headphones.jpg', 'TRUE');
INSERT INTO `products` VALUES (109, 'Helmet', 3.06, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/helmet.jpg', 'TRUE');
INSERT INTO `products` VALUES (111, 'Ice Cube Tray', 4.83, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ice_cube_tray.jpg', 'TRUE');
INSERT INTO `products` VALUES (112, 'Ipod', 43.08, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ipod.jpg', 'TRUE');
INSERT INTO `products` VALUES (113, 'Key Chain', 0.37, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/key_chain.jpg', 'TRUE');
INSERT INTO `products` VALUES (114, 'Keyboard', 19.06, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keyboard.jpg', 'TRUE');
INSERT INTO `products` VALUES (115, 'Keys', 12.03, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keys.jpg', 'TRUE');
INSERT INTO `products` VALUES (116, 'Knife', 5.86, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/knife.jpg', 'TRUE');
INSERT INTO `products` VALUES (118, 'Lamp', 12.12, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp_shade.jpg', 'TRUE');
INSERT INTO `products` VALUES (119, 'Lamp Shade', 6.58, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp.jpg', 'TRUE');
INSERT INTO `products` VALUES (120, 'Leg Warmers', 9.64, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/leg_warmers.jpg', 'TRUE');
INSERT INTO `products` VALUES (121, 'Lip Gloss', 1.51, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lip_gloss.jpg', 'TRUE');
INSERT INTO `products` VALUES (122, 'Lotion', 7.90, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lotion.jpg', 'TRUE');
INSERT INTO `products` VALUES (123, 'Magnet', 0.29, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/magnet.jpg', 'TRUE');
INSERT INTO `products` VALUES (125, 'Mirror', 10.33, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mirror.jpg', 'TRUE');
INSERT INTO `products` VALUES (128, 'Monitor', 32.03, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/monitor.jpg', 'TRUE');
INSERT INTO `products` VALUES (129, 'Mop', 15.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mop.jpg', 'TRUE');
INSERT INTO `products` VALUES (130, 'Mouse Pad', 7.74, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mouse_pad.jpg', 'TRUE');
INSERT INTO `products` VALUES (131, 'Mp3 Player', 8.50, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mp3_player.jpg', 'TRUE');
INSERT INTO `products` VALUES (132, 'Nail Clippers', 6.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_clippers.jpg', 'TRUE');
INSERT INTO `products` VALUES (133, 'Nail File', 9.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_file.jpg', 'TRUE');
INSERT INTO `products` VALUES (134, 'Needle', 0.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/needle.jpg', 'TRUE');
INSERT INTO `products` VALUES (137, 'Packing Peanuts', 3.33, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/packing_peanuts.jpg', 'TRUE');
INSERT INTO `products` VALUES (138, 'Paint Brush', 1.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paint_brush.jpg', 'TRUE');
INSERT INTO `products` VALUES (139, 'Pants', 11.17, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pants.jpg', 'TRUE');
INSERT INTO `products` VALUES (140, 'Paper', 0.50, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paper.jpg', 'TRUE');
INSERT INTO `products` VALUES (141, 'Pen', 2.57, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pen.jpg', 'TRUE');
INSERT INTO `products` VALUES (142, 'Pencil', 0.77, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pencil.jpg', 'TRUE');
INSERT INTO `products` VALUES (143, 'Perfume', 33.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/perfume.jpg', 'TRUE');
INSERT INTO `products` VALUES (144, 'Phone', 9.70, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/phone.jpg', 'TRUE');
INSERT INTO `products` VALUES (145, 'Photo Album', 1.21, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/photo_album.jpg', 'TRUE');
INSERT INTO `products` VALUES (146, 'Piano', 100.30, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/piano.jpg', 'TRUE');
INSERT INTO `products` VALUES (147, 'Picture Frame', 3.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/picture_frame.jpg', 'TRUE');
INSERT INTO `products` VALUES (148, 'Pillow', 9.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pillow.jpg', 'TRUE');
INSERT INTO `products` VALUES (149, 'Plastic Fork', 1.52, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plastic_fork.jpg', 'TRUE');
INSERT INTO `products` VALUES (150, 'Plate', 2.10, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plate.jpg', 'TRUE');
INSERT INTO `products` VALUES (154, 'Purse', 50.92, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/purse.jpg', 'TRUE');
INSERT INTO `products` VALUES (155, 'Radio', 1.17, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/radio.jpg', 'TRUE');
INSERT INTO `products` VALUES (156, 'Remote', 12.85, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/remote.jpg', 'TRUE');
INSERT INTO `products` VALUES (157, 'Ring', 605.99, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ring.jpg', 'TRUE');
INSERT INTO `products` VALUES (158, 'Rubber Band', 12.01, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_band.jpg', 'TRUE');
INSERT INTO `products` VALUES (159, 'Rubber Duck', 5.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_duck.jpg', 'TRUE');
INSERT INTO `products` VALUES (160, 'Rug', 13.70, 'musc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rug.jpg', 'TRUE');
INSERT INTO `products` VALUES (161, 'Rusty Nail', 1.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rusty_nail.jpg', 'TRUE');
INSERT INTO `products` VALUES (162, 'Sailboat', 483.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sailboat.jpg', 'TRUE');
INSERT INTO `products` VALUES (163, 'Sand Paper', 5.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sand_paper.jpg', 'TRUE');
INSERT INTO `products` VALUES (164, 'Sandal', 21.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sandal.jpg', 'TRUE');
INSERT INTO `products` VALUES (165, 'Scotch Tape', 5.58, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/scotch_tape.jpg', 'TRUE');
INSERT INTO `products` VALUES (166, 'Screw', 1.39, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/screw.jpg', 'TRUE');
INSERT INTO `products` VALUES (167, 'Seat Belt', 55.65, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/seat_belt.jpg', 'TRUE');
INSERT INTO `products` VALUES (168, 'Shampoo', 6.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shampoo.jpg', 'TRUE');
INSERT INTO `products` VALUES (169, 'Sharpie', 2.23, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sharpie.jpg', 'TRUE');
INSERT INTO `products` VALUES (170, 'Shawl', 9.83, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shawl.jpg', 'TRUE');
INSERT INTO `products` VALUES (171, 'Shirt', 9.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shirt.jpg', 'TRUE');
INSERT INTO `products` VALUES (172, 'Shoe Lace', 1.84, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoe_lace.jpg', 'TRUE');
INSERT INTO `products` VALUES (173, 'Shoes', 20.50, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoes.jpg', 'TRUE');
INSERT INTO `products` VALUES (174, 'Shovel', 17.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shovel.jpg', 'TRUE');
INSERT INTO `products` VALUES (176, 'Sketch Pad', 15.72, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sketch_pad.jpg', 'TRUE');
INSERT INTO `products` VALUES (177, 'Slipper', 21.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/slipper.jpg', 'TRUE');
INSERT INTO `products` VALUES (178, 'Soap', 35.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soap.jpg', 'TRUE');
INSERT INTO `products` VALUES (179, 'Socks', 3.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/socks.jpg', 'TRUE');
INSERT INTO `products` VALUES (180, 'Soda Can', 1.35, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soda_can.jpg', 'TRUE');
INSERT INTO `products` VALUES (181, 'Sofa', 104.18, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sofa.jpg', 'TRUE');
INSERT INTO `products` VALUES (182, 'Soy Sauce Packet', .86, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soy_sauce_packet.jpg', 'TRUE');
INSERT INTO `products` VALUES (183, 'Speakers', 31.04, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/speakers.jpg', 'TRUE');
INSERT INTO `products` VALUES (184, 'Sponge', 2.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sponge.jpg', 'TRUE');
INSERT INTO `products` VALUES (185, 'Spoon', 3.92, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spoon.jpg', 'TRUE');
INSERT INTO `products` VALUES (186, 'Spring', 2.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spring.jpg', 'TRUE');
INSERT INTO `products` VALUES (187, 'Sticky Note', 0.45, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sticky_note.jpg', 'TRUE');
INSERT INTO `products` VALUES (188, 'Stockings', 14.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stockings.jpg', 'TRUE');
INSERT INTO `products` VALUES (189, 'Stop Sign', 17.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stop_sign.jpg', 'TRUE');
INSERT INTO `products` VALUES (190, 'Street Lights', 54.80, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/street_lights.jpg', 'TRUE');
INSERT INTO `products` VALUES (191, 'Sun Glasses', 11.49, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sun_glasses.jpg', 'TRUE');
INSERT INTO `products` VALUES (193, 'Teddies', 24.37, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/teddies.jpg', 'TRUE');
INSERT INTO `products` VALUES (194, 'Television', 61.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/television.jpg', 'TRUE');
INSERT INTO `products` VALUES (195, 'Thermometer', 18.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermometer.jpg', 'TRUE');
INSERT INTO `products` VALUES (196, 'Thermostat', 24.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermostat.jpg', 'TRUE');
INSERT INTO `products` VALUES (197, 'Thread', 0.51, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thread.jpg', 'TRUE');
INSERT INTO `products` VALUES (198, 'Tire Swing', 38.56, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tire_swing.jpg', 'TRUE');
INSERT INTO `products` VALUES (199, 'Tissue Box', 23.41, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tissue_box.jpg', 'TRUE');
INSERT INTO `products` VALUES (201, 'Toilet', 73.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toilet.jpg', 'TRUE');
INSERT INTO `products` VALUES (202, 'Tomato', 2.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tomato.jpg', 'TRUE');
INSERT INTO `products` VALUES (203, 'Tooth Picks', 5.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tooth_picks.jpg', 'TRUE');
INSERT INTO `products` VALUES (204, 'Toothbrush', 2.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothbrush.jpg', 'TRUE');
INSERT INTO `products` VALUES (205, 'Toothpaste', 3.94, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothpaste.jpg', 'TRUE');
INSERT INTO `products` VALUES (206, 'Towel', 7.71, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/towel.jpg', 'TRUE');
INSERT INTO `products` VALUES (210, 'Tweezers', 19.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twezzers.jpg', 'TRUE');
INSERT INTO `products` VALUES (211, 'Twister', 1.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twister.jpg', 'TRUE');
INSERT INTO `products` VALUES (212, 'Usb Drive', 14.77, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/usb_drive.jpg', 'TRUE');
INSERT INTO `products` VALUES (213, 'Vase', 26.36, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/vase.jpg', 'TRUE');
INSERT INTO `products` VALUES (214, 'Video Games', 56.02, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/video_games.jpg', 'TRUE');
INSERT INTO `products` VALUES (216, 'Wallet', 13.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/wallet.jpg', 'TRUE');
INSERT INTO `products` VALUES (218, 'Watch', 24.81, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/watch.jpg', 'TRUE');
INSERT INTO `products` VALUES (219, 'Water Bottle', 12.11, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/water_bottle.jpg', 'TRUE');
INSERT INTO `products` VALUES (220, 'White Out', 2.42, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/white_out.jpg', 'TRUE');
INSERT INTO `products` VALUES (222, 'Zipper', 4.87, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/zipper.jpg', 'TRUE');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email_address` varchar(75) NOT NULL,
  `password` varchar(60) NOT NULL,
  `room_num` varchar(4) NOT NULL,
  `is_admin` varchar(5) NOT NULL DEFAULT 'false',
  `wallet` decimal(6,2) NOT NULL DEFAULT '0.00',
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `is_active` varchar(5) NOT NULL DEFAULT 'true',
  `phone_number` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
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

DROP TABLE IF EXISTS `cc_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cc_info` (
  `cc_id` int(11) NOT NULL AUTO_INCREMENT, 
  `credit_card_number` varchar(25) NOT NULL,
  `ccv` varchar(4) NOT NULL,
  `exp_date` varchar(4) NOT NULL,
  PRIMARY KEY (`cc_id`),
  UNIQUE KEY `cc_id_unique` (`cc_id`),
  UNIQUE KEY `credit_card_number_unique` (`credit_card_number`) 
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

insert into `cc_info` (credit_card_number, ccv, exp_date) values ('3566002040360500','459','1219'),('5547899423555470','802','1220'),('3566002020860500','422','1221'),('5547819433555470','242','1222'),('3566003020360500','265','1223'),('5547899833555470','544','1224'),('3566002120360500','226','1225'),('5147899433555470','419','1226'),('3566005020360500','911','1227'),('5547899333555470','238','1228'),('3566002720360500','964','1229'),('5590899423555470','677','1230'),('3566002021360500','885','1211'),('5542899433555470','260','1212'),('3566002020368500','707','1213'),('8547899433555470','461','1214'),('3526002020360500','889','1215'),('5554899433555470','371','1216'),('3236002020360500','955','1217'),('5547888833555470','742','1218'),('8888002020360500','677','1219'),('1237899433555470','928','1210'),('3216002020360500','628','1201'),('2317899433555470','509','1202'),('4446002020360500','283','1203'),('5542349433555470','312','1204'),('9966002020360500','406','1205'),('5547833433555470','609','1206'),('3566002440360500','961','1207'),('5547894433555470','229','1208');
--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2018-09-25 09:22:11','nec@lectuspedeet.ca',':(lTD3I0','3353','true',12.75,'Joya  ','Long','true','19073948827'),(2,'2018-09-25 09:22:11','velit.in.aliquet@at.edu',':(lTD3I1','1531','false',3.70,'Damaris  ','Stanley','true','19073948827'),(3,'2018-09-25 09:22:11','nulla.ante@Duis.co.uk',':(lTD3I2','4156','true',12.11,'Debbie  ','Kintaudi','true','19073948827'),(4,'2018-09-25 09:22:11','Phasellus.ornare.Fusce@Fuscediamnunc.co.uk',':(lTD3I3','1743','true',9.28,'Yolanda  ','Weiss','true','19073948827'),(5,'2018-09-25 09:22:11','Phasellus.dapibus.quam@sit.net',':(lTD3I4','2038','false',13.32,'Mina  ','Best','false','19073948827'),(6,'2018-09-25 09:22:11','lectus@tortorat.co.uk',':(lTD3I5','5233','true',6.49,'Hollis  ','Guzman','true','19073948827'),(7,'2018-09-25 09:22:11','in.aliquet.lobortis@congue.ca',':(lTD3I6','1167','true',6.24,'Hilario  ','Hill','true','19073948827'),(8,'2018-09-25 09:22:11','Mauris.blandit@dignissimpharetra.org',':(lTD3I7','1877','false',7.72,'Cami  ','Daniel','false','19073948827'),(9,'2018-09-25 09:22:11','Ut.tincidunt.orci@enim.ca',':(lTD3I8','4488','true',5.06,'Gerardo  ','Gutierrez','true','19073948827'),(10,'2018-09-25 09:22:11','sed.turpis@massaQuisqueporttitor.org',':(lTD3I9','2452','false',14.69,'Britni  ','Drake','false','19073948827'),(11,'2018-09-25 09:22:11','fringilla.euismod@quisurnaNunc.co.uk',':(lTD3I10','2282','true',20.90,'Sixta  ','Hickman','true','19073948827'),(12,'2018-09-25 09:22:11','vulputate.magna@Cumsociisnatoque.net',':(lTD3I11','1742','true',18.59,'Rudolf  ','Cardenas','true','19073948827'),(13,'2018-09-25 09:22:11','Ut@Donec.net',':(lTD3I12','4870','false',8.63,'Janette  ','Hodges','false','19073948827'),(14,'2018-09-25 09:22:11','et@et.edu',':(lTD3I13','2807','false',23.34,'Rich  ','Bolton','false','19073948827'),(15,'2018-09-25 09:22:11','elit.Nulla.facilisi@aliquamadipiscing.edu',':(lTD3I14','6208','true',15.31,'Cherry  ','Carney','true','19073948827'),(16,'2018-09-25 09:22:11','ipsum@suscipitnonummyFusce.ca',':(lTD3I15','3639','false',18.49,'Enedina  ','Tyler','false','19073948827'),(17,'2018-09-25 09:22:11','libero.lacus.varius@parturientmontes.com',':(lTD3I16','1444','true',19.00,'Shane  ','Farley','true','19073948827'),(18,'2018-09-25 09:22:11','Vivamus.sit.amet@cursuset.ca',':(lTD3I17','1644','true',1.93,'Bess  ','Brennan','true','19073948827'),(19,'2018-09-25 09:22:11','luctus.et.ultrices@Duisatlacus.com',':(lTD3I18','5822','false',5.49,'Lyndsay  ','Hanson','false','19073948827'),(20,'2018-09-25 09:22:11','Duis.ac@tinciduntdui.edu',':(lTD3I19','6476','true',3.93,'Hwa  ','Hardy','true','19073948827'),(21,'2018-09-25 09:22:11','eget@rutrum.edu',':(lTD3I20','4272','true',13.77,'Jasmine  ','Dorsey','true','19073948827'),(22,'2018-09-25 09:22:11','amet.luctus@mipedenonummy.net',':(lTD3I21','5168','false',11.60,'Bethann  ','Blake','false','19073948827'),(23,'2018-09-25 09:22:11','dolor@ligulaNullam.org',':(lTD3I22','3263','true',17.95,'Drucilla  ','Walton','true','19073948827'),(24,'2018-09-25 09:22:11','egestas.lacinia@morbitristique.co.uk',':(lTD3I23','6008','false',7.20,'Lourie  ','Wilkins','false','19073948827'),(25,'2018-09-25 09:22:11','quis.tristique@eunibh.net',':(lTD3I24','6240','true',15.95,'Ching  ','Myers','true','19073948827'),(26,'2018-09-25 09:22:11','augue@eumetusIn.net',':(lTD3I25','1925','true',17.44,'Kattie  ','Duarte','true','19073948827'),(27,'2018-09-25 09:22:11','lectus@Maurismagna.org',':(lTD3I26','3920','false',16.14,'Morris  ','Parrish','false','19073948827'),(28,'2018-09-25 09:22:11','quis@Maurisblandit.co.uk',':(lTD3I27','2868','false',8.59,'Makeda  ','Vaughan','false','19073948827'),(29,'2018-09-25 09:22:11','Nunc.ullamcorper@iaculisneceleifend.org',':(lTD3I28','2424','false',9.66,'Ashlie  ','Gibson','false','19073948827'),(30,'2018-09-25 09:22:11','ut.quam.vel@molestietellusAenean.com',':(lTD3I29','2782','true',12.73,'Malorie  ','Craig','true','19073832737'),(110,'2019-02-07 14:25:27','email@email.com','$2a$10$ED1XNVZwFFQ6IGdRj1ipl.dz/Qdr/DFYq5JtzNg.3LY3rWDtTW6MW','1234','true',30.21,'Dave','Safanyuk','true','2158919927'),(111,'2019-02-14 15:18:11','k@email.com','$2a$10$o4wh8aoSV.zjwFdaZiqun.qq8UiKAVeKHSbi.pnnLrBpYPfalqMGG','1234','false',60.96,'keke','olivia','false','2158919936'),(112,'2019-02-18 13:16:01','fake@email.com','$2a$10$FakLbGKYllruRdA4zDFWLOtO./PY/ccvq7gbWhC4TrQOFGGx4AL/K','1233','false',8.23,'Fake','User','false','1233211234'),(113,'2019-03-11 15:08:45','test-test@email.com','$2a$10$.nNkLamgriovIdNxu9gY5.EJdQsPt5dX9/dBOV5Kd70RB5Z.2tkb2','0101','false',0.00,'test','test','true',NULL),(114,'2019-03-11 16:10:38','fakeuserm8@email.com','$2a$10$.Con6J591U9mcfSCGXxRcuvs.S2Y2lRwfC2FiC9Z/N4//oKFWvLK.','1231','false',0.00,'fake',' user m8','true',NULL),(115,'2019-03-11 16:14:58','testeroni@pepperoni.com','$2a$10$TFQTqsJ46PsJQlrCw3dZJ.nprcACzhtin.51d5sVm4LJTJUIk2.Dy','1029','false',0.00,'testeroni','Pepproni','true','2151234321'),(116,'2019-03-11 16:37:05','dsa@em.com','$2a$10$9oyNGV1Hw69OZFOngeRY6umXqKQHFH3AhsSwMyJ6FBxEG.FJjVZxu','1233','false',0.00,'asd','dsa','true','2158919927');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

DROP VIEW IF EXISTS `product_records`;
CREATE view fetchr_db.product_records as
SELECT products.*,  ifnull(sum(order_summary.quantity),0) as 'total_sold' 
  FROM `products` left OUTER JOIN fetchr_db.order_summary
    ON order_summary.product_id = products.product_id
 group by product_id;

drop procedure if exists fetchr_db.prodsSoldByCat;
delimiter //
create procedure fetchr_db.prodsSoldByCat()
begin
select group_concat( concat( 'sum(if(category = ''', t.category, ''', quantity, 0)) as ', t.category))
  into @pivot
  from (select distinct category from fetchr_db.products) t;
  
set @pivot = concat('select ', @pivot, ' from fetchr_db.products join fetchr_db.order_summary on products.product_id = order_summary.product_id');

PREPARE statement FROM @pivot;
EXECUTE statement;
DEALLOCATE PREPARE statement;
end//
delimiter ;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-28 12:32:53
