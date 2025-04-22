-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 192.168.100.237    Database: team_management_v2
-- ------------------------------------------------------
-- Server version	8.0.35

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

--
-- Table structure for table `progress`
--

DROP TABLE IF EXISTS `progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progress` (
  `devid` int NOT NULL,
  `pid` int NOT NULL,
  `progress_weight` decimal(3,2) DEFAULT NULL,
  KEY `devid` (`devid`),
  KEY `pid` (`pid`),
  CONSTRAINT `progress_ibfk_1` FOREIGN KEY (`devid`) REFERENCES `developer` (`Devid`),
  CONSTRAINT `progress_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `project` (`PID`),
  CONSTRAINT `progress_chk_1` CHECK (((`progress_weight` >= 0.00) and (`progress_weight` <= 1.00)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progress`
--

LOCK TABLES `progress` WRITE;
/*!40000 ALTER TABLE `progress` DISABLE KEYS */;
INSERT INTO `progress` VALUES (5,1,0.15),(1,1,0.30),(5,1,0.30),(1,2,0.15),(3,2,0.22),(5,2,0.30),(7,2,0.08),(2,3,0.10),(4,3,0.13),(5,3,0.01),(8,3,0.01),(1,4,0.15),(7,4,0.15),(6,4,0.38),(9,4,0.08),(4,5,0.03),(6,5,0.04),(8,5,0.04),(10,5,0.15),(9,6,0.45),(10,6,0.30),(8,7,0.45),(7,7,0.30),(2,8,0.20),(11,8,0.05),(12,9,0.75),(13,10,0.23),(14,10,0.03),(15,11,0.75);
/*!40000 ALTER TABLE `progress` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-25 20:32:34
