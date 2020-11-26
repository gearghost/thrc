-- MySQL dump 10.13  Distrib 8.0.22, for osx10.16 (x86_64)
--
-- Host: localhost    Database: ApolloConfigDB
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
-- Table structure for table `AccessKey`
--

DROP TABLE IF EXISTS `AccessKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccessKey` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Secret` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secret',
  `IsEnabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: enabled, 0: disabled',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='访问密钥';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccessKey`
--

LOCK TABLES `AccessKey` WRITE;
/*!40000 ALTER TABLE `AccessKey` DISABLE KEYS */;
INSERT INTO `AccessKey` VALUES (1,'thrc.account','0b459cb986564f4d9703de0847f41f34',_binary '',_binary '\0','apollo','2020-11-17 19:22:02','apollo','2020-11-17 19:22:05'),(2,'thrc-user','849e0d809f4f47f9a1b35f16e12d76e1',_binary '',_binary '\0','apollo','2020-11-17 19:23:24','apollo','2020-11-17 19:23:27'),(3,'thrc-account','3f8e1060956a4a08b3e39611ceecfc41',_binary '',_binary '\0','apollo','2020-11-17 19:59:40','apollo','2020-11-17 19:59:44'),(4,'thrc-account-http-interface','a3617f26edcf4438921062e2b5e1f91b',_binary '',_binary '\0','apollo','2020-11-21 00:08:16','apollo','2020-11-21 00:08:19'),(5,'thrc.gateway','5a1896d16f8c4596bd3e87f20ab4d8e6',_binary '',_binary '\0','apollo','2020-11-21 00:16:42','apollo','2020-11-21 00:16:45'),(6,'thrc-gateway','1904f8f8aef046f6bced887a97d8f3c6',_binary '',_binary '\0','apollo','2020-11-21 21:10:25','apollo','2020-11-21 21:10:29');
/*!40000 ALTER TABLE `AccessKey` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `App` VALUES (1,'SampleApp','Sample App','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'thrc.account','account-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-17 20:02:56'),(3,'thrc-user','user-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'thrc-account','account-service','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'thrc.gateway','api-gateway','TEST1','样例部门1','apollo','apollo@acme.com',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-21 21:12:59'),(6,'thrc-account-http-interface','account-interface','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'thrc-gateway','http-gateway','TEST1','样例部门1','apollo','apollo@acme.com',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
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
INSERT INTO `AppNamespace` VALUES (1,'application','SampleApp','properties',_binary '\0','default app namespace',_binary '\0','','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'application','thrc.account','properties',_binary '\0','default app namespace',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-18 10:02:55'),(3,'application','thrc-user','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'application','thrc-account','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'application','thrc.gateway','properties',_binary '\0','default app namespace',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-22 11:12:59'),(6,'application','thrc-account-http-interface','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'application','thrc-gateway','properties',_binary '\0','default app namespace',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `AppNamespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Audit`
--

DROP TABLE IF EXISTS `Audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Audit` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `EntityName` varchar(50) NOT NULL DEFAULT 'default' COMMENT '表名',
  `EntityId` int unsigned DEFAULT NULL COMMENT '记录ID',
  `OpName` varchar(50) NOT NULL DEFAULT 'default' COMMENT '操作类型',
  `Comment` varchar(500) DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日志审计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Audit`
--

LOCK TABLES `Audit` WRITE;
/*!40000 ALTER TABLE `Audit` DISABLE KEYS */;
INSERT INTO `Audit` VALUES (1,'App',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:34:30',NULL,'2020-11-17 17:34:30'),(2,'AppNamespace',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:34:30',NULL,'2020-11-17 17:34:30'),(3,'Cluster',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:34:30',NULL,'2020-11-17 17:34:30'),(4,'Namespace',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:34:30',NULL,'2020-11-17 17:34:30'),(5,'Item',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:34:59',NULL,'2020-11-17 17:34:59'),(6,'Item',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:35:45',NULL,'2020-11-17 17:35:45'),(7,'Item',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:36:07',NULL,'2020-11-17 17:36:07'),(8,'Item',5,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:36:31',NULL,'2020-11-17 17:36:31'),(9,'Item',5,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 17:36:58',NULL,'2020-11-17 17:36:58'),(10,'Item',6,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:37:36',NULL,'2020-11-17 17:37:36'),(11,'Item',7,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:38:50',NULL,'2020-11-17 17:38:50'),(12,'Item',8,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:39:30',NULL,'2020-11-17 17:39:30'),(13,'Item',9,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:39:50',NULL,'2020-11-17 17:39:50'),(14,'Item',9,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 17:40:10',NULL,'2020-11-17 17:40:10'),(15,'Item',10,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:40:41',NULL,'2020-11-17 17:40:41'),(16,'Item',11,'INSERT',NULL,_binary '\0','apollo','2020-11-17 17:41:13',NULL,'2020-11-17 17:41:13'),(17,'Item',10,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 17:41:26',NULL,'2020-11-17 17:41:26'),(18,'Item',11,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 17:41:33',NULL,'2020-11-17 17:41:33'),(19,'App',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:14:46',NULL,'2020-11-17 19:14:46'),(20,'AppNamespace',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:14:46',NULL,'2020-11-17 19:14:46'),(21,'Cluster',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:14:46',NULL,'2020-11-17 19:14:46'),(22,'Namespace',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:14:46',NULL,'2020-11-17 19:14:46'),(23,'Item',12,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:15:16',NULL,'2020-11-17 19:15:16'),(24,'Item',13,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:15:52',NULL,'2020-11-17 19:15:52'),(25,'Item',14,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:16:44',NULL,'2020-11-17 19:16:44'),(26,'Item',15,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:17:21',NULL,'2020-11-17 19:17:21'),(27,'Item',16,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:17:51',NULL,'2020-11-17 19:17:51'),(28,'Item',17,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:18:40',NULL,'2020-11-17 19:18:40'),(29,'Item',18,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:19:05',NULL,'2020-11-17 19:19:05'),(30,'Item',19,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:19:48',NULL,'2020-11-17 19:19:48'),(31,'Item',19,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 19:20:03',NULL,'2020-11-17 19:20:03'),(32,'Item',20,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:20:24',NULL,'2020-11-17 19:20:24'),(33,'Item',21,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:20:52',NULL,'2020-11-17 19:20:52'),(34,'Release',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:21:15',NULL,'2020-11-17 19:21:15'),(35,'ReleaseHistory',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:21:15',NULL,'2020-11-17 19:21:15'),(36,'Release',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:21:27',NULL,'2020-11-17 19:21:27'),(37,'ReleaseHistory',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:21:27',NULL,'2020-11-17 19:21:27'),(38,'AccessKey',1,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:22:02',NULL,'2020-11-17 19:22:02'),(39,'AccessKey',1,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 19:22:05',NULL,'2020-11-17 19:22:05'),(40,'AccessKey',2,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:23:24',NULL,'2020-11-17 19:23:24'),(41,'AccessKey',2,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 19:23:27',NULL,'2020-11-17 19:23:27'),(42,'App',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:51:24',NULL,'2020-11-17 19:51:24'),(43,'AppNamespace',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:51:24',NULL,'2020-11-17 19:51:24'),(44,'Cluster',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:51:24',NULL,'2020-11-17 19:51:24'),(45,'Namespace',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:51:24',NULL,'2020-11-17 19:51:24'),(46,'Item',22,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:54:28',NULL,'2020-11-17 19:54:28'),(47,'Item',23,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:54:57',NULL,'2020-11-17 19:54:57'),(48,'Item',24,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:55:38',NULL,'2020-11-17 19:55:38'),(49,'Item',25,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:56:08',NULL,'2020-11-17 19:56:08'),(50,'Item',26,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:56:34',NULL,'2020-11-17 19:56:34'),(51,'Item',27,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:57:17',NULL,'2020-11-17 19:57:17'),(52,'Item',28,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:57:45',NULL,'2020-11-17 19:57:45'),(53,'Item',29,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:58:14',NULL,'2020-11-17 19:58:14'),(54,'Item',30,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:58:46',NULL,'2020-11-17 19:58:46'),(55,'Item',31,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:59:19',NULL,'2020-11-17 19:59:19'),(56,'Release',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:59:33',NULL,'2020-11-17 19:59:33'),(57,'ReleaseHistory',4,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:59:33',NULL,'2020-11-17 19:59:33'),(58,'AccessKey',3,'INSERT',NULL,_binary '\0','apollo','2020-11-17 19:59:40',NULL,'2020-11-17 19:59:40'),(59,'AccessKey',3,'UPDATE',NULL,_binary '\0','apollo','2020-11-17 19:59:44',NULL,'2020-11-17 19:59:44'),(60,'Namespace',2,'DELETE',NULL,_binary '\0','apollo','2020-11-17 20:02:56',NULL,'2020-11-17 20:02:56'),(61,'Cluster',2,'DELETE',NULL,_binary '\0','apollo','2020-11-17 20:02:56',NULL,'2020-11-17 20:02:56'),(62,'App',2,'DELETE',NULL,_binary '\0','apollo','2020-11-17 20:02:56',NULL,'2020-11-17 20:02:56'),(63,'Item',17,'UPDATE',NULL,_binary '\0','apollo','2020-11-18 00:15:58',NULL,'2020-11-18 00:15:58'),(64,'Release',5,'INSERT',NULL,_binary '\0','apollo','2020-11-18 00:16:08',NULL,'2020-11-18 00:16:08'),(65,'ReleaseHistory',5,'INSERT',NULL,_binary '\0','apollo','2020-11-18 00:16:08',NULL,'2020-11-18 00:16:08'),(66,'Item',27,'UPDATE',NULL,_binary '\0','apollo','2020-11-18 00:16:30',NULL,'2020-11-18 00:16:30'),(67,'Release',6,'INSERT',NULL,_binary '\0','apollo','2020-11-18 00:16:33',NULL,'2020-11-18 00:16:33'),(68,'ReleaseHistory',6,'INSERT',NULL,_binary '\0','apollo','2020-11-18 00:16:33',NULL,'2020-11-18 00:16:33'),(69,'ReleaseHistory',7,'INSERT',NULL,_binary '\0','apollo','2020-11-18 01:24:47',NULL,'2020-11-18 01:24:47'),(70,'Release',7,'INSERT',NULL,_binary '\0','apollo','2020-11-18 01:25:09',NULL,'2020-11-18 01:25:09'),(71,'ReleaseHistory',8,'INSERT',NULL,_binary '\0','apollo','2020-11-18 01:25:09',NULL,'2020-11-18 01:25:09'),(72,'ReleaseHistory',9,'INSERT',NULL,_binary '\0','apollo','2020-11-18 01:25:19',NULL,'2020-11-18 01:25:19'),(73,'ReleaseHistory',10,'INSERT',NULL,_binary '\0','apollo','2020-11-18 01:25:36',NULL,'2020-11-18 01:25:36'),(74,'Release',8,'INSERT',NULL,_binary '\0','apollo','2020-11-18 19:16:59',NULL,'2020-11-18 19:16:59'),(75,'ReleaseHistory',11,'INSERT',NULL,_binary '\0','apollo','2020-11-18 19:16:59',NULL,'2020-11-18 19:16:59'),(76,'Release',9,'INSERT',NULL,_binary '\0','apollo','2020-11-18 19:17:07',NULL,'2020-11-18 19:17:07'),(77,'ReleaseHistory',12,'INSERT',NULL,_binary '\0','apollo','2020-11-18 19:17:07',NULL,'2020-11-18 19:17:07'),(78,'ReleaseHistory',13,'INSERT',NULL,_binary '\0','apollo','2020-11-18 23:13:20',NULL,'2020-11-18 23:13:20'),(79,'ReleaseHistory',14,'INSERT',NULL,_binary '\0','apollo','2020-11-18 23:13:34',NULL,'2020-11-18 23:13:34'),(80,'App',5,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:37:15',NULL,'2020-11-20 11:37:15'),(81,'AppNamespace',5,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:37:15',NULL,'2020-11-20 11:37:15'),(82,'Cluster',5,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:37:15',NULL,'2020-11-20 11:37:15'),(83,'Namespace',5,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:37:15',NULL,'2020-11-20 11:37:15'),(84,'Item',32,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:39:46',NULL,'2020-11-20 11:39:46'),(85,'Item',33,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:41:09',NULL,'2020-11-20 11:41:09'),(86,'Item',34,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:41:28',NULL,'2020-11-20 11:41:28'),(87,'Item',35,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:42:00',NULL,'2020-11-20 11:42:00'),(88,'Item',36,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:42:34',NULL,'2020-11-20 11:42:34'),(89,'Release',10,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:42:45',NULL,'2020-11-20 11:42:45'),(90,'ReleaseHistory',15,'INSERT',NULL,_binary '\0','apollo','2020-11-20 11:42:45',NULL,'2020-11-20 11:42:45'),(91,'App',6,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:06:52',NULL,'2020-11-21 00:06:52'),(92,'AppNamespace',6,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:06:52',NULL,'2020-11-21 00:06:52'),(93,'Cluster',6,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:06:52',NULL,'2020-11-21 00:06:52'),(94,'Namespace',6,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:06:52',NULL,'2020-11-21 00:06:52'),(95,'Item',37,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:07:09',NULL,'2020-11-21 00:07:09'),(96,'Item',38,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:07:16',NULL,'2020-11-21 00:07:16'),(97,'Item',39,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:07:25',NULL,'2020-11-21 00:07:25'),(98,'Item',40,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:07:39',NULL,'2020-11-21 00:07:39'),(99,'Item',41,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:08:04',NULL,'2020-11-21 00:08:04'),(100,'Release',11,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:08:08',NULL,'2020-11-21 00:08:08'),(101,'ReleaseHistory',16,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:08:08',NULL,'2020-11-21 00:08:08'),(102,'AccessKey',4,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:08:16',NULL,'2020-11-21 00:08:16'),(103,'AccessKey',4,'UPDATE',NULL,_binary '\0','apollo','2020-11-21 00:08:19',NULL,'2020-11-21 00:08:19'),(104,'AccessKey',5,'INSERT',NULL,_binary '\0','apollo','2020-11-21 00:16:42',NULL,'2020-11-21 00:16:42'),(105,'AccessKey',5,'UPDATE',NULL,_binary '\0','apollo','2020-11-21 00:16:45',NULL,'2020-11-21 00:16:45'),(106,'App',7,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:01',NULL,'2020-11-21 21:09:01'),(107,'AppNamespace',7,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:01',NULL,'2020-11-21 21:09:01'),(108,'Cluster',7,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:01',NULL,'2020-11-21 21:09:01'),(109,'Namespace',7,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:01',NULL,'2020-11-21 21:09:01'),(110,'Item',42,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:12',NULL,'2020-11-21 21:09:12'),(111,'Item',43,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:19',NULL,'2020-11-21 21:09:19'),(112,'Item',44,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:27',NULL,'2020-11-21 21:09:27'),(113,'Item',45,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:09:48',NULL,'2020-11-21 21:09:48'),(114,'Item',46,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:10:15',NULL,'2020-11-21 21:10:15'),(115,'Release',12,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:10:20',NULL,'2020-11-21 21:10:20'),(116,'ReleaseHistory',17,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:10:20',NULL,'2020-11-21 21:10:20'),(117,'AccessKey',6,'INSERT',NULL,_binary '\0','apollo','2020-11-21 21:10:25',NULL,'2020-11-21 21:10:25'),(118,'AccessKey',6,'UPDATE',NULL,_binary '\0','apollo','2020-11-21 21:10:29',NULL,'2020-11-21 21:10:29'),(119,'Namespace',5,'DELETE',NULL,_binary '\0','apollo','2020-11-21 21:12:59',NULL,'2020-11-21 21:12:59'),(120,'Cluster',5,'DELETE',NULL,_binary '\0','apollo','2020-11-21 21:12:59',NULL,'2020-11-21 21:12:59'),(121,'App',5,'DELETE',NULL,_binary '\0','apollo','2020-11-21 21:12:59',NULL,'2020-11-21 21:12:59');
/*!40000 ALTER TABLE `Audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cluster`
--

DROP TABLE IF EXISTS `Cluster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cluster` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT '集群名字',
  `AppId` varchar(32) NOT NULL DEFAULT '' COMMENT 'App id',
  `ParentClusterId` int unsigned NOT NULL DEFAULT '0' COMMENT '父cluster',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_AppId_Name` (`AppId`,`Name`),
  KEY `IX_ParentClusterId` (`ParentClusterId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='集群';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cluster`
--

LOCK TABLES `Cluster` WRITE;
/*!40000 ALTER TABLE `Cluster` DISABLE KEYS */;
INSERT INTO `Cluster` VALUES (1,'default','SampleApp',0,_binary '\0','','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'default','thrc.account',0,_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-17 20:02:56'),(3,'default','thrc-user',0,_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'default','thrc-account',0,_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'default','thrc.gateway',0,_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-21 21:12:59'),(6,'default','thrc-account-http-interface',0,_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'default','thrc-gateway',0,_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `Cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Commit`
--

DROP TABLE IF EXISTS `Commit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Commit` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ChangeSets` longtext NOT NULL COMMENT '修改变更集',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `Comment` varchar(500) DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `AppId` (`AppId`(191)),
  KEY `ClusterName` (`ClusterName`(191)),
  KEY `NamespaceName` (`NamespaceName`(191))
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='commit 历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Commit`
--

LOCK TABLES `Commit` WRITE;
/*!40000 ALTER TABLE `Commit` DISABLE KEYS */;
INSERT INTO `Commit` VALUES (1,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"port\",\"value\":\"9090\",\"comment\":\"监听端口\",\"lineNum\":1,\"id\":2,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:34:59\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:34:59\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:34:59','apollo','2020-11-18 10:02:55'),(2,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"region\",\"value\":\"cn\",\"comment\":\"服务区域\",\"lineNum\":2,\"id\":3,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:35:45\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:35:45\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:35:45','apollo','2020-11-18 10:02:55'),(3,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"zone\",\"value\":\"gd\",\"comment\":\"机房区域\",\"lineNum\":3,\"id\":4,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:36:06\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:36:06\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:36:07','apollo','2020-11-18 10:02:55'),(4,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"env\",\"value\":\"服务环境类型\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:36:31\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:36:31\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:36:31','apollo','2020-11-18 10:02:55'),(5,'{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":2,\"key\":\"env\",\"value\":\"服务环境类型\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:36:31\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:36:31\"},\"newItem\":{\"namespaceId\":2,\"key\":\"env\",\"value\":\"dev\",\"comment\":\"服务环境\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:36:31\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:36:58\"}}],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:36:58','apollo','2020-11-18 10:02:55'),(6,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"appid\",\"value\":\"thrc.account\",\"comment\":\"应用ID\",\"lineNum\":5,\"id\":6,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:37:36\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:37:36\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:37:36','apollo','2020-11-18 10:02:55'),(7,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"mysql-addr\",\"value\":\"localhost\",\"comment\":\"mysql数据库地址\",\"lineNum\":6,\"id\":7,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:38:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:38:50\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:38:50','apollo','2020-11-18 10:02:55'),(8,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"mysql-port\",\"value\":\"3306\",\"comment\":\"mysql数据库端口\",\"lineNum\":7,\"id\":8,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:39:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:39:30\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:39:30','apollo','2020-11-18 10:02:55'),(9,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"mysql-username\",\"value\":\"root\",\"lineNum\":8,\"id\":9,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:39:49\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:39:49\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:39:50','apollo','2020-11-18 10:02:55'),(10,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"mysql-password\",\"value\":\"\",\"comment\":\"数据库密码\",\"lineNum\":9,\"id\":10,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:40:40\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:40:40\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:40:41','apollo','2020-11-18 10:02:55'),(11,'{\"createItems\":[{\"namespaceId\":2,\"key\":\"mysql-db\",\"value\":\"thrc\",\"comment\":\"数据库名\",\"lineNum\":10,\"id\":11,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 15:41:12\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 15:41:12\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.account','default','application',NULL,_binary '','apollo','2020-11-17 17:41:13','apollo','2020-11-18 10:02:55'),(12,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"region\",\"value\":\"cn\",\"comment\":\"服务区域\",\"lineNum\":1,\"id\":12,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:15:16\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:15:16\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:15:16','apollo','2020-11-17 19:15:16'),(13,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"zone\",\"value\":\"gd\",\"comment\":\"机房区域\",\"lineNum\":2,\"id\":13,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:15:52\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:15:52\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:15:52','apollo','2020-11-17 19:15:52'),(14,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"env\",\"value\":\"dev\",\"comment\":\"服务环境类型\",\"lineNum\":3,\"id\":14,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:16:43\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:16:43\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:16:44','apollo','2020-11-17 19:16:44'),(15,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"appid\",\"value\":\"thrc.user\",\"comment\":\"应用ID\",\"lineNum\":4,\"id\":15,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:17:21\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:17:21\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:17:21','apollo','2020-11-17 19:17:21'),(16,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"port\",\"value\":\"9091\",\"comment\":\"服务监听端口\",\"lineNum\":5,\"id\":16,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:17:51\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:17:51\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:17:51','apollo','2020-11-17 19:17:51'),(17,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"mysql-addr\",\"value\":\"localhost\",\"comment\":\"mysql服务器地址\",\"lineNum\":6,\"id\":17,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:18:39\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:18:39\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:18:40','apollo','2020-11-17 19:18:40'),(18,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"mysql-port\",\"value\":\"3306\",\"comment\":\"mysql服务器端口\",\"lineNum\":7,\"id\":18,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:19:05\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:19:05\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:19:05','apollo','2020-11-17 19:19:05'),(19,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"mysql-username\",\"value\":\"root\",\"lineNum\":8,\"id\":19,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:19:47\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:19:47\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:19:48','apollo','2020-11-17 19:19:48'),(20,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"mysql-password\",\"value\":\"\",\"comment\":\"mysql密码\",\"lineNum\":9,\"id\":20,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:20:23\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:20:23\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:20:24','apollo','2020-11-17 19:20:24'),(21,'{\"createItems\":[{\"namespaceId\":3,\"key\":\"mysql-db\",\"value\":\"thrc\",\"comment\":\"mysql数据库名\",\"lineNum\":10,\"id\":21,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:20:52\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:20:52\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-17 19:20:52','apollo','2020-11-17 19:20:52'),(22,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"region\",\"value\":\"cn\",\"comment\":\"服务区域\",\"lineNum\":1,\"id\":22,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:54:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:54:28\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:54:28','apollo','2020-11-17 19:54:28'),(23,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"zone\",\"value\":\"gd\",\"comment\":\"机房区域\",\"lineNum\":2,\"id\":23,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:54:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:54:57\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:54:57','apollo','2020-11-17 19:54:57'),(24,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"env\",\"value\":\"dev\",\"comment\":\"服务环境\",\"lineNum\":3,\"id\":24,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:55:38\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:55:38\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:55:38','apollo','2020-11-17 19:55:38'),(25,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"appid\",\"value\":\"thrc.account\",\"comment\":\"应用ID\",\"lineNum\":4,\"id\":25,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:56:07\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:56:07\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:56:08','apollo','2020-11-17 19:56:08'),(26,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"port\",\"value\":\"9090\",\"comment\":\"监听端口\",\"lineNum\":5,\"id\":26,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:56:33\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:56:33\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:56:34','apollo','2020-11-17 19:56:34'),(27,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"mysql-addr\",\"value\":\"localhost\",\"comment\":\"mysql数据库地址\",\"lineNum\":6,\"id\":27,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:57:16\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:57:16\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:57:17','apollo','2020-11-17 19:57:17'),(28,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"mysql-port\",\"value\":\"3306\",\"comment\":\"mysql数据库端口\",\"lineNum\":7,\"id\":28,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:57:44\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:57:44\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:57:45','apollo','2020-11-17 19:57:45'),(29,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"mysql-username\",\"value\":\"root\",\"comment\":\"mysql数据库用户名\",\"lineNum\":8,\"id\":29,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:58:13\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:58:13\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:58:14','apollo','2020-11-17 19:58:14'),(30,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"mysql-password\",\"value\":\"\",\"comment\":\"mysql数据库密码\",\"lineNum\":9,\"id\":30,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:58:46\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:58:46\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:58:46','apollo','2020-11-17 19:58:46'),(31,'{\"createItems\":[{\"namespaceId\":4,\"key\":\"mysql-db\",\"value\":\"thrc\",\"comment\":\"mysql数据库名\",\"lineNum\":10,\"id\":31,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:59:19\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:59:19\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-17 19:59:19','apollo','2020-11-17 19:59:19'),(32,'{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":3,\"key\":\"mysql-addr\",\"value\":\"localhost\",\"comment\":\"mysql服务器地址\",\"lineNum\":6,\"id\":17,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:18:40\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:18:40\"},\"newItem\":{\"namespaceId\":3,\"key\":\"mysql-addr\",\"value\":\"host.minikube.internal\",\"comment\":\"mysql服务器地址\",\"lineNum\":6,\"id\":17,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:18:40\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 22:15:57\"}}],\"deleteItems\":[]}','thrc-user','default','application',NULL,_binary '\0','apollo','2020-11-18 00:15:58','apollo','2020-11-18 00:15:58'),(33,'{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":4,\"key\":\"mysql-addr\",\"value\":\"localhost\",\"comment\":\"mysql数据库地址\",\"lineNum\":6,\"id\":27,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:57:17\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 17:57:17\"},\"newItem\":{\"namespaceId\":4,\"key\":\"mysql-addr\",\"value\":\"host.minikube.internal\",\"comment\":\"mysql数据库地址\",\"lineNum\":6,\"id\":27,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-18 17:57:17\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-18 22:16:30\"}}],\"deleteItems\":[]}','thrc-account','default','application',NULL,_binary '\0','apollo','2020-11-18 00:16:30','apollo','2020-11-18 00:16:30'),(34,'{\"createItems\":[{\"namespaceId\":5,\"key\":\"port\",\"value\":\"2233\",\"comment\":\"服务端口\",\"lineNum\":1,\"id\":32,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 09:39:45\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 09:39:45\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.gateway','default','application',NULL,_binary '','apollo','2020-11-20 11:39:46','apollo','2020-11-22 11:12:59'),(35,'{\"createItems\":[{\"namespaceId\":5,\"key\":\"region\",\"value\":\"cn\",\"comment\":\"服务区域\",\"lineNum\":2,\"id\":33,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 09:41:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 09:41:09\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.gateway','default','application',NULL,_binary '','apollo','2020-11-20 11:41:09','apollo','2020-11-22 11:12:59'),(36,'{\"createItems\":[{\"namespaceId\":5,\"key\":\"zone\",\"value\":\"gd\",\"comment\":\"机房区域\",\"lineNum\":3,\"id\":34,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 09:41:27\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 09:41:27\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.gateway','default','application',NULL,_binary '','apollo','2020-11-20 11:41:28','apollo','2020-11-22 11:12:59'),(37,'{\"createItems\":[{\"namespaceId\":5,\"key\":\"env\",\"value\":\"dev\",\"comment\":\"服务环境\",\"lineNum\":4,\"id\":35,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 09:41:59\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 09:41:59\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.gateway','default','application',NULL,_binary '','apollo','2020-11-20 11:42:00','apollo','2020-11-22 11:12:59'),(38,'{\"createItems\":[{\"namespaceId\":5,\"key\":\"appid\",\"value\":\"thrc.gateway\",\"comment\":\"应用ID\",\"lineNum\":5,\"id\":36,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 09:42:34\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 09:42:34\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc.gateway','default','application',NULL,_binary '','apollo','2020-11-20 11:42:34','apollo','2020-11-22 11:12:59'),(39,'{\"createItems\":[{\"namespaceId\":6,\"key\":\"port\",\"value\":\"6060\",\"lineNum\":1,\"id\":37,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 22:07:08\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 22:07:08\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account-http-interface','default','application',NULL,_binary '\0','apollo','2020-11-21 00:07:09','apollo','2020-11-21 00:07:09'),(40,'{\"createItems\":[{\"namespaceId\":6,\"key\":\"region\",\"value\":\"cn\",\"lineNum\":2,\"id\":38,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 22:07:15\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 22:07:15\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account-http-interface','default','application',NULL,_binary '\0','apollo','2020-11-21 00:07:16','apollo','2020-11-21 00:07:16'),(41,'{\"createItems\":[{\"namespaceId\":6,\"key\":\"zone\",\"value\":\"gd\",\"lineNum\":3,\"id\":39,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 22:07:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 22:07:24\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account-http-interface','default','application',NULL,_binary '\0','apollo','2020-11-21 00:07:25','apollo','2020-11-21 00:07:25'),(42,'{\"createItems\":[{\"namespaceId\":6,\"key\":\"appid\",\"value\":\"account\",\"lineNum\":4,\"id\":40,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 22:07:38\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 22:07:38\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account-http-interface','default','application',NULL,_binary '\0','apollo','2020-11-21 00:07:39','apollo','2020-11-21 00:07:39'),(43,'{\"createItems\":[{\"namespaceId\":6,\"key\":\"env\",\"value\":\"dev\",\"lineNum\":5,\"id\":41,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-21 22:08:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-21 22:08:03\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-account-http-interface','default','application',NULL,_binary '\0','apollo','2020-11-21 00:08:04','apollo','2020-11-21 00:08:04'),(44,'{\"createItems\":[{\"namespaceId\":7,\"key\":\"port\",\"value\":\"2233\",\"lineNum\":1,\"id\":42,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-22 19:09:11\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-22 19:09:11\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-gateway','default','application',NULL,_binary '\0','apollo','2020-11-21 21:09:12','apollo','2020-11-21 21:09:12'),(45,'{\"createItems\":[{\"namespaceId\":7,\"key\":\"region\",\"value\":\"cn\",\"lineNum\":2,\"id\":43,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-22 19:09:19\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-22 19:09:19\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-gateway','default','application',NULL,_binary '\0','apollo','2020-11-21 21:09:19','apollo','2020-11-21 21:09:19'),(46,'{\"createItems\":[{\"namespaceId\":7,\"key\":\"zone\",\"value\":\"gd\",\"lineNum\":3,\"id\":44,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-22 19:09:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-22 19:09:26\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-gateway','default','application',NULL,_binary '\0','apollo','2020-11-21 21:09:27','apollo','2020-11-21 21:09:27'),(47,'{\"createItems\":[{\"namespaceId\":7,\"key\":\"env\",\"value\":\"dev\",\"lineNum\":4,\"id\":45,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-22 19:09:47\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-22 19:09:47\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-gateway','default','application',NULL,_binary '\0','apollo','2020-11-21 21:09:48','apollo','2020-11-21 21:09:48'),(48,'{\"createItems\":[{\"namespaceId\":7,\"key\":\"appid\",\"value\":\"thrc.gateway\",\"lineNum\":5,\"id\":46,\"isDeleted\":false,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2020-11-22 19:10:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2020-11-22 19:10:14\"}],\"updateItems\":[],\"deleteItems\":[]}','thrc-gateway','default','application',NULL,_binary '\0','apollo','2020-11-21 21:10:15','apollo','2020-11-21 21:10:15');
/*!40000 ALTER TABLE `Commit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GrayReleaseRule`
--

DROP TABLE IF EXISTS `GrayReleaseRule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GrayReleaseRule` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `NamespaceName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `BranchName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'branch name',
  `Rules` varchar(16000) DEFAULT '[]' COMMENT '灰度规则',
  `ReleaseId` int unsigned NOT NULL DEFAULT '0' COMMENT '灰度对应的release',
  `BranchStatus` tinyint DEFAULT '1' COMMENT '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Namespace` (`AppId`,`ClusterName`,`NamespaceName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='灰度规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GrayReleaseRule`
--

LOCK TABLES `GrayReleaseRule` WRITE;
/*!40000 ALTER TABLE `GrayReleaseRule` DISABLE KEYS */;
/*!40000 ALTER TABLE `GrayReleaseRule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Instance`
--

DROP TABLE IF EXISTS `Instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Instance` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `DataCenter` varchar(64) NOT NULL DEFAULT 'default' COMMENT 'Data Center Name',
  `Ip` varchar(32) NOT NULL DEFAULT '' COMMENT 'instance ip',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_UNIQUE_KEY` (`AppId`,`ClusterName`,`Ip`,`DataCenter`),
  KEY `IX_IP` (`Ip`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='使用配置的应用实例';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instance`
--

LOCK TABLES `Instance` WRITE;
/*!40000 ALTER TABLE `Instance` DISABLE KEYS */;
INSERT INTO `Instance` VALUES (1,'thrc.account','default','','192.168.50.245','2020-11-17 19:24:09','2020-11-17 19:24:09'),(2,'thrc-user','default','','192.168.50.245','2020-11-17 19:46:44','2020-11-17 19:46:44'),(3,'thrc-account','default','','192.168.50.245','2020-11-17 20:03:14','2020-11-17 20:03:14'),(4,'thrc-user','default','','172.17.0.6','2020-11-18 00:35:41','2020-11-18 00:35:41'),(5,'thrc-user','default','','172.17.0.7','2020-11-18 00:35:45','2020-11-18 00:35:45'),(6,'thrc-user','default','','172.17.0.3','2020-11-18 00:35:47','2020-11-18 00:35:47'),(7,'thrc-account','default','','172.17.0.4','2020-11-18 00:45:03','2020-11-18 00:45:03'),(8,'thrc-account','default','','172.17.0.5','2020-11-18 00:45:10','2020-11-18 00:45:10'),(9,'thrc-account','default','','172.17.0.8','2020-11-18 00:45:14','2020-11-18 00:45:14'),(10,'thrc-account','default','','172.17.0.3','2020-11-18 19:13:03','2020-11-18 19:13:03'),(11,'thrc-account-http-interface','default','','192.168.50.245','2020-11-21 00:10:14','2020-11-21 00:10:14'),(12,'thrc.gateway','default','','192.168.50.245','2020-11-21 00:24:35','2020-11-21 00:24:35'),(13,'thrc-gateway','default','','192.168.50.245','2020-11-21 21:11:18','2020-11-21 21:11:18'),(14,'thrc-account-http-interface','default','','192.168.64.1','2020-11-21 23:44:47','2020-11-21 23:44:47'),(15,'thrc-account','default','','192.168.64.1','2020-11-22 00:10:17','2020-11-22 00:10:17'),(16,'thrc-user','default','','192.168.64.1','2020-11-22 00:10:17','2020-11-22 00:10:17'),(17,'thrc-gateway','default','','192.168.64.1','2020-11-22 00:10:18','2020-11-22 00:10:18');
/*!40000 ALTER TABLE `Instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InstanceConfig`
--

DROP TABLE IF EXISTS `InstanceConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InstanceConfig` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `InstanceId` int unsigned DEFAULT NULL COMMENT 'Instance Id',
  `ConfigAppId` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Config App Id',
  `ConfigClusterName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Config Cluster Name',
  `ConfigNamespaceName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'Config Namespace Name',
  `ReleaseKey` varchar(64) NOT NULL DEFAULT '' COMMENT '发布的Key',
  `ReleaseDeliveryTime` timestamp NULL DEFAULT NULL COMMENT '配置获取时间',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_UNIQUE_KEY` (`InstanceId`,`ConfigAppId`,`ConfigNamespaceName`),
  KEY `IX_ReleaseKey` (`ReleaseKey`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Valid_Namespace` (`ConfigAppId`,`ConfigClusterName`,`ConfigNamespaceName`,`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用实例的配置信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InstanceConfig`
--

LOCK TABLES `InstanceConfig` WRITE;
/*!40000 ALTER TABLE `InstanceConfig` DISABLE KEYS */;
INSERT INTO `InstanceConfig` VALUES (2,2,'thrc-user','default','application','20201118172115-b7c1b975b8065507','2020-11-18 01:25:50','2020-11-17 19:46:44','2020-11-18 23:16:16'),(3,3,'thrc-account','default','application','20201118175933-c653b975b8065509','2020-11-17 20:03:14','2020-11-17 20:03:14','2020-11-18 23:16:04'),(4,4,'thrc-user','default','application','20201118221608-b7c1b975b806550a','2020-11-18 00:35:41','2020-11-18 00:35:41','2020-11-18 00:35:41'),(5,5,'thrc-user','default','application','20201118221608-b7c1b975b806550a','2020-11-18 00:35:44','2020-11-18 00:35:44','2020-11-18 00:35:44'),(6,6,'thrc-user','default','application','20201118221608-b7c1b975b806550a','2020-11-18 00:35:46','2020-11-18 00:35:46','2020-11-18 00:35:46'),(7,7,'thrc-account','default','application','20201119171658-c65338d5383fc08c','2020-11-18 19:18:51','2020-11-18 00:45:03','2020-11-18 19:18:52'),(8,8,'thrc-account','default','application','20201119171658-c65338d5383fc08c','2020-11-18 19:18:51','2020-11-18 00:45:10','2020-11-18 19:18:52'),(9,9,'thrc-account','default','application','20201118221633-c653b975b806550b','2020-11-18 00:45:14','2020-11-18 00:45:14','2020-11-18 00:45:14'),(10,10,'thrc-account','default','application','20201119171658-c65338d5383fc08c','2020-11-18 19:18:38','2020-11-18 19:13:02','2020-11-18 19:18:39'),(11,11,'thrc-account-http-interface','default','application','20201121220808-258a38d5383fc08f','2020-11-21 00:10:13','2020-11-21 00:10:13','2020-11-21 00:10:13'),(13,13,'thrc-gateway','default','application','20201122191020-d8aa38d5383fc090','2020-11-21 21:11:18','2020-11-21 21:11:18','2020-11-21 21:11:18'),(14,14,'thrc-account-http-interface','default','application','20201121220808-258a38d5383fc08f','2020-11-21 23:44:47','2020-11-21 23:44:47','2020-11-22 21:20:03'),(15,15,'thrc-account','default','application','20201118175933-c653b975b8065509','2020-11-22 00:10:16','2020-11-22 00:10:16','2020-11-22 21:20:03'),(16,16,'thrc-user','default','application','20201118172115-b7c1b975b8065507','2020-11-22 00:10:17','2020-11-22 00:10:17','2020-11-22 21:20:04'),(17,17,'thrc-gateway','default','application','20201122191020-d8aa38d5383fc090','2020-11-22 00:10:17','2020-11-22 00:10:17','2020-11-22 21:20:03');
/*!40000 ALTER TABLE `InstanceConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `NamespaceId` int unsigned NOT NULL DEFAULT '0' COMMENT '集群NamespaceId',
  `Key` varchar(128) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` longtext NOT NULL COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `LineNum` int unsigned DEFAULT '0' COMMENT '行号',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_GroupId` (`NamespaceId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置项目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (1,1,'timeout','100','sample timeout配置',1,_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,2,'port','9090','监听端口',1,_binary '','apollo','2020-11-17 17:34:59','apollo','2020-11-18 10:02:55'),(3,2,'region','cn','服务区域',2,_binary '','apollo','2020-11-17 17:35:45','apollo','2020-11-18 10:02:55'),(4,2,'zone','gd','机房区域',3,_binary '','apollo','2020-11-17 17:36:07','apollo','2020-11-18 10:02:55'),(5,2,'env','dev','服务环境',4,_binary '','apollo','2020-11-17 17:36:31','apollo','2020-11-18 10:02:55'),(6,2,'appid','thrc.account','应用ID',5,_binary '','apollo','2020-11-17 17:37:36','apollo','2020-11-18 10:02:55'),(7,2,'mysql-addr','localhost','mysql数据库地址',6,_binary '','apollo','2020-11-17 17:38:50','apollo','2020-11-18 10:02:55'),(8,2,'mysql-port','3306','mysql数据库端口',7,_binary '','apollo','2020-11-17 17:39:30','apollo','2020-11-18 10:02:55'),(9,2,'mysql-username','root','mysql数据库用户名',8,_binary '','apollo','2020-11-17 17:39:50','apollo','2020-11-18 10:02:55'),(10,2,'mysql-password','','mysql数据库密码',9,_binary '','apollo','2020-11-17 17:40:41','apollo','2020-11-18 10:02:55'),(11,2,'mysql-db','thrc','mysql数据库名',10,_binary '','apollo','2020-11-17 17:41:13','apollo','2020-11-18 10:02:55'),(12,3,'region','cn','服务区域',1,_binary '\0','apollo','2020-11-17 19:15:16','apollo','2020-11-17 19:15:16'),(13,3,'zone','gd','机房区域',2,_binary '\0','apollo','2020-11-17 19:15:52','apollo','2020-11-17 19:15:52'),(14,3,'env','dev','服务环境类型',3,_binary '\0','apollo','2020-11-17 19:16:44','apollo','2020-11-17 19:16:44'),(15,3,'appid','thrc.user','应用ID',4,_binary '\0','apollo','2020-11-17 19:17:21','apollo','2020-11-17 19:17:21'),(16,3,'port','9091','服务监听端口',5,_binary '\0','apollo','2020-11-17 19:17:51','apollo','2020-11-17 19:17:51'),(17,3,'mysql-addr','host.minikube.internal','mysql服务器地址',6,_binary '\0','apollo','2020-11-17 19:18:40','apollo','2020-11-18 00:15:58'),(18,3,'mysql-port','3306','mysql服务器端口',7,_binary '\0','apollo','2020-11-17 19:19:05','apollo','2020-11-17 19:19:05'),(19,3,'mysql-username','root','mysql用户名',8,_binary '\0','apollo','2020-11-17 19:19:48','apollo','2020-11-17 19:20:03'),(20,3,'mysql-password','','mysql密码',9,_binary '\0','apollo','2020-11-17 19:20:24','apollo','2020-11-17 19:20:24'),(21,3,'mysql-db','thrc','mysql数据库名',10,_binary '\0','apollo','2020-11-17 19:20:52','apollo','2020-11-17 19:20:52'),(22,4,'region','cn','服务区域',1,_binary '\0','apollo','2020-11-17 19:54:28','apollo','2020-11-17 19:54:28'),(23,4,'zone','gd','机房区域',2,_binary '\0','apollo','2020-11-17 19:54:57','apollo','2020-11-17 19:54:57'),(24,4,'env','dev','服务环境',3,_binary '\0','apollo','2020-11-17 19:55:38','apollo','2020-11-17 19:55:38'),(25,4,'appid','thrc.account','应用ID',4,_binary '\0','apollo','2020-11-17 19:56:08','apollo','2020-11-17 19:56:08'),(26,4,'port','9090','监听端口',5,_binary '\0','apollo','2020-11-17 19:56:34','apollo','2020-11-17 19:56:34'),(27,4,'mysql-addr','host.minikube.internal','mysql数据库地址',6,_binary '\0','apollo','2020-11-17 19:57:17','apollo','2020-11-18 00:16:30'),(28,4,'mysql-port','3306','mysql数据库端口',7,_binary '\0','apollo','2020-11-17 19:57:45','apollo','2020-11-17 19:57:45'),(29,4,'mysql-username','root','mysql数据库用户名',8,_binary '\0','apollo','2020-11-17 19:58:14','apollo','2020-11-17 19:58:14'),(30,4,'mysql-password','','mysql数据库密码',9,_binary '\0','apollo','2020-11-17 19:58:46','apollo','2020-11-17 19:58:46'),(31,4,'mysql-db','thrc','mysql数据库名',10,_binary '\0','apollo','2020-11-17 19:59:19','apollo','2020-11-17 19:59:19'),(32,5,'port','2233','服务端口',1,_binary '','apollo','2020-11-20 11:39:46','apollo','2020-11-22 11:12:59'),(33,5,'region','cn','服务区域',2,_binary '','apollo','2020-11-20 11:41:09','apollo','2020-11-22 11:12:59'),(34,5,'zone','gd','机房区域',3,_binary '','apollo','2020-11-20 11:41:28','apollo','2020-11-22 11:12:59'),(35,5,'env','dev','服务环境',4,_binary '','apollo','2020-11-20 11:42:00','apollo','2020-11-22 11:12:59'),(36,5,'appid','thrc.gateway','应用ID',5,_binary '','apollo','2020-11-20 11:42:34','apollo','2020-11-22 11:12:59'),(37,6,'port','6060',NULL,1,_binary '\0','apollo','2020-11-21 00:07:09','apollo','2020-11-21 00:07:09'),(38,6,'region','cn',NULL,2,_binary '\0','apollo','2020-11-21 00:07:16','apollo','2020-11-21 00:07:16'),(39,6,'zone','gd',NULL,3,_binary '\0','apollo','2020-11-21 00:07:25','apollo','2020-11-21 00:07:25'),(40,6,'appid','account',NULL,4,_binary '\0','apollo','2020-11-21 00:07:39','apollo','2020-11-21 00:07:39'),(41,6,'env','dev',NULL,5,_binary '\0','apollo','2020-11-21 00:08:04','apollo','2020-11-21 00:08:04'),(42,7,'port','2233',NULL,1,_binary '\0','apollo','2020-11-21 21:09:12','apollo','2020-11-21 21:09:12'),(43,7,'region','cn',NULL,2,_binary '\0','apollo','2020-11-21 21:09:19','apollo','2020-11-21 21:09:19'),(44,7,'zone','gd',NULL,3,_binary '\0','apollo','2020-11-21 21:09:27','apollo','2020-11-21 21:09:27'),(45,7,'env','dev',NULL,4,_binary '\0','apollo','2020-11-21 21:09:48','apollo','2020-11-21 21:09:48'),(46,7,'appid','thrc.gateway',NULL,5,_binary '\0','apollo','2020-11-21 21:10:15','apollo','2020-11-21 21:10:15');
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Namespace`
--

DROP TABLE IF EXISTS `Namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Namespace` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `NamespaceName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId_ClusterName_NamespaceName` (`AppId`(191),`ClusterName`(191),`NamespaceName`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_NamespaceName` (`NamespaceName`(191))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='命名空间';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Namespace`
--

LOCK TABLES `Namespace` WRITE;
/*!40000 ALTER TABLE `Namespace` DISABLE KEYS */;
INSERT INTO `Namespace` VALUES (1,'SampleApp','default','application',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'thrc.account','default','application',_binary '','apollo','2020-11-17 17:34:30','apollo','2020-11-17 20:02:56'),(3,'thrc-user','default','application',_binary '\0','apollo','2020-11-17 19:14:46','apollo','2020-11-17 19:14:46'),(4,'thrc-account','default','application',_binary '\0','apollo','2020-11-17 19:51:24','apollo','2020-11-17 19:51:24'),(5,'thrc.gateway','default','application',_binary '','apollo','2020-11-20 11:37:15','apollo','2020-11-21 21:12:59'),(6,'thrc-account-http-interface','default','application',_binary '\0','apollo','2020-11-21 00:06:52','apollo','2020-11-21 00:06:52'),(7,'thrc-gateway','default','application',_binary '\0','apollo','2020-11-21 21:09:01','apollo','2020-11-21 21:09:01');
/*!40000 ALTER TABLE `Namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NamespaceLock`
--

DROP TABLE IF EXISTS `NamespaceLock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NamespaceLock` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `NamespaceId` int unsigned NOT NULL DEFAULT '0' COMMENT '集群NamespaceId',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT 'default' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `IsDeleted` bit(1) DEFAULT b'0' COMMENT '软删除',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_NamespaceId` (`NamespaceId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='namespace的编辑锁';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NamespaceLock`
--

LOCK TABLES `NamespaceLock` WRITE;
/*!40000 ALTER TABLE `NamespaceLock` DISABLE KEYS */;
/*!40000 ALTER TABLE `NamespaceLock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Release`
--

DROP TABLE IF EXISTS `Release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Release` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ReleaseKey` varchar(64) NOT NULL DEFAULT '' COMMENT '发布的Key',
  `Name` varchar(64) NOT NULL DEFAULT 'default' COMMENT '发布名字',
  `Comment` varchar(256) DEFAULT NULL COMMENT '发布说明',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `Configurations` longtext NOT NULL COMMENT '发布配置',
  `IsAbandoned` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否废弃',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId_ClusterName_GroupName` (`AppId`(191),`ClusterName`(191),`NamespaceName`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ReleaseKey` (`ReleaseKey`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='发布';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Release`
--

LOCK TABLES `Release` WRITE;
/*!40000 ALTER TABLE `Release` DISABLE KEYS */;
INSERT INTO `Release` VALUES (1,'20161009155425-d3a0749c6e20bc15','20161009155424-release','Sample发布','SampleApp','default','application','{\"timeout\":\"100\"}',_binary '\0',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'20201118172115-b7c1b975b8065507','20201118172106-release','','thrc-user','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.user\",\"port\":\"9091\",\"mysql-addr\":\"localhost\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '\0',_binary '\0','apollo','2020-11-17 19:21:15','apollo','2020-11-17 19:21:15'),(3,'20201118172127-3772b975b8065508','20201118172124-release','','thrc.account','default','application','{\"port\":\"9090\",\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.account\",\"mysql-addr\":\"localhost\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '\0',_binary '','apollo','2020-11-17 19:21:27','apollo','2020-11-18 10:02:55'),(4,'20201118175933-c653b975b8065509','20201118175929-release','','thrc-account','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.account\",\"port\":\"9090\",\"mysql-addr\":\"localhost\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '\0',_binary '\0','apollo','2020-11-17 19:59:33','apollo','2020-11-17 19:59:33'),(5,'20201118221608-b7c1b975b806550a','20201118221606-release','','thrc-user','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.user\",\"port\":\"9091\",\"mysql-addr\":\"host.minikube.internal\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '',_binary '\0','apollo','2020-11-18 00:16:08','apollo','2020-11-18 01:25:36'),(6,'20201118221633-c653b975b806550b','20201118221631-release','','thrc-account','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.account\",\"port\":\"9090\",\"mysql-addr\":\"host.minikube.internal\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '',_binary '\0','apollo','2020-11-18 00:16:33','apollo','2020-11-18 01:24:47'),(7,'20201118232509-c653b975b806550c','20201118232503-release','','thrc-account','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.account\",\"port\":\"9090\",\"mysql-addr\":\"host.minikube.internal\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '',_binary '\0','apollo','2020-11-18 01:25:09','apollo','2020-11-18 01:25:19'),(8,'20201119171658-c65338d5383fc08c','20201119171657-release','','thrc-account','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.account\",\"port\":\"9090\",\"mysql-addr\":\"host.minikube.internal\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '',_binary '\0','apollo','2020-11-18 19:16:59','apollo','2020-11-18 23:13:34'),(9,'20201119171706-b7c138d5383fc08d','20201119171705-release','','thrc-user','default','application','{\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.user\",\"port\":\"9091\",\"mysql-addr\":\"host.minikube.internal\",\"mysql-port\":\"3306\",\"mysql-username\":\"root\",\"mysql-password\":\"\",\"mysql-db\":\"thrc\"}',_binary '',_binary '\0','apollo','2020-11-18 19:17:07','apollo','2020-11-18 23:13:20'),(10,'20201121094244-49c938d5383fc08e','20201121094238-release','','thrc.gateway','default','application','{\"port\":\"2233\",\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.gateway\"}',_binary '\0',_binary '','apollo','2020-11-20 11:42:45','apollo','2020-11-22 11:12:59'),(11,'20201121220808-258a38d5383fc08f','20201121220806-release','','thrc-account-http-interface','default','application','{\"port\":\"6060\",\"region\":\"cn\",\"zone\":\"gd\",\"appid\":\"account\",\"env\":\"dev\"}',_binary '\0',_binary '\0','apollo','2020-11-21 00:08:08','apollo','2020-11-21 00:08:08'),(12,'20201122191020-d8aa38d5383fc090','20201122191018-release','','thrc-gateway','default','application','{\"port\":\"2233\",\"region\":\"cn\",\"zone\":\"gd\",\"env\":\"dev\",\"appid\":\"thrc.gateway\"}',_binary '\0',_binary '\0','apollo','2020-11-21 21:10:20','apollo','2020-11-21 21:10:20');
/*!40000 ALTER TABLE `Release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReleaseHistory`
--

DROP TABLE IF EXISTS `ReleaseHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ReleaseHistory` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(32) NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `BranchName` varchar(32) NOT NULL DEFAULT 'default' COMMENT '发布分支名',
  `ReleaseId` int unsigned NOT NULL DEFAULT '0' COMMENT '关联的Release Id',
  `PreviousReleaseId` int unsigned NOT NULL DEFAULT '0' COMMENT '前一次发布的ReleaseId',
  `Operation` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度',
  `OperationContext` longtext NOT NULL COMMENT '发布上下文信息',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_Namespace` (`AppId`,`ClusterName`,`NamespaceName`,`BranchName`),
  KEY `IX_ReleaseId` (`ReleaseId`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='发布历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReleaseHistory`
--

LOCK TABLES `ReleaseHistory` WRITE;
/*!40000 ALTER TABLE `ReleaseHistory` DISABLE KEYS */;
INSERT INTO `ReleaseHistory` VALUES (1,'SampleApp','default','application','default',1,0,0,'{}',_binary '\0','apollo','2020-11-18 06:32:57','apollo','2020-11-18 06:32:57'),(2,'thrc-user','default','application','default',2,0,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-17 19:21:15','apollo','2020-11-17 19:21:15'),(3,'thrc.account','default','application','default',3,0,0,'{\"isEmergencyPublish\":false}',_binary '','apollo','2020-11-17 19:21:27','apollo','2020-11-18 10:02:55'),(4,'thrc-account','default','application','default',4,0,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-17 19:59:33','apollo','2020-11-17 19:59:33'),(5,'thrc-user','default','application','default',5,2,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-18 00:16:08','apollo','2020-11-18 00:16:08'),(6,'thrc-account','default','application','default',6,4,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-18 00:16:33','apollo','2020-11-18 00:16:33'),(7,'thrc-account','default','application','default',4,6,1,'{}',_binary '\0','apollo','2020-11-18 01:24:47','apollo','2020-11-18 01:24:47'),(8,'thrc-account','default','application','default',7,4,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-18 01:25:09','apollo','2020-11-18 01:25:09'),(9,'thrc-account','default','application','default',4,7,1,'{}',_binary '\0','apollo','2020-11-18 01:25:19','apollo','2020-11-18 01:25:19'),(10,'thrc-user','default','application','default',2,5,1,'{}',_binary '\0','apollo','2020-11-18 01:25:36','apollo','2020-11-18 01:25:36'),(11,'thrc-account','default','application','default',8,4,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-18 19:16:59','apollo','2020-11-18 19:16:59'),(12,'thrc-user','default','application','default',9,2,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-18 19:17:07','apollo','2020-11-18 19:17:07'),(13,'thrc-user','default','application','default',2,9,1,'{}',_binary '\0','apollo','2020-11-18 23:13:20','apollo','2020-11-18 23:13:20'),(14,'thrc-account','default','application','default',4,8,1,'{}',_binary '\0','apollo','2020-11-18 23:13:34','apollo','2020-11-18 23:13:34'),(15,'thrc.gateway','default','application','default',10,0,0,'{\"isEmergencyPublish\":false}',_binary '','apollo','2020-11-20 11:42:45','apollo','2020-11-22 11:12:59'),(16,'thrc-account-http-interface','default','application','default',11,0,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-21 00:08:08','apollo','2020-11-21 00:08:08'),(17,'thrc-gateway','default','application','default',12,0,0,'{\"isEmergencyPublish\":false}',_binary '\0','apollo','2020-11-21 21:10:20','apollo','2020-11-21 21:10:20');
/*!40000 ALTER TABLE `ReleaseHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReleaseMessage`
--

DROP TABLE IF EXISTS `ReleaseMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ReleaseMessage` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Message` varchar(1024) NOT NULL DEFAULT '' COMMENT '发布的消息内容',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Message` (`Message`(191))
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='发布消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReleaseMessage`
--

LOCK TABLES `ReleaseMessage` WRITE;
/*!40000 ALTER TABLE `ReleaseMessage` DISABLE KEYS */;
INSERT INTO `ReleaseMessage` VALUES (1,'SampleApp+default+application','2020-11-18 06:32:57'),(5,'thrc.account+default+application','2020-11-17 20:02:56'),(14,'thrc-user+default+application','2020-11-18 23:13:20'),(15,'thrc-account+default+application','2020-11-18 23:13:34'),(17,'thrc-account-http-interface+default+application','2020-11-21 00:08:08'),(18,'thrc-gateway+default+application','2020-11-21 21:10:20'),(19,'thrc.gateway+default+application','2020-11-21 21:12:59');
/*!40000 ALTER TABLE `ReleaseMessage` ENABLE KEYS */;
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
  `Cluster` varchar(32) NOT NULL DEFAULT 'default' COMMENT '配置对应的集群，default为不针对特定的集群',
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置服务自身配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServerConfig`
--

LOCK TABLES `ServerConfig` WRITE;
/*!40000 ALTER TABLE `ServerConfig` DISABLE KEYS */;
INSERT INTO `ServerConfig` VALUES (1,'eureka.service.url','default','http://localhost:8080/eureka/','Eureka服务Url，多个service以英文逗号分隔',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(2,'namespace.lock.switch','default','false','一次发布只能有一个人修改开关',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(3,'item.value.length.limit','default','20000','item value最大长度限制',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(4,'config-service.cache.enabled','default','false','ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57'),(5,'item.key.length.limit','default','128','item key 最大长度限制',_binary '\0','default','2020-11-18 06:32:57','','2020-11-18 06:32:57');
/*!40000 ALTER TABLE `ServerConfig` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-26 10:16:06
