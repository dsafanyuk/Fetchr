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

--
-- Table structure for table `Order_Summary`
--

DROP TABLE IF EXISTS `Order_Summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Order_Summary` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Summary`
--

LOCK TABLES `Order_Summary` WRITE;
/*!40000 ALTER TABLE `Order_Summary` DISABLE KEYS */;
INSERT INTO `Order_Summary` VALUES (1,5,3),(4,9,3),(7,16,5),(6,21,1),(2,15,4),(1,15,4),(6,7,4),(6,20,3),(1,15,2),(3,8,3),(4,17,1),(6,30,3),(1,7,5),(2,9,1),(7,22,3),(2,15,5),(1,6,2),(5,5,5),(5,31,4),(3,31,3);
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
  `time_delivered` datetime NOT NULL,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_total` decimal(5,2) NOT NULL,
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
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'Arizona Tea',0.99,'drinks'),(2,'Dunkin Iced Coffee',1.08,'drinks'),(3,'Bai ',1.81,'drinks'),(4,'Coca Cola',2.42,'drinks'),(5,'Pepsi',3.38,'drinks'),(6,'Sprite',2.33,'drinks'),(7,'Root Beer',1.49,'drinks'),(8,'Milk',1.17,'drinks'),(9,'Doritos Small',2.50,'snacks'),(10,'Pringles',2.57,'snacks'),(11,'Oreos',3.57,'snacks'),(12,'Pretzels',3.08,'snacks'),(13,'Cheetos',2.70,'snacks'),(14,'Cheez-It',1.21,'snacks'),(15,'Fritos',1.77,'snacks'),(16,'Snickers',2.30,'snacks'),(17,'Chex Mix',4.35,'snacks'),(18,'Popcorn',2.46,'snacks'),(19,'Indomie',3.52,'snacks'),(20,'Ice Cream',2.10,'snacks'),(21,'Pencils',3.00,'school_supplies'),(22,'Eraser',1.12,'school_supplies'),(23,'Stapler',1.88,'school_supplies'),(24,'Pen',0.92,'school_supplies'),(25,'Notebooks',1.17,'school_supplies'),(26,'Hole Puncher',2.85,'school_supplies'),(27,'Nyquil',5.99,'misc'),(28,'Advil',2.01,'misc'),(29,'Umbrella',1.26,'misc'),(30,'Toilet Paper',3.70,'misc'),(31,'Tissues',1.02,'misc'),(32,'Sewing Kit',3.96,'misc');
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
  `password` varchar(45) NOT NULL,
  `room_num` varchar(4) NOT NULL,
  `is_courier` tinyint(4) NOT NULL,
  `credit_card_number` varchar(25) NOT NULL,
  `ccv` varchar(4) NOT NULL,
  `exp_date` varchar(4) NOT NULL,
  `wallet` decimal(5,2) NOT NULL DEFAULT '0.00',
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'2018-09-25 09:22:11','nec@lectuspedeet.ca',':(lTD3I0','3353',1,'3566002020360500','459','1219',12.75,'Joya  ','Short'),(2,'2018-09-25 09:22:11','velit.in.aliquet@at.edu',':(lTD3I1','1531',0,'5547899433555470','802','1220',3.70,'Damaris  ','Stanley'),(3,'2018-09-25 09:22:11','nulla.ante@Duis.co.uk',':(lTD3I2','4156',1,'3566002020360500','422','1221',12.11,'Debbie  ','Novak'),(4,'2018-09-25 09:22:11','Phasellus.ornare.Fusce@Fuscediamnunc.co.uk',':(lTD3I3','1743',1,'5547899433555470','242','1222',9.28,'Yolanda  ','Weiss'),(5,'2018-09-25 09:22:11','Phasellus.dapibus.quam@sit.net',':(lTD3I4','2038',0,'3566002020360500','265','1223',13.32,'Mina  ','Best'),(6,'2018-09-25 09:22:11','lectus@tortorat.co.uk',':(lTD3I5','5233',1,'5547899433555470','544','1224',6.49,'Hollis  ','Guzman'),(7,'2018-09-25 09:22:11','in.aliquet.lobortis@congue.ca',':(lTD3I6','1167',1,'3566002020360500','226','1225',6.24,'Hilario  ','Hill'),(8,'2018-09-25 09:22:11','Mauris.blandit@dignissimpharetra.org',':(lTD3I7','1877',0,'5547899433555470','419','1226',7.72,'Cami  ','Daniel'),(9,'2018-09-25 09:22:11','Ut.tincidunt.orci@enim.ca',':(lTD3I8','4488',1,'3566002020360500','911','1227',5.06,'Gerardo  ','Gutierrez'),(10,'2018-09-25 09:22:11','sed.turpis@massaQuisqueporttitor.org',':(lTD3I9','2452',0,'5547899433555470','238','1228',14.69,'Britni  ','Drake'),(11,'2018-09-25 09:22:11','fringilla.euismod@quisurnaNunc.co.uk',':(lTD3I10','2282',1,'3566002020360500','964','1229',20.90,'Sixta  ','Hickman'),(12,'2018-09-25 09:22:11','vulputate.ullamcorper.magna@Cumsociisnatoque.net',':(lTD3I11','1742',1,'5547899433555470','677','1230',18.59,'Rudolf  ','Cardenas'),(13,'2018-09-25 09:22:11','Ut@Donec.net',':(lTD3I12','4870',0,'3566002020360500','885','1231',8.63,'Janette  ','Hodges'),(14,'2018-09-25 09:22:11','et@et.edu',':(lTD3I13','2807',0,'5547899433555470','260','1232',23.34,'Rich  ','Bolton'),(15,'2018-09-25 09:22:11','elit.Nulla.facilisi@aliquamadipiscing.edu',':(lTD3I14','6208',1,'3566002020360500','707','1233',15.31,'Cherry  ','Carney'),(16,'2018-09-25 09:22:11','ipsum@suscipitnonummyFusce.ca',':(lTD3I15','3639',0,'5547899433555470','461','1234',18.49,'Enedina  ','Tyler'),(17,'2018-09-25 09:22:11','libero.lacus.varius@parturientmontes.com',':(lTD3I16','1444',1,'3566002020360500','889','1235',19.00,'Shane  ','Farley'),(18,'2018-09-25 09:22:11','Vivamus.sit.amet@cursuset.ca',':(lTD3I17','1644',1,'5547899433555470','371','1236',1.93,'Bess  ','Brennan'),(19,'2018-09-25 09:22:11','luctus.et.ultrices@Duisatlacus.com',':(lTD3I18','5822',0,'3566002020360500','955','1237',5.49,'Lyndsay  ','Hanson'),(20,'2018-09-25 09:22:11','Duis.ac@tinciduntdui.edu',':(lTD3I19','6476',1,'5547899433555470','742','1238',3.93,'Hwa  ','Hardy'),(21,'2018-09-25 09:22:11','eget@rutrum.edu',':(lTD3I20','4272',1,'3566002020360500','677','1239',13.77,'Jasmine  ','Dorsey'),(22,'2018-09-25 09:22:11','amet.luctus@mipedenonummy.net',':(lTD3I21','5168',0,'5547899433555470','928','1240',11.60,'Bethann  ','Blake'),(23,'2018-09-25 09:22:11','dolor@ligulaNullam.org',':(lTD3I22','3263',1,'3566002020360500','628','1241',17.95,'Drucilla  ','Walton'),(24,'2018-09-25 09:22:11','egestas.lacinia@morbitristique.co.uk',':(lTD3I23','6008',0,'5547899433555470','509','1242',7.20,'Lourie  ','Wilkins'),(25,'2018-09-25 09:22:11','quis.tristique@eunibh.net',':(lTD3I24','6240',1,'3566002020360500','283','1243',15.95,'Ching  ','Myers'),(26,'2018-09-25 09:22:11','augue@eumetusIn.net',':(lTD3I25','1925',1,'5547899433555470','312','1244',17.44,'Kattie  ','Duarte'),(27,'2018-09-25 09:22:11','lectus@Maurismagna.org',':(lTD3I26','3920',0,'3566002020360500','406','1245',16.14,'Morris  ','Parrish'),(28,'2018-09-25 09:22:11','quis@Maurisblandit.co.uk',':(lTD3I27','2868',0,'5547899433555470','609','1246',8.59,'Makeda  ','Vaughan'),(29,'2018-09-25 09:22:11','Nunc.ullamcorper@iaculisneceleifend.org',':(lTD3I28','2424',0,'3566002020360500','961','1247',9.66,'Ashlie  ','Gibson'),(30,'2018-09-25 09:22:11','ut.quam.vel@molestietellusAenean.com',':(lTD3I29','2782',1,'5547899433555470','229','1248',12.73,'Malorie  ','Craig');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-28 12:32:53
