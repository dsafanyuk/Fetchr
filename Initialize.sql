SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fetchr_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fetchr_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fetchr_db` DEFAULT CHARACTER SET utf8 ;
USE `fetchr_db` ;

-- -----------------------------------------------------
-- Table `fetchr_db`.`Accounts`
-- -----------------------------------------------------
create TABLE IF NOT EXISTS `fetchr_db`.`Users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email_address` VARCHAR(45) NOT NULL unique,
  `password` VARCHAR(45) NOT NULL,
  `room_num` VARCHAR(4) NOT NULL,
  `is_courier` TINYINT NOT NULL,
  `credit_card_number` VARCHAR(25) NOT NULL,
  `ccv` VARCHAR(4) NOT NULL,
  `exp_date` VARCHAR(4) NOT NULL,
  `wallet` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fetchr_db`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fetchr_db`.`Products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fetchr_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fetchr_db`.`Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `courier_id` INT NULL,
  `delivery_status` VARCHAR(15) NULL,
  `time_delivered` DATE NOT NULL,
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_total` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `courier_fk_idx` (`courier_id` ASC),
  INDEX `customer_fk_idx` (`customer_id` ASC),
  CONSTRAINT `courier_fk`
    FOREIGN KEY (`courier_id`)
    REFERENCES `fetchr_db`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `fetchr_db`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fetchr_db`.`Order_Summary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fetchr_db`.`Order_Summary` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_Order_Details_Products1_idx` (`product_id` ASC),
  CONSTRAINT `fk_Order_Details_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `fetchr_db`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Details_Products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `fetchr_db`.`Products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;