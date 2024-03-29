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
-- Table structure for table `bk_contact`
--

DROP TABLE IF EXISTS `bk_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bk_contact` (
  `booking_ref_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_email` varchar(150) NOT NULL,
  `contact_tel_ctry` int(3) NOT NULL,
  `contact_tel_area` int(3) DEFAULT NULL,
  `contact_tel_hp` varchar(11) NOT NULL,
  `departure_flightbk_id` int(11) NOT NULL,
  `arrival_flightbk_id` int(11) DEFAULT NULL,
  `payment_id` int(11) NOT NULL,
  PRIMARY KEY (`booking_ref_id`),
  KEY `departure_flightbk_id_idx` (`departure_flightbk_id`),
  KEY `arrival_flightbk_id_idx` (`arrival_flightbk_id`),
  KEY `payment_id_idx` (`payment_id`),
  CONSTRAINT `arrival_flightbk_id` FOREIGN KEY (`arrival_flightbk_id`) REFERENCES `bk_flightbk` (`flight_bk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `departure_flightbk_id` FOREIGN KEY (`departure_flightbk_id`) REFERENCES `bk_flightbk` (`flight_bk_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_id` FOREIGN KEY (`payment_id`) REFERENCES `bk_payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bk_contact`
--

LOCK TABLES `bk_contact` WRITE;
/*!40000 ALTER TABLE `bk_contact` DISABLE KEYS */;
INSERT INTO `bk_contact` VALUES (1,'darrenchua77@yahoo.com.sg',65,NULL,'97719384',1,2,1),(2,'chngweicheng@gmail.com',65,NULL,'90723827',3,NULL,2);
/*!40000 ALTER TABLE `bk_contact` ENABLE KEYS */;
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
