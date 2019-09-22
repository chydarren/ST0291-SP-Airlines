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
-- Table structure for table `flightschedule`
--

DROP TABLE IF EXISTS `flightschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flightschedule` (
  `flightschedule_id` int(4) NOT NULL AUTO_INCREMENT,
  `aircraft_id` int(4) NOT NULL,
  `aircraft_flightno` varchar(6) NOT NULL,
  `departure_airport` varchar(100) NOT NULL,
  `departure_terminal` char(1) NOT NULL,
  `arrival_airport` varchar(100) NOT NULL,
  `arrival_terminal` char(1) NOT NULL,
  `arrival_country` varchar(50) NOT NULL,
  `arrival_city` varchar(50) NOT NULL,
  `economy_cost` decimal(6,2) DEFAULT NULL,
  `business_cost` decimal(7,2) DEFAULT NULL,
  `first_cost` decimal(7,2) DEFAULT NULL,
  `departure_datetime` datetime NOT NULL,
  `arrival_datetime` datetime NOT NULL,
  `flight_time` time NOT NULL,
  `departure_IATA` char(3) NOT NULL DEFAULT 'N.A',
  `departure_country` varchar(50) NOT NULL DEFAULT 'N.A',
  `departure_city` varchar(50) NOT NULL DEFAULT 'N.A',
  `arrival_IATA` char(3) NOT NULL DEFAULT 'N.A',
  `economy_count` int(11) DEFAULT NULL,
  `business_count` int(11) DEFAULT NULL,
  `first_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`flightschedule_id`),
  KEY `aircraft_id_idx` (`aircraft_id`),
  KEY `aircraft_flightno_idx` (`aircraft_flightno`),
  CONSTRAINT `aircraft_flightno` FOREIGN KEY (`aircraft_flightno`) REFERENCES `aircraft` (`aircraft_flightno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7039 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flightschedule`
--

LOCK TABLES `flightschedule` WRITE;
/*!40000 ALTER TABLE `flightschedule` DISABLE KEYS */;
INSERT INTO `flightschedule` VALUES (7028,1068,'SP114','London Heathrow Airport','4','Hong Kong International Airport','2','China','Hong Kong',2350.00,3500.00,5200.50,'2017-05-07 01:00:00','2017-05-07 19:45:00','12:45:00','LHR','United Kingdom','London','HKG',350,77,14),(7029,1061,'SP107','Hong Kong International Airport','2','Singapore Changi Airport','1','Singapore','Singapore',796.00,1500.00,NULL,'2017-05-07 21:00:00','2017-05-08 00:55:00','03:55:00','HKG','China','Hong Kong','SIN',204,74,0),(7030,1061,'SP107','Singapore Changi Airport','3','Hong Kong International Airport','2','China','Hong Kong',796.00,1500.00,NULL,'2017-05-09 03:00:00','2017-05-09 06:55:00','03:55:00','SIN','Singapore','Singapore','HKG',204,74,0),(7031,1068,'SP114','Hong Kong International Airport','2','London Heathrow Airport','4','United Kingdom','London',2350.00,3500.00,5200.50,'2017-05-09 09:00:00','2017-05-09 14:45:00','12:45:00','HKG','China','Hong Kong','LHR',350,77,14),(7032,1057,'SP103','Singapore Changi Airport','4','Bangkok International Airport','1','Thailand','Bangkok',588.00,720.00,NULL,'2017-08-18 13:00:00','2017-08-18 14:25:00','02:25:00','SIN','Singapore','Singapore','BKK',240,45,0),(7033,1058,'SP104','Bangkok International Airport','2','Singapore Changi Airport','1','Singapore','Singapore',588.00,720.00,NULL,'2017-08-18 18:00:00','2017-08-18 19:25:00','02:25:00','BKK','Thailand','Bangkok','SIN',240,45,0),(7034,1067,'SP113','Singapore Changi Airport','1','Tokyo Narita Airport','2','Japan','Tokyo',1200.00,1700.00,2500.00,'2017-08-20 13:00:00','2017-08-20 21:05:00','07:05:00','SIN','Singapore','Singapore','NRT',350,77,12),(7035,1069,'SP115','Tokyo Narita Airport','1','Singapore Changi Airport','4','Singapore','Singapore',1200.00,1700.00,2500.00,'2017-08-25 22:00:00','2017-08-26 04:05:00','07:05:00','NRT','Japan','Tokyo','SIN',350,77,12),(7036,1061,'SP107','Kuala Lumpur International Airport','M','Sydney International Airport','1','Australia','Sydney',1500.00,2300.00,NULL,'2017-08-26 07:00:00','2017-08-26 16:40:00','07:40:00','KUL','Malaysia','Kuala Lumpur','SYD',203,74,0),(7037,1062,'SP108','Sydney International Airport','2','Kuala Lumpur International Airport','M','Malaysia','Kuala Lumpur',1500.00,2300.00,NULL,'2017-08-28 18:00:00','2017-08-29 11:40:00','07:40:00','SYD','Australia','Sydney','KUL',204,74,0),(7038,1069,'SP115','Tokyo Narita Airport','1','Singapore Changi Airport','4','Singapore','Singapore',1200.00,1700.00,2500.00,'2017-08-22 18:00:00','2017-08-23 01:05:00','07:05:00','NRT','Japan','Tokyo','SIN',350,77,14);
/*!40000 ALTER TABLE `flightschedule` ENABLE KEYS */;
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
