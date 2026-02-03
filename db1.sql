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
INSERT INTO `cache` VALUES ('jurnal-ykde-cache-spatie.permission.cache','a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}',1770184869);
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
-- Table structure for table `class_memberships`
--

DROP TABLE IF EXISTS `class_memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_memberships` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_id` bigint unsigned NOT NULL,
  `student_id` bigint unsigned NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `assigned_by_admin_id` bigint unsigned DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_memberships_class_id_student_id_unique` (`class_id`,`student_id`),
  KEY `class_memberships_student_id_foreign` (`student_id`),
  KEY `class_memberships_assigned_by_admin_id_foreign` (`assigned_by_admin_id`),
  CONSTRAINT `class_memberships_assigned_by_admin_id_foreign` FOREIGN KEY (`assigned_by_admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `class_memberships_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_memberships_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_memberships`
--

LOCK TABLES `class_memberships` WRITE;
/*!40000 ALTER TABLE `class_memberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_memberships` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_students`
--

LOCK TABLES `classroom_students` WRITE;
/*!40000 ALTER TABLE `classroom_students` DISABLE KEYS */;
INSERT INTO `classroom_students` VALUES (1,1,9,'2026-02-02 20:10:58','2026-02-02 20:10:58');
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  KEY `classrooms_teacher_id_foreign` (`mentor_id`),
  CONSTRAINT `classrooms_teacher_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` VALUES (1,'Kelas Test mentor',2,'2026-02-02 20:10:45','2026-02-02 20:10:45','Ini adalah contoh kelas','ACTIVE');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_reflections`
--

LOCK TABLES `daily_reflections` WRITE;
/*!40000 ALTER TABLE `daily_reflections` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genetic_types`
--

LOCK TABLES `genetic_types` WRITE;
/*!40000 ALTER TABLE `genetic_types` DISABLE KEYS */;
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
  `student_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `habit_categories_created_by_user_id_foreign` (`created_by_user_id`),
  KEY `habit_categories_updated_by_user_id_foreign` (`updated_by_user_id`),
  KEY `habit_categories_student_id_foreign` (`student_id`),
  CONSTRAINT `habit_categories_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habit_categories_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `habit_categories_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_categories`
--

LOCK TABLES `habit_categories` WRITE;
/*!40000 ALTER TABLE `habit_categories` DISABLE KEYS */;
INSERT INTO `habit_categories` VALUES (1,'Bangun',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(2,'Ibadah',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(3,'Olahraga',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(4,'Makan',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(5,'Belajar',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(6,'Bermasyarakat',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(7,'Tidur',NULL,NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL);
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
  `log_date` date NOT NULL,
  `status` enum('completed','skipped','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` bigint unsigned DEFAULT NULL,
  `logged_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `habit_logs_habit_id_date_unique` (`habit_id`,`log_date`),
  KEY `habit_logs_student_id_foreign` (`student_id`),
  CONSTRAINT `habit_logs_habit_id_foreign` FOREIGN KEY (`habit_id`) REFERENCES `habits` (`id`) ON DELETE CASCADE,
  CONSTRAINT `habit_logs_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_user`
--

LOCK TABLES `habit_user` WRITE;
/*!40000 ALTER TABLE `habit_user` DISABLE KEYS */;
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
  `student_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#4F46E5',
  `frequency` enum('daily','weekly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  `created_by_user_id` bigint unsigned DEFAULT NULL,
  `updated_by_user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `habits_user_id_foreign` (`student_id`),
  KEY `habits_category_id_foreign` (`category_id`),
  KEY `habits_created_by_user_id_foreign` (`created_by_user_id`),
  KEY `habits_updated_by_user_id_foreign` (`updated_by_user_id`),
  CONSTRAINT `habits_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `habit_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habits_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habits_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `habits_user_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habits`
--

LOCK TABLES `habits` WRITE;
/*!40000 ALTER TABLE `habits` DISABLE KEYS */;
INSERT INTO `habits` VALUES (1,9,'Complete Homework','Finish math assignment','#3B82F6','daily',1,'2026-01-31 05:44:33','2026-01-31 05:44:33',NULL,9,NULL),(2,NULL,'Bangun Routine','Default routine for Bangun','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',1,NULL,NULL),(3,NULL,'Ibadah Routine','Default routine for Ibadah','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',2,NULL,NULL),(4,NULL,'Olahraga Routine','Default routine for Olahraga','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',3,NULL,NULL),(5,NULL,'Makan Routine','Default routine for Makan','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',4,NULL,NULL),(6,NULL,'Belajar Routine','Default routine for Belajar','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',5,NULL,NULL),(7,NULL,'Bermasyarakat Routine','Default routine for Bermasyarakat','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',6,NULL,NULL),(8,NULL,'Tidur Routine','Default routine for Tidur','#10B981','daily',1,'2026-02-02 21:22:28','2026-02-02 21:22:28',7,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_01_09_232438_create_habits_table',1),(5,'2026_01_09_232439_create_habit_logs_table',1),(6,'2026_01_09_232441_create_habit_permissions_table',1),(7,'2026_01_12_185602_create_permission_tables',1),(8,'2026_01_12_185715_drop_social_tables',1),(9,'2026_01_12_185716_create_student_guardians_table',1),(10,'2026_01_12_185718_create_classrooms_tables',1),(11,'2026_01_25_074004_update_schema_for_mvp',1),(12,'2026_01_25_075641_refactor_habit_categories_table',1),(13,'2026_01_25_080306_refactor_habit_categories_v2',1),(14,'2026_01_26_082950_add_role_and_genetic_type_to_users_table',1),(15,'2026_01_26_084718_create_student_profiles_table',1),(16,'2026_01_26_085533_create_genetic_types_table',1),(17,'2026_01_26_085533_replace_genetic_type_with_id_in_users_table',1),(18,'2026_01_26_093246_drop_student_id_target_time_sort_order_from_habits_table',1),(19,'2026_01_31_032356_fix_habits_and_categories_structure',1),(20,'2026_01_31_081951_create_habit_user_table',1),(21,'2026_01_31_082310_migrate_existing_habits_to_pivot',1);
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
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(2,'App\\Models\\User',3),(2,'App\\Models\\User',4),(2,'App\\Models\\User',5),(2,'App\\Models\\User',6),(2,'App\\Models\\User',7),(2,'App\\Models\\User',8),(3,'App\\Models\\User',9);
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
INSERT INTO `roles` VALUES (1,'admin','web','2026-01-31 05:44:31','2026-01-31 05:44:31'),(2,'mentor','web','2026-01-31 05:44:31','2026-01-31 05:44:31'),(3,'student','web','2026-01-31 05:44:31','2026-01-31 05:44:31');
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
INSERT INTO `sessions` VALUES ('OoLg94UGEUeAGWAneqYZef4Qi13qBnz2bW365Evv',2,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiSlh2SHR4N2YzUXducHlVMDc3ZnJwWmVJN2VvZWRaYWI5SWN1Nkw4RCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZW50b3IvbXktY2xhc3Nlcy8xL2VkaXQiO3M6NToicm91dGUiO3M6NDE6ImZpbGFtZW50Lm1lbnRvci5yZXNvdXJjZXMubXktY2xhc3Nlcy5lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2Rhc2hib2FyZCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjQyZGYyYmYyYTJmYTkyODZlMDJkM2NmMDljZjdiZjFkMGIwNzNlMTg5YzExZDYxNjMzYzhlOWY0NDNhZTU4MTIiO30=',1770102082),('oQRzNn5DQ8uqf8i0a0J2Zt2DykYkdS2jDxUVwlCy',2,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTo3OntzOjY6Il90b2tlbiI7czo0MDoicFpUZ0MzSWl4b3ppaERzT1lrUnhMaU45ZER1V1Fralp4WlhtYWdsUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZW50b3IvbXktY2xhc3Nlcy8xL2VkaXQiO3M6NToicm91dGUiO3M6NDE6ImZpbGFtZW50Lm1lbnRvci5yZXNvdXJjZXMubXktY2xhc3Nlcy5lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2Rhc2hib2FyZCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjQyZGYyYmYyYTJmYTkyODZlMDJkM2NmMDljZjdiZjFkMGIwNzNlMTg5YzExZDYxNjMzYzhlOWY0NDNhZTU4MTIiO3M6ODoiZmlsYW1lbnQiO2E6MDp7fX0=',1770107500),('QlDE1ybtE9oNtQXduTNj0cMTMrVoOJ5Sm56rxika',2,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZVIxTFJUTGdldXNsQVJpa3RySlJtYTJmeEtrTFhaOFFVeThGc2xZVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZW50b3IvbXktY2xhc3Nlcy8xL2VkaXQiO3M6NToicm91dGUiO3M6NDE6ImZpbGFtZW50Lm1lbnRvci5yZXNvdXJjZXMubXktY2xhc3Nlcy5lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiNDJkZjJiZjJhMmZhOTI4NmUwMmQzY2YwOWNmN2JmMWQwYjA3M2UxODljMTFkNjE2MzNjOGU5ZjQ0M2FlNTgxMiI7czo4OiJmaWxhbWVudCI7YTowOnt9fQ==',1770108118),('WRACXjFp6R9yu9fJigSU46ghBGNpsnyNsm9hpwwk',2,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTo3OntzOjY6Il90b2tlbiI7czo0MDoidGp6alozY09lODYwTTVJdmM3MDQzdzFEU08zM1hJTG9rYUJ4ZXNGTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZW50b3IvbXktY2xhc3Nlcy8xL2VkaXQiO3M6NToicm91dGUiO3M6NDE6ImZpbGFtZW50Lm1lbnRvci5yZXNvdXJjZXMubXktY2xhc3Nlcy5lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2Rhc2hib2FyZCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjQyZGYyYmYyYTJmYTkyODZlMDJkM2NmMDljZjdiZjFkMGIwNzNlMTg5YzExZDYxNjMzYzhlOWY0NDNhZTU4MTIiO3M6ODoiZmlsYW1lbnQiO2E6MDp7fX0=',1770106383);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_profiles`
--

LOCK TABLES `student_profiles` WRITE;
/*!40000 ALTER TABLE `student_profiles` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin','admin@admin.com','2026-01-31 05:44:31','$2y$12$h8WnABXv.Dnj6WR9mI8mwO8H70YSxLKV5u7iuamPDfUfETcUmsKWy',NULL,'2026-01-31 05:44:31','2026-01-31 05:44:31',NULL),(2,'Mentor User','mentor','mentor@gmail.com','2026-01-31 05:44:31','$2y$12$mmkQVjlD9mUq4JbxzscL1OqjdcS3EyIuh4VPV6i5xWIlM6FfRCQGK','hIIhQ9WaGdJGu3ynnOGt8j2OfEYwJXYacaiSh2qdfYdbyQEBZfomNG93bIVX','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(3,'Mentor 5','mentor5','mentor5@gmail.com','2026-01-31 05:44:32','$2y$12$2Lb9cSpXdOtk5INHMIaJtu9Mjxs341nwzlqGxSFHlHEZUk/9msvsO','aECkSCmhUV','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(4,'Andreanne Balistreri','ndietrich','otilia96@example.net','2026-01-31 05:44:32','$2y$12$BV6WAjQqgiE0msCu4R6DIeYZ8tqsCOdHLdG7chxc2.8pNvTYE0j02','QQz0agrsmN','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(5,'Kay Mraz PhD','manuel83','yhagenes@example.com','2026-01-31 05:44:32','$2y$12$BV6WAjQqgiE0msCu4R6DIeYZ8tqsCOdHLdG7chxc2.8pNvTYE0j02','pAjv7o8EZi','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(6,'Prof. Geovanny Gusikowski III','koelpin.cullen','jkoss@example.org','2026-01-31 05:44:32','$2y$12$BV6WAjQqgiE0msCu4R6DIeYZ8tqsCOdHLdG7chxc2.8pNvTYE0j02','4GOcsXALir','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(7,'Kaylah Hickle','jared.little','roxanne.schinner@example.com','2026-01-31 05:44:32','$2y$12$BV6WAjQqgiE0msCu4R6DIeYZ8tqsCOdHLdG7chxc2.8pNvTYE0j02','XZmAGTov54','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(8,'Tomasa Orn','abbott.evelyn','gaetano05@example.com','2026-01-31 05:44:32','$2y$12$BV6WAjQqgiE0msCu4R6DIeYZ8tqsCOdHLdG7chxc2.8pNvTYE0j02','HuxCeQcKwA','2026-01-31 05:44:32','2026-01-31 05:44:32',NULL),(9,'Student User','student','student@gmail.com','2026-01-31 05:44:33','$2y$12$HO8PMNM4pv7nIZHQoxqdvutcZrPLIIMpHcrdaqQatfVLEYkSBlSnK','foaK4sGUku','2026-01-31 05:44:33','2026-01-31 05:44:33',NULL);
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

-- Dump completed on 2026-02-03 15:44:54
