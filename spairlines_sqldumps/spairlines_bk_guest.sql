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
-- Table structure for table `bk_guest`
--

DROP TABLE IF EXISTS `bk_guest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bk_guest` (
  `guest_passportno` varchar(15) NOT NULL,
  `booking_ref_id` int(4) NOT NULL,
  `guest_salutation` varchar(12) NOT NULL,
  `guest_firstname` varchar(100) DEFAULT NULL,
  `guest_lastname` varchar(40) NOT NULL,
  PRIMARY KEY (`guest_passportno`,`booking_ref_id`),
  KEY `booking_ref_id_idx` (`booking_ref_id`),
  CONSTRAINT `booking_ref_id` FOREIGN KEY (`booking_ref_id`) REFERENCES `bk_contact` (`booking_ref_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bk_guest`
--

LOCK TABLES `bk_guest` WRITE;
/*!40000 ALTER TABLE `bk_guest` DISABLE KEYS */;
INSERT INTO `bk_guest` VALUES ('E1234567',1,'MR','HAN YONG DARREN','CHUA'),('E7654321',1,'MR','WEI CHENG','CHNG'),('E7654321',2,'MR','WEI CHENG','CHNG');
/*!40000 ALTER TABLE `bk_guest` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-05 20:47:53
