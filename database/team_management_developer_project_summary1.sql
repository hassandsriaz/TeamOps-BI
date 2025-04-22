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
-- Table structure for table `developer_project_summary1`
--

DROP TABLE IF EXISTS `developer_project_summary1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `developer_project_summary1` (
  `devid` int NOT NULL,
  `num_high_end_projects` int NOT NULL,
  `num_low_end_projects` int NOT NULL,
  `number_of_projects` int NOT NULL,
  `avg_developer_rating` float NOT NULL,
  `burden` float NOT NULL,
  `efficiency` float NOT NULL,
  `sum_rating` float NOT NULL,
  `sum_weight` double NOT NULL,
  `total_proj_type` float NOT NULL,
  PRIMARY KEY (`devid`),
  CONSTRAINT `developer_project_summary1_ibfk_1` FOREIGN KEY (`devid`) REFERENCES `developer` (`Devid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer_project_summary1`
--

LOCK TABLES `developer_project_summary1` WRITE;
/*!40000 ALTER TABLE `developer_project_summary1` DISABLE KEYS */;
INSERT INTO `developer_project_summary1` VALUES (1,3,0,3,3.66667,0.266667,2.4,11,0.6000000000000001,2.25),(2,0,2,2,4.5,0.6,1.3,9,0.30000000000000004,0.5),(3,1,0,1,4,0.3,0.9,4,0.22499999999999998,0.75),(4,0,2,2,4,0.3,0.7,8,0.15,0.5),(5,3,1,4,4.75,0.305,3.5125,19,0.7625000000000001,2.5),(6,1,1,2,2.5,0.4125,0.8625,5,0.4125,1),(7,3,0,3,3,0.233333,1.5,9,0.5250000000000001,2.25),(8,1,2,3,3.66667,0.4,1.525,11,0.49999999999999994,1.25),(9,2,0,2,2,0.35,1.05,4,0.5249999999999999,1.5),(10,1,1,2,2.5,0.45,1.05,5,0.45000000000000007,1),(11,0,1,1,4,0.2,0.2,4,0.05,0.25),(12,1,0,1,5,1,3.75,5,0.75,0.75),(13,0,1,1,5,0.9,1.125,5,0.225,0.25),(14,0,1,1,5,0.1,0.125,5,0.025,0.25),(15,1,0,1,5,1,3.75,5,0.75,0.75),(16,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `developer_project_summary1` ENABLE KEYS */;
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
