-- MySQL dump 10.13  Distrib 8.0.22, for osx10.16 (x86_64)
--
-- Host: localhost    Database: ApolloPortalDB
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `App`
--

DROP TABLE IF EXISTS `App`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `App` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Name` (`Name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `App`
--

LOCK TABLES `App` WRITE;
/*!40000 ALTER TABLE `App` DISABLE KEYS */;
INSERT INTO `App` VALUES (1,'SampleApp','Sample App','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'thrc.account','account-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(3,'thrc-user','user-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'thrc-account','account-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'thrc.gateway','api-gateway','TEST1','样例部门1','apollo','apollo@acme.com',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(6,'thrc-account-http-interface','account-interface','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'thrc-gateway','http-gateway','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `App` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AppNamespace`
--

DROP TABLE IF EXISTS `AppNamespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AppNamespace` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(32) NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_AppId` (`AppId`),
  KEY `Name_AppId` (`Name`,`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用namespace定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppNamespace`
--

LOCK TABLES `AppNamespace` WRITE;
/*!40000 ALTER TABLE `AppNamespace` DISABLE KEYS */;
INSERT INTO `AppNamespace` VALUES (1,'application','SampleApp','properties',_binary '\0','default app namespace',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'application','thrc.account','properties',_binary '\0','default app namespace',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(3,'application','thrc-user','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'application','thrc-account','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'application','thrc.gateway','properties',_binary '\0','default app namespace',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(6,'application','thrc-account-http-interface','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'application','thrc-gateway','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `AppNamespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Authorities`
--

DROP TABLE IF EXISTS `Authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Authorities` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL,
  `Authority` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Authorities`
--

LOCK TABLES `Authorities` WRITE;
/*!40000 ALTER TABLE `Authorities` DISABLE KEYS */;
INSERT INTO `Authorities` VALUES (1,'apollo','ROLE_user');
/*!40000 ALTER TABLE `Authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Consumer`
--

DROP TABLE IF EXISTS `Consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Consumer` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='开放API消费者';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consumer`
--

LOCK TABLES `Consumer` WRITE;
/*!40000 ALTER TABLE `Consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConsumerAudit`
--

DROP TABLE IF EXISTS `ConsumerAudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ConsumerAudit` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ConsumerId` (`ConsumerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer审计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ConsumerAudit`
--

LOCK TABLES `ConsumerAudit` WRITE;
/*!40000 ALTER TABLE `ConsumerAudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `ConsumerAudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConsumerRole`
--

DROP TABLE IF EXISTS `ConsumerRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ConsumerRole` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_ConsumerId_RoleId` (`ConsumerId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer和role的绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ConsumerRole`
--

LOCK TABLES `ConsumerRole` WRITE;
/*!40000 ALTER TABLE `ConsumerRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `ConsumerRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConsumerToken`
--

DROP TABLE IF EXISTS `ConsumerToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ConsumerToken` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int unsigned DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Token` (`Token`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ConsumerToken`
--

LOCK TABLES `ConsumerToken` WRITE;
/*!40000 ALTER TABLE `ConsumerToken` DISABLE KEYS */;
/*!40000 ALTER TABLE `ConsumerToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Favorite`
--

DROP TABLE IF EXISTS `Favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Favorite` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int NOT NULL DEFAULT '10000' COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `IX_UserId` (`UserId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Favorite`
--

LOCK TABLES `Favorite` WRITE;
/*!40000 ALTER TABLE `Favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `Favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permission`
--

DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permission` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_TargetId_PermissionType` (`TargetId`(191),`PermissionType`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='permission表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permission`
--

LOCK TABLES `Permission` WRITE;
/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` VALUES (1,'CreateCluster','SampleApp',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'CreateNamespace','SampleApp',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(3,'AssignRole','SampleApp',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(4,'ModifyNamespace','SampleApp+application',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(5,'ReleaseNamespace','SampleApp+application',_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(6,'CreateApplication','SystemRole',_binary '\0','apollo','2020-11-17 16:36:05','apollo','2020-11-17 16:36:05'),(7,'CreateNamespace','thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(8,'CreateCluster','thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(9,'AssignRole','thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(10,'ManageAppMaster','thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(11,'ModifyNamespace','thrc.account+application',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(12,'ReleaseNamespace','thrc.account+application',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(13,'ModifyNamespace','thrc.account+application+DEV',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(14,'ReleaseNamespace','thrc.account+application+DEV',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(15,'CreateNamespace','thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(16,'CreateCluster','thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(17,'AssignRole','thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(18,'ManageAppMaster','thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(19,'ModifyNamespace','thrc-user+application',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(20,'ReleaseNamespace','thrc-user+application',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(21,'ModifyNamespace','thrc-user+application+DEV',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(22,'ReleaseNamespace','thrc-user+application+DEV',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(23,'CreateCluster','thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(24,'CreateNamespace','thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(25,'AssignRole','thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(26,'ManageAppMaster','thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(27,'ModifyNamespace','thrc-account+application',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(28,'ReleaseNamespace','thrc-account+application',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(29,'ModifyNamespace','thrc-account+application+DEV',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(30,'ReleaseNamespace','thrc-account+application+DEV',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(31,'CreateCluster','thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(32,'CreateNamespace','thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(33,'AssignRole','thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(34,'ManageAppMaster','thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(35,'ModifyNamespace','thrc.gateway+application',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(36,'ReleaseNamespace','thrc.gateway+application',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(37,'ModifyNamespace','thrc.gateway+application+DEV',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(38,'ReleaseNamespace','thrc.gateway+application+DEV',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(39,'CreateNamespace','thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(40,'AssignRole','thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(41,'CreateCluster','thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(42,'ManageAppMaster','thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(43,'ModifyNamespace','thrc-account-http-interface+application',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(44,'ReleaseNamespace','thrc-account-http-interface+application',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(45,'ModifyNamespace','thrc-account-http-interface+application+DEV',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(46,'ReleaseNamespace','thrc-account-http-interface+application+DEV',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(47,'CreateNamespace','thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(48,'CreateCluster','thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(49,'AssignRole','thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(50,'ManageAppMaster','thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(51,'ModifyNamespace','thrc-gateway+application',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(52,'ReleaseNamespace','thrc-gateway+application',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(53,'ModifyNamespace','thrc-gateway+application+DEV',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(54,'ReleaseNamespace','thrc-gateway+application+DEV',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_RoleName` (`RoleName`(191)),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'Master+SampleApp',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'ModifyNamespace+SampleApp+application',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(3,'ReleaseNamespace+SampleApp+application',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(4,'CreateApplication+SystemRole',_binary '\0','apollo','2020-11-17 16:36:05','apollo','2020-11-17 16:36:05'),(5,'Master+thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(6,'ManageAppMaster+thrc.account',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(7,'ModifyNamespace+thrc.account+application',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(8,'ReleaseNamespace+thrc.account+application',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(9,'ModifyNamespace+thrc.account+application+DEV',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(10,'ReleaseNamespace+thrc.account+application+DEV',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(11,'Master+thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(12,'ManageAppMaster+thrc-user',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(13,'ModifyNamespace+thrc-user+application',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(14,'ReleaseNamespace+thrc-user+application',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(15,'ModifyNamespace+thrc-user+application+DEV',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(16,'ReleaseNamespace+thrc-user+application+DEV',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(17,'Master+thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(18,'ManageAppMaster+thrc-account',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(19,'ModifyNamespace+thrc-account+application',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(20,'ReleaseNamespace+thrc-account+application',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(21,'ModifyNamespace+thrc-account+application+DEV',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(22,'ReleaseNamespace+thrc-account+application+DEV',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(23,'Master+thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(24,'ManageAppMaster+thrc.gateway',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(25,'ModifyNamespace+thrc.gateway+application',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(26,'ReleaseNamespace+thrc.gateway+application',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(27,'ModifyNamespace+thrc.gateway+application+DEV',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(28,'ReleaseNamespace+thrc.gateway+application+DEV',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(29,'Master+thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(30,'ManageAppMaster+thrc-account-http-interface',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(31,'ModifyNamespace+thrc-account-http-interface+application',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(32,'ReleaseNamespace+thrc-account-http-interface+application',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(33,'ModifyNamespace+thrc-account-http-interface+application+DEV',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(34,'ReleaseNamespace+thrc-account-http-interface+application+DEV',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(35,'Master+thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(36,'ManageAppMaster+thrc-gateway',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(37,'ModifyNamespace+thrc-gateway+application',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(38,'ReleaseNamespace+thrc-gateway+application',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(39,'ModifyNamespace+thrc-gateway+application+DEV',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(40,'ReleaseNamespace+thrc-gateway+application+DEV',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RolePermission`
--

DROP TABLE IF EXISTS `RolePermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RolePermission` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int unsigned DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int unsigned DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_PermissionId` (`PermissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和权限的绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RolePermission`
--

LOCK TABLES `RolePermission` WRITE;
/*!40000 ALTER TABLE `RolePermission` DISABLE KEYS */;
INSERT INTO `RolePermission` VALUES (1,1,1,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,1,2,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(3,1,3,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(4,2,4,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(5,3,5,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(6,4,6,_binary '\0','apollo','2020-11-17 16:36:05','apollo','2020-11-17 16:36:05'),(7,5,7,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(8,5,8,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(9,5,9,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(10,6,10,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(11,7,11,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(12,8,12,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(13,9,13,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(14,10,14,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(15,11,16,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(16,11,17,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(17,11,15,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(18,12,18,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(19,13,19,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(20,14,20,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(21,15,21,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(22,16,22,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(23,17,23,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(24,17,24,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(25,17,25,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(26,18,26,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(27,19,27,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(28,20,28,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(29,21,29,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(30,22,30,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(31,23,32,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(32,23,33,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(33,23,31,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(34,24,34,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(35,25,35,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(36,26,36,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(37,27,37,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(38,28,38,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(39,29,39,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(40,29,40,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(41,29,41,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(42,30,42,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(43,31,43,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(44,32,44,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(45,33,45,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(46,34,46,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(47,35,48,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(48,35,49,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(49,35,47,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(50,36,50,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(51,37,51,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(52,38,52,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(53,39,53,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(54,40,54,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `RolePermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServerConfig`
--

DROP TABLE IF EXISTS `ServerConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ServerConfig` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_Key` (`Key`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置服务自身配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServerConfig`
--

LOCK TABLES `ServerConfig` WRITE;
/*!40000 ALTER TABLE `ServerConfig` DISABLE KEYS */;
INSERT INTO `ServerConfig` VALUES (1,'apollo.portal.envs','dev','可支持的环境列表',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'organizations','[{\"orgId\":\"TEST1\",\"orgName\":\"样例部门1\"},{\"orgId\":\"TEST2\",\"orgName\":\"样例部门2\"}]','部门列表',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(3,'superAdmin','apollo','Portal超级管理员',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(4,'api.readTimeout','10000','http接口read timeout',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(5,'consumer.token.salt','someSalt','consumer token salt',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(6,'admin.createPrivateNamespace.switch','true','是否允许项目管理员创建私有namespace',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(7,'configView.memberOnly.envs','dev','只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔',_binary '\0','default','2020-11-18 06:33:23','','2020-11-18 06:33:23');
/*!40000 ALTER TABLE `ServerConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRole`
--

DROP TABLE IF EXISTS `UserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserRole` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_UserId_RoleId` (`UserId`,`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和role的绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRole`
--

LOCK TABLES `UserRole` WRITE;
/*!40000 ALTER TABLE `UserRole` DISABLE KEYS */;
INSERT INTO `UserRole` VALUES (1,'apollo',1,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(2,'apollo',2,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(3,'apollo',3,_binary '\0','','2020-11-18 06:33:23','','2020-11-18 06:33:23'),(4,'apollo',5,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(5,'apollo',7,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(6,'apollo',8,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(7,'apollo',11,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(8,'apollo',13,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(9,'apollo',14,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(10,'apollo',17,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(11,'apollo',19,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(12,'apollo',20,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(13,'apollo',23,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(14,'apollo',25,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(15,'apollo',26,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:58'),(16,'apollo',29,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(17,'apollo',31,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(18,'apollo',32,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(19,'apollo',35,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(20,'apollo',37,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01'),(21,'apollo',38,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `UserRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL DEFAULT 'default' COMMENT '用户名',
  `Password` varchar(64) NOT NULL DEFAULT 'default' COMMENT '密码',
  `Email` varchar(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'apollo','$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS','apollo@acme.com',1);
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

-- Dump completed on 2020-11-26 10:16:28
