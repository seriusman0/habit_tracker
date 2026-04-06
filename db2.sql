-- MySQL dump 10.13  Distrib 9.0.1, for macos13.7 (x86_64)
--
-- Host: localhost    Database: habit_share_db
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint unsigned NOT NULL,
  `classroom_id` bigint unsigned NOT NULL,
  `date` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attendances_student_id_classroom_id_date_unique` (`student_id`,`classroom_id`,`date`),
  KEY `attendances_classroom_id_foreign` (`classroom_id`),
  CONSTRAINT `attendances_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,63,11,'2026-03-28','pending','2026-03-27 15:43:10','2026-03-27 15:43:10'),(2,63,2,'2026-03-28','pending','2026-03-27 15:43:19','2026-03-27 15:43:19'),(3,63,11,'2026-03-29','pending','2026-03-28 14:15:23','2026-03-28 14:15:23'),(4,52,13,'2026-03-31','pending','2026-03-31 00:59:55','2026-03-31 00:59:55'),(5,53,2,'2026-04-01','pending','2026-03-31 11:33:07','2026-03-31 11:33:07'),(6,77,14,'2026-04-03','pending','2026-04-03 08:27:41','2026-04-03 08:27:41'),(7,77,14,'2026-04-04','pending','2026-04-03 10:14:48','2026-04-03 10:14:48');
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coordinator_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('jurnal-ykde-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3','i:1;',1775518300),('jurnal-ykde-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer','i:1775518300;',1775518300),('jurnal-ykde-cache-spatie.permission.cache','a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}',1775604640);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_students`
--

DROP TABLE IF EXISTS `classroom_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_students` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `classroom_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_students_classroom_id_student_id_unique` (`classroom_id`,`student_id`),
  KEY `classroom_students_student_id_foreign` (`student_id`),
  CONSTRAINT `classroom_students_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `classroom_students_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_students`
--

LOCK TABLES `classroom_students` WRITE;
/*!40000 ALTER TABLE `classroom_students` DISABLE KEYS */;
INSERT INTO `classroom_students` VALUES (6,2,51,'2026-03-10 14:37:25','2026-03-10 14:37:25'),(7,3,26,'2026-03-19 02:39:28','2026-03-19 02:39:28'),(8,3,60,'2026-03-19 02:39:37','2026-03-19 02:39:37'),(9,3,70,'2026-03-19 02:40:10','2026-03-19 02:40:10'),(10,3,59,'2026-03-19 02:41:36','2026-03-19 02:41:36'),(11,3,65,'2026-03-19 02:41:44','2026-03-19 02:41:44'),(12,4,32,'2026-03-19 02:42:25','2026-03-19 02:42:25'),(13,4,40,'2026-03-19 02:42:32','2026-03-19 02:42:32'),(15,4,48,'2026-03-19 02:42:52','2026-03-19 02:42:52'),(16,4,44,'2026-03-19 02:43:12','2026-03-19 02:43:12'),(17,5,43,'2026-03-19 02:44:01','2026-03-19 02:44:01'),(18,5,29,'2026-03-19 02:44:13','2026-03-19 02:44:13'),(19,5,66,'2026-03-19 02:44:43','2026-03-19 02:44:43'),(20,5,30,'2026-03-19 02:44:51','2026-03-19 02:44:51'),(21,5,72,'2026-03-19 02:45:11','2026-03-19 02:45:11'),(22,6,38,'2026-03-19 02:46:11','2026-03-19 02:46:11'),(23,6,62,'2026-03-19 02:46:19','2026-03-19 02:46:19'),(24,6,56,'2026-03-19 02:46:31','2026-03-19 02:46:31'),(25,6,41,'2026-03-19 02:46:40','2026-03-19 02:46:40'),(26,6,58,'2026-03-19 02:46:47','2026-03-19 02:46:47'),(28,8,57,'2026-03-19 02:47:39','2026-03-19 02:47:39'),(29,8,35,'2026-03-19 02:47:51','2026-03-19 02:47:51'),(30,8,67,'2026-03-19 02:48:02','2026-03-19 02:48:02'),(31,8,61,'2026-03-19 02:48:15','2026-03-19 02:48:15'),(32,8,37,'2026-03-19 02:48:28','2026-03-19 02:48:28'),(33,11,54,'2026-03-19 02:49:17','2026-03-19 02:49:17'),(34,11,53,'2026-03-19 02:49:24','2026-03-19 02:49:24'),(35,11,63,'2026-03-19 02:49:37','2026-03-19 02:49:37'),(36,11,39,'2026-03-19 02:50:07','2026-03-19 02:50:07'),(37,11,27,'2026-03-19 02:50:20','2026-03-19 02:50:20'),(38,11,46,'2026-03-19 02:50:32','2026-03-19 02:50:32'),(39,11,47,'2026-03-19 02:50:40','2026-03-19 02:50:40'),(40,13,75,'2026-03-19 03:02:00','2026-03-19 03:02:00'),(41,13,47,'2026-03-19 15:01:18','2026-03-19 15:01:18'),(42,13,33,'2026-03-19 15:01:25','2026-03-19 15:01:25'),(43,13,69,'2026-03-19 15:01:34','2026-03-19 15:01:34'),(44,13,52,'2026-03-19 15:01:41','2026-03-19 15:01:41'),(45,13,31,'2026-03-19 15:01:50','2026-03-19 15:01:50'),(46,13,42,'2026-03-19 15:02:02','2026-03-19 15:02:02'),(47,1,26,'2026-03-19 15:16:57','2026-03-19 15:16:57'),(48,1,59,'2026-03-19 15:17:03','2026-03-19 15:17:03'),(49,1,32,'2026-03-19 15:17:09','2026-03-19 15:17:09'),(50,1,29,'2026-03-19 15:18:44','2026-03-19 15:18:44'),(51,1,30,'2026-03-19 15:18:51','2026-03-19 15:18:51'),(52,1,60,'2026-03-19 15:19:15','2026-03-19 15:19:15'),(53,1,65,'2026-03-19 15:19:21','2026-03-19 15:19:21'),(54,1,72,'2026-03-19 15:19:29','2026-03-19 15:19:29'),(55,1,35,'2026-03-19 15:19:37','2026-03-19 15:19:37'),(56,1,27,'2026-03-19 15:20:13','2026-03-19 15:20:13'),(57,1,34,'2026-03-19 15:20:42','2026-03-19 15:20:42'),(58,1,28,'2026-03-19 15:20:53','2026-03-19 15:20:53'),(59,1,31,'2026-03-19 15:21:02','2026-03-19 15:21:02'),(60,1,33,'2026-03-19 15:21:14','2026-03-19 15:21:14'),(61,2,70,'2026-03-19 15:22:48','2026-03-19 15:22:48'),(62,2,40,'2026-03-19 15:23:00','2026-03-19 15:23:00'),(64,2,71,'2026-03-19 15:23:14','2026-03-19 15:23:14'),(65,2,48,'2026-03-19 15:24:08','2026-03-19 15:24:08'),(66,2,44,'2026-03-19 15:24:15','2026-03-19 15:24:15'),(67,2,43,'2026-03-19 15:24:20','2026-03-19 15:24:20'),(68,2,41,'2026-03-19 15:24:27','2026-03-19 15:24:27'),(69,2,56,'2026-03-19 15:25:10','2026-03-19 15:25:10'),(70,2,66,'2026-03-19 15:25:18','2026-03-19 15:25:18'),(71,2,38,'2026-03-19 15:25:25','2026-03-19 15:25:25'),(72,2,62,'2026-03-19 15:25:35','2026-03-19 15:25:35'),(73,2,58,'2026-03-19 15:26:21','2026-03-19 15:26:21'),(74,2,64,'2026-03-19 15:26:34','2026-03-19 15:26:34'),(75,2,67,'2026-03-19 15:26:44','2026-03-19 15:26:44'),(76,2,37,'2026-03-19 15:26:51','2026-03-19 15:26:51'),(77,2,57,'2026-03-19 15:26:58','2026-03-19 15:26:58'),(78,2,61,'2026-03-19 15:27:06','2026-03-19 15:27:06'),(79,2,54,'2026-03-19 15:27:17','2026-03-19 15:27:17'),(80,2,53,'2026-03-19 15:27:27','2026-03-19 15:27:27'),(81,2,63,'2026-03-19 15:27:35','2026-03-19 15:27:35'),(82,2,39,'2026-03-19 15:27:48','2026-03-19 15:27:48'),(83,2,36,'2026-03-19 15:27:55','2026-03-19 15:27:55'),(84,2,46,'2026-03-19 15:28:03','2026-03-19 15:28:03'),(85,2,68,'2026-03-19 15:28:23','2026-03-19 15:28:23'),(86,2,42,'2026-03-19 15:28:32','2026-03-19 15:28:32'),(87,2,69,'2026-03-19 15:28:41','2026-03-19 15:28:41'),(88,2,52,'2026-03-19 15:28:49','2026-03-19 15:28:49'),(89,2,47,'2026-03-19 15:28:57','2026-03-19 15:28:57'),(90,14,77,'2026-03-30 10:38:48','2026-03-30 10:38:48');
/*!40000 ALTER TABLE `classroom_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classrooms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mentor_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classrooms_mentor_id_foreign` (`mentor_id`),
  CONSTRAINT `classrooms_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,'Kelas Karakter Non Kristen',18,NULL,'ACTIVE','2026-02-19 18:07:32','2026-03-19 15:21:36'),(2,'Kelas Karakter Kristen',2,'Ini adalah kelas percobaan untuk role Mentor','ACTIVE','2026-03-10 14:32:23','2026-03-19 15:15:52'),(3,'Kelas Matematika 1,2,3',17,'Kelas ini bagi anak-anak yang kelas 1-3 dengan mata pelajaran yang ada','ACTIVE','2026-03-10 21:23:20','2026-03-10 21:23:20'),(4,'Kelas Matematika 4,5,6',22,'Kelas untuk anak anak yang duduk dibangku kelas 4,5,6','ACTIVE','2026-03-10 21:25:13','2026-03-10 21:25:13'),(5,'Kelas Bahasa Inggris 1,2,3',18,'kelas bagi adik adik di kelas 1-3 yang ingin menguasai bahasa','ACTIVE','2026-03-10 21:26:24','2026-03-10 21:26:24'),(6,'Kelas Bahasa Inggris 4,5,6',11,'Kelas ini untuk adik adik bertumbuh dalam perkembangan kelas yang lebih dewasa','ACTIVE','2026-03-10 21:27:57','2026-03-19 14:59:42'),(8,'Kelas IPA 4,5,6',12,'Untuk adik-adik yang ingin belajar banyak tentang biologi','ACTIVE','2026-03-10 21:32:00','2026-03-10 21:32:00'),(11,'Kelas Gitar',16,'Untuk pengembangan seni didalam petikan gitar','ACTIVE','2026-03-10 21:43:18','2026-03-10 21:43:18'),(13,'Kelas IPA 1,2,3',6,'Ini hanyalah test','ACTIVE','2026-03-19 03:01:45','2026-03-19 15:15:05'),(14,'mentor',76,'ini contoh','ACTIVE','2026-03-30 10:38:39','2026-03-30 10:38:39');
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_reflections`
--

DROP TABLE IF EXISTS `daily_reflections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_reflections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint unsigned NOT NULL,
  `ref_date` date NOT NULL,
  `mood` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `daily_reflections_student_id_ref_date_unique` (`student_id`,`ref_date`),
  CONSTRAINT `daily_reflections_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_reflections`
--

LOCK TABLES `daily_reflections` WRITE;
/*!40000 ALTER TABLE `daily_reflections` DISABLE KEYS */;
INSERT INTO `daily_reflections` VALUES (1,51,'2026-03-11','NEUTRAL',NULL,'2026-03-10 14:43:37','2026-03-10 14:43:37'),(2,54,'2026-03-16','HAPPY',NULL,'2026-03-15 13:44:47','2026-03-15 13:44:47'),(3,53,'2026-03-16','HAPPY',NULL,'2026-03-15 13:52:30','2026-03-15 13:52:30'),(4,39,'2026-03-16','HAPPY',NULL,'2026-03-15 14:25:40','2026-03-15 14:25:40'),(5,52,'2026-03-16','HAPPY',NULL,'2026-03-15 16:24:27','2026-03-15 16:24:27'),(6,31,'2026-03-18','HAPPY',NULL,'2026-03-17 19:11:12','2026-03-17 19:11:12'),(7,72,'2026-03-18','HAPPY',NULL,'2026-03-17 20:17:16','2026-03-17 20:17:16'),(8,63,'2026-03-19','HAPPY',NULL,'2026-03-18 15:08:05','2026-03-18 15:08:05'),(9,54,'2026-03-19','HAPPY',NULL,'2026-03-18 17:44:18','2026-03-18 17:44:18'),(10,62,'2026-03-26','HAPPY',NULL,'2026-03-25 13:03:11','2026-03-25 13:03:11'),(11,74,'2026-03-26','HAPPY',NULL,'2026-03-25 13:03:30','2026-03-25 13:03:30'),(12,63,'2026-03-28','HAPPY',NULL,'2026-03-27 19:09:35','2026-03-27 19:09:35'),(13,52,'2026-03-31','HAPPY',NULL,'2026-03-31 01:01:03','2026-03-31 01:01:03'),(14,77,'2026-04-01','HAPPY',NULL,'2026-03-31 11:30:52','2026-03-31 11:30:52');
/*!40000 ALTER TABLE `daily_reflections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genetic_types`
--

DROP TABLE IF EXISTS `genetic_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genetic_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `genetic_types_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genetic_types`
--

LOCK TABLES `genetic_types` WRITE;
/*!40000 ALTER TABLE `genetic_types` DISABLE KEYS */;
INSERT INTO `genetic_types` VALUES (1,'Sensing','Focus on sensory details and concrete reality.','2026-02-19 18:06:26','2026-02-19 18:06:26'),(2,'Thinking','Analytical and logical decision making.','2026-02-19 18:06:26','2026-02-19 18:06:26'),(3,'Intuiting','Focus on possibilities, patterns, and future implications.','2026-02-19 18:06:26','2026-02-19 18:06:26'),(4,'Feeling','Decision making based on values and harmony.','2026-02-19 18:06:26','2026-02-19 18:06:26'),(5,'Instinct','Spontaneous and gut-driven reactions.','2026-02-19 18:06:26','2026-02-19 18:06:26');
/*!40000 ALTER TABLE `genetic_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habit_categories`
--

DROP TABLE IF EXISTS `habit_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habit_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_user_id` bigint unsigned DEFAULT NULL,
  `updated_by_user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `habit_categories_created_by_user_id_foreign` (`created_by_user_id`),
  KEY `habit_categories_updated_by_user_id_foreign` (`updated_by_user_id`),
  CONSTRAINT `habit_categories_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habit_categories_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_categories`
--

LOCK TABLES `habit_categories` WRITE;
/*!40000 ALTER TABLE `habit_categories` DISABLE KEYS */;
INSERT INTO `habit_categories` VALUES (1,'Bangun',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(2,'Ibadah',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(3,'Olahraga',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(4,'Makan',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(5,'Belajar',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(6,'Bermasyarakat',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(7,'Tidur',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(8,'Mentoring',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19'),(9,'Kehadiran',NULL,NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19');
/*!40000 ALTER TABLE `habit_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habit_logs`
--

DROP TABLE IF EXISTS `habit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `habit_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `log_date` date NOT NULL,
  `status` enum('completed','skipped','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `logged_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `habit_logs_student_id_habit_id_log_date_unique` (`student_id`,`habit_id`,`log_date`),
  KEY `habit_logs_habit_id_foreign` (`habit_id`),
  CONSTRAINT `habit_logs_habit_id_foreign` FOREIGN KEY (`habit_id`) REFERENCES `habits` (`id`) ON DELETE CASCADE,
  CONSTRAINT `habit_logs_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_logs`
--

LOCK TABLES `habit_logs` WRITE;
/*!40000 ALTER TABLE `habit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `habit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habit_user`
--

DROP TABLE IF EXISTS `habit_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habit_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `habit_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frequency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `habit_user_habit_id_student_id_unique` (`habit_id`,`student_id`),
  KEY `habit_user_student_id_foreign` (`student_id`),
  CONSTRAINT `habit_user_habit_id_foreign` FOREIGN KEY (`habit_id`) REFERENCES `habits` (`id`) ON DELETE CASCADE,
  CONSTRAINT `habit_user_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_user`
--

LOCK TABLES `habit_user` WRITE;
/*!40000 ALTER TABLE `habit_user` DISABLE KEYS */;
INSERT INTO `habit_user` VALUES (69,7,77,'bg-indigo-500','daily',1,'2026-03-30 14:29:14','2026-03-30 14:29:14'),(70,12,77,'bg-indigo-500','daily',1,'2026-03-30 14:29:29','2026-03-30 14:29:29'),(71,4,77,'bg-indigo-500','daily',1,'2026-03-30 14:29:31','2026-03-30 14:29:31'),(72,5,77,'bg-indigo-500','daily',1,'2026-03-30 14:29:33','2026-03-30 14:29:33'),(73,3,77,'bg-indigo-500','daily',1,'2026-03-31 11:19:14','2026-03-31 11:19:14'),(74,9,77,'bg-indigo-500','daily',1,'2026-04-03 08:26:54','2026-04-03 08:26:54'),(77,3,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(78,4,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(79,5,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(80,6,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(81,7,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(82,8,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(83,9,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(84,10,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(85,12,26,'bg-indigo-500','daily',1,'2026-04-06 16:31:21','2026-04-06 16:31:21'),(87,3,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(88,4,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(89,5,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(90,6,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(91,7,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(92,8,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(93,9,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(94,10,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(95,12,27,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(96,3,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(97,4,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(98,5,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(99,6,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(100,7,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(101,8,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(102,9,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(103,10,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(104,12,28,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(105,3,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(106,4,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(107,5,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(108,6,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(109,7,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(110,8,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(111,9,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(112,10,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(113,12,29,'bg-indigo-500','daily',1,'2026-04-06 16:36:55','2026-04-06 16:36:55'),(114,3,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(115,4,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(116,5,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(117,6,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(118,7,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(119,8,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(120,9,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(121,10,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(122,12,30,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(123,3,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(124,4,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(125,5,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(126,6,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(127,7,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(128,8,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(129,9,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(130,10,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(131,12,31,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(132,3,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(133,4,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(134,5,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(135,6,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(136,7,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(137,8,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(138,9,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(139,10,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(140,12,32,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(141,3,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(142,4,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(143,5,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(144,6,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(145,7,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(146,8,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(147,9,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(148,10,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(149,12,33,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(150,3,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(151,4,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(152,5,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(153,6,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(154,7,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(155,8,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(156,9,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(157,10,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(158,12,34,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(159,3,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(160,4,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(161,5,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(162,6,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(163,7,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(164,8,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(165,9,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(166,10,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(167,12,35,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(168,3,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(169,4,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(170,5,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(171,6,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(172,7,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(173,8,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(174,9,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(175,10,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(176,12,36,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(177,3,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(178,4,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(179,5,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(180,6,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(181,7,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(182,8,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(183,9,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(184,10,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(185,12,37,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(186,3,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(187,4,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(188,5,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(189,6,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(190,7,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(191,8,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(192,9,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(193,10,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(194,12,38,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(195,3,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(196,4,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(197,5,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(198,6,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(199,7,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(200,8,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(201,9,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(202,10,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(203,12,39,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(204,3,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(205,4,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(206,5,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(207,6,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(208,7,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(209,8,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(210,9,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(211,10,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(212,12,40,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(213,3,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(214,4,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(215,5,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(216,6,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(217,7,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(218,8,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(219,9,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(220,10,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(221,12,41,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(222,3,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(223,4,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(224,5,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(225,6,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(226,7,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(227,8,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(228,9,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(229,10,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(230,12,42,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(231,3,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(232,4,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(233,5,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(234,6,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(235,7,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(236,8,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(237,9,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(238,10,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(239,12,43,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(240,3,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(241,4,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(242,5,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(243,6,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(244,7,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(245,8,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(246,9,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(247,10,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(248,12,44,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(249,3,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(250,4,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(251,5,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(252,6,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(253,7,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(254,8,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(255,9,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(256,10,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(257,12,46,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(258,3,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(259,4,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(260,5,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(261,6,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(262,7,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(263,8,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(264,9,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(265,10,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(266,12,47,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(267,3,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(268,4,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(269,5,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(270,6,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(271,7,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(272,8,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(273,9,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(274,10,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(275,12,48,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(276,3,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(277,4,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(278,5,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(279,6,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(280,7,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(281,8,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(282,9,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(283,10,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(284,12,51,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(285,3,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(286,4,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(287,5,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(288,6,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(289,7,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(290,8,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(291,9,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(292,10,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(293,12,52,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(294,3,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(295,4,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(296,5,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(297,6,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(298,7,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(299,8,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(300,9,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(301,10,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(302,12,53,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(303,3,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(304,4,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(305,5,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(306,6,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(307,7,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(308,8,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(309,9,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(310,10,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(311,12,54,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(312,3,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(313,4,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(314,5,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(315,6,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(316,7,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(317,8,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(318,9,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(319,10,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(320,12,56,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(321,3,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(322,4,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(323,5,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(324,6,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(325,7,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(326,8,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(327,9,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(328,10,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(329,12,57,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(330,3,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(331,4,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(332,5,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(333,6,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(334,7,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(335,8,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(336,9,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(337,10,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(338,12,58,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(339,3,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(340,4,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(341,5,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(342,6,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(343,7,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(344,8,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(345,9,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(346,10,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(347,12,59,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(348,3,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(349,4,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(350,5,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(351,6,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(352,7,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(353,8,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(354,9,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(355,10,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(356,12,60,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(357,3,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(358,4,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(359,5,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(360,6,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(361,7,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(362,8,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(363,9,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(364,10,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(365,12,61,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(366,3,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(367,4,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(368,5,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(369,6,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(370,7,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(371,8,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(372,9,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(373,10,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(374,12,62,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(375,3,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(376,4,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(377,5,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(378,6,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(379,7,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(380,8,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(381,9,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(382,10,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(383,12,63,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(384,3,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(385,4,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(386,5,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(387,6,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(388,7,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(389,8,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(390,9,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(391,10,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(392,12,64,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(393,3,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(394,4,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(395,5,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(396,6,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(397,7,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(398,8,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(399,9,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(400,10,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(401,12,65,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(402,3,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(403,4,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(404,5,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(405,6,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(406,7,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(407,8,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(408,9,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(409,10,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(410,12,66,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(411,3,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(412,4,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(413,5,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(414,6,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(415,7,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(416,8,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(417,9,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(418,10,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(419,12,67,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(420,3,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(421,4,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(422,5,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(423,6,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(424,7,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(425,8,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(426,9,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(427,10,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(428,12,68,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(429,3,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(430,4,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(431,5,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(432,6,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(433,7,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(434,8,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(435,9,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(436,10,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(437,12,69,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(438,3,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(439,4,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(440,5,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(441,6,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(442,7,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(443,8,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(444,9,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(445,10,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(446,12,70,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(447,3,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(448,4,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(449,5,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(450,6,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(451,7,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(452,8,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(453,9,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(454,10,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(455,12,71,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(456,3,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(457,4,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(458,5,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(459,6,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(460,7,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(461,8,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(462,9,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(463,10,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(464,12,72,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(465,3,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(466,4,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(467,5,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(468,6,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(469,7,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(470,8,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(471,9,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(472,10,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(473,12,74,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(474,3,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(475,4,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(476,5,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(477,6,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(478,7,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(479,8,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(480,9,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(481,10,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(482,12,75,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(483,6,77,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(484,8,77,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(485,10,77,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(486,3,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(487,4,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(488,5,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(489,6,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(490,7,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(491,8,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(492,9,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(493,10,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(494,12,78,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(495,3,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(496,4,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(497,5,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(498,6,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(499,7,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(500,8,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(501,9,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(502,10,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56'),(503,12,79,'bg-indigo-500','daily',1,'2026-04-06 16:36:56','2026-04-06 16:36:56');
/*!40000 ALTER TABLE `habit_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habits`
--

DROP TABLE IF EXISTS `habits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#4F46E5',
  `frequency` enum('daily','weekly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by_user_id` bigint unsigned DEFAULT NULL,
  `updated_by_user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `habits_created_by_user_id_foreign` (`created_by_user_id`),
  KEY `habits_updated_by_user_id_foreign` (`updated_by_user_id`),
  KEY `habits_category_id_foreign` (`category_id`),
  CONSTRAINT `habits_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `habit_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habits_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habits_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habits`
--

LOCK TABLES `habits` WRITE;
/*!40000 ALTER TABLE `habits` DISABLE KEYS */;
INSERT INTO `habits` VALUES (3,1,'BANGUN PAGI','Bangun pagi merupakan kebiasaan bangun di pagi hari yang apabila dilakukan setiap hari akan memberikan manfaat diantaranya melatih kedisiplinan, meningkatkan kemampuan mengelola waktu, meningkatkan kemampuan mengendalikan diri, meningkatakan keseimbangan jiwa dan raga yang dapat berkontribusi pada kesuksesan seseorang','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:23:59','2026-04-06 16:33:24'),(4,2,'BERIBADAH','Kebiasaan beribadah merupakan fondasi penting dalam pembentukan karakter positif pada anak yang bermanfaat untuk mendekatkan hubungan individu dengan Tuhan, meningkatkan nilai-nilai etika, moral, spiritual, dan sosial, serta meningkatkan pemahaman tujuan hidup dan arah yang bermakna, meningkatkan kebersamaan dan solidaritas, serta peningkatan diri secara berkelanjutan.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:24:30','2026-04-06 16:34:01'),(5,3,'BEROLAHRAGA','Kebiasaan berolahraga merupakan bagian penting dari gaya hidup sehat yang bermanfaat untuk  menjaga kesehatan fisik dan mendukung kesehatan  mental, menjaga kebugaran tubuh, meningkatkan  potensi diri, dan meningkatkan nilai sportivitas.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:29:33','2026-04-06 16:34:26'),(6,4,'MAKAN SEHAT DAN BERGIZI','Kebiasaan makan sehat dan bergizi berkaitan dengan prinsip dan nilai tentang pentingnya memenuhi kebutuhan nutrisi tubuh untuk mendukung kehidupan yang sehat, seimbang, dan bermakna. Kebiasaan ini bermanfaat untuk menjaga kesehatan fisik sebagai investasi jangka panjang, memaksimalkan potensi tubuh dan pikiran, menjaga tubuh tetap sehat sebagai tanggung jawab individu, serta meningkatkan kemandirian.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:30:03','2026-04-06 16:34:56'),(7,5,'GEMAR BELAJAR','Kebiasaan gemar belajar adalah kebiasaan yang sangat penting dalam perkembangan pribadi dan akademis. Kebiasaan ini bermanfaat untuk mengembangkan diri,  menumbuhkan kreativitas dan imajinasi, menemukan kebenaran dan pengetahuan, serta membentuk kerendahan hati dan rasa empati.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:30:27','2026-04-06 16:35:12'),(8,6,'BERMASYARAKAT','Kebiasaan bermasyarakat adalah perilaku terlibat dalam kegiatan sosial, budaya, atau lingkungan di komunitas tempat tinggal seseorang. Kebiasaan ini bermanfaat untuk menumbuhkembangkan nilai gotong royong, kerja sama, saling menghormati, toleransi, keadilan, dan kesetaraan, serta meningkatkan tanggung jawab terhadap lingkungan, dan rasa sekaligus menciptakan kegembiraan.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:31:33','2026-04-06 16:35:37'),(9,7,'TIDUR CEPAT','Tidur cepat merupakan kebiasaan tidur tepat waktu di malam hari pada waktunya sesuai usia anak agar dapat bangun pagi. Kebiasaan tidur cepat ini dipengaruhi waktu ideal yang dibutuhkan anak. Jika merujuk pada National Sleep Foundation yang dikutip halodoc.com, waktu tidur yang ideal berdasarkan kelompok usia adalah sebagai berikut.','bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:31:56','2026-04-06 16:36:11'),(10,8,'MENTORING',NULL,'bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:32:14','2026-03-30 13:53:19'),(12,9,'HADIR SETIAP SABTU',NULL,'bg-indigo-500','daily',1,NULL,NULL,'2026-03-11 16:33:50','2026-03-30 13:53:19');
/*!40000 ALTER TABLE `habits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_feedbacks`
--

DROP TABLE IF EXISTS `mentor_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor_feedbacks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` bigint unsigned NOT NULL,
  `mentor_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `feedback_date` date NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mentor_feedbacks_class_id_foreign` (`class_id`),
  KEY `mentor_feedbacks_mentor_id_foreign` (`mentor_id`),
  KEY `mentor_feedbacks_student_id_foreign` (`student_id`),
  CONSTRAINT `mentor_feedbacks_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mentor_feedbacks_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mentor_feedbacks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_feedbacks`
--

LOCK TABLES `mentor_feedbacks` WRITE;
/*!40000 ALTER TABLE `mentor_feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentor_feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_01_09_232438_create_habits_table',1),(5,'2026_01_09_232439_create_habit_logs_table',1),(6,'2026_01_12_185602_create_permission_tables',1),(7,'2026_01_12_185716_create_student_guardians_table',1),(8,'2026_01_12_185718_create_classrooms_tables',1),(9,'2026_01_25_074004_update_schema_for_mvp',1),(10,'2026_01_26_084718_create_student_profiles_table',1),(11,'2026_01_26_085533_create_genetic_types_table',1),(12,'2026_01_26_085533_replace_genetic_type_with_id_in_users_table',1),(13,'2026_01_31_081951_create_habit_user_table',1),(14,'2026_03_02_192341_create_branches_table',1),(15,'2026_03_17_100204_create_attendances_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(2,'App\\Models\\User',4),(2,'App\\Models\\User',5),(2,'App\\Models\\User',6),(2,'App\\Models\\User',11),(2,'App\\Models\\User',12),(2,'App\\Models\\User',16),(2,'App\\Models\\User',17),(2,'App\\Models\\User',18),(2,'App\\Models\\User',22),(3,'App\\Models\\User',26),(3,'App\\Models\\User',27),(3,'App\\Models\\User',28),(3,'App\\Models\\User',29),(3,'App\\Models\\User',30),(3,'App\\Models\\User',31),(3,'App\\Models\\User',32),(3,'App\\Models\\User',33),(3,'App\\Models\\User',34),(3,'App\\Models\\User',35),(3,'App\\Models\\User',36),(3,'App\\Models\\User',37),(3,'App\\Models\\User',38),(3,'App\\Models\\User',39),(3,'App\\Models\\User',40),(3,'App\\Models\\User',41),(3,'App\\Models\\User',42),(3,'App\\Models\\User',43),(3,'App\\Models\\User',44),(3,'App\\Models\\User',46),(3,'App\\Models\\User',47),(3,'App\\Models\\User',48),(2,'App\\Models\\User',50),(3,'App\\Models\\User',51),(3,'App\\Models\\User',52),(3,'App\\Models\\User',53),(3,'App\\Models\\User',54),(3,'App\\Models\\User',56),(3,'App\\Models\\User',57),(3,'App\\Models\\User',58),(3,'App\\Models\\User',59),(3,'App\\Models\\User',60),(3,'App\\Models\\User',61),(3,'App\\Models\\User',62),(3,'App\\Models\\User',63),(3,'App\\Models\\User',64),(3,'App\\Models\\User',65),(3,'App\\Models\\User',66),(3,'App\\Models\\User',67),(3,'App\\Models\\User',68),(3,'App\\Models\\User',69),(3,'App\\Models\\User',70),(3,'App\\Models\\User',71),(3,'App\\Models\\User',72),(3,'App\\Models\\User',74),(3,'App\\Models\\User',75),(2,'App\\Models\\User',76),(3,'App\\Models\\User',77),(3,'App\\Models\\User',78),(3,'App\\Models\\User',79);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','web','2026-02-19 18:01:19','2026-02-19 18:01:19'),(2,'mentor','web','2026-02-19 18:01:19','2026-02-19 18:01:19'),(3,'student','web','2026-02-19 18:01:19','2026-02-19 18:01:19');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('d15Id5f5BKI6b7dqQ4Gh2mahHLhPOKK5fN9rd4te',77,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoibUthcWh6alVtbjlDeUFvYjc5ZExYQ21rZkh5aEdQU3VNajFKRlZZQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjc3O30=',1775518673),('VaXtfhOeCxwLT4cXN6cOS0KsvO0apbAVwPTOdi1R',1,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','YTo4OntzOjY6Il90b2tlbiI7czo0MDoiTndUVDVNN1RSWkdZTUtmTmdmanB5QkFnMGN3ZUw0M1FyOVJBOXBTOSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM0OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYWRtaW4vbWVudG9yIjtzOjU6InJvdXRlIjtzOjM3OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMubWVudG9yLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiMWZiNDMwNjZhYjhhZWNmMmU4M2NhZGM5Njc5OTliZGJkNzY2NjE0NWE4NWU1NWFlY2QxYTRjODg0MmRlNTNiNyI7czo4OiJmaWxhbWVudCI7YTowOnt9czo2OiJ0YWJsZXMiO2E6MTp7czo0MToiOGZmZDg5ZmE4YWExZjM4NTEzMWU0MmMyZTk5OTY5NGJfcGVyX3BhZ2UiO3M6MjoiMjUiO319',1775518644);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_guardians`
--

DROP TABLE IF EXISTS `student_guardians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_guardians` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint unsigned NOT NULL,
  `guardian_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_guardians_student_id_guardian_id_unique` (`student_id`,`guardian_id`),
  KEY `student_guardians_guardian_id_foreign` (`guardian_id`),
  CONSTRAINT `student_guardians_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_guardians_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_guardians`
--

LOCK TABLES `student_guardians` WRITE;
/*!40000 ALTER TABLE `student_guardians` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_guardians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_profiles`
--

DROP TABLE IF EXISTS `student_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `birth_date` date DEFAULT NULL,
  `school_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade_level` int DEFAULT NULL,
  `school_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_profiles_user_id_foreign` (`user_id`),
  CONSTRAINT `student_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_profiles`
--

LOCK TABLES `student_profiles` WRITE;
/*!40000 ALTER TABLE `student_profiles` DISABLE KEYS */;
INSERT INTO `student_profiles` VALUES (2,26,'2013-05-25','Karah','Jln karah',5,'SD','Mama Zah','0895342770603','2026-02-19 18:24:10','2026-03-12 14:49:32'),(3,27,'2026-03-09','Karah','Jln karah',5,'SD','Mam Az','0822132881113','2026-02-19 18:24:10','2026-03-12 14:47:54'),(4,28,'2014-01-23','Karah','Jln karah',5,'SD','Mama nes','085179873642','2026-02-19 18:24:11','2026-03-12 14:45:19'),(5,29,'2012-12-23','Karah','Jln karah',6,'SD','Mama Kez','+62 851-9834-4635','2026-02-19 18:24:11','2026-03-12 14:44:01'),(6,30,'2026-03-02','Karah','Jln karah',5,'SD','Mama Nes','085171173015','2026-02-19 18:24:12','2026-03-12 14:42:33'),(7,31,'2017-04-24','Karah','Jln karah',1,'SD','Mama Nes','+62 815-4748-0677','2026-02-19 18:24:12','2026-03-12 14:41:10'),(8,32,'2014-05-14','Karah','Jln karah',5,'SD','Sinta','081585242340','2026-02-19 18:24:13','2026-03-12 14:39:13'),(9,33,'2013-10-27','Karah','Jln karah',5,'SD','Mama Shelvy','+62 821-3144-3276','2026-02-19 18:24:13','2026-03-12 14:37:25'),(10,34,'2019-01-21','Karah','Jln karah',3,'SD','Mama Shelvy','+62 821-3144-3276','2026-02-19 18:24:14','2026-03-12 14:35:39'),(11,35,'2026-03-04','Karah','Jln karah',1,'SD','Sutanto','+62 881-0363-54807','2026-02-19 18:24:14','2026-03-12 14:33:19'),(12,36,'2026-03-13','Karah','Jln karah',6,'SD','Oraile','+62 812-3087-2277','2026-02-19 18:24:15','2026-03-12 14:31:25'),(13,37,'2012-08-23','Karah','Jln karah',6,'SD','Ely','+62 881-0363-54807','2026-02-19 18:24:15','2026-03-12 14:28:52'),(14,38,'2016-04-20','Karah','Jln karah',3,'SD','Ely','+62 881-0363-54807','2026-02-19 18:24:15','2026-03-12 14:27:01'),(15,39,'2018-10-29','Karah','Jln karah',1,'SD','Pak Agustinus','+62 881-0363-54807','2026-02-19 18:24:16','2026-03-12 14:25:25'),(16,40,'2014-04-18','Karah','Jln karah',5,'SD','Lhievan','+62 881-0363-54807','2026-02-19 18:24:16','2026-03-12 13:55:36'),(17,41,'2012-04-06','Karah','Jln karah',6,'SD','Lhievan','+62 881-0363-54807','2026-02-19 18:24:17','2026-03-12 14:04:56'),(18,42,'2014-06-08','Karah','Jln karah',4,'SD','Mama Nurlia','+62 881-0363-54807','2026-02-19 18:24:17','2026-03-12 14:02:58'),(19,43,'2026-03-15','Karah','Jln karah',2,'SMP','David Mulyono','+62 881-0363-54807','2026-02-19 18:24:17','2026-03-12 14:00:17'),(20,44,'2026-03-13','Karah','Jln karah',3,'SD','David Mulyono','+62 881-0363-54807','2026-02-19 18:24:18','2026-03-12 13:58:44'),(22,46,NULL,NULL,NULL,1,'SMP',NULL,'081233579446','2026-02-19 18:24:18','2026-02-19 18:24:18'),(23,47,NULL,NULL,NULL,4,'SD',NULL,'081233579446','2026-02-19 18:24:19','2026-02-19 18:24:19'),(24,48,NULL,NULL,NULL,3,'SD',NULL,'081233579446','2026-02-19 18:24:19','2026-02-19 18:24:19'),(26,52,'2013-12-28','SDN Karah ','jl Karah No 1',6,'SD','Bintarta','08977305654','2026-03-11 16:54:53','2026-03-11 16:54:53'),(27,53,'2018-12-17','SDN KARAH 1','JLN KARAH 9',1,'SD','Anugerah Kavilla Dewan','085812606295','2026-03-11 16:58:06','2026-03-11 16:58:06'),(28,54,'2014-06-03','SDN KARAH 1','Jln Karah 9',6,'SD','Agustinus Dito Purnomo','085812606295','2026-03-11 17:02:49','2026-03-11 17:02:49'),(30,56,'2018-03-21','SDN KARAH 1','Jl karah 9',1,'SD','Stefanus','085708508260','2026-03-11 17:12:14','2026-03-11 17:12:14'),(31,57,'2019-04-21','SDN KARAH 1 SURABAYA','JL KARAH 9',1,'SD','Even ','085808946978','2026-03-11 17:16:02','2026-03-11 17:16:02'),(32,58,'2014-03-22','SDN KARAH 1 SURABAYA','Jl Karah 9',6,'SD','Petrus Hartono','085808946978','2026-03-11 23:00:43','2026-03-11 23:00:43'),(33,59,'2020-12-07','Bebekan Jagalan','SDN SIDOARJO',-1,'SD','Dedy Ferdianto','087809192038','2026-03-11 23:10:40','2026-03-11 23:10:40'),(34,60,'2017-09-25','SDN Ketegan','jl sidoarjo',1,'SD','Fatimah Tuzuhroh','087809192038','2026-03-11 23:15:53','2026-03-11 23:15:53'),(35,61,'2010-12-26','SMP KEJAR B','Sekolah kejar paket',1,'SMP','Ardianus mampo','082331009826','2026-03-12 01:46:40','2026-03-12 01:46:40'),(36,62,'2018-03-14','SDN KARAH 3','Ketintang Selatan 3 karah',3,'SD','Ervin Melkianto Liufeto','083845620502','2026-03-12 01:50:50','2026-03-12 01:50:50'),(37,63,'2015-11-01','SDN KARAH 1 SURABAYA','jl karah 9',4,'SD','Elki Jermias Dethan','085232525734','2026-03-12 01:56:25','2026-03-12 01:56:25'),(38,64,'2007-07-02','SMA BANGKINGAN','JL BANGKINGAN',2,'SMA','Yuliana Reni','082331009826','2026-03-12 02:01:47','2026-03-12 02:01:47'),(39,65,'2017-01-26','SD Petigen 1 Driyorejo','jln petigen',2,'SD','Ardianus','082338889817','2026-03-12 02:07:22','2026-03-12 02:07:22'),(40,66,'2010-02-08','HS Lontar Surabaya','Jk Lontar Surabaya',1,'SMA','Reni','082338889817','2026-03-12 02:10:36','2026-03-12 02:10:36'),(41,67,'2009-12-30','SMP FARMASI SEKESAL','JLN GOLF NO 1',1,'SMA','Suwito','081230553676','2026-03-12 02:15:08','2026-03-12 02:15:08'),(42,68,'2012-12-28','SMP YANTO YOSEF','JLN JOYOBOYO',1,'SMP','Hendriek','08563370609','2026-03-12 02:19:07','2026-03-12 02:19:07'),(43,51,'2008-07-09','karah','karah',3,'SD','ibu','08725363738','2026-03-12 02:24:15','2026-03-12 02:24:15'),(44,69,'0006-05-04','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',5,'SD','Bintarta','08977305654','2026-03-12 02:26:17','2026-03-12 02:26:17'),(45,70,'2014-06-05','SDN KARAH 1 SURABAYA','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',5,'SD','Petrus Hartono','085808946978','2026-03-12 02:29:56','2026-03-12 02:29:56'),(46,71,'2017-02-25','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',3,'SD','Bintarta','08977305654','2026-03-12 02:31:17','2026-03-12 02:31:17'),(47,72,'2018-06-03','SDN KARAH 1 SURABAYA','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',3,'SD','Bintarta','08977305654','2026-03-12 02:33:52','2026-03-12 02:33:52'),(49,74,'2016-05-03','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',3,'SD','Bintarta','085808946978','2026-03-12 02:38:43','2026-03-12 02:38:43'),(50,75,'2008-02-04','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',4,'SD','Bintarta','085808946978','2026-03-12 02:45:15','2026-03-12 02:45:15'),(51,77,'2000-03-18','Ini contoh Sekolah','Ini contoh Alamat',10,'SMA','Theo','0812345678','2026-03-19 03:04:30','2026-03-19 03:04:30'),(52,78,'2008-05-04','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',6,'SD','Petrus Hartono','08977305654','2026-03-19 15:40:15','2026-03-19 15:40:15'),(53,79,'2009-08-07','SDN Karah ','Jl. Ketintang, Ketintang, Kec. Gayungan, Surabaya, Jawa Timur 60231',6,'SD','Bintarta','085808946978','2026-03-19 15:47:57','2026-03-19 15:47:57');
/*!40000 ALTER TABLE `student_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `genetic_type_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_genetic_type_id_foreign` (`genetic_type_id`),
  CONSTRAINT `users_genetic_type_id_foreign` FOREIGN KEY (`genetic_type_id`) REFERENCES `genetic_types` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin','admin@admin.com','2026-02-19 18:01:19','$2y$12$YpyGjVe1YbM8EyqyrKUs5ewH6YRTr2O3kFtNdMbn5MTfYCM8odOt6',NULL,'2026-02-19 18:01:19','2026-02-19 18:01:19',NULL),(2,'Theodorus Patrick','Theodorus_MentorRB24','theodorptrck@gmail.com','2026-02-19 18:01:19','$2y$12$lTLxkGzU2cAjS3Gi6Om6X.8wut9K6MN/yZF0lF85IkIkqtaL9KBvO',NULL,'2026-02-19 18:01:19','2026-03-10 22:20:33',NULL),(4,'Patricia Alenski Wibisono','Alen_MentorRB26','patriciaalenski2212@gmail.com','2026-02-19 18:01:20','$2y$12$if2Rs8LweZa.gk4GzPDStOLN0OQ1UloVpWUWMp1K40NuNNPFhr3/a','NRiGR8wWKK0sIzm7p5rGPsPwDiebdDDx1woBXRqJGXuARUKu7T0i56zDORbz','2026-02-19 18:01:20','2026-03-10 23:15:02',NULL),(5,'Gladwin Sarototonafo Marundruri','Gladwin_MentorRB26','gladwinpython@gmail.com','2026-02-19 18:01:21','$2y$12$BSLjnJS9S45WQy.0hFwDse3/ztZiKOlBQ5wKjQ/m3MojdpkU4TON6','lC9znLjAtRTx2u2ybcX7j9SWmwj0eJnre1aUThAOWaqoQUo98ucn48np2tS0','2026-02-19 18:01:21','2026-03-10 22:48:02',NULL),(6,'Charlie Saputra Waluyo','Charlie_MentorRB26','charliesaputrawaluyo123@gmail.com','2026-02-19 18:01:21','$2y$12$m4CQdlhU/Sw1S1JAf1mTFeAYc5607GZHUegK.iKuH.z6l58uBqFBK','0hmzFIoMc1J8pCmm5dhIOLqtFH0OlhGQMTfb8xzhN40aFt0H8uAd2JUzlQtj','2026-02-19 18:01:21','2026-03-10 22:47:31',NULL),(11,'Fabian Christian Dhinata','Fabian_MentorRB26','fabianchristian123@gmail.com','2026-02-19 18:01:23','$2y$12$1tjT8ZCWsQe7oFhk3BWmZ.BQVgpqViErjbbOzTIlLVR7fuJUiyuWW',NULL,'2026-02-19 18:01:23','2026-03-10 22:46:29',NULL),(12,'Renov Satulo Zebua','Renov_MentorRB26','renovsatulo@gmail.com','2026-02-19 18:01:23','$2y$12$.r2QCoZGzNytvoO9hEGcgeSxU5MlnEf5d.e4AcF6LKsUqFqxXjAVS','RCV7eHCdTRtlUYO6npqJN7Pnizu9b72nWk5tQI08Cn4tCLBmxsGMZqlkSRgt','2026-02-19 18:01:23','2026-03-10 22:34:37',NULL),(16,'Mikhael Yuli Ananda Elvan Permana','Mikhael_MentorRB26','mikhaelyuliaep.flats47@gmail.com','2026-02-19 18:01:24','$2y$12$zKoQFqa1YtveDtouLHlS3OFiEJRTyZEd/j8jds9ABbKYQbjhDPlHm',NULL,'2026-02-19 18:01:24','2026-03-10 22:38:33',NULL),(17,'Earl Oswald Pangelah','Oswald_MentorRB25','oswaldpangelah@gmail.com','2026-02-19 18:01:25','$2y$12$sB1zTWfJO8.XO4K5yGzGueBJgaOoMfCxirdRL.HInEmWe2Fx6saFm','vKcH1e556KvpxhUW8l0vtVr1sI15EnpLxuU2VrCtfVILAGAw4YTVJYtOwcdW','2026-02-19 18:01:25','2026-03-10 22:39:54',NULL),(18,'Margareth Thatchert','Margareth_MentorRB25','mthatchert@gmail.com','2026-02-19 18:01:25','$2y$12$6mM5z1gYrAapxtM8UXkOX.5MGEpJJX//HrSBYgtflCTNKhPTHg0r.',NULL,'2026-02-19 18:01:25','2026-03-13 00:32:23',NULL),(22,'Artha Novelina Sianipar','Artha_MentorRB25','arthaartha2911@gmail.com','2026-02-19 18:01:27','$2y$12$nvOaTZ2KTMAGzbq2AMxrmePxMkXb6oyE6V/NW/MDkVHqjzQsS5NyG',NULL,'2026-02-19 18:01:27','2026-03-13 00:33:57',NULL),(26,'Ad. Zahira','Zahira_SiswaRB','Zahira_SiswaRB@gmail.com','2026-02-19 18:24:10','$2y$12$Mg.p7cWiVQOyuAp.KCWqseyNBNQavfM5eHKVOP53Btizccnug9WW2',NULL,'2026-02-19 18:24:10','2026-03-12 14:49:33',1),(27,'Michayla Queen Azzhra','Azzhra_SiswaRB','Azzhra_SiswaRB@gmail.com','2026-02-19 18:24:10','$2y$12$pLMU0CvmRFtYOMCRG5sdkORjdbg23PycI29.k2gWSb45BUOSpjRUm',NULL,'2026-02-19 18:24:10','2026-03-12 14:47:55',3),(28,'Neshellya Ery Friestya','Neshellya_SiswaRB','Neshellya_SiswaRB@gmail.com','2026-02-19 18:24:11','$2y$12$QWOLk4T.BsFK6JUlAvW9i.NPO3hvgzx5BCbVZcux709qcNVo2JFiG',NULL,'2026-02-19 18:24:11','2026-03-12 14:45:19',5),(29,'Desty keyza angraini','Keyza_SiswaRB','Keyza_SiswaRB@gmail.com','2026-02-19 18:24:11','$2y$12$nJU6uegzZX3pHHI9pqA7v.BWP5LuXNo5Y5VkPaWnteTerKitsRG7O',NULL,'2026-02-19 18:24:11','2026-03-12 14:44:01',3),(30,'Dewi Kayla Putri Ardiansyah','Dewi_SiswaRB','Dewi_SiswaRB@gmail.com','2026-02-19 18:24:12','$2y$12$CuqOB42JIo21XJgeB8i2v.k3Kdl/xOrXM6vPk5CwC3Eeh1KHmYdge',NULL,'2026-02-19 18:24:12','2026-03-12 14:42:33',3),(31,'Rafa Eri Mahendra','Rafa_SiswaRB','Rafa_SiswaRB@gmail.com','2026-02-19 18:24:12','$2y$12$xnfhgyVsSr8Xh3UMCYaKF.KfGbqz4N.2cBN/5/ngc9Ys50xMT5NsO','g6UFeBaOZj2SaaFr11A4zxjf3cPMmZNlxV0JOHKwJwcBZzcEkK39Jcpp79Up','2026-02-19 18:24:12','2026-03-12 14:41:10',5),(32,'Arsinta Widya Ningtyas','Arshinta_SiswaRB','Arshinta_SiswaRB@gmail.com','2026-02-19 18:24:13','$2y$12$Jg8V5GarqJEnk8b6vX0dreG/xoNBdZi42mlprDbQlF4n5fIHga2/S',NULL,'2026-02-19 18:24:13','2026-03-12 14:39:13',1),(33,'Shelvy Arifiani','Shelvy_SiswaRB','Shelvy_SiswaRB@gmail.com','2026-02-19 18:24:13','$2y$12$Xlts6Z8hbs6otkT3lHwHm.Zc5Azn6lYPWiuftYm4VOYHjONasktyu',NULL,'2026-02-19 18:24:13','2026-03-12 14:37:26',2),(34,'Muhamad alif ilham','Ilham_SiswaRB','Ilham_SiswaRB@gmail.com','2026-02-19 18:24:14','$2y$12$65Q4ulx7atnSDFGPssIUT.6EtVb9iBGYiPezlv2o3vAhpII7BhObq',NULL,'2026-02-19 18:24:14','2026-03-12 14:35:39',5),(35,'Kayla','Kayla_SiswaRB','Kayla_SiswaRB@gmail.com','2026-02-19 18:24:14','$2y$12$35hOyWwN3/r.8Bz9l5PkXeGKhX19xFhjE3gIRBoxorR1CgQqt/zQC',NULL,'2026-02-19 18:24:14','2026-03-12 14:33:19',2),(36,'Michele','Michele_SiswaRB','Michele_SiswaRB@gmail.com','2026-02-19 18:24:15','$2y$12$fr.KOyBtCGAm.Y25v6XnXeFZ4u.024ebAFhPjbJnexFs8JCckqqci',NULL,'2026-02-19 18:24:15','2026-03-12 14:31:25',5),(37,'Marcel','Marshel_SiswaRB','Marshel_SiswaRB@gmail.com','2026-02-19 18:24:15','$2y$12$/qusx39Wba2z1V.J0rP07e3HQgKBmfrZRBZIigg/DvxT/8xSOmjYq',NULL,'2026-02-19 18:24:15','2026-03-12 14:28:52',1),(38,'Helen','Helen_SiswaRB','Helen_SiswaRB@gmail.com','2026-02-19 18:24:15','$2y$12$yrhvK6/.kN42qrLegLDoMee8A5RCsj4KQsDwxXzEdbMTp.75hcJvC',NULL,'2026-02-19 18:24:15','2026-03-12 14:27:02',3),(39,'Meira','Meira_SiswaRB','meira_SiswaRB@gmail.com','2026-02-19 18:24:16','$2y$12$dhJ434JgEDDfnE5lJQOHl.fN9gzvaFxSqTaSUaSZSOzT9TWzVgevK','EHxKib0FhZxpmg205gdgRPHUIR61jGROcupQOB6W6LHKCGfe6x1jD65mmJjf','2026-02-19 18:24:16','2026-03-12 14:25:25',2),(40,'Benson','Benson','Benson_SiswaRB@gmail.com','2026-02-19 18:24:16','$2y$12$xteE3D2IrkhVm8nFXqPCB.H0pVQAGvC43W38FTlTnBgNYaIXgWdh.',NULL,'2026-02-19 18:24:16','2026-03-12 13:55:36',1),(41,'Easter','Easter_SiswaRB','Easter_SiswaRB@gmail.com','2026-02-19 18:24:17','$2y$12$X1.kf6RFwlHFx8XbXx/1cehSntIq2tKJoSmzDcP/NxEvRYsI6538q',NULL,'2026-02-19 18:24:17','2026-03-12 14:04:57',1),(42,'Nurlia','Nurlia_SiswaRB','Nurlia_SiswaRB@gmail.com','2026-02-19 18:24:17','$2y$12$vNWnfG61jL7zpEnxFFDzTewSWyWESRenokLH2jUf9c0qXi0zJtD6S',NULL,'2026-02-19 18:24:17','2026-03-12 14:02:58',5),(43,'Dendi Mulyono','Dendi_SiswaRB','Dendi_SiswaRB@gmail.com','2026-02-19 18:24:17','$2y$12$vPS8WP0gqPzcBmjeSQ/sxuCwUu58sxLQryqT34eo2/m7adaciGkha',NULL,'2026-02-19 18:24:17','2026-03-12 14:00:18',3),(44,'Daniel Mulyono','Daniel_SiswaRB','daniel_SiswaRB@gmail.com','2026-02-19 18:24:18','$2y$12$FxDNkDYkRD6oxxI71UitZe9Dje2/P5bHJs4uSKGG7alvXNBAJ18A2',NULL,'2026-02-19 18:24:18','2026-03-12 13:58:44',3),(46,'Moscha Apricilliya Suhatmoko','moscha_apricilliya_suhatmoko','moscha_apricilliya_suhatmoko@siswa.com','2026-02-19 18:24:18','$2y$12$OfaUGX3kMsdgG3g3992GZuGIacaNvY9AlLkuXfj6JIiv8qtSOjmCO',NULL,'2026-02-19 18:24:18','2026-02-19 18:24:18',NULL),(47,'Sofhia Celiya Suhatmoko','sofhia_celiya_suhatmoko','sofhia_celiya_suhatmoko@siswa.com','2026-02-19 18:24:19','$2y$12$OwQXqXby3aOqntBo5TjQXelR5jOfl5xwSjkfMoLh9bxdGHRWVDIk.',NULL,'2026-02-19 18:24:19','2026-02-19 18:24:19',NULL),(48,'Daniel Aliando Suhatmoko','daniel_aliando_suhatmoko','daniel_aliando_suhatmoko@siswa.com','2026-02-19 18:24:19','$2y$12$gPqfXiENKJpcWou.wE/29eQpyPWoc0Zes2WWms1LRC2HRBuwCA3BW',NULL,'2026-02-19 18:24:19','2026-02-19 18:24:19',NULL),(50,'Tiara Analita Zebua','Tiara_MentorRB24','tiaraanalisa@gmail.com',NULL,'$2y$12$tW3egoO1yUzuLSlYtR8rOus4yYnZV.fMNmDEuJM0U7uybeCkM8jDC','iC6XMRAQmjaNg0OZuAKseGZhnrw2uRxSTzN9thuUhXT5c40wdxZvukUr5t3X','2026-03-10 14:30:55','2026-03-10 22:45:11',4),(51,'Shellona','Shellona_SiswaRB','Shellona_SiswaRB@gmail.com',NULL,'$2y$12$1YsawwhHi0xSretM3u/NW.RhbpgcFv/ntdDKaSooibW5Ot7o6efOq',NULL,'2026-03-10 14:37:15','2026-03-12 02:24:15',5),(52,'Rayi Pambayun Astuningtyas','Rayi_SiswaRB','Rayi_SiswaRB@gmail.com',NULL,'$2y$12$7W9lw2ynZPQ2nvsdJxG/y.Mx0qEbS5dXTgpLi2bhONmLTL/0uZ..y','siW8k2oqh9hOmqKqGWR6Kp6zpF5Vu9vHXe3d407qx9UEX3AaMTPsrPoZ40cX','2026-03-11 16:54:53','2026-03-11 16:54:53',5),(53,'Maria Pambayun Astuningtyas','Maria_SiswaRB','Maria_SiswaRB@gmail.com',NULL,'$2y$12$UdZY6wLcD7Ge3.f3RaIXH.Od/D1dUvD2TtgJSYQSavQuZMqO3PJYK',NULL,'2026-03-11 16:58:06','2026-03-11 16:58:06',4),(54,'Maria Ardella Putri Kirana','Ardella_SiswaRB','Ardella_SiswaRB@gmail.com',NULL,'$2y$12$aITamgLrZxxUiFZ/B07SDODyQDGgXHMbhYSXb..RF4JQ4piFxuXP6',NULL,'2026-03-11 17:02:49','2026-03-11 17:02:49',1),(56,'Ebenhaezer Steven JR Santoso','Ebenhaezer_SiswaRB','Ebenhaezer_SiswaRB@gmail.com',NULL,'$2y$12$egO5AX1VkfZOJe1KZ7layepVcdKk/1RjGtqH9UCItl3zyByfyISw6',NULL,'2026-03-11 17:12:14','2026-03-11 17:12:14',2),(57,'Kairos Steven JR Santoso','Kairos_SiswaRB','Kairos_SiswaRB@gmail.com',NULL,'$2y$12$nFq7jww5f1GEiZ3AHgIs5e1A6Xv/Ghse29rQ.svkJlphS21eNKML.',NULL,'2026-03-11 17:16:02','2026-03-11 17:16:02',4),(58,'Jeremiah Kevin Kendio','Jeremiah_SiswaRB','Jeremiah_SiswaRB@gmail.com',NULL,'$2y$12$Ljdc.ZuEqpPSxiViaI0YIenK.WSueFb2wEwhvamUWLM8Qn9M6dVJq',NULL,'2026-03-11 23:00:43','2026-03-11 23:00:43',3),(59,'Aisyah Almayrha Ferdianto','Aisyah_SiswaRB','Aisyah_SiswaRB@gmail.com',NULL,'$2y$12$Pn5miqPzKcQJBr2/wbO0OuIvq2FBkKqQ7O1dq9RWZBHCHhA7jmEXu',NULL,'2026-03-11 23:10:40','2026-03-11 23:10:40',1),(60,'Aflah Sakha Ferdianto','Aflah__SiswaRB','Aflah_SiswaRB@gmail.com',NULL,'$2y$12$iQKBvCV58.uB5TtMs78dQORrgwqp8DcCqeIqpm8qShnhgQMqvuL3i',NULL,'2026-03-11 23:15:53','2026-03-11 23:15:53',2),(61,'Letisya Tasya Veronica','Letisya_MentorRB26','Letisya_SiswaRB@gmail.com',NULL,'$2y$12$DB3V/j.Sf2oZptiPjX4K.uRp9QFqXla5RrFH5AFQ8ntKnquPp5dUO',NULL,'2026-03-12 01:46:40','2026-03-12 01:46:40',1),(62,'Javier Marcello Putra Liufeto','Javier_SiswaRB','javier_siswarb@gmail.com',NULL,'$2y$12$jzwhbHHGuIc4YCjwFlJhyeC/LLeNjOByjqNVDncSUWZi7ooj7DNx2','OxjH47feg324zxWBo40z84a9hgH2w8ovRMhejkdcUUp3zgFz9BDoG6fO3KuP','2026-03-12 01:50:50','2026-03-25 12:48:18',5),(63,'Mario Bezaleel Dethan','Mario_SiswaRB','Mario_SiswaRB@gmail.com',NULL,'$2y$12$zNdyv5fCixGg1.wi06QZwuux6p6wUfKhhLjKW/PueU6yDV7gYza22','eO9YAj0I0TX7pKglmH7DDlyybSVqETQAJxc9Zy1yYLXj9SXNPK3ascRRfZMw','2026-03-12 01:56:25','2026-03-12 01:56:25',3),(64,'Jonathan Tristan Enrico','Jonathan_SiswaRB','Jonathan_SiswaRB@gmail.com',NULL,'$2y$12$/Eyjge6YO5ITMoF3PB99IetulyI3.C8AQ0zpWEiIUhgpndST7J2oS',NULL,'2026-03-12 02:01:47','2026-03-12 02:01:47',4),(65,'Alisya Natania Joselin','Alisya_SiswaRB','Alisya_SiswaRB@gmail.com',NULL,'$2y$12$VtXdVBlDYXGHO8LdzdPgSOpshxqXDLyjnH22R9NxBv8Rjo8tM27Im',NULL,'2026-03-12 02:07:22','2026-03-12 02:07:22',5),(66,'Etryani Eltasari Eldy','Etryani_SiswaRB','Etryani_SiswaRB@gmail.com',NULL,'$2y$12$10.2Rpao.DEk3eOR5vAINuNQMdjs3Vr/vgLyPTKJH3rrZg5h0fbqW',NULL,'2026-03-12 02:10:36','2026-03-12 02:10:36',1),(67,'Kezia Mawar Kristina Rochmawati','Kezia_SiswaRB','Kezia_SiswaRB@gmail.com',NULL,'$2y$12$HPT5aFubDXe7/eLOyq9Bx.VNS7poNSCdPqN0E8G2EsDQSn1iUHgNa',NULL,'2026-03-12 02:15:08','2026-03-12 02:15:08',4),(68,'Nathanael bagaskara manik','Nathanael_SiswaRB','Nathanael_SiswaRB@gmail.com',NULL,'$2y$12$2a2f2HnKuuiu1jLCPogeSOSEJ0MZ7AQFH0rv6fR9GuPzf07Po3MOa',NULL,'2026-03-12 02:19:07','2026-03-12 02:19:07',2),(69,'Shellota','Shellota_SiswaRB','Shellota_SiswaRB@gmail.com',NULL,'$2y$12$1vBqjNQGlXgsZC0iqwLage3YPZq02/1zsYblEro9McYSgsC8WEXAm',NULL,'2026-03-12 02:26:17','2026-03-12 02:26:17',5),(70,'Albern','Albern_SiswaRB','Albern_SiswaRB@gmail.com',NULL,'$2y$12$F06EbFnGdx4cj5TGua2H7.yEN4BNxonU6YMN6WC8AZiqYE7LGlqTG',NULL,'2026-03-12 02:29:56','2026-03-12 02:29:56',3),(71,'Cleon','Cleon_SiswaRB','Cleon_SiswaRB@gmail.com',NULL,'$2y$12$z/k0PgnCES2imNNo2x4CTuW0hKNjmL0jvqrOWLx/Cd3q8eMNTDXFW',NULL,'2026-03-12 02:31:17','2026-03-12 02:31:17',5),(72,'Dilan','Dilan_SiswaRB','Dilan_SiswaRB@gmail.com',NULL,'$2y$12$ioXO53gQx6A2rIDa2SX28u6tqr8nDv4r61WcKJSX3/.P2d.ElGpIC',NULL,'2026-03-12 02:33:52','2026-03-12 02:33:52',1),(74,'Nadara','Nadara_SiswaRB','Nadara_SiswaRB@gmail.com',NULL,'$2y$12$eTVF0fO2bVtWB/VIQj8OIeR5LmMr7T8JU8D0jlajKsDhvjsviNbrC',NULL,'2026-03-12 02:38:43','2026-03-12 02:38:43',3),(75,'Sesil','Sesil_SiswaRB','Sesil_SiswaRB@gmail.com',NULL,'$2y$12$aug.G1zvf7sT1Nk5zYmsb.SbhyqeUWAZLaahPkBIe/X/Ssy.pK656',NULL,'2026-03-12 02:45:15','2026-03-12 02:45:15',3),(76,'Mentor','mentor@gmail.com','mentor@gmail.com',NULL,'$2y$12$Xvw9sqCwRl9ghc5GWlF8w.x4m75PtB2rzpLl2bIQpYT40V5SCPHtS',NULL,'2026-03-19 03:00:39','2026-03-19 03:00:39',NULL),(77,'Student','student@gmail.com','student@gmail.com',NULL,'$2y$12$x9cYRYOtgl6LoXUe/v90C.43GZlCuMG3Dol4uogF/aMmHA1XPUmhe',NULL,'2026-03-19 03:04:30','2026-03-19 03:04:30',4),(78,'Nalitha','NalithaSiswaRB','nalithasiswa_rb25@gmail.com',NULL,'$2y$12$Iqu9We2GGZHcIsj4ff4eHO6mpzzC5zSE1jsGV3CNSBT1yoo7hEOZe','ZPMSXjyxNCc3eXbgh0aqP7JAab6iW2hxRMBE3avGHu4xLPa5zxRB7fVhaUsz','2026-03-19 15:40:15','2026-03-25 12:46:21',5),(79,'Christian Bagus Suwito','Christian Bagus Suwito','ChristianBagusSRB26@gmail.com',NULL,'$2y$12$dYOesC2j9vDc5eK8ts0oX.e3CjuABhqxIjN9w4cddBGPXyev4vZUa',NULL,'2026-03-19 15:47:57','2026-03-19 15:47:57',5);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-07  6:38:35
