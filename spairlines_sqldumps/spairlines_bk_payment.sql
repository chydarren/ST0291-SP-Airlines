CREATE DATABASE  IF NOT EXISTS `ca1spairlines` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ca1spairlines`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: ca1spairlines
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bk_payment`
--

DROP TABLE IF EXISTS `bk_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bk_payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_card_holder` varchar(150) NOT NULL,
  `payment_card_no` varchar(16) NOT NULL,
  `payment_card_expdate` date NOT NULL,
  `payment_card_cvv` int(3) NOT NULL,
  `payment_addr_address` varchar(200) NOT NULL,
  `payment_addr_postcode` varchar(10) DEFAULT NULL,
  `payment_addr_residence` varchar(50) NOT NULL,
  `payment_addr_city` varchar(50) NOT NULL,
  `payment_addr_state` varchar(50) DEFAULT NULL,
  `payment_total_cost` decimal(7,2) NOT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bk_payment`
--

LOCK TABLES `bk_payment` WRITE;
/*!40000 ALTER TABLE `bk_payment` DISABLE KEYS */;
INSERT INTO `bk_payment` VALUES (1,'CHUA HAN YONG DARREN','4544150000550150','2017-11-24',721,'ST ANTHONY DRIVE 50 SINGAPORE','712123','Singapore','SINGAPORE','SINGAPORE',4000.00),(2,'CHNG WEI CHENG','4275315603725493','2017-09-27',451,'LINCOLN ROAD 42 HAI WAN BUILDING','642042','Singapore','SINGAPORE','SINGAPORE',1500.00);
/*!40000 ALTER TABLE `bk_payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-05 20:47:54
