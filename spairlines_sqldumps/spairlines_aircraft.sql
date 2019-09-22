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
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aircraft` (
  `aircraft_id` int(4) NOT NULL AUTO_INCREMENT,
  `aircraft_model` varchar(25) NOT NULL,
  `aircraft_flightno` varchar(6) NOT NULL,
  `passenger_capacity` int(3) NOT NULL,
  `image_path` varchar(100) NOT NULL DEFAULT 'images\\default.png',
  `economy_count` int(3) DEFAULT NULL,
  `business_count` int(3) DEFAULT NULL,
  `first_count` int(3) DEFAULT NULL,
  PRIMARY KEY (`aircraft_id`),
  UNIQUE KEY `aircraft_flightno_UNIQUE` (`aircraft_flightno`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (1056,'Boeing 777-200','SP102',323,'images\\Boeing 777-200SP102.jpg',260,63,0),(1057,'Boeing 777-200ER','SP103',285,'images\\Boeing 777-200ERSP103.jpg',240,45,0),(1058,'Boeing 777-200ER','SP104',285,'images\\Boeing 777-200ERSP104.jpg',240,45,0),(1059,'Boeing 777-300','SP105',284,'images\\Boeing 777-300SP105.jpg',210,74,0),(1060,'Boeing 777-300','SP106',284,'images\\Boeing 777-300SP106.jpg',210,74,0),(1061,'Boeing 777-300ER','SP107',278,'images\\Boeing 777-300ERSP107.jpg',204,74,0),(1062,'Boeing 777-300ER','SP108',278,'images\\Boeing 777-300ERSP108.jpg',204,74,0),(1063,'Airbus A330-300','SP109',285,'images\\Airbus A330-300SP109.jpg',237,48,0),(1064,'Airbus A330-300','SP110',285,'images\\Airbus A330-300SP110.jpg',237,48,0),(1065,'Airbus A350-900','SP111',253,'images\\Airbus A350-900SP111.jpg',208,45,0),(1066,'Airbus A350-900','SP112',253,'images\\Airbus A350-900SP112.jpg',208,45,0),(1067,'Airbus A380-800','SP113',441,'images\\Airbus A380-800SP113.jpg',350,77,14),(1068,'Airbus A380-800','SP114',441,'images\\Airbus A380-800SP114.jpg',350,77,14),(1069,'Airbus A380-800','SP115',441,'images\\Airbus A380-800SP115.jpg',350,77,14);
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
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
