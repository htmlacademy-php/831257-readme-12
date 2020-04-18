-- MySQL Script generated by MySQL Workbench
-- Сб 18 апр 2020 21:08:44
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema readme
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema readme
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `readme` DEFAULT CHARACTER SET utf8 ;
USE `readme` ;

-- -----------------------------------------------------
-- Table `readme`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL,
  `email` VARCHAR(320) NOT NULL,
  `login` VARCHAR(30) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `avatar` VARCHAR(4100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB
COMMENT = 'Представляет зарегистрированного пользователя. ';


-- -----------------------------------------------------
-- Table `readme`.`content_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`content_type` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  `class` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `class_UNIQUE` (`class` ASC))
ENGINE = InnoDB
COMMENT = 'Один из пяти предопределенных типов контента.';


-- -----------------------------------------------------
-- Table `readme`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`post` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL,
  `heading` VARCHAR(50) NULL,
  `text` TEXT NULL,
  `author_quote` VARCHAR(50) NULL,
  `picture_path` VARCHAR(4100) NULL,
  `video_url` VARCHAR(2050) NULL,
  `link` VARCHAR(2050) NULL,
  `number_views` INT UNSIGNED NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `content_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user_idx` (`user_id` ASC),
  INDEX `fk_post_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_post_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `readme`.`content_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Состоит из заголовка и содержимого. Набор полей, которые будут заполнены, зависит от выбранного типа.';


-- -----------------------------------------------------
-- Table `readme`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL,
  `text` TINYTEXT NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `post_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Текстовый комментарий, оставленный к одному из постов.';


-- -----------------------------------------------------
-- Table `readme`.`like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`like` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_like_post1_idx` (`post_id` ASC),
  INDEX `fk_like_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_like_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `readme`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`subscription` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id_creator` INT UNSIGNED NOT NULL,
  `user_id_subscriber` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_user1_idx` (`user_id_creator` ASC),
  INDEX `fk_subscription_user2_idx` (`user_id_subscriber` ASC),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`user_id_creator`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_user2`
    FOREIGN KEY (`user_id_subscriber`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `readme`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`message` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL,
  `text` TINYTEXT NULL,
  `user_id_sender` INT UNSIGNED NOT NULL,
  `user_id_recipient` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`user_id_sender` ASC),
  INDEX `fk_message_user2_idx` (`user_id_recipient` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`user_id_sender`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`user_id_recipient`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Одно сообщение из внутренней переписки пользователей на сайте';


-- -----------------------------------------------------
-- Table `readme`.`hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`hashtag` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Один из используемых хештегов на сайте.';


-- -----------------------------------------------------
-- Table `readme`.`post_hashtag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`post_hashtag` (
  `post_id` INT UNSIGNED NOT NULL,
  `hashtag_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`, `hashtag_id`),
  INDEX `fk_post_hashtag_hashtag1_idx` (`hashtag_id` ASC),
  INDEX `fk_post_hashtag_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_hashtag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `readme`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_hashtag_hashtag1`
    FOREIGN KEY (`hashtag_id`)
    REFERENCES `readme`.`hashtag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
