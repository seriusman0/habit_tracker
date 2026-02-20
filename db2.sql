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
INSERT INTO `cache` VALUES ('jurnal-ykde-cache-spatie.permission.cache','a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}',1771660955);
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
INSERT INTO `classrooms` VALUES (1,'X-A',2,'2026-02-20 01:07:32','2026-02-20 01:07:32',NULL,'ACTIVE');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genetic_types`
--

LOCK TABLES `genetic_types` WRITE;
/*!40000 ALTER TABLE `genetic_types` DISABLE KEYS */;
INSERT INTO `genetic_types` VALUES (1,'Sensing','Focus on sensory details and concrete reality.','2026-02-20 01:06:26','2026-02-20 01:06:26'),(2,'Thinking','Analytical and logical decision making.','2026-02-20 01:06:26','2026-02-20 01:06:26'),(3,'Intuiting','Focus on possibilities, patterns, and future implications.','2026-02-20 01:06:26','2026-02-20 01:06:26'),(4,'Feeling','Decision making based on values and harmony.','2026-02-20 01:06:26','2026-02-20 01:06:26'),(5,'Instinct','Spontaneous and gut-driven reactions.','2026-02-20 01:06:26','2026-02-20 01:06:26');
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
INSERT INTO `habit_categories` VALUES (1,'Bangun',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(2,'Ibadah',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(3,'Olahraga',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(4,'Makan',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(5,'Belajar',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(6,'Bermasyarakat',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(7,'Tidur',NULL,NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habits`
--

LOCK TABLES `habits` WRITE;
/*!40000 ALTER TABLE `habits` DISABLE KEYS */;
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
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(2,'App\\Models\\User',3),(2,'App\\Models\\User',4),(2,'App\\Models\\User',5),(2,'App\\Models\\User',6),(2,'App\\Models\\User',7),(2,'App\\Models\\User',8),(2,'App\\Models\\User',9),(2,'App\\Models\\User',10),(2,'App\\Models\\User',11),(2,'App\\Models\\User',12),(2,'App\\Models\\User',13),(2,'App\\Models\\User',14),(2,'App\\Models\\User',15),(2,'App\\Models\\User',16),(2,'App\\Models\\User',17),(2,'App\\Models\\User',18),(2,'App\\Models\\User',19),(2,'App\\Models\\User',20),(2,'App\\Models\\User',21),(2,'App\\Models\\User',22),(2,'App\\Models\\User',23),(3,'App\\Models\\User',26),(3,'App\\Models\\User',27),(3,'App\\Models\\User',28),(3,'App\\Models\\User',29),(3,'App\\Models\\User',30),(3,'App\\Models\\User',31),(3,'App\\Models\\User',32),(3,'App\\Models\\User',33),(3,'App\\Models\\User',34),(3,'App\\Models\\User',35),(3,'App\\Models\\User',36),(3,'App\\Models\\User',37),(3,'App\\Models\\User',38),(3,'App\\Models\\User',39),(3,'App\\Models\\User',40),(3,'App\\Models\\User',41),(3,'App\\Models\\User',42),(3,'App\\Models\\User',43),(3,'App\\Models\\User',44),(3,'App\\Models\\User',45),(3,'App\\Models\\User',46),(3,'App\\Models\\User',47),(3,'App\\Models\\User',48),(3,'App\\Models\\User',49);
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
INSERT INTO `roles` VALUES (1,'admin','web','2026-02-20 01:01:19','2026-02-20 01:01:19'),(2,'mentor','web','2026-02-20 01:01:19','2026-02-20 01:01:19'),(3,'student','web','2026-02-20 01:01:19','2026-02-20 01:01:19');
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
INSERT INTO `sessions` VALUES ('irwuc4f5miTbRTWe0NBxhmAL3uMxT5a9XJWBRQ7B',1,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoibTFYTXcxVjFoWFlvd3ZxRmxFcjI0ZE5pbmVVdzVydmZidW1Xang0aCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi91c2VycyI7czo1OiJyb3V0ZSI7czozNjoiZmlsYW1lbnQuYWRtaW4ucmVzb3VyY2VzLnVzZXJzLmluZGV4Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiMWZiNDMwNjZhYjhhZWNmMmU4M2NhZGM5Njc5OTliZGJkNzY2NjE0NWE4NWU1NWFlY2QxYTRjODg0MmRlNTNiNyI7fQ==',1771574581);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_profiles`
--

LOCK TABLES `student_profiles` WRITE;
/*!40000 ALTER TABLE `student_profiles` DISABLE KEYS */;
INSERT INTO `student_profiles` VALUES (2,26,'2013-05-25',NULL,NULL,5,'SD',NULL,'0895342770603','2026-02-20 01:24:10','2026-02-20 01:24:10'),(3,27,NULL,NULL,NULL,5,'SD',NULL,'0822132881113','2026-02-20 01:24:10','2026-02-20 01:24:10'),(4,28,'2014-01-23',NULL,NULL,5,'SD',NULL,'085179873642','2026-02-20 01:24:11','2026-02-20 01:24:11'),(5,29,'2012-12-23',NULL,NULL,6,'SD',NULL,NULL,'2026-02-20 01:24:11','2026-02-20 01:24:11'),(6,30,NULL,NULL,NULL,5,'SD',NULL,'085171173015','2026-02-20 01:24:12','2026-02-20 01:24:12'),(7,31,'2017-04-24',NULL,NULL,1,'SD',NULL,NULL,'2026-02-20 01:24:12','2026-02-20 01:24:12'),(8,32,'2014-05-14',NULL,NULL,5,'SD',NULL,'081585242340','2026-02-20 01:24:13','2026-02-20 01:24:13'),(9,33,'2013-10-27',NULL,NULL,5,'SD',NULL,NULL,'2026-02-20 01:24:13','2026-02-20 01:24:13'),(10,34,'2019-01-21',NULL,NULL,NULL,'TKB',NULL,NULL,'2026-02-20 01:24:14','2026-02-20 01:24:14'),(11,35,NULL,NULL,NULL,NULL,'TKB',NULL,NULL,'2026-02-20 01:24:14','2026-02-20 01:24:14'),(12,36,NULL,NULL,NULL,6,'SD',NULL,NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15'),(13,37,'2012-08-23',NULL,NULL,6,'SD',NULL,NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15'),(14,38,'2016-04-20',NULL,NULL,3,'SD',NULL,NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15'),(15,39,'2018-10-29',NULL,NULL,1,'SD',NULL,NULL,'2026-02-20 01:24:16','2026-02-20 01:24:16'),(16,40,'2014-04-18',NULL,NULL,5,'SD',NULL,NULL,'2026-02-20 01:24:16','2026-02-20 01:24:16'),(17,41,'2012-04-06',NULL,NULL,6,'SD',NULL,NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17'),(18,42,'2014-06-08',NULL,NULL,4,'SD',NULL,NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17'),(19,43,NULL,NULL,NULL,2,'SMP',NULL,NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17'),(20,44,NULL,NULL,NULL,3,'SD',NULL,NULL,'2026-02-20 01:24:18','2026-02-20 01:24:18'),(21,45,NULL,NULL,NULL,2,'SMA',NULL,NULL,'2026-02-20 01:24:18','2026-02-20 01:24:18'),(22,46,NULL,NULL,NULL,1,'SMP',NULL,'081233579446','2026-02-20 01:24:18','2026-02-20 01:24:18'),(23,47,NULL,NULL,NULL,4,'SD',NULL,'081233579446','2026-02-20 01:24:19','2026-02-20 01:24:19'),(24,48,NULL,NULL,NULL,3,'SD',NULL,'081233579446','2026-02-20 01:24:19','2026-02-20 01:24:19'),(25,49,NULL,NULL,NULL,3,'SMA',NULL,NULL,'2026-02-20 01:24:20','2026-02-20 01:24:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin','admin@admin.com','2026-02-20 01:01:19','$2y$12$YpyGjVe1YbM8EyqyrKUs5ewH6YRTr2O3kFtNdMbn5MTfYCM8odOt6',NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(2,'Theodorus Patrick','theodorus_patrick','theodorus_patrick@email.com','2026-02-20 01:01:19','$2y$12$Tt.4.gwR5bv6Dsv.Lh1fX..B346zKWuzWoalbfEd5OdkbLB9Nnh4C',NULL,'2026-02-20 01:01:19','2026-02-20 01:01:19',NULL),(3,'Ade Puan','ade_puan','ade_puan@email.com','2026-02-20 01:01:20','$2y$12$puhOHiwEsmcp//v7gjGvj.nKVfbsgd.N7Y4IBQ2z.fe1ITLSHapz.',NULL,'2026-02-20 01:01:20','2026-02-20 01:01:20',NULL),(4,'Kristiani','kristiani','kristiani@email.com','2026-02-20 01:01:20','$2y$12$nfiaIb4/XLcR.KHciMva7Oc4t4CM9yMVnVgkFqZyCxd9ZdqWyV3p.',NULL,'2026-02-20 01:01:20','2026-02-20 01:01:20',NULL),(5,'Meidhora','meidhora','meidhora@email.com','2026-02-20 01:01:21','$2y$12$8PbJsGqwNscOx.Z6iff9a.dvCH9HWGkKVnS/We2Eb9KVSwq/LmFBS',NULL,'2026-02-20 01:01:21','2026-02-20 01:01:21',NULL),(6,'Widya','widya','widya@email.com','2026-02-20 01:01:21','$2y$12$GJ3sAMXV1OMLGxMPW/0ti.YflhX/Y34ER1uYVGVPhbauNlCMkqmuW',NULL,'2026-02-20 01:01:21','2026-02-20 01:01:21',NULL),(7,'Tabitha','tabitha','tabitha@email.com','2026-02-20 01:01:21','$2y$12$OkcAPs4pNw1eoW/v6vTOm.W7yeFKCQwoLxgzV4fvywP8DDo7ot2ca',NULL,'2026-02-20 01:01:21','2026-02-20 01:01:21',NULL),(8,'Tri','tri','tri@email.com','2026-02-20 01:01:22','$2y$12$UTL8sm.mqXxEDAi39lMzdeShSHvXYE9GjnHCaWreRdUhLxId/wMBK',NULL,'2026-02-20 01:01:22','2026-02-20 01:01:22',NULL),(9,'Ras Enchari','ras_enchari','ras_enchari@email.com','2026-02-20 01:01:22','$2y$12$SNCp79eOG7NmVkn.tcX8veoDfFaxYnF6VWoUcyZ9eACqQraRK8QO6',NULL,'2026-02-20 01:01:22','2026-02-20 01:01:22',NULL),(10,'Krisyanto Edo','krisyanto_edo','krisyanto_edo@email.com','2026-02-20 01:01:22','$2y$12$kGynmaP1/ppeo12oN4D6t.LDoS05QnzdB3lQQ5HxSv4QmQK.64.Lq',NULL,'2026-02-20 01:01:22','2026-02-20 01:01:22',NULL),(11,'Obaja','obaja','obaja@email.com','2026-02-20 01:01:23','$2y$12$NOTAxMvxlbpfGSEyjgukS.6mmZwZgajt5E9pbdkZrLkjnGuAOYEOi',NULL,'2026-02-20 01:01:23','2026-02-20 01:01:23',NULL),(12,'Amelia','amelia','amelia@email.com','2026-02-20 01:01:23','$2y$12$Z3Lg8kyFoUjS8diFCOV8ruEM.uL8WJiqTZcsr.47FR9JC4l94xY/e',NULL,'2026-02-20 01:01:23','2026-02-20 01:01:23',NULL),(13,'Della','della','della@email.com','2026-02-20 01:01:23','$2y$12$yjMiToXabaq90pYpSAoFo.mojiWV9mHwK9.cLpydN.7K6T/Tkn8UO',NULL,'2026-02-20 01:01:23','2026-02-20 01:01:23',NULL),(14,'Cecilia','cecilia','cecilia@email.com','2026-02-20 01:01:24','$2y$12$1MgAN40hESxRM50eriCAIOcsGTCBkBIdMHenwXhcRjzVzZ2X.iV8.',NULL,'2026-02-20 01:01:24','2026-02-20 01:01:24',NULL),(15,'Donfri','donfri','donfri@email.com','2026-02-20 01:01:24','$2y$12$85y4CedcL0P9mCyHZOlda.hGF31HQCjFu55uvkFJ6HQXjve1uxjiq',NULL,'2026-02-20 01:01:24','2026-02-20 01:01:24',NULL),(16,'Mikhael','mikhael','mikhael@email.com','2026-02-20 01:01:24','$2y$12$jJCkfVpxT.xEvyxmEQfhrOTLHa9/mxnYzeh6U1HjrW2ji2LQYoQlq',NULL,'2026-02-20 01:01:24','2026-02-20 01:01:24',NULL),(17,'Oswald','oswald','oswald@email.com','2026-02-20 01:01:25','$2y$12$Dnod78kBMlTrvZbAjD8ATeRJ2vqYKnuYacr9cjmDs.NRoNS329NGK',NULL,'2026-02-20 01:01:25','2026-02-20 01:01:25',NULL),(18,'Margareth','margareth','margareth@email.com','2026-02-20 01:01:25','$2y$12$nbGLN8hgSOQAE82NfVjv4OBIbMDIOMPCcy2Ewq/Gc7kWNWag.n/Ii',NULL,'2026-02-20 01:01:25','2026-02-20 01:01:25',NULL),(19,'Romario','romario','romario@email.com','2026-02-20 01:01:26','$2y$12$WZb64ClxjIlwueugXMvtJuRqrhqb4vOjA8n725kKzE/fd2XhPSXI.',NULL,'2026-02-20 01:01:26','2026-02-20 01:01:26',NULL),(20,'Naomi','naomi','naomi@email.com','2026-02-20 01:01:26','$2y$12$Tka3038odfju/1K/gWDxhuMazpPSEVrUzaC3Im907P5QMrQ6UXYZq',NULL,'2026-02-20 01:01:26','2026-02-20 01:01:26',NULL),(21,'Herdiyanto','herdiyanto','herdiyanto@email.com','2026-02-20 01:01:26','$2y$12$AUjF/pStZYOQQtUmRGepqOuDoiH9Smr7TMFQJyyKHJdtjzDxbZcyK',NULL,'2026-02-20 01:01:26','2026-02-20 01:01:26',NULL),(22,'Artha','artha','artha@email.com','2026-02-20 01:01:27','$2y$12$Z4ZRebq0qF5Mb9PGenHGZOumTrltVnHYRYG.53NwJoh2BMuz2GHXS',NULL,'2026-02-20 01:01:27','2026-02-20 01:01:27',NULL),(23,'Nethania','nethania','nethania@email.com','2026-02-20 01:01:27','$2y$12$VD.l81Jk5d8cVibaNg2DoOi5qnNIpzx3nU0Tsy.maJNJ5YddxHf8C',NULL,'2026-02-20 01:01:27','2026-02-20 01:01:27',NULL),(26,'Ad. Zahira','ad_zahira','ad_zahira@siswa.com','2026-02-20 01:24:10','$2y$12$eifQVEMGKWBE0XXd161TqevUFnxwiu0gfM2qmxOYCy9iEEkQOj/8q',NULL,'2026-02-20 01:24:10','2026-02-20 01:24:10',NULL),(27,'Michayla Queen Azzhra','michayla_queen_azzhra','michayla_queen_azzhra@siswa.com','2026-02-20 01:24:10','$2y$12$Fr.wghcce0zKaL2uqI9NOenmZdzVfysePNQCQm40P4Pl6.3bOwP7C',NULL,'2026-02-20 01:24:10','2026-02-20 01:24:10',NULL),(28,'Neshellya Ery Friestya','neshellya_ery_friestya','neshellya_ery_friestya@siswa.com','2026-02-20 01:24:11','$2y$12$OPMycqum4ilTtKgLQzhINeKaqt/rFBRuaQIAPIO8k1zh/ztHv828W',NULL,'2026-02-20 01:24:11','2026-02-20 01:24:11',NULL),(29,'Desty keyza angraini','desty_keyza_angraini','desty_keyza_angraini@siswa.com','2026-02-20 01:24:11','$2y$12$O2IjJpwJRpo8fLkhoJUyAODGC44cPjFic9mHYo8G7ifaQdHxqfBqa',NULL,'2026-02-20 01:24:11','2026-02-20 01:24:11',NULL),(30,'Dewi Kayla Putri Ardiansyah','dewi_kayla_putri_ardiansyah','dewi_kayla_putri_ardiansyah@siswa.com','2026-02-20 01:24:12','$2y$12$F/FUtNGPd9HY4Az7pGQr9ul31n4fA.PgBnVGQEcNbFd.dKXttWxYS',NULL,'2026-02-20 01:24:12','2026-02-20 01:24:12',NULL),(31,'Rafa Eri Mahendra','rafa_eri_mahendra','rafa_eri_mahendra@siswa.com','2026-02-20 01:24:12','$2y$12$OHdMOhCklY54Fna.5h.sfubNuBF9Vese.tHJMOvXSBbhO7m1xwesq',NULL,'2026-02-20 01:24:12','2026-02-20 01:24:12',NULL),(32,'Arsinta Widya Ningtyas','arsinta_widya_ningtyas','arsinta_widya_ningtyas@siswa.com','2026-02-20 01:24:13','$2y$12$0SfegrJLZrFch4XljcrSkejUFdxcw.tRNKGx5KCaNoS37mUz0nylq',NULL,'2026-02-20 01:24:13','2026-02-20 01:24:13',NULL),(33,'Shelvy Arifiani','shelvy_arifiani','shelvy_arifiani@siswa.com','2026-02-20 01:24:13','$2y$12$kE61dbqvNqTFAaILUs842Os8lgqHGe6bDCL03cWXCGFoSqRES4fI6',NULL,'2026-02-20 01:24:13','2026-02-20 01:24:13',NULL),(34,'Muhamad alif ilham','muhamad_alif_ilham','muhamad_alif_ilham@siswa.com','2026-02-20 01:24:14','$2y$12$ZhpkiKIzpdMJD92B9o8HIOh1FdWijl3d0xO6VZcxPmEKjjvANMuCG',NULL,'2026-02-20 01:24:14','2026-02-20 01:24:14',NULL),(35,'Kayla','kayla','kayla@siswa.com','2026-02-20 01:24:14','$2y$12$gnBsVcxp2i8inVOQ9FWdeehO2gZgMeFQLyfIgBN8BaA..pDxBiqQm',NULL,'2026-02-20 01:24:14','2026-02-20 01:24:14',NULL),(36,'Michelle','michelle','michelle@siswa.com','2026-02-20 01:24:15','$2y$12$SduyrgeXtt0G17s4Rl4RVOQNZx3Y4abi4bIeK.Ma/Tp7rwv/ffGoq',NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15',NULL),(37,'Marcel','marcel','marcel@siswa.com','2026-02-20 01:24:15','$2y$12$6GhJwumPbSEJhjfQWHX4D.FsIrdfgCArK6n.tG6S2Jp8sJQIznkh.',NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15',NULL),(38,'Helen','helen','helen@siswa.com','2026-02-20 01:24:15','$2y$12$wgKs3kJl6yzAYUSDLQJzS.xFyFo5R.9taBkHRQgA5HakS0JXlDndi',NULL,'2026-02-20 01:24:15','2026-02-20 01:24:15',NULL),(39,'Meira','meira','meira@siswa.com','2026-02-20 01:24:16','$2y$12$hn4L7ccXP7Ws9ujFM6rIV.ncYTYIkvNFzlhzX1F3BAjK9LGxksV7e',NULL,'2026-02-20 01:24:16','2026-02-20 01:24:16',NULL),(40,'Benson','benson','benson@siswa.com','2026-02-20 01:24:16','$2y$12$WfKvk.xUCoh7MyeGM8HU7.Tu4iu4Xh8f4HB6ws/.btNd2N8mhAupG',NULL,'2026-02-20 01:24:16','2026-02-20 01:24:16',NULL),(41,'Easter','easter','easter@siswa.com','2026-02-20 01:24:17','$2y$12$oI5a2W9pEA6361jCpiDyeuwALjutmR2ZPEioXEbaKELDdGIIi98BW',NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17',NULL),(42,'Nurlia','nurlia','nurlia@siswa.com','2026-02-20 01:24:17','$2y$12$CerR7.fzO3GuQ7A8ZSKzSe0sN1XziQ3RKTlJTqH.diCbxIhZVv98K',NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17',NULL),(43,'Dendi','dendi','dendi@siswa.com','2026-02-20 01:24:17','$2y$12$jVXxgBMmgIS9bGB.li/DgOeegiHUhd0ZtG7eHIhZ74j5BWfEVriCy',NULL,'2026-02-20 01:24:17','2026-02-20 01:24:17',NULL),(44,'Daniel','daniel','daniel@siswa.com','2026-02-20 01:24:18','$2y$12$PgkAJL49jhvzbDLZO1IbZ.sEaNnG26JORtEJIy0qQKWRZX1qKIvWe',NULL,'2026-02-20 01:24:18','2026-02-20 01:24:18',NULL),(45,'Ezekiel','ezekiel','ezekiel@siswa.com','2026-02-20 01:24:18','$2y$12$D83tcnACFdzeDtHQKo.bv.rln6/IF/INKi5sGfip4om0CP3z3.yrO',NULL,'2026-02-20 01:24:18','2026-02-20 01:24:18',NULL),(46,'Moscha Apricilliya Suhatmoko','moscha_apricilliya_suhatmoko','moscha_apricilliya_suhatmoko@siswa.com','2026-02-20 01:24:18','$2y$12$OfaUGX3kMsdgG3g3992GZuGIacaNvY9AlLkuXfj6JIiv8qtSOjmCO',NULL,'2026-02-20 01:24:18','2026-02-20 01:24:18',NULL),(47,'Sofhia Celiya Suhatmoko','sofhia_celiya_suhatmoko','sofhia_celiya_suhatmoko@siswa.com','2026-02-20 01:24:19','$2y$12$OwQXqXby3aOqntBo5TjQXelR5jOfl5xwSjkfMoLh9bxdGHRWVDIk.',NULL,'2026-02-20 01:24:19','2026-02-20 01:24:19',NULL),(48,'Daniel Aliando Suhatmoko','daniel_aliando_suhatmoko','daniel_aliando_suhatmoko@siswa.com','2026-02-20 01:24:19','$2y$12$gPqfXiENKJpcWou.wE/29eQpyPWoc0Zes2WWms1LRC2HRBuwCA3BW',NULL,'2026-02-20 01:24:19','2026-02-20 01:24:19',NULL),(49,'Tio','tio','tio@siswa.com','2026-02-20 01:24:20','$2y$12$qpzR4mCtaD34.BZB6b6rx.9OkwGwvhMqclJlUWT1DFaNboN7u3xEC',NULL,'2026-02-20 01:24:20','2026-02-20 01:24:20',NULL);
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

-- Dump completed on 2026-02-20 15:29:19
