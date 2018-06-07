-- MySQL Script generated by MySQL Workbench
-- Tue Jun  5 12:54:35 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`company` ;

CREATE TABLE IF NOT EXISTS `mydb`.`company` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`department` ;

CREATE TABLE IF NOT EXISTS `mydb`.`department` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_department_company1_idx` (`company_id` ASC),
  CONSTRAINT `fk_department_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `mydb`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`collaborator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`collaborator` ;

CREATE TABLE IF NOT EXISTS `mydb`.`collaborator` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_collaborator_department_idx` (`department_id` ASC),
  CONSTRAINT `fk_collaborator_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`chat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`chat` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`agent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`agent` ;

CREATE TABLE IF NOT EXISTS `mydb`.`agent` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`agent_has_chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`agent_has_chat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`agent_has_chat` (
  `chat_id` INT NOT NULL,
  `agent_id` INT NOT NULL,
  PRIMARY KEY (`chat_id`, `agent_id`),
  INDEX `fk_chat_has_agent_agent1_idx` (`agent_id` ASC),
  INDEX `fk_chat_has_agent_chat1_idx` (`chat_id` ASC),
  CONSTRAINT `fk_chat_has_agent_chat1`
    FOREIGN KEY (`chat_id`)
    REFERENCES `mydb`.`chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_has_agent_agent1`
    FOREIGN KEY (`agent_id`)
    REFERENCES `mydb`.`agent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`topic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`topic` ;

CREATE TABLE IF NOT EXISTS `mydb`.`topic` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`message` ;

CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `id` INT NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  `chat_id` INT NOT NULL,
  `topic_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_chat1_idx` (`chat_id` ASC),
  INDEX `fk_message_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_message_chat1`
    FOREIGN KEY (`chat_id`)
    REFERENCES `mydb`.`chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `mydb`.`topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`attachment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`attachment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`attachment` (
  `id` INT NOT NULL,
  `link` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message_has_attachment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`message_has_attachment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`message_has_attachment` (
  `message_id` INT NOT NULL,
  `attachment_id` INT NOT NULL,
  PRIMARY KEY (`message_id`, `attachment_id`),
  INDEX `fk_message_has_attachment_attachment1_idx` (`attachment_id` ASC),
  INDEX `fk_message_has_attachment_message1_idx` (`message_id` ASC),
  CONSTRAINT `fk_message_has_attachment_message1`
    FOREIGN KEY (`message_id`)
    REFERENCES `mydb`.`message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_has_attachment_attachment1`
    FOREIGN KEY (`attachment_id`)
    REFERENCES `mydb`.`attachment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view` ;

CREATE TABLE IF NOT EXISTS `mydb`.`view` (
  `message_id` INT NOT NULL,
  `collaborator_id` INT NULL,
  `agent_id` INT NULL,
  PRIMARY KEY (`message_id`, `collaborator_id`, `agent_id`),
  INDEX `fk_message_has_collaborator_collaborator1_idx` (`collaborator_id` ASC),
  INDEX `fk_message_has_collaborator_message1_idx` (`message_id` ASC),
  INDEX `fk_view_agent1_idx` (`agent_id` ASC),
  CONSTRAINT `fk_message_has_collaborator_message1`
    FOREIGN KEY (`message_id`)
    REFERENCES `mydb`.`message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_has_collaborator_collaborator1`
    FOREIGN KEY (`collaborator_id`)
    REFERENCES `mydb`.`collaborator` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_view_agent1`
    FOREIGN KEY (`agent_id`)
    REFERENCES `mydb`.`agent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`department_has_chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`department_has_chat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`department_has_chat` (
  `department_id` INT NOT NULL,
  `chat_id` INT NOT NULL,
  PRIMARY KEY (`department_id`, `chat_id`),
  INDEX `fk_department_has_chat_chat1_idx` (`chat_id` ASC),
  INDEX `fk_department_has_chat_department1_idx` (`department_id` ASC),
  CONSTRAINT `fk_department_has_chat_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_has_chat_chat1`
    FOREIGN KEY (`chat_id`)
    REFERENCES `mydb`.`chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
