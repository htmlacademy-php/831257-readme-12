-- MySQL Script generated by MySQL Workbench
-- Вт 12 мая 2020 17:24:59
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema readme
-- -----------------------------------------------------
-- Сервис для публикаций сообщений в своём блоге. Учебный проект HTML-академии.

-- -----------------------------------------------------
-- Schema readme
--
-- Сервис для публикаций сообщений в своём блоге. Учебный проект HTML-академии.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `readme` DEFAULT CHARACTER SET utf8 ;
USE `readme` ;

-- -----------------------------------------------------
-- Table `readme`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL DEFAULT NULL,
  `email` VARCHAR(320) NOT NULL,
  `login` VARCHAR(30) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(70) NULL DEFAULT NULL,
  `subscribers` INT UNSIGNED NULL DEFAULT 0,
  `posts` INT UNSIGNED NULL DEFAULT 0,
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
  `name` VARCHAR(30) NULL DEFAULT NULL,
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
  `creation_time` DATETIME NULL DEFAULT NULL,
  `heading` VARCHAR(50) NULL DEFAULT NULL,
  `text` TEXT NULL DEFAULT NULL,
  `author_quote` VARCHAR(50) NULL DEFAULT NULL,
  `picture` VARCHAR(70) NULL DEFAULT NULL,
  `video` VARCHAR(1000) NULL DEFAULT NULL,
  `link` VARCHAR(1000) NULL DEFAULT NULL,
  `views` INT UNSIGNED NULL DEFAULT NULL,
  `repost` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `original_user_id` INT UNSIGNED NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `content_type_id` TINYINT UNSIGNED NOT NULL,
  `likes` INT UNSIGNED NULL DEFAULT 0,
  `comments` INT UNSIGNED NULL DEFAULT 0,
  `reposts` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user_idx` (`user_id` ASC),
  INDEX `fk_post_content1_idx` (`content_type_id` ASC),
  INDEX `fk_post_user1_idx` (`original_user_id` ASC),
  CONSTRAINT `fk_post_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_content1`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `readme`.`content_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`original_user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Состоит из заголовка и содержимого. Набор полей, которые будут заполнены, зависит от выбранного типа.';


-- -----------------------------------------------------
-- Table `readme`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL DEFAULT NULL,
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
  `post_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`, `user_id`),
  INDEX `index2` (`post_id` ASC),
  INDEX `index3` (`user_id` ASC),
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
  `creator_user_id` INT UNSIGNED NOT NULL,
  `subscriber_user_id_` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_user1_idx` (`creator_user_id` ASC),
  INDEX `fk_subscription_user2_idx` (`subscriber_user_id_` ASC),
  CONSTRAINT `fk_subscription_user1`
    FOREIGN KEY (`creator_user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscription_user2`
    FOREIGN KEY (`subscriber_user_id_`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `readme`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `readme`.`message` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creation_time` DATETIME NULL DEFAULT NULL,
  `text` TINYTEXT NULL DEFAULT NULL,
  `sender_user_id` INT UNSIGNED NOT NULL,
  `recipient_user_id` INT UNSIGNED NOT NULL,
  `read` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_user_id` ASC),
  INDEX `fk_message_user2_idx` (`recipient_user_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_user_id`)
    REFERENCES `readme`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`recipient_user_id`)
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
  `name` VARCHAR(50) NULL DEFAULT NULL,
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
