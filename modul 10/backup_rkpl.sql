-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: rkpl_db
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `kepadatan`
--

DROP TABLE IF EXISTS `kepadatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kepadatan` (
  `id_kepadatan` int NOT NULL,
  `id_ruas` int DEFAULT NULL,
  `waktu` datetime DEFAULT NULL,
  `jumlah_kendaraan` int DEFAULT NULL,
  `kecepatan_rata2` decimal(5,2) DEFAULT NULL,
  `tingkat_kepadatan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_kepadatan`),
  KEY `idx_kepadatan_id_ruas` (`id_ruas`),
  CONSTRAINT `kepadatan_ibfk_1` FOREIGN KEY (`id_ruas`) REFERENCES `ruas_jalan` (`id_ruas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lokasi`
--

DROP TABLE IF EXISTS `lokasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lokasi` (
  `id_lokasi` int NOT NULL,
  `nama_lokasi` varchar(100) DEFAULT NULL,
  `alamat` text,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perjalanan`
--

DROP TABLE IF EXISTS `perjalanan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perjalanan` (
  `id_perjalanan` int NOT NULL,
  `id_rute` int DEFAULT NULL,
  `id_lokasi` int DEFAULT NULL,
  `waktu_mulai` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `posisi_asal` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_perjalanan`),
  KEY `id_rute` (`id_rute`),
  KEY `id_lokasi` (`id_lokasi`),
  CONSTRAINT `perjalanan_ibfk_1` FOREIGN KEY (`id_rute`) REFERENCES `rute` (`id_rute`),
  CONSTRAINT `perjalanan_ibfk_2` FOREIGN KEY (`id_lokasi`) REFERENCES `lokasi` (`id_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ruas_jalan`
--

DROP TABLE IF EXISTS `ruas_jalan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruas_jalan` (
  `id_ruas` int NOT NULL,
  `nama_ruas` varchar(100) NOT NULL,
  `jenis_jalan` varchar(50) DEFAULT NULL,
  `panjang` decimal(10,2) DEFAULT NULL,
  `lebar_jalan` decimal(5,2) DEFAULT NULL,
  `kecepatan_normal` decimal(5,2) DEFAULT NULL,
  `geometri` text,
  `total_kendaraan` int DEFAULT '0',
  PRIMARY KEY (`id_ruas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rute`
--

DROP TABLE IF EXISTS `rute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rute` (
  `id_rute` int NOT NULL,
  `jenis_rute` varchar(50) DEFAULT NULL,
  `total_jarak` decimal(10,2) DEFAULT NULL,
  `eta` varchar(50) DEFAULT NULL,
  `sisa_jarak` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_rute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'rkpl_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-05  8:54:05
