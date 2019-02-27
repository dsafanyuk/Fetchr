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
-- Dumping data for table `orders`
--


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
  `product_url` varchar(200),
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1, 'Arizona Tea', 0.99, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Arizona%20Iced%20Tea.png');
INSERT INTO `products` VALUES (2, 'Dunkin Iced Coffee', 1.08, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Dunkin%20Iced%20Coffee.png');
INSERT INTO `products` VALUES (3, 'Bai ', 1.81, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Bai.png');
INSERT INTO `products` VALUES (4, 'Coca Cola', 2.42, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Coca%20Cola.png');
INSERT INTO `products` VALUES (5, 'Pepsi', 3.38, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pepsi.png');
INSERT INTO `products` VALUES (6, 'Sprite', 2.33, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sprite.png');
INSERT INTO `products` VALUES (7, 'Root Beer', 1.49, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Root%20Beer.png');
INSERT INTO `products` VALUES (8, 'Milk', 1.17, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Milk.png');
INSERT INTO `products` VALUES (9, 'Doritos Small', 2.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Doritos.png');
INSERT INTO `products` VALUES (10, 'Pringles', 2.57, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pringles.png');
INSERT INTO `products` VALUES (11, 'Oreos', 3.57, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Oreo.png');
INSERT INTO `products` VALUES (12, 'Pretzels', 3.08, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pretzels.png');
INSERT INTO `products` VALUES (13, 'Cheetos', 2.70, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Cheetos.png');
INSERT INTO `products` VALUES (14, 'Cheez-It', 1.21, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Cheez-It.jp2');
INSERT INTO `products` VALUES (16, 'Snickers', 2.30, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Snickers.png');
INSERT INTO `products` VALUES (17, 'Chex Mix', 4.35, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Chex%20Mix.png');
INSERT INTO `products` VALUES (18, 'Popcorn', 2.46, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Popcorn.png');
INSERT INTO `products` VALUES (19, 'Indomie', 3.52, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Indomie.png');
INSERT INTO `products` VALUES (20, 'Ice Cream', 2.10, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Ice%20Cream.png');
INSERT INTO `products` VALUES (21, 'Pencils', 3.00, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pencils.png');
INSERT INTO `products` VALUES (22, 'Eraser', 1.12, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Eraser.png');
INSERT INTO `products` VALUES (23, 'Stapler', 1.88, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Stapler.png');
INSERT INTO `products` VALUES (24, 'Pen', 0.92, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Pen.png');
INSERT INTO `products` VALUES (25, 'Notebooks', 1.17, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Notebooks.png');
INSERT INTO `products` VALUES (26, 'Hole Puncher', 2.85, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Hole%20Puncher.png');
INSERT INTO `products` VALUES (27, 'Nyquil', 5.99, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Nyquil.png');
INSERT INTO `products` VALUES (28, 'Advil', 2.01, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Advil.png');
INSERT INTO `products` VALUES (29, 'Umbrella', 1.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Umbrella.png');
INSERT INTO `products` VALUES (30, 'Toilet Paper', 3.70, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Toilet%20Paper.png');
INSERT INTO `products` VALUES (31, 'Tissues', 1.02, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Tissues.png');
INSERT INTO `products` VALUES (32, 'Sewing Kit', 3.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/Sewing%20Kit.png');
INSERT INTO `products` VALUES (33, 'Air Freshener', 5.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/air_freshener.jpg');
INSERT INTO `products` VALUES (34, 'Apple', 25.81, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/apple.jpg');
INSERT INTO `products` VALUES (35, 'Bag', 7.58, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bag.jpg');
INSERT INTO `products` VALUES (36, 'Balloon', 6.39, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/balloon.jpg');
INSERT INTO `products` VALUES (37, 'Bananas', 15.65, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bananas.jpg');
INSERT INTO `products` VALUES (38, 'Bed', 49.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bed.jpg');
INSERT INTO `products` VALUES (39, 'Beef', 38.23, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/beef.jpg');
INSERT INTO `products` VALUES (40, 'Blanket', 9.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blanket.jpg');
INSERT INTO `products` VALUES (41, 'Blouse', 7.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/blouse.jpg');
INSERT INTO `products` VALUES (42, 'Book', 19.84, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/book.jpg');
INSERT INTO `products` VALUES (43, 'Bookmark', 10.50, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bookmark.jpg');
INSERT INTO `products` VALUES (44, 'Boom Box', 17.45, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/boom_box.jpg');
INSERT INTO `products` VALUES (45, 'Bottle Cap', 48.20, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle_cap.jpg');
INSERT INTO `products` VALUES (46, 'Bottle', 45.72, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bottle.jpg');
INSERT INTO `products` VALUES (47, 'Bow', 31.77, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bow.jpg');
INSERT INTO `products` VALUES (48, 'Bowl', 35.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bowl.jpg');
INSERT INTO `products` VALUES (49, 'Box', 31.46, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/box.jpg');
INSERT INTO `products` VALUES (50, 'Bracelet', 33.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bracelet.jpg');
INSERT INTO `products` VALUES (51, 'Bread', 2.18, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/bread.jpg');
INSERT INTO `products` VALUES (52, 'Brocolli', 34.26, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/brocolli.jpg');
INSERT INTO `products` VALUES (53, 'Buckle', 31.04, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/buckel.jpg');
INSERT INTO `products` VALUES (54, 'Button', 46.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/button.jpg');
INSERT INTO `products` VALUES (55, 'Camera', 47.92, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/camera.jpg');
INSERT INTO `products` VALUES (56, 'Candle', 33.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candle.jpg');
INSERT INTO `products` VALUES (57, 'Candy Wrapper', 23.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/candy_wrapper.jpg');
INSERT INTO `products` VALUES (58, 'Canvas', 14.81, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/canvas.jpg');
INSERT INTO `products` VALUES (59, 'Car', 37.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/car.jpg');
INSERT INTO `products` VALUES (60, 'Carrots', 44.80, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/carrots.jpg');
INSERT INTO `products` VALUES (61, 'Cat', 31.49, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cat.jpg');
INSERT INTO `products` VALUES (62, 'Cd', 32.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cd.jpg');
INSERT INTO `products` VALUES (63, 'Cell Phone', 24.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cell_phone.jpg');
INSERT INTO `products` VALUES (64, 'Chair', 41.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chair.jpg');
INSERT INTO `products` VALUES (65, 'Chalk', 28.28, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chalk.jpg');
INSERT INTO `products` VALUES (66, 'Chapter Book', 14.37, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chapter_book.jpg');
INSERT INTO `products` VALUES (67, 'Charger', 23.51, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/charger.jpg');
INSERT INTO `products` VALUES (68, 'Checkbook', 38.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/checkbook.jpg');
INSERT INTO `products` VALUES (69, 'Chocolate', 0.41, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/chocolate.jpg');
INSERT INTO `products` VALUES (70, 'Cinder Block', 7.99, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cinder_block.jpg');
INSERT INTO `products` VALUES (71, 'Clamp', 20.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clamp.jpg');
INSERT INTO `products` VALUES (72, 'Clay Pot', 25.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clay_pot.jpg');
INSERT INTO `products` VALUES (73, 'Clock', 25.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clock.jpg');
INSERT INTO `products` VALUES (74, 'Clothes', 39.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/clothes.jpg');
INSERT INTO `products` VALUES (75, 'Coasters', 42.94, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/coasters.jpg');
INSERT INTO `products` VALUES (76, 'Computer', 21.71, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/computer.jpg');
INSERT INTO `products` VALUES (77, 'Conditioner', 30.05, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/conditioner.jpg');
INSERT INTO `products` VALUES (78, 'Controller', 15.93, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/controller.jpg');
INSERT INTO `products` VALUES (79, 'Cookie Jar', 5.76, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cookie_jar.jpg');
INSERT INTO `products` VALUES (80, 'Cork', 19.41, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cork.jpg');
INSERT INTO `products` VALUES (81, 'Couch', 24.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/couch.jpg');
INSERT INTO `products` VALUES (82, 'Credit Card', 49.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/credit_card.jpg');
INSERT INTO `products` VALUES (83, 'Cup', 36.36, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/cup.jpg');
INSERT INTO `products` VALUES (84, 'Deodorant ', 29.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/deodorant_.jpg');
INSERT INTO `products` VALUES (85, 'Desk', 0.50, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/desk.jpg');
INSERT INTO `products` VALUES (86, 'Doll', 46.57, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/doll.jpg');
INSERT INTO `products` VALUES (87, 'Door', 30.59, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/door.jpg');
INSERT INTO `products` VALUES (88, 'Drawer', 40.09, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/drawer.jpg');
INSERT INTO `products` VALUES (91, 'Eye Liner', 17.26, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/eye_liner.jpg');
INSERT INTO `products` VALUES (92, 'Face Wash', 43.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/face_wash.jpg');
INSERT INTO `products` VALUES (93, 'Fake Flowers', 40.70, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fake_flowers.jpg');
INSERT INTO `products` VALUES (94, 'Flag', 46.55, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flag.jpg');
INSERT INTO `products` VALUES (96, 'Flowers', 39.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/flowers.jpg');
INSERT INTO `products` VALUES (98, 'Fork', 43.21, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fork.jpg');
INSERT INTO `products` VALUES (99, 'Fridge', 4.34, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/fridge.jpg');
INSERT INTO `products` VALUES (100, 'Glass', 26.04, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glass.jpg');
INSERT INTO `products` VALUES (101, 'Glasses', 17.43, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glasses.jpg');
INSERT INTO `products` VALUES (102, 'Glow Stick', 15.78, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/glow_stick.jpg');
INSERT INTO `products` VALUES (103, 'Greeting Card', 12.55, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/greeting_card.jpg');
INSERT INTO `products` VALUES (104, 'Grid Paper', 45.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/grid_paper.jpg');
INSERT INTO `products` VALUES (105, 'Hair Brush', 5.56, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_brush.jpg');
INSERT INTO `products` VALUES (106, 'Hair Tie', 4.75, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hair_tie.jpg');
INSERT INTO `products` VALUES (107, 'Hanger', 33.24, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/hanger.jpg');
INSERT INTO `products` VALUES (108, 'Headphones', 30.65, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/headphones.jpg');
INSERT INTO `products` VALUES (109, 'Helmet', 3.06, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/helmet.jpg');
INSERT INTO `products` VALUES (111, 'Ice Cube Tray', 45.83, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ice_cube_tray.jpg');
INSERT INTO `products` VALUES (112, 'Ipod', 3.08, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ipod.jpg');
INSERT INTO `products` VALUES (113, 'Key Chain', 40.30, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/key_chain.jpg');
INSERT INTO `products` VALUES (114, 'Keyboard', 19.06, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keyboard.jpg');
INSERT INTO `products` VALUES (115, 'Keys', 26.03, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/keys.jpg');
INSERT INTO `products` VALUES (116, 'Knife', 32.86, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/knife.jpg');
INSERT INTO `products` VALUES (118, 'Lamp', 12.12, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp_shade.jpg');
INSERT INTO `products` VALUES (119, 'Lamp Shade', 21.58, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lamp.jpg');
INSERT INTO `products` VALUES (120, 'Leg Warmers', 9.64, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/leg_warmers.jpg');
INSERT INTO `products` VALUES (121, 'Lip Gloss', 10.51, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lip_gloss.jpg');
INSERT INTO `products` VALUES (122, 'Lotion', 25.90, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/lotion.jpg');
INSERT INTO `products` VALUES (123, 'Magnet', 6.99, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/magnet.jpg');
INSERT INTO `products` VALUES (125, 'Mirror', 32.33, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mirror.jpg');
INSERT INTO `products` VALUES (128, 'Monitor', 32.03, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/monitor.jpg');
INSERT INTO `products` VALUES (129, 'Mop', 45.83, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mop.jpg');
INSERT INTO `products` VALUES (130, 'Mouse Pad', 47.74, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mouse_pad.jpg');
INSERT INTO `products` VALUES (131, 'Mp3 Player', 18.50, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/mp3_player.jpg');
INSERT INTO `products` VALUES (132, 'Nail Clippers', 21.69, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_clippers.jpg');
INSERT INTO `products` VALUES (133, 'Nail File', 1.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/nail_file.jpg');
INSERT INTO `products` VALUES (134, 'Needle', 1.81, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/needle.jpg');
INSERT INTO `products` VALUES (137, 'Packing Peanuts', 2.33, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/packing_peanuts.jpg');
INSERT INTO `products` VALUES (138, 'Paint Brush', 1.49, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paint_brush.jpg');
INSERT INTO `products` VALUES (139, 'Pants', 1.17, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pants.jpg');
INSERT INTO `products` VALUES (140, 'Paper', 2.50, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/paper.jpg');
INSERT INTO `products` VALUES (141, 'Pen', 2.57, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pen.jpg');
INSERT INTO `products` VALUES (142, 'Pencil', 3.57, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pencil.jpg');
INSERT INTO `products` VALUES (143, 'Perfume', 3.08, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/perfume.jpg');
INSERT INTO `products` VALUES (144, 'Phone', 2.70, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/phone.jpg');
INSERT INTO `products` VALUES (145, 'Photo Album', 1.21, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/photo_album.jpg');
INSERT INTO `products` VALUES (146, 'Piano', 200.30, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/piano.jpg');
INSERT INTO `products` VALUES (147, 'Picture Frame', 4.35, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/picture_frame.jpg');
INSERT INTO `products` VALUES (148, 'Pillow', 2.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/pillow.jpg');
INSERT INTO `products` VALUES (149, 'Plastic Fork', 3.52, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plastic_fork.jpg');
INSERT INTO `products` VALUES (150, 'Plate', 2.10, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/plate.jpg');
INSERT INTO `products` VALUES (154, 'Purse', 0.92, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/purse.jpg');
INSERT INTO `products` VALUES (155, 'Radio', 1.17, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/radio.jpg');
INSERT INTO `products` VALUES (156, 'Remote', 2.85, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/remote.jpg');
INSERT INTO `products` VALUES (157, 'Ring', 5.99, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/ring.jpg');
INSERT INTO `products` VALUES (158, 'Rubber Band', 2.01, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_band.jpg');
INSERT INTO `products` VALUES (159, 'Rubber Duck', 1.26, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rubber_duck.jpg');
INSERT INTO `products` VALUES (160, 'Rug', 3.70, 'musc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rug.jpg');
INSERT INTO `products` VALUES (161, 'Rusty Nail', 1.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/rusty_nail.jpg');
INSERT INTO `products` VALUES (162, 'Sailboat', 3.96, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sailboat.jpg');
INSERT INTO `products` VALUES (163, 'Sand Paper', 5.74, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sand_paper.jpg');
INSERT INTO `products` VALUES (164, 'Sandal', 25.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sandal.jpg');
INSERT INTO `products` VALUES (165, 'Scotch Tape', 7.58, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/scotch_tape.jpg');
INSERT INTO `products` VALUES (166, 'Screw', 6.39, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/screw.jpg');
INSERT INTO `products` VALUES (167, 'Seat Belt', 15.65, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/seat_belt.jpg');
INSERT INTO `products` VALUES (168, 'Shampoo', 49.35, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shampoo.jpg');
INSERT INTO `products` VALUES (169, 'Sharpie', 38.23, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sharpie.jpg');
INSERT INTO `products` VALUES (170, 'Shawl', 9.83, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shawl.jpg');
INSERT INTO `products` VALUES (171, 'Shirt', 7.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shirt.jpg');
INSERT INTO `products` VALUES (172, 'Shoe Lace', 19.84, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoe_lace.jpg');
INSERT INTO `products` VALUES (173, 'Shoes', 10.50, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shoes.jpg');
INSERT INTO `products` VALUES (174, 'Shovel', 17.45, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/shovel.jpg');
INSERT INTO `products` VALUES (176, 'Sketch Pad', 45.72, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sketch_pad.jpg');
INSERT INTO `products` VALUES (177, 'Slipper', 31.77, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/slipper.jpg');
INSERT INTO `products` VALUES (178, 'Soap', 35.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soap.jpg');
INSERT INTO `products` VALUES (179, 'Socks', 31.46, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/socks.jpg');
INSERT INTO `products` VALUES (180, 'Soda Can', 33.35, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soda_can.jpg');
INSERT INTO `products` VALUES (181, 'Sofa', 2.18, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sofa.jpg');
INSERT INTO `products` VALUES (182, 'Soy Sauce Packet', 34.26, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/soy_sauce_packet.jpg');
INSERT INTO `products` VALUES (183, 'Speakers', 31.04, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/speakers.jpg');
INSERT INTO `products` VALUES (184, 'Sponge', 46.02, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sponge.jpg');
INSERT INTO `products` VALUES (185, 'Spoon', 47.92, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spoon.jpg');
INSERT INTO `products` VALUES (186, 'Spring', 33.91, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/spring.jpg');
INSERT INTO `products` VALUES (187, 'Sticky Note', 23.45, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sticky_note.jpg');
INSERT INTO `products` VALUES (188, 'Stockings', 14.81, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stockings.jpg');
INSERT INTO `products` VALUES (189, 'Stop Sign', 37.11, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/stop_sign.jpg');
INSERT INTO `products` VALUES (190, 'Street Lights', 44.80, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/street_lights.jpg');
INSERT INTO `products` VALUES (191, 'Sun Glasses', 31.49, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/sun_glasses.jpg');
INSERT INTO `products` VALUES (193, 'Teddies', 24.37, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/teddies.jpg');
INSERT INTO `products` VALUES (194, 'Television', 41.24, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/television.jpg');
INSERT INTO `products` VALUES (195, 'Thermometer', 28.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermometer.jpg');
INSERT INTO `products` VALUES (196, 'Thermostat', 14.37, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thermostat.jpg');
INSERT INTO `products` VALUES (197, 'Thread', 23.51, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/thread.jpg');
INSERT INTO `products` VALUES (198, 'Tire Swing', 38.56, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tire_swing.jpg');
INSERT INTO `products` VALUES (199, 'Tissue Box', 0.41, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tissue_box.jpg');
INSERT INTO `products` VALUES (201, 'Toilet', 20.03, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toilet.jpg');
INSERT INTO `products` VALUES (202, 'Tomato', 25.50, 'snacks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tomato.jpg');
INSERT INTO `products` VALUES (203, 'Tooth Picks', 25.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/tooth_picks.jpg');
INSERT INTO `products` VALUES (204, 'Toothbrush', 39.28, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothbrush.jpg');
INSERT INTO `products` VALUES (205, 'Toothpaste', 42.94, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/toothpaste.jpg');
INSERT INTO `products` VALUES (206, 'Towel', 21.71, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/towel.jpg');
INSERT INTO `products` VALUES (210, 'Tweezers', 19.41, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twezzers.jpg');
INSERT INTO `products` VALUES (211, 'Twister', 24.57, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/twister.jpg');
INSERT INTO `products` VALUES (212, 'Usb Drive', 49.77, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/usb_drive.jpg');
INSERT INTO `products` VALUES (213, 'Vase', 36.36, 'misc', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/vase.jpg');
INSERT INTO `products` VALUES (214, 'Video Games', 46.02, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/video_games.jpg');
INSERT INTO `products` VALUES (216, 'Wallet', 33.91, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/wallet.jpg');
INSERT INTO `products` VALUES (218, 'Watch', 14.81, 'electronics', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/watch.jpg');
INSERT INTO `products` VALUES (219, 'Water Bottle', 37.11, 'drinks', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/water_bottle.jpg');
INSERT INTO `products` VALUES (220, 'White Out', 35.42, 'school_supplies', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/white_out.jpg');
INSERT INTO `products` VALUES (222, 'Zipper', 21.87, 'personal', 'https://fetchrapp.s3.amazonaws.com/Product%20Photos/zipper.jpg')
;/*!40000 ALTER TABLE `products` ENABLE KEYS */;
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


CREATE or replace view fetchr_db.product_records as
SELECT products.*,  ifnull(sum(order_summary.quantity),0) as 'total_sold' 
  FROM fetchr_db.products left OUTER JOIN fetchr_db.order_summary
    ON order_summary.product_id = products.product_id
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
