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
  `order_total` decimal(5,2),
  PRIMARY KEY (`order_id`),
  KEY `courier_fk_idx` (`courier_id`),
  KEY `customer_fk_idx` (`customer_id`),
  CONSTRAINT `courier_fk` FOREIGN KEY (`courier_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `customer_fk` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `is_active` varchar(5) NOT NULL DEFAULT 'true',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1, 'Arizona Tea', 0.99, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Arizona%20Iced%20Tea.png', 'true');
INSERT INTO `products` VALUES (2, 'Dunkin Iced Coffee', 2.25, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Dunkin%20Iced%20Coffee.png', 'true');
INSERT INTO `products` VALUES (3, 'Bai ', 1.81, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Bai.png', 'true');
INSERT INTO `products` VALUES (4, 'Coca Cola', 1.77, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Coca%20Cola.png', 'true');
INSERT INTO `products` VALUES (5, 'Pepsi', 1.77, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pepsi.png', 'true');
INSERT INTO `products` VALUES (6, 'Sprite', 1.57, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sprite.png', 'true');
INSERT INTO `products` VALUES (7, 'Root Beer', 1.49, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Root%20Beer.png', 'true');
INSERT INTO `products` VALUES (8, 'Milk', 3.98, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Milk.png', 'true');
INSERT INTO `products` VALUES (9, 'Doritos Small', 0.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Doritos.png', 'true');
INSERT INTO `products` VALUES (10, 'Pringles', 1.49, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pringles.png', 'true');
INSERT INTO `products` VALUES (11, 'Oreos', 3.28, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Oreo.png', 'true');
INSERT INTO `products` VALUES (12, 'Pretzels', 3.08, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pretzels.png', 'true');
INSERT INTO `products` VALUES (13, 'Cheetos', 3.70, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Cheetos.png', 'true');
INSERT INTO `products` VALUES (14, 'Cheez-It', 2.09, 'snacks', 'https://s3.us-east-2.amazonaws.com/fetchrapp/Product+Photos/cheeze-it.jpeg', 'true');
INSERT INTO `products` VALUES (16, 'Snickers', 1.32, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Snickers.png', 'true');
INSERT INTO `products` VALUES (17, 'Chex Mix', 2.35, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Chex%20Mix.png', 'true');
INSERT INTO `products` VALUES (18, 'Popcorn', 3.46, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Popcorn.png', 'true');
INSERT INTO `products` VALUES (19, 'Indomie', 0.47, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Indomie.png', 'true');
INSERT INTO `products` VALUES (20, 'Ice Cream', 2.10, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Ice%20Cream.png', 'true');
INSERT INTO `products` VALUES (21, 'Pencils', 0.53, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pencils.png', 'true');
INSERT INTO `products` VALUES (22, 'Eraser', 0.22, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Eraser.png', 'true');
INSERT INTO `products` VALUES (23, 'Stapler', 1.88, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Stapler.png', 'true');
INSERT INTO `products` VALUES (24, 'Pen', 0.82, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pen.png', 'true');
INSERT INTO `products` VALUES (25, 'Notebooks', 0.60, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Notebooks.png', 'true');
INSERT INTO `products` VALUES (26, 'Hole Puncher', 4.85, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Hole%20Puncher.png', 'true');
INSERT INTO `products` VALUES (27, 'Nyquil', 5.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Nyquil.png', 'true');
INSERT INTO `products` VALUES (28, 'Advil', 3.41, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Advil.png', 'true');
INSERT INTO `products` VALUES (29, 'Umbrella', 8.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Umbrella.png', 'true');
INSERT INTO `products` VALUES (30, 'Toilet Paper', 3.70, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Toilet%20Paper.png', 'true');
INSERT INTO `products` VALUES (31, 'Tissues', 4.02, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Tissues.png', 'true');
INSERT INTO `products` VALUES (32, 'Sewing Kit', 5.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sewing%20Kit.png', 'true');
INSERT INTO `products` VALUES (33, 'Air Freshener', 2.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/air_freshener.jpg', 'true');
INSERT INTO `products` VALUES (34, 'Apple', 2.87, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/apple.jpg', 'true');
INSERT INTO `products` VALUES (35, 'Bag', 13.58, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bag.jpg', 'true');
INSERT INTO `products` VALUES (36, 'Balloon', 0.69, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/balloon.jpg', 'true');
INSERT INTO `products` VALUES (37, 'Bananas', 2.65, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bananas.jpg', 'true');
INSERT INTO `products` VALUES (38, 'Bed', 49.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bed.jpg', 'true');
INSERT INTO `products` VALUES (39, 'Beef', 28.23, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/beef.jpg', 'true');
INSERT INTO `products` VALUES (40, 'Blanket', 9.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blanket.jpg', 'true');
INSERT INTO `products` VALUES (41, 'Blouse', 7.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blouse.jpg', 'true');
INSERT INTO `products` VALUES (42, 'Book', 14.86, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/book.jpg', 'true');
INSERT INTO `products` VALUES (43, 'Bookmark', 8.35, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bookmark.jpg', 'true');
INSERT INTO `products` VALUES (44, 'Boom Box', 17.45, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/boom_box.jpg', 'true');
INSERT INTO `products` VALUES (45, 'Bottle Cap', 0.20, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle_cap.jpg', 'true');
INSERT INTO `products` VALUES (46, 'Bottle', 8.72, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle.jpg', 'true');
INSERT INTO `products` VALUES (47, 'Bow', 31.77, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bow.jpg', 'true');
INSERT INTO `products` VALUES (48, 'Bowl', 2.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bowl.jpg', 'true');
INSERT INTO `products` VALUES (49, 'Box', 6.46, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/box.jpg', 'true');
INSERT INTO `products` VALUES (50, 'Bracelet', 0.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bracelet.jpg', 'true');
INSERT INTO `products` VALUES (51, 'Bread', 5.18, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bread.jpg', 'true');
INSERT INTO `products` VALUES (52, 'Brocolli', 3.26, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/brocolli.jpg', 'true');
INSERT INTO `products` VALUES (53, 'Buckle', 13.04, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/buckel.jpg', 'true');
INSERT INTO `products` VALUES (54, 'Button', 7.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/button.jpg', 'true');
INSERT INTO `products` VALUES (55, 'Camera', 47.92, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/camera.jpg', 'true');
INSERT INTO `products` VALUES (56, 'Candle', 0.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candle.jpg', 'true');
INSERT INTO `products` VALUES (57, 'Candy Wrapper', 0.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candy_wrapper.jpg', 'true');
INSERT INTO `products` VALUES (58, 'Canvas', 4.81, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/canvas.jpg', 'true');
INSERT INTO `products` VALUES (59, 'Car', 937.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/car.jpg', 'true');
INSERT INTO `products` VALUES (60, 'Carrots', 5.80, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/carrots.jpg', 'true');
INSERT INTO `products` VALUES (61, 'Cat', 14.49, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cat.jpg', 'true');
INSERT INTO `products` VALUES (62, 'Cd', 0.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cd.jpg', 'true');
INSERT INTO `products` VALUES (63, 'Cell Phone', 24.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cell_phone.jpg', 'true');
INSERT INTO `products` VALUES (64, 'Chair', 12.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chair.jpg', 'true');
INSERT INTO `products` VALUES (65, 'Chalk', 1.28, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chalk.jpg', 'true');
INSERT INTO `products` VALUES (66, 'Chapter Book', 4.37, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chapter_book.jpg', 'true');
INSERT INTO `products` VALUES (67, 'Charger', 16.51, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/charger.jpg', 'true');
INSERT INTO `products` VALUES (68, 'Checkbook', 8.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/checkbook.jpg', 'true');
INSERT INTO `products` VALUES (69, 'Chocolate', 6.41, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chocolate.jpg', 'true');
INSERT INTO `products` VALUES (70, 'Cinder Block', 17.99, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cinder_block.jpg', 'true');
INSERT INTO `products` VALUES (71, 'Clamp', 7.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clamp.jpg', 'true');
INSERT INTO `products` VALUES (72, 'Clay Pot', 5.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clay_pot.jpg', 'true');
INSERT INTO `products` VALUES (73, 'Clock', 25.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clock.jpg', 'true');
INSERT INTO `products` VALUES (74, 'Clothes', 19.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clothes.jpg', 'true');
INSERT INTO `products` VALUES (75, 'Coasters', 22.94, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/coasters.jpg', 'true');
INSERT INTO `products` VALUES (76, 'Computer', 121.71, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/computer.jpg', 'true');
INSERT INTO `products` VALUES (77, 'Conditioner', 9.05, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/conditioner.jpg', 'true');
INSERT INTO `products` VALUES (78, 'Controller', 25.93, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/controller.jpg', 'true');
INSERT INTO `products` VALUES (79, 'Cookie Jar', 7.76, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cookie_jar.jpg', 'true');
INSERT INTO `products` VALUES (80, 'Cork', 6.41, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cork.jpg', 'true');
INSERT INTO `products` VALUES (81, 'Couch', 74.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/couch.jpg', 'true');
INSERT INTO `products` VALUES (82, 'Credit Card', 49.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/credit_card.jpg', 'true');
INSERT INTO `products` VALUES (83, 'Cup', 6.36, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cup.jpg', 'true');
INSERT INTO `products` VALUES (84, 'Deodorant ', 0.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/deodorant_.jpg', 'true');
INSERT INTO `products` VALUES (85, 'Desk', 12.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/desk.jpg', 'true');
INSERT INTO `products` VALUES (86, 'Doll', 6.57, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/doll.jpg', 'true');
INSERT INTO `products` VALUES (87, 'Door', 34.59, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/door.jpg', 'true');
INSERT INTO `products` VALUES (88, 'Drawer', 26.09, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/drawer.jpg', 'true');
INSERT INTO `products` VALUES (91, 'Eye Liner', 7.26, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/eye_liner.jpg', 'true');
INSERT INTO `products` VALUES (92, 'Face Wash', 13.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/face_wash.jpg', 'true');
INSERT INTO `products` VALUES (93, 'Fake Flowers', 3.70, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fake_flowers.jpg', 'true');
INSERT INTO `products` VALUES (94, 'Flag', 9.55, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flag.jpg', 'true');
INSERT INTO `products` VALUES (96, 'Flowers', 28.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flowers.jpg', 'true');
INSERT INTO `products` VALUES (98, 'Fork', 3.21, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fork.jpg', 'true');
INSERT INTO `products` VALUES (99, 'Fridge', 394.34, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fridge.jpg', 'true');
INSERT INTO `products` VALUES (100, 'Glass', 26.04, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glass.jpg', 'true');
INSERT INTO `products` VALUES (101, 'Glasses', 17.43, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glasses.jpg', 'true');
INSERT INTO `products` VALUES (102, 'Glow Stick', 5.78, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glow_stick.jpg', 'true');
INSERT INTO `products` VALUES (103, 'Greeting Card', 1.55, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/greeting_card.jpg', 'true');
INSERT INTO `products` VALUES (104, 'Grid Paper', 0.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/grid_paper.jpg', 'true');
INSERT INTO `products` VALUES (105, 'Hair Brush', 1.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_brush.jpg', 'true');
INSERT INTO `products` VALUES (106, 'Hair Tie', 0.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_tie.jpg', 'true');
INSERT INTO `products` VALUES (107, 'Hanger', 0.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hanger.jpg', 'true');
INSERT INTO `products` VALUES (108, 'Headphones', 12.65, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/headphones.jpg', 'true');
INSERT INTO `products` VALUES (109, 'Helmet', 3.06, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/helmet.jpg', 'true');
INSERT INTO `products` VALUES (111, 'Ice Cube Tray', 4.83, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ice_cube_tray.jpg', 'true');
INSERT INTO `products` VALUES (112, 'Ipod', 43.08, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ipod.jpg', 'true');
INSERT INTO `products` VALUES (113, 'Key Chain', 0.37, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/key_chain.jpg', 'true');
INSERT INTO `products` VALUES (114, 'Keyboard', 19.06, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keyboard.jpg', 'true');
INSERT INTO `products` VALUES (115, 'Keys', 12.03, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keys.jpg', 'true');
INSERT INTO `products` VALUES (116, 'Knife', 5.86, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/knife.jpg', 'true');
INSERT INTO `products` VALUES (118, 'Lamp', 12.12, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp_shade.jpg', 'true');
INSERT INTO `products` VALUES (119, 'Lamp Shade', 6.58, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp.jpg', 'true');
INSERT INTO `products` VALUES (120, 'Leg Warmers', 9.64, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/leg_warmers.jpg', 'true');
INSERT INTO `products` VALUES (121, 'Lip Gloss', 1.51, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lip_gloss.jpg', 'true');
INSERT INTO `products` VALUES (122, 'Lotion', 7.90, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lotion.jpg', 'true');
INSERT INTO `products` VALUES (123, 'Magnet', 0.29, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/magnet.jpg', 'true');
INSERT INTO `products` VALUES (125, 'Mirror', 10.33, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mirror.jpg', 'true');
INSERT INTO `products` VALUES (128, 'Monitor', 32.03, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/monitor.jpg', 'true');
INSERT INTO `products` VALUES (129, 'Mop', 15.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mop.jpg', 'true');
INSERT INTO `products` VALUES (130, 'Mouse Pad', 7.74, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mouse_pad.jpg', 'true');
INSERT INTO `products` VALUES (131, 'Mp3 Player', 8.50, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mp3_player.jpg', 'true');
INSERT INTO `products` VALUES (132, 'Nail Clippers', 6.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_clippers.jpg', 'true');
INSERT INTO `products` VALUES (133, 'Nail File', 9.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_file.jpg', 'true');
INSERT INTO `products` VALUES (134, 'Needle', 0.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/needle.jpg', 'true');
INSERT INTO `products` VALUES (137, 'Packing Peanuts', 3.33, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/packing_peanuts.jpg', 'true');
INSERT INTO `products` VALUES (138, 'Paint Brush', 1.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paint_brush.jpg', 'true');
INSERT INTO `products` VALUES (139, 'Pants', 11.17, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pants.jpg', 'true');
INSERT INTO `products` VALUES (140, 'Paper', 0.50, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paper.jpg', 'true');
INSERT INTO `products` VALUES (141, 'Pen', 2.57, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pen.jpg', 'true');
INSERT INTO `products` VALUES (142, 'Pencil', 0.77, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pencil.jpg', 'true');
INSERT INTO `products` VALUES (143, 'Perfume', 33.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/perfume.jpg', 'true');
INSERT INTO `products` VALUES (144, 'Phone', 9.70, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/phone.jpg', 'true');
INSERT INTO `products` VALUES (145, 'Photo Album', 1.21, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/photo_album.jpg', 'true');
INSERT INTO `products` VALUES (146, 'Piano', 100.30, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/piano.jpg', 'true');
INSERT INTO `products` VALUES (147, 'Picture Frame', 3.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/picture_frame.jpg', 'true');
INSERT INTO `products` VALUES (148, 'Pillow', 9.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pillow.jpg', 'true');
INSERT INTO `products` VALUES (149, 'Plastic Fork', 1.52, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plastic_fork.jpg', 'true');
INSERT INTO `products` VALUES (150, 'Plate', 2.10, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plate.jpg', 'true');
INSERT INTO `products` VALUES (154, 'Purse', 50.92, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/purse.jpg', 'true');
INSERT INTO `products` VALUES (155, 'Radio', 1.17, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/radio.jpg', 'true');
INSERT INTO `products` VALUES (156, 'Remote', 12.85, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/remote.jpg', 'true');
INSERT INTO `products` VALUES (157, 'Ring', 605.99, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ring.jpg', 'true');
INSERT INTO `products` VALUES (158, 'Rubber Band', 12.01, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_band.jpg', 'true');
INSERT INTO `products` VALUES (159, 'Rubber Duck', 5.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_duck.jpg', 'true');
INSERT INTO `products` VALUES (160, 'Rug', 13.70, 'musc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rug.jpg', 'true');
INSERT INTO `products` VALUES (161, 'Rusty Nail', 1.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rusty_nail.jpg', 'true');
INSERT INTO `products` VALUES (162, 'Sailboat', 483.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sailboat.jpg', 'true');
INSERT INTO `products` VALUES (163, 'Sand Paper', 5.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sand_paper.jpg', 'true');
INSERT INTO `products` VALUES (164, 'Sandal', 21.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sandal.jpg', 'true');
INSERT INTO `products` VALUES (165, 'Scotch Tape', 5.58, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/scotch_tape.jpg', 'true');
INSERT INTO `products` VALUES (166, 'Screw', 1.39, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/screw.jpg', 'true');
INSERT INTO `products` VALUES (167, 'Seat Belt', 55.65, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/seat_belt.jpg', 'true');
INSERT INTO `products` VALUES (168, 'Shampoo', 6.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shampoo.jpg', 'true');
INSERT INTO `products` VALUES (169, 'Sharpie', 2.23, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sharpie.jpg', 'true');
INSERT INTO `products` VALUES (170, 'Shawl', 9.83, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shawl.jpg', 'true');
INSERT INTO `products` VALUES (171, 'Shirt', 9.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shirt.jpg', 'true');
INSERT INTO `products` VALUES (172, 'Shoe Lace', 1.84, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoe_lace.jpg', 'true');
INSERT INTO `products` VALUES (173, 'Shoes', 20.50, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoes.jpg', 'true');
INSERT INTO `products` VALUES (174, 'Shovel', 17.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shovel.jpg', 'true');
INSERT INTO `products` VALUES (176, 'Sketch Pad', 15.72, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sketch_pad.jpg', 'true');
INSERT INTO `products` VALUES (177, 'Slipper', 21.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/slipper.jpg', 'true');
INSERT INTO `products` VALUES (178, 'Soap', 35.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soap.jpg', 'true');
INSERT INTO `products` VALUES (179, 'Socks', 3.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/socks.jpg', 'true');
INSERT INTO `products` VALUES (180, 'Soda Can', 1.35, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soda_can.jpg', 'true');
INSERT INTO `products` VALUES (181, 'Sofa', 104.18, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sofa.jpg', 'true');
INSERT INTO `products` VALUES (182, 'Soy Sauce Packet', .86, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soy_sauce_packet.jpg', 'true');
INSERT INTO `products` VALUES (183, 'Speakers', 31.04, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/speakers.jpg', 'true');
INSERT INTO `products` VALUES (184, 'Sponge', 2.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sponge.jpg', 'true');
INSERT INTO `products` VALUES (185, 'Spoon', 3.92, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spoon.jpg', 'true');
INSERT INTO `products` VALUES (186, 'Spring', 2.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spring.jpg', 'true');
INSERT INTO `products` VALUES (187, 'Sticky Note', 0.45, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sticky_note.jpg', 'true');
INSERT INTO `products` VALUES (188, 'Stockings', 14.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stockings.jpg', 'true');
INSERT INTO `products` VALUES (189, 'Stop Sign', 17.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stop_sign.jpg', 'true');
INSERT INTO `products` VALUES (190, 'Street Lights', 54.80, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/street_lights.jpg', 'true');
INSERT INTO `products` VALUES (191, 'Sun Glasses', 11.49, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sun_glasses.jpg', 'true');
INSERT INTO `products` VALUES (193, 'Teddies', 24.37, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/teddies.jpg', 'true');
INSERT INTO `products` VALUES (194, 'Television', 61.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/television.jpg', 'true');
INSERT INTO `products` VALUES (195, 'Thermometer', 18.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermometer.jpg', 'true');
INSERT INTO `products` VALUES (196, 'Thermostat', 24.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermostat.jpg', 'true');
INSERT INTO `products` VALUES (197, 'Thread', 0.51, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thread.jpg', 'true');
INSERT INTO `products` VALUES (198, 'Tire Swing', 38.56, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tire_swing.jpg', 'true');
INSERT INTO `products` VALUES (199, 'Tissue Box', 23.41, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tissue_box.jpg', 'true');
INSERT INTO `products` VALUES (201, 'Toilet', 73.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toilet.jpg', 'true');
INSERT INTO `products` VALUES (202, 'Tomato', 2.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tomato.jpg', 'true');
INSERT INTO `products` VALUES (203, 'Tooth Picks', 5.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tooth_picks.jpg', 'true');
INSERT INTO `products` VALUES (204, 'Toothbrush', 2.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothbrush.jpg', 'true');
INSERT INTO `products` VALUES (205, 'Toothpaste', 3.94, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothpaste.jpg', 'true');
INSERT INTO `products` VALUES (206, 'Towel', 7.71, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/towel.jpg', 'true');
INSERT INTO `products` VALUES (210, 'Tweezers', 19.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twezzers.jpg', 'true');
INSERT INTO `products` VALUES (211, 'Twister', 1.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twister.jpg', 'true');
INSERT INTO `products` VALUES (212, 'Usb Drive', 14.77, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/usb_drive.jpg', 'true');
INSERT INTO `products` VALUES (213, 'Vase', 26.36, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/vase.jpg', 'true');
INSERT INTO `products` VALUES (214, 'Video Games', 56.02, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/video_games.jpg', 'true');
INSERT INTO `products` VALUES (216, 'Wallet', 13.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/wallet.jpg', 'true');
INSERT INTO `products` VALUES (218, 'Watch', 24.81, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/watch.jpg', 'true');
INSERT INTO `products` VALUES (219, 'Water Bottle', 12.11, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/water_bottle.jpg', 'true');
INSERT INTO `products` VALUES (220, 'White Out', 2.42, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/white_out.jpg', 'true');
INSERT INTO `products` VALUES (222, 'Zipper', 4.87, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/zipper.jpg', 'true');
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
  `wallet` decimal(5,2) NOT NULL DEFAULT '0.00',
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `is_active` varchar(5) NOT NULL DEFAULT 'true',
  `phone_number` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


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
