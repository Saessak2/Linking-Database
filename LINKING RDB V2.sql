CREATE DATABASE  IF NOT EXISTS `linking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `linking`;
-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: linking-mysql.c23kvlbmlqie.ap-northeast-2.rds.amazonaws.com    Database: linking
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `annotation`
--

DROP TABLE IF EXISTS `annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `annotation` (
  `annotation_id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `participant_id` bigint DEFAULT NULL,
  `block_id` bigint NOT NULL,
  `writer` varchar(40) NOT NULL,
  `created_datetime` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  PRIMARY KEY (`annotation_id`),
  KEY `annotation_block_id_idx` (`block_id`),
  KEY `annotation_participant_id_idx` (`participant_id`),
  CONSTRAINT `annotation_block_id` FOREIGN KEY (`block_id`) REFERENCES `block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `annotation_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assign`
--

DROP TABLE IF EXISTS `assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assign` (
  `assign_id` bigint NOT NULL AUTO_INCREMENT,
  `todo_id` bigint NOT NULL,
  `participant_id` bigint NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'BEFORE_START',
  PRIMARY KEY (`assign_id`),
  KEY `assign_todo_id_idx` (`todo_id`),
  KEY `assing_participant_id_idx` (`participant_id`),
  CONSTRAINT `assign_todo_id` FOREIGN KEY (`todo_id`) REFERENCES `todo` (`todo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assing_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `block` (
  `block_id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT 'untitled',
  `content` text NOT NULL,
  `page_id` bigint NOT NULL,
  `block_order` int NOT NULL,
  PRIMARY KEY (`block_id`),
  KEY `block_page_id` (`page_id`),
  CONSTRAINT `block_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `chat_id` bigint NOT NULL AUTO_INCREMENT,
  `participant_id` bigint NOT NULL,
  `chatroom_id` bigint NOT NULL,
  `content` varchar(255) NOT NULL,
  `sent_datetime` datetime NOT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `participant_id_idx` (`participant_id`),
  KEY `chatroom_id_idx` (`chatroom_id`),
  CONSTRAINT `chatroom_id` FOREIGN KEY (`chatroom_id`) REFERENCES `chatroom` (`chatroom_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=554 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_join`
--

DROP TABLE IF EXISTS `chat_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_join` (
  `chat_join_id` bigint NOT NULL AUTO_INCREMENT,
  `chatroom_id` bigint NOT NULL,
  `participant_id` bigint NOT NULL,
  PRIMARY KEY (`chat_join_id`),
  KEY `chatroom_id_idx` (`chatroom_id`),
  KEY `participant_id_idx` (`participant_id`),
  CONSTRAINT `fk_1_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chatroom_id` FOREIGN KEY (`chatroom_id`) REFERENCES `chatroom` (`chatroom_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatroom`
--

DROP TABLE IF EXISTS `chatroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom` (
  `chatroom_id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint DEFAULT NULL,
  PRIMARY KEY (`chatroom_id`),
  KEY `project_id_idx` (`project_id`),
  CONSTRAINT `project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatroom_badge`
--

DROP TABLE IF EXISTS `chatroom_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatroom_badge` (
  `badge_id` bigint NOT NULL AUTO_INCREMENT,
  `participant_id` bigint NOT NULL,
  `chatroom_id` bigint NOT NULL,
  `unread_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`badge_id`),
  KEY `participant_id_idx` (`participant_id`),
  KEY `chatroom_id_idx` (`chatroom_id`),
  CONSTRAINT `fk_1_chatroom_id` FOREIGN KEY (`chatroom_id`) REFERENCES `chatroom` (`chatroom_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_2_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `firebase_token`
--

DROP TABLE IF EXISTS `firebase_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `firebase_token` (
  `token_id` bigint NOT NULL AUTO_INCREMENT,
  `app_token` varchar(200) DEFAULT NULL,
  `app_timestamp` timestamp NULL DEFAULT NULL,
  `web_token` varchar(200) DEFAULT NULL,
  `web_timestamp` timestamp NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`token_id`),
  KEY `token_user_id_idx` (`user_id`),
  CONSTRAINT `token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `group_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL DEFAULT 'New Group',
  `project_id` bigint NOT NULL,
  `group_order` int NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `group_project_id` (`project_id`),
  CONSTRAINT `group_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page` (
  `page_id` bigint NOT NULL AUTO_INCREMENT,
  `page_order` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `group_id` bigint NOT NULL,
  `template` varchar(45) NOT NULL DEFAULT 'BLANK',
  `content` text,
  PRIMARY KEY (`page_id`),
  KEY `page_group_id` (`group_id`),
  CONSTRAINT `page_group_id` FOREIGN KEY (`group_id`) REFERENCES `group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagecheck`
--

DROP TABLE IF EXISTS `pagecheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagecheck` (
  `pagecheck_id` bigint NOT NULL AUTO_INCREMENT,
  `last_checked` datetime DEFAULT NULL,
  `page_id` bigint NOT NULL,
  `participant_id` bigint NOT NULL,
  `anno_not_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`pagecheck_id`),
  KEY `pagecheck_page_id_idx` (`page_id`),
  KEY `pagecheck_participant_id` (`participant_id`),
  CONSTRAINT `pagecheck_page_id` FOREIGN KEY (`page_id`) REFERENCES `page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pagecheck_participant_id` FOREIGN KEY (`participant_id`) REFERENCES `participant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=440 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `participant`
--

DROP TABLE IF EXISTS `participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participant` (
  `participant_id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `user_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`participant_id`),
  KEY `participant_user_id_idx` (`user_id`),
  KEY `participant_project_id_idx` (`project_id`),
  CONSTRAINT `participant_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participant_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `project_id` bigint NOT NULL AUTO_INCREMENT,
  `begin_date` date NOT NULL,
  `due_date` date NOT NULL,
  `project_name` varchar(28) NOT NULL,
  `owner_id` bigint NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `project_user_id` (`owner_id`),
  CONSTRAINT `project_user_id` FOREIGN KEY (`owner_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_notification`
--

DROP TABLE IF EXISTS `push_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notification` (
  `push_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `project_id` bigint NOT NULL,
  `sender` varchar(40) NOT NULL,
  `notice_type` varchar(10) NOT NULL,
  `priority` smallint NOT NULL,
  `target_id` bigint DEFAULT NULL,
  `created_date` date NOT NULL,
  `is_checked` tinyint NOT NULL,
  `body` varchar(100) NOT NULL,
  PRIMARY KEY (`push_id`),
  KEY `push_user_receiver_id_idx` (`user_id`),
  KEY `push_project_project_id_idx` (`project_id`),
  CONSTRAINT `push_project_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `push_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_notification_badge`
--

DROP TABLE IF EXISTS `push_notification_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notification_badge` (
  `user_id` bigint NOT NULL,
  `unread_count` int NOT NULL,
  `badge_id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`badge_id`),
  KEY `pushbadge_user_id_idx` (`user_id`),
  CONSTRAINT `pushbadge_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_settings`
--

DROP TABLE IF EXISTS `push_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_settings` (
  `push_settings_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `allowed_app_push` tinyint NOT NULL,
  `allowed_web_push` tinyint NOT NULL,
  `allowed_mail` tinyint NOT NULL,
  PRIMARY KEY (`push_settings_id`),
  KEY `push_settings_user_id` (`user_id`),
  CONSTRAINT `push_settings_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `todo`
--

DROP TABLE IF EXISTS `todo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `todo` (
  `todo_id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `parent_todo_id` bigint DEFAULT NULL,
  `is_parent` tinyint NOT NULL DEFAULT '1',
  `start_date` datetime NOT NULL,
  `due_date` datetime NOT NULL,
  `content` varchar(28) NOT NULL DEFAULT '""',
  PRIMARY KEY (`todo_id`),
  KEY `todo_project_id_idx` (`project_id`),
  KEY `todo_parent_todo_id_idx` (`parent_todo_id`),
  CONSTRAINT `todo_parent_todo_id` FOREIGN KEY (`parent_todo_id`) REFERENCES `todo` (`todo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `todo_project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-14 11:35:46
