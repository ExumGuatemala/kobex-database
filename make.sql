-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema kobex
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kobex
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kobex` DEFAULT CHARACTER SET utf8 ;
USE `kobex` ;

-- -----------------------------------------------------
-- Table `kobex`.`persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`persons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `lastname` TEXT NULL,
  `address` TEXT NULL,
  `phone1` TEXT NULL,
  `phone2` TEXT NULL,
  `more` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `persons_id` INT NOT NULL,
  `code` TEXT NOT NULL,
  `email` TEXT BINARY NOT NULL,
  `password` TEXT NULL,
  `token` TEXT NULL,
  `roles_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_persons1_idx` (`persons_id` ASC),
  INDEX `fk_users_roles1_idx` (`roles_id` ASC),
  CONSTRAINT `fk_users_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `kobex`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `kobex`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `persons_id` INT NOT NULL,
  `users_id` INT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clients_persons_idx` (`persons_id` ASC),
  INDEX `fk_clients_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_clients_persons`
    FOREIGN KEY (`persons_id`)
    REFERENCES `kobex`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clients_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`cases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`cases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `users_id` INT NOT NULL,
  `cases_id` INT NOT NULL,
  `done` VARCHAR(3) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_documents_users1_idx` (`users_id` ASC),
  INDEX `fk_documents_cases1_idx` (`cases_id` ASC),
  CONSTRAINT `fk_documents_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_cases1`
    FOREIGN KEY (`cases_id`)
    REFERENCES `kobex`.`cases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`templates` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `name` TEXT NULL,
  `path` TEXT NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_templates_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_templates_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`versions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`versions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `documents_id` INT NOT NULL,
  `description` TEXT NULL,
  `path` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_versions_users1_idx` (`users_id` ASC),
  INDEX `fk_versions_documents1_idx` (`documents_id` ASC),
  CONSTRAINT `fk_versions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_versions_documents1`
    FOREIGN KEY (`documents_id`)
    REFERENCES `kobex`.`documents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`plans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NULL,
  `description` TEXT NULL,
  `price` INT NULL,
  `duration` INT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`logs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `action` TEXT NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sessions_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_sessions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`users_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`users_plans` (
  `users_id` INT NOT NULL,
  `plans_id` INT NOT NULL,
  `active` VARCHAR(3) NULL,
  `created_at` DATETIME NULL,
  `expires_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_plans_has_users_users1_idx` (`users_id` ASC),
  INDEX `fk_plans_has_users_plans1_idx` (`plans_id` ASC),
  CONSTRAINT `fk_plans_has_users_plans1`
    FOREIGN KEY (`plans_id`)
    REFERENCES `kobex`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plans_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`leaders_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`leaders_users` (
  `leader_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_users_has_users_users2_idx` (`user_id` ASC),
  INDEX `fk_users_has_users_users1_idx` (`leader_id` ASC),
  CONSTRAINT `fk_users_has_users_users1`
    FOREIGN KEY (`leader_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_users_users2`
    FOREIGN KEY (`user_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`notifications` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `description` TEXT NULL,
  `url` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notifications_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`users_cases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`users_cases` (
  `users_id` INT NOT NULL,
  `cases_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_cases_has_users_users1_idx` (`users_id` ASC),
  INDEX `fk_cases_has_users_cases1_idx` (`cases_id` ASC),
  CONSTRAINT `fk_cases_has_users_cases1`
    FOREIGN KEY (`cases_id`)
    REFERENCES `kobex`.`cases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cases_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `kobex`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`cases_clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`cases_clients` (
  `cases_id` INT NOT NULL,
  `clients_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_cases_has_clients_clients1_idx` (`clients_id` ASC),
  INDEX `fk_cases_has_clients_cases1_idx` (`cases_id` ASC),
  CONSTRAINT `fk_cases_has_clients_cases1`
    FOREIGN KEY (`cases_id`)
    REFERENCES `kobex`.`cases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cases_has_clients_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `kobex`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kobex`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kobex`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` TEXT NULL,
  `description` TEXT NULL,
  `cases_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_cases1_idx` (`cases_id` ASC),
  CONSTRAINT `fk_comments_cases1`
    FOREIGN KEY (`cases_id`)
    REFERENCES `kobex`.`cases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
