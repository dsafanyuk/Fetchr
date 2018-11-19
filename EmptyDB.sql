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


CREATE or replace view fetchr_db.product_records as
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
