-- MySQL Script generated by MySQL Workbench
-- Mon Dec  2 15:39:15 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Olivanders
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Olivanders` ;

-- -----------------------------------------------------
-- Schema Olivanders
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Olivanders` ;
USE `Olivanders` ;

-- -----------------------------------------------------
-- Table `Olivanders`.`wand_has_core`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wand_has_core` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wand_has_core` (
  `core_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `discover_date` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`core_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wand_has_wood`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wand_has_wood` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wand_has_wood` (
  `wood_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `discover_date` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`wood_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wandmakers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wandmakers` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wandmakers` (
  `wandmaker_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `last_name` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`wandmaker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wands` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wands` (
  `wand_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `wandmaker_id` INT UNSIGNED NOT NULL,
  `wood_id` INT UNSIGNED NOT NULL,
  `core_id` INT UNSIGNED NOT NULL,
  `length` INT NOT NULL,
  PRIMARY KEY (`wand_id`),
  INDEX `idx_core_id` (`core_id` ASC) VISIBLE,
  INDEX `idx_wood_id` (`wood_id` ASC) VISIBLE,
  INDEX `idx_wandmaker_id` (`wandmaker_id` ASC) VISIBLE,
  CONSTRAINT `fk_wands_core_id`
    FOREIGN KEY (`core_id`)
    REFERENCES `Olivanders`.`wand_has_core` (`core_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wands_wood_id`
    FOREIGN KEY (`wood_id`)
    REFERENCES `Olivanders`.`wand_has_wood` (`wood_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wands_wandmaker_id`
    FOREIGN KEY (`wandmaker_id`)
    REFERENCES `Olivanders`.`wandmakers` (`wandmaker_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`users` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `birth_date` VARCHAR(20) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`Transfers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`Transfers` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`Transfers` (
  `transfer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `wandmaker_id` INT UNSIGNED NULL DEFAULT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `wand_id` INT UNSIGNED NOT NULL,
  `price` INT NULL DEFAULT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transfer_id`),
  INDEX `idx_transfer_wand_id` (`wand_id` ASC) VISIBLE,
  INDEX `idx_transfer_user_id` (`user_id` ASC) VISIBLE,
  INDEX `idx_transfer_wandmaker_id` (`wandmaker_id` ASC) VISIBLE,
  CONSTRAINT `fk_transfers_wand_id`
    FOREIGN KEY (`wand_id`)
    REFERENCES `Olivanders`.`wands` (`wand_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transfers_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Olivanders`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transfers_wandmaker_id`
    FOREIGN KEY (`wandmaker_id`)
    REFERENCES `Olivanders`.`wandmakers` (`wandmaker_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`languages` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`languages` (
  `language_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `iso_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `iso_code_UNIQUE` (`iso_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wood_has_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wood_has_language` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wood_has_language` (
  `wood_id` INT UNSIGNED NOT NULL,
  `language_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(350) NOT NULL,
  PRIMARY KEY (`wood_id`, `language_id`),
  INDEX `idx_language_id` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_wood_language_id`
    FOREIGN KEY (`language_id`)
    REFERENCES `Olivanders`.`languages` (`language_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wood_language_wood_id`
    FOREIGN KEY (`wood_id`)
    REFERENCES `Olivanders`.`wand_has_wood` (`wood_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`core_has_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`core_has_language` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`core_has_language` (
  `core_id` INT UNSIGNED NOT NULL,
  `language_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(220) NOT NULL,
  PRIMARY KEY (`core_id`, `language_id`),
  INDEX `idx_language_core_id` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_core_language_core_id`
    FOREIGN KEY (`core_id`)
    REFERENCES `Olivanders`.`wand_has_core` (`core_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_core_language_id`
    FOREIGN KEY (`language_id`)
    REFERENCES `Olivanders`.`languages` (`language_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wandmaker_has_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wandmaker_has_language` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wandmaker_has_language` (
  `wandmaker_id` INT UNSIGNED NOT NULL,
  `language_id` INT UNSIGNED NOT NULL,
  `specialty` VARCHAR(400) NULL DEFAULT NULL,
  PRIMARY KEY (`wandmaker_id`, `language_id`),
  INDEX `idx_wandmaker_language_id` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_wandmaker_language_id`
    FOREIGN KEY (`language_id`)
    REFERENCES `Olivanders`.`languages` (`language_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_wandmaker_id`
    FOREIGN KEY (`wandmaker_id`)
    REFERENCES `Olivanders`.`wandmakers` (`wandmaker_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Olivanders`.`wand_has_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Olivanders`.`wand_has_language` ;

CREATE TABLE IF NOT EXISTS `Olivanders`.`wand_has_language` (
  `language_id` INT UNSIGNED NOT NULL,
  `wand_id` INT UNSIGNED NOT NULL,
  `flexibility` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`language_id`, `wand_id`),
  INDEX `fk_language_id_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_wand_id_idx` (`wand_id` ASC) VISIBLE,
  CONSTRAINT `fk_language_id`
    FOREIGN KEY (`language_id`)
    REFERENCES `Olivanders`.`languages` (`language_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wand_id`
    FOREIGN KEY (`wand_id`)
    REFERENCES `Olivanders`.`wands` (`wand_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;