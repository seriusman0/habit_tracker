-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 03, 2026 at 12:40 AM
-- Server version: 10.11.15-MariaDB-cll-lve
-- PHP Version: 8.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jcifkgkd_habit_share_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('jurnal-ykde-cache-patrickrustam76@gmail.com|182.253.70.156', 'i:4;', 1772100886),
('jurnal-ykde-cache-patrickrustam76@gmail.com|182.253.70.156:timer', 'i:1772100886;', 1772100886),
('jurnal-ykde-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:0:{}s:11:\"permissions\";a:0:{}s:5:\"roles\";a:0:{}}', 1772187319),
('jurnal-ykde-cache-theodorus.23336@mhs.unesa.ac.id|182.253.70.156', 'i:1;', 1772100925),
('jurnal-ykde-cache-theodorus.23336@mhs.unesa.ac.id|182.253.70.156:timer', 'i:1772100925;', 1772100925);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classrooms`
--

CREATE TABLE `classrooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `mentor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`id`, `name`, `mentor_id`, `created_at`, `updated_at`, `description`, `status`) VALUES
(1, 'X-A', 2, '2026-02-20 01:07:32', '2026-02-20 01:07:32', NULL, 'ACTIVE');

-- --------------------------------------------------------

--
-- Table structure for table `classroom_students`
--

CREATE TABLE `classroom_students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `classroom_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_memberships`
--

CREATE TABLE `class_memberships` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'ACTIVE',
  `assigned_by_admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `daily_reflections`
--

CREATE TABLE `daily_reflections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `ref_date` date NOT NULL,
  `mood` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genetic_types`
--

CREATE TABLE `genetic_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genetic_types`
--

INSERT INTO `genetic_types` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Sensing', 'Focus on sensory details and concrete reality.', '2026-02-20 01:06:26', '2026-02-20 01:06:26'),
(2, 'Thinking', 'Analytical and logical decision making.', '2026-02-20 01:06:26', '2026-02-20 01:06:26'),
(3, 'Intuiting', 'Focus on possibilities, patterns, and future implications.', '2026-02-20 01:06:26', '2026-02-20 01:06:26'),
(4, 'Feeling', 'Decision making based on values and harmony.', '2026-02-20 01:06:26', '2026-02-20 01:06:26'),
(5, 'Instinct', 'Spontaneous and gut-driven reactions.', '2026-02-20 01:06:26', '2026-02-20 01:06:26');

-- --------------------------------------------------------

--
-- Table structure for table `habits`
--

CREATE TABLE `habits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT '#4F46E5',
  `frequency` enum('daily','weekly') NOT NULL DEFAULT 'daily',
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `habit_categories`
--

CREATE TABLE `habit_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `habit_categories`
--

INSERT INTO `habit_categories` (`id`, `name`, `created_by_user_id`, `updated_by_user_id`, `created_at`, `updated_at`, `student_id`) VALUES
(1, 'Bangun', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(2, 'Ibadah', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(3, 'Olahraga', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(4, 'Makan', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(5, 'Belajar', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(6, 'Bermasyarakat', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(7, 'Tidur', NULL, NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `habit_logs`
--

CREATE TABLE `habit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `habit_id` bigint(20) UNSIGNED NOT NULL,
  `log_date` date NOT NULL,
  `status` enum('completed','skipped','failed') NOT NULL DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` bigint(20) UNSIGNED DEFAULT NULL,
  `logged_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `habit_user`
--

CREATE TABLE `habit_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `habit_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) NOT NULL DEFAULT 'daily',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mentor_feedbacks`
--

CREATE TABLE `mentor_feedbacks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `mentor_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `feedback_date` date NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_09_232438_create_habits_table', 1),
(5, '2026_01_09_232439_create_habit_logs_table', 1),
(6, '2026_01_09_232441_create_habit_permissions_table', 1),
(7, '2026_01_12_185602_create_permission_tables', 1),
(8, '2026_01_12_185715_drop_social_tables', 1),
(9, '2026_01_12_185716_create_student_guardians_table', 1),
(10, '2026_01_12_185718_create_classrooms_tables', 1),
(11, '2026_01_25_074004_update_schema_for_mvp', 1),
(12, '2026_01_25_075641_refactor_habit_categories_table', 1),
(13, '2026_01_25_080306_refactor_habit_categories_v2', 1),
(14, '2026_01_26_082950_add_role_and_genetic_type_to_users_table', 1),
(15, '2026_01_26_084718_create_student_profiles_table', 1),
(16, '2026_01_26_085533_create_genetic_types_table', 1),
(17, '2026_01_26_085533_replace_genetic_type_with_id_in_users_table', 1),
(18, '2026_01_26_093246_drop_student_id_target_time_sort_order_from_habits_table', 1),
(19, '2026_01_31_032356_fix_habits_and_categories_structure', 1),
(20, '2026_01_31_081951_create_habit_user_table', 1),
(21, '2026_01_31_082310_migrate_existing_habits_to_pivot', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 12),
(2, 'App\\Models\\User', 13),
(2, 'App\\Models\\User', 14),
(2, 'App\\Models\\User', 15),
(2, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 17),
(2, 'App\\Models\\User', 18),
(2, 'App\\Models\\User', 19),
(2, 'App\\Models\\User', 20),
(2, 'App\\Models\\User', 21),
(2, 'App\\Models\\User', 22),
(2, 'App\\Models\\User', 23),
(3, 'App\\Models\\User', 26),
(3, 'App\\Models\\User', 27),
(3, 'App\\Models\\User', 28),
(3, 'App\\Models\\User', 29),
(3, 'App\\Models\\User', 30),
(3, 'App\\Models\\User', 31),
(3, 'App\\Models\\User', 32),
(3, 'App\\Models\\User', 33),
(3, 'App\\Models\\User', 34),
(3, 'App\\Models\\User', 35),
(3, 'App\\Models\\User', 36),
(3, 'App\\Models\\User', 37),
(3, 'App\\Models\\User', 38),
(3, 'App\\Models\\User', 39),
(3, 'App\\Models\\User', 40),
(3, 'App\\Models\\User', 41),
(3, 'App\\Models\\User', 42),
(3, 'App\\Models\\User', 43),
(3, 'App\\Models\\User', 44),
(3, 'App\\Models\\User', 45),
(3, 'App\\Models\\User', 46),
(3, 'App\\Models\\User', 47),
(3, 'App\\Models\\User', 48),
(3, 'App\\Models\\User', 49);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2026-02-20 01:01:19', '2026-02-20 01:01:19'),
(2, 'mentor', 'web', '2026-02-20 01:01:19', '2026-02-20 01:01:19'),
(3, 'student', 'web', '2026-02-20 01:01:19', '2026-02-20 01:01:19');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('irwuc4f5miTbRTWe0NBxhmAL3uMxT5a9XJWBRQ7B', 1, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoibTFYTXcxVjFoWFlvd3ZxRmxFcjI0ZE5pbmVVdzVydmZidW1Xang0aCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi91c2VycyI7czo1OiJyb3V0ZSI7czozNjoiZmlsYW1lbnQuYWRtaW4ucmVzb3VyY2VzLnVzZXJzLmluZGV4Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiMWZiNDMwNjZhYjhhZWNmMmU4M2NhZGM5Njc5OTliZGJkNzY2NjE0NWE4NWU1NWFlY2QxYTRjODg0MmRlNTNiNyI7fQ==', 1771574581);

-- --------------------------------------------------------

--
-- Table structure for table `student_guardians`
--

CREATE TABLE `student_guardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `guardian_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `birth_date` date DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `school_address` varchar(255) DEFAULT NULL,
  `grade_level` int(11) DEFAULT NULL,
  `school_level` varchar(255) DEFAULT NULL,
  `guardian_name` varchar(255) DEFAULT NULL,
  `guardian_phone` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_profiles`
--

INSERT INTO `student_profiles` (`id`, `user_id`, `birth_date`, `school_name`, `school_address`, `grade_level`, `school_level`, `guardian_name`, `guardian_phone`, `created_at`, `updated_at`) VALUES
(2, 26, '2013-05-25', NULL, NULL, 5, 'SD', NULL, '0895342770603', '2026-02-20 01:24:10', '2026-02-20 01:24:10'),
(3, 27, NULL, NULL, NULL, 5, 'SD', NULL, '0822132881113', '2026-02-20 01:24:10', '2026-02-20 01:24:10'),
(4, 28, '2014-01-23', NULL, NULL, 5, 'SD', NULL, '085179873642', '2026-02-20 01:24:11', '2026-02-20 01:24:11'),
(5, 29, '2012-12-23', NULL, NULL, 6, 'SD', NULL, NULL, '2026-02-20 01:24:11', '2026-02-20 01:24:11'),
(6, 30, NULL, NULL, NULL, 5, 'SD', NULL, '085171173015', '2026-02-20 01:24:12', '2026-02-20 01:24:12'),
(7, 31, '2017-04-24', NULL, NULL, 1, 'SD', NULL, NULL, '2026-02-20 01:24:12', '2026-02-20 01:24:12'),
(8, 32, '2014-05-14', NULL, NULL, 5, 'SD', NULL, '081585242340', '2026-02-20 01:24:13', '2026-02-20 01:24:13'),
(9, 33, '2013-10-27', NULL, NULL, 5, 'SD', NULL, NULL, '2026-02-20 01:24:13', '2026-02-20 01:24:13'),
(10, 34, '2019-01-21', NULL, NULL, NULL, 'TKB', NULL, NULL, '2026-02-20 01:24:14', '2026-02-20 01:24:14'),
(11, 35, NULL, NULL, NULL, NULL, 'TKB', NULL, NULL, '2026-02-20 01:24:14', '2026-02-20 01:24:14'),
(12, 36, NULL, NULL, NULL, 6, 'SD', NULL, NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15'),
(13, 37, '2012-08-23', NULL, NULL, 6, 'SD', NULL, NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15'),
(14, 38, '2016-04-20', NULL, NULL, 3, 'SD', NULL, NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15'),
(15, 39, '2018-10-29', NULL, NULL, 1, 'SD', NULL, NULL, '2026-02-20 01:24:16', '2026-02-20 01:24:16'),
(16, 40, '2014-04-18', NULL, NULL, 5, 'SD', NULL, NULL, '2026-02-20 01:24:16', '2026-02-20 01:24:16'),
(17, 41, '2012-04-06', NULL, NULL, 6, 'SD', NULL, NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17'),
(18, 42, '2014-06-08', NULL, NULL, 4, 'SD', NULL, NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17'),
(19, 43, NULL, NULL, NULL, 2, 'SMP', NULL, NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17'),
(20, 44, NULL, NULL, NULL, 3, 'SD', NULL, NULL, '2026-02-20 01:24:18', '2026-02-20 01:24:18'),
(21, 45, NULL, NULL, NULL, 2, 'SMA', NULL, NULL, '2026-02-20 01:24:18', '2026-02-20 01:24:18'),
(22, 46, NULL, NULL, NULL, 1, 'SMP', NULL, '081233579446', '2026-02-20 01:24:18', '2026-02-20 01:24:18'),
(23, 47, NULL, NULL, NULL, 4, 'SD', NULL, '081233579446', '2026-02-20 01:24:19', '2026-02-20 01:24:19'),
(24, 48, NULL, NULL, NULL, 3, 'SD', NULL, '081233579446', '2026-02-20 01:24:19', '2026-02-20 01:24:19'),
(25, 49, NULL, NULL, NULL, 3, 'SMA', NULL, NULL, '2026-02-20 01:24:20', '2026-02-20 01:24:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `genetic_type_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `genetic_type_id`) VALUES
(1, 'Admin', 'admin', 'admin@admin.com', '2026-02-20 01:01:19', '$2y$12$YpyGjVe1YbM8EyqyrKUs5ewH6YRTr2O3kFtNdMbn5MTfYCM8odOt6', NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(2, 'Theodorus Patrick', 'theodorus_patrick', 'theodorus_patrick@email.com', '2026-02-20 01:01:19', '$2y$12$Tt.4.gwR5bv6Dsv.Lh1fX..B346zKWuzWoalbfEd5OdkbLB9Nnh4C', NULL, '2026-02-20 01:01:19', '2026-02-20 01:01:19', NULL),
(3, 'Ade Puan', 'ade_puan', 'ade_puan@email.com', '2026-02-20 01:01:20', '$2y$12$puhOHiwEsmcp//v7gjGvj.nKVfbsgd.N7Y4IBQ2z.fe1ITLSHapz.', NULL, '2026-02-20 01:01:20', '2026-02-20 01:01:20', NULL),
(4, 'Kristiani', 'kristiani', 'kristiani@email.com', '2026-02-20 01:01:20', '$2y$12$nfiaIb4/XLcR.KHciMva7Oc4t4CM9yMVnVgkFqZyCxd9ZdqWyV3p.', NULL, '2026-02-20 01:01:20', '2026-02-20 01:01:20', NULL),
(5, 'Meidhora', 'meidhora', 'meidhora@email.com', '2026-02-20 01:01:21', '$2y$12$8PbJsGqwNscOx.Z6iff9a.dvCH9HWGkKVnS/We2Eb9KVSwq/LmFBS', NULL, '2026-02-20 01:01:21', '2026-02-20 01:01:21', NULL),
(6, 'Widya', 'widya', 'widya@email.com', '2026-02-20 01:01:21', '$2y$12$GJ3sAMXV1OMLGxMPW/0ti.YflhX/Y34ER1uYVGVPhbauNlCMkqmuW', NULL, '2026-02-20 01:01:21', '2026-02-20 01:01:21', NULL),
(7, 'Tabitha', 'tabitha', 'tabitha@email.com', '2026-02-20 01:01:21', '$2y$12$OkcAPs4pNw1eoW/v6vTOm.W7yeFKCQwoLxgzV4fvywP8DDo7ot2ca', NULL, '2026-02-20 01:01:21', '2026-02-20 01:01:21', NULL),
(8, 'Tri', 'tri', 'tri@email.com', '2026-02-20 01:01:22', '$2y$12$UTL8sm.mqXxEDAi39lMzdeShSHvXYE9GjnHCaWreRdUhLxId/wMBK', NULL, '2026-02-20 01:01:22', '2026-02-20 01:01:22', NULL),
(9, 'Ras Enchari', 'ras_enchari', 'ras_enchari@email.com', '2026-02-20 01:01:22', '$2y$12$SNCp79eOG7NmVkn.tcX8veoDfFaxYnF6VWoUcyZ9eACqQraRK8QO6', NULL, '2026-02-20 01:01:22', '2026-02-20 01:01:22', NULL),
(10, 'Krisyanto Edo', 'krisyanto_edo', 'krisyanto_edo@email.com', '2026-02-20 01:01:22', '$2y$12$kGynmaP1/ppeo12oN4D6t.LDoS05QnzdB3lQQ5HxSv4QmQK.64.Lq', NULL, '2026-02-20 01:01:22', '2026-02-20 01:01:22', NULL),
(11, 'Obaja', 'obaja', 'obaja@email.com', '2026-02-20 01:01:23', '$2y$12$NOTAxMvxlbpfGSEyjgukS.6mmZwZgajt5E9pbdkZrLkjnGuAOYEOi', NULL, '2026-02-20 01:01:23', '2026-02-20 01:01:23', NULL),
(12, 'Amelia', 'amelia', 'amelia@email.com', '2026-02-20 01:01:23', '$2y$12$Z3Lg8kyFoUjS8diFCOV8ruEM.uL8WJiqTZcsr.47FR9JC4l94xY/e', NULL, '2026-02-20 01:01:23', '2026-02-20 01:01:23', NULL),
(13, 'Della', 'della', 'della@email.com', '2026-02-20 01:01:23', '$2y$12$yjMiToXabaq90pYpSAoFo.mojiWV9mHwK9.cLpydN.7K6T/Tkn8UO', NULL, '2026-02-20 01:01:23', '2026-02-20 01:01:23', NULL),
(14, 'Cecilia', 'cecilia', 'cecilia@email.com', '2026-02-20 01:01:24', '$2y$12$1MgAN40hESxRM50eriCAIOcsGTCBkBIdMHenwXhcRjzVzZ2X.iV8.', NULL, '2026-02-20 01:01:24', '2026-02-20 01:01:24', NULL),
(15, 'Donfri', 'donfri', 'donfri@email.com', '2026-02-20 01:01:24', '$2y$12$85y4CedcL0P9mCyHZOlda.hGF31HQCjFu55uvkFJ6HQXjve1uxjiq', NULL, '2026-02-20 01:01:24', '2026-02-20 01:01:24', NULL),
(16, 'Mikhael', 'mikhael', 'mikhael@email.com', '2026-02-20 01:01:24', '$2y$12$jJCkfVpxT.xEvyxmEQfhrOTLHa9/mxnYzeh6U1HjrW2ji2LQYoQlq', NULL, '2026-02-20 01:01:24', '2026-02-20 01:01:24', NULL),
(17, 'Oswald', 'oswald', 'oswald@email.com', '2026-02-20 01:01:25', '$2y$12$Dnod78kBMlTrvZbAjD8ATeRJ2vqYKnuYacr9cjmDs.NRoNS329NGK', NULL, '2026-02-20 01:01:25', '2026-02-20 01:01:25', NULL),
(18, 'Margareth', 'margareth', 'margareth@email.com', '2026-02-20 01:01:25', '$2y$12$nbGLN8hgSOQAE82NfVjv4OBIbMDIOMPCcy2Ewq/Gc7kWNWag.n/Ii', NULL, '2026-02-20 01:01:25', '2026-02-20 01:01:25', NULL),
(19, 'Romario', 'romario', 'romario@email.com', '2026-02-20 01:01:26', '$2y$12$WZb64ClxjIlwueugXMvtJuRqrhqb4vOjA8n725kKzE/fd2XhPSXI.', NULL, '2026-02-20 01:01:26', '2026-02-20 01:01:26', NULL),
(20, 'Naomi', 'naomi', 'naomi@email.com', '2026-02-20 01:01:26', '$2y$12$Tka3038odfju/1K/gWDxhuMazpPSEVrUzaC3Im907P5QMrQ6UXYZq', NULL, '2026-02-20 01:01:26', '2026-02-20 01:01:26', NULL),
(21, 'Herdiyanto', 'herdiyanto', 'herdiyanto@email.com', '2026-02-20 01:01:26', '$2y$12$AUjF/pStZYOQQtUmRGepqOuDoiH9Smr7TMFQJyyKHJdtjzDxbZcyK', NULL, '2026-02-20 01:01:26', '2026-02-20 01:01:26', NULL),
(22, 'Artha', 'artha', 'artha@email.com', '2026-02-20 01:01:27', '$2y$12$Z4ZRebq0qF5Mb9PGenHGZOumTrltVnHYRYG.53NwJoh2BMuz2GHXS', NULL, '2026-02-20 01:01:27', '2026-02-20 01:01:27', NULL),
(23, 'Nethania', 'nethania', 'nethania@email.com', '2026-02-20 01:01:27', '$2y$12$VD.l81Jk5d8cVibaNg2DoOi5qnNIpzx3nU0Tsy.maJNJ5YddxHf8C', NULL, '2026-02-20 01:01:27', '2026-02-20 01:01:27', NULL),
(26, 'Ad. Zahira', 'ad_zahira', 'ad_zahira@siswa.com', '2026-02-20 01:24:10', '$2y$12$eifQVEMGKWBE0XXd161TqevUFnxwiu0gfM2qmxOYCy9iEEkQOj/8q', NULL, '2026-02-20 01:24:10', '2026-02-20 01:24:10', NULL),
(27, 'Michayla Queen Azzhra', 'michayla_queen_azzhra', 'michayla_queen_azzhra@siswa.com', '2026-02-20 01:24:10', '$2y$12$Fr.wghcce0zKaL2uqI9NOenmZdzVfysePNQCQm40P4Pl6.3bOwP7C', NULL, '2026-02-20 01:24:10', '2026-02-20 01:24:10', NULL),
(28, 'Neshellya Ery Friestya', 'neshellya_ery_friestya', 'neshellya_ery_friestya@siswa.com', '2026-02-20 01:24:11', '$2y$12$OPMycqum4ilTtKgLQzhINeKaqt/rFBRuaQIAPIO8k1zh/ztHv828W', NULL, '2026-02-20 01:24:11', '2026-02-20 01:24:11', NULL),
(29, 'Desty keyza angraini', 'desty_keyza_angraini', 'desty_keyza_angraini@siswa.com', '2026-02-20 01:24:11', '$2y$12$O2IjJpwJRpo8fLkhoJUyAODGC44cPjFic9mHYo8G7ifaQdHxqfBqa', NULL, '2026-02-20 01:24:11', '2026-02-20 01:24:11', NULL),
(30, 'Dewi Kayla Putri Ardiansyah', 'dewi_kayla_putri_ardiansyah', 'dewi_kayla_putri_ardiansyah@siswa.com', '2026-02-20 01:24:12', '$2y$12$F/FUtNGPd9HY4Az7pGQr9ul31n4fA.PgBnVGQEcNbFd.dKXttWxYS', NULL, '2026-02-20 01:24:12', '2026-02-20 01:24:12', NULL),
(31, 'Rafa Eri Mahendra', 'rafa_eri_mahendra', 'rafa_eri_mahendra@siswa.com', '2026-02-20 01:24:12', '$2y$12$OHdMOhCklY54Fna.5h.sfubNuBF9Vese.tHJMOvXSBbhO7m1xwesq', NULL, '2026-02-20 01:24:12', '2026-02-20 01:24:12', NULL),
(32, 'Arsinta Widya Ningtyas', 'arsinta_widya_ningtyas', 'arsinta_widya_ningtyas@siswa.com', '2026-02-20 01:24:13', '$2y$12$0SfegrJLZrFch4XljcrSkejUFdxcw.tRNKGx5KCaNoS37mUz0nylq', NULL, '2026-02-20 01:24:13', '2026-02-20 01:24:13', NULL),
(33, 'Shelvy Arifiani', 'shelvy_arifiani', 'shelvy_arifiani@siswa.com', '2026-02-20 01:24:13', '$2y$12$kE61dbqvNqTFAaILUs842Os8lgqHGe6bDCL03cWXCGFoSqRES4fI6', NULL, '2026-02-20 01:24:13', '2026-02-20 01:24:13', NULL),
(34, 'Muhamad alif ilham', 'muhamad_alif_ilham', 'muhamad_alif_ilham@siswa.com', '2026-02-20 01:24:14', '$2y$12$ZhpkiKIzpdMJD92B9o8HIOh1FdWijl3d0xO6VZcxPmEKjjvANMuCG', NULL, '2026-02-20 01:24:14', '2026-02-20 01:24:14', NULL),
(35, 'Kayla', 'kayla', 'kayla@siswa.com', '2026-02-20 01:24:14', '$2y$12$gnBsVcxp2i8inVOQ9FWdeehO2gZgMeFQLyfIgBN8BaA..pDxBiqQm', NULL, '2026-02-20 01:24:14', '2026-02-20 01:24:14', NULL),
(36, 'Michelle', 'michelle', 'michelle@siswa.com', '2026-02-20 01:24:15', '$2y$12$SduyrgeXtt0G17s4Rl4RVOQNZx3Y4abi4bIeK.Ma/Tp7rwv/ffGoq', NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15', NULL),
(37, 'Marcel', 'marcel', 'marcel@siswa.com', '2026-02-20 01:24:15', '$2y$12$6GhJwumPbSEJhjfQWHX4D.FsIrdfgCArK6n.tG6S2Jp8sJQIznkh.', NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15', NULL),
(38, 'Helen', 'helen', 'helen@siswa.com', '2026-02-20 01:24:15', '$2y$12$wgKs3kJl6yzAYUSDLQJzS.xFyFo5R.9taBkHRQgA5HakS0JXlDndi', NULL, '2026-02-20 01:24:15', '2026-02-20 01:24:15', NULL),
(39, 'Meira', 'meira', 'meira@siswa.com', '2026-02-20 01:24:16', '$2y$12$hn4L7ccXP7Ws9ujFM6rIV.ncYTYIkvNFzlhzX1F3BAjK9LGxksV7e', NULL, '2026-02-20 01:24:16', '2026-02-20 01:24:16', NULL),
(40, 'Benson', 'benson', 'benson@siswa.com', '2026-02-20 01:24:16', '$2y$12$WfKvk.xUCoh7MyeGM8HU7.Tu4iu4Xh8f4HB6ws/.btNd2N8mhAupG', NULL, '2026-02-20 01:24:16', '2026-02-20 01:24:16', NULL),
(41, 'Easter', 'easter', 'easter@siswa.com', '2026-02-20 01:24:17', '$2y$12$oI5a2W9pEA6361jCpiDyeuwALjutmR2ZPEioXEbaKELDdGIIi98BW', NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17', NULL),
(42, 'Nurlia', 'nurlia', 'nurlia@siswa.com', '2026-02-20 01:24:17', '$2y$12$CerR7.fzO3GuQ7A8ZSKzSe0sN1XziQ3RKTlJTqH.diCbxIhZVv98K', NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17', NULL),
(43, 'Dendi', 'dendi', 'dendi@siswa.com', '2026-02-20 01:24:17', '$2y$12$jVXxgBMmgIS9bGB.li/DgOeegiHUhd0ZtG7eHIhZ74j5BWfEVriCy', NULL, '2026-02-20 01:24:17', '2026-02-20 01:24:17', NULL),
(44, 'Daniel', 'daniel', 'daniel@siswa.com', '2026-02-20 01:24:18', '$2y$12$PgkAJL49jhvzbDLZO1IbZ.sEaNnG26JORtEJIy0qQKWRZX1qKIvWe', NULL, '2026-02-20 01:24:18', '2026-02-20 01:24:18', NULL),
(45, 'Ezekiel', 'ezekiel', 'ezekiel@siswa.com', '2026-02-20 01:24:18', '$2y$12$D83tcnACFdzeDtHQKo.bv.rln6/IF/INKi5sGfip4om0CP3z3.yrO', NULL, '2026-02-20 01:24:18', '2026-02-20 01:24:18', NULL),
(46, 'Moscha Apricilliya Suhatmoko', 'moscha_apricilliya_suhatmoko', 'moscha_apricilliya_suhatmoko@siswa.com', '2026-02-20 01:24:18', '$2y$12$OfaUGX3kMsdgG3g3992GZuGIacaNvY9AlLkuXfj6JIiv8qtSOjmCO', NULL, '2026-02-20 01:24:18', '2026-02-20 01:24:18', NULL),
(47, 'Sofhia Celiya Suhatmoko', 'sofhia_celiya_suhatmoko', 'sofhia_celiya_suhatmoko@siswa.com', '2026-02-20 01:24:19', '$2y$12$OwQXqXby3aOqntBo5TjQXelR5jOfl5xwSjkfMoLh9bxdGHRWVDIk.', NULL, '2026-02-20 01:24:19', '2026-02-20 01:24:19', NULL),
(48, 'Daniel Aliando Suhatmoko', 'daniel_aliando_suhatmoko', 'daniel_aliando_suhatmoko@siswa.com', '2026-02-20 01:24:19', '$2y$12$gPqfXiENKJpcWou.wE/29eQpyPWoc0Zes2WWms1LRC2HRBuwCA3BW', NULL, '2026-02-20 01:24:19', '2026-02-20 01:24:19', NULL),
(49, 'Tio', 'tio', 'tio@siswa.com', '2026-02-20 01:24:20', '$2y$12$qpzR4mCtaD34.BZB6b6rx.9OkwGwvhMqclJlUWT1DFaNboN7u3xEC', NULL, '2026-02-20 01:24:20', '2026-02-20 01:24:20', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classrooms_teacher_id_foreign` (`mentor_id`);

--
-- Indexes for table `classroom_students`
--
ALTER TABLE `classroom_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `classroom_students_classroom_id_student_id_unique` (`classroom_id`,`student_id`),
  ADD KEY `classroom_students_student_id_foreign` (`student_id`);

--
-- Indexes for table `class_memberships`
--
ALTER TABLE `class_memberships`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `class_memberships_class_id_student_id_unique` (`class_id`,`student_id`),
  ADD KEY `class_memberships_student_id_foreign` (`student_id`),
  ADD KEY `class_memberships_assigned_by_admin_id_foreign` (`assigned_by_admin_id`);

--
-- Indexes for table `daily_reflections`
--
ALTER TABLE `daily_reflections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `daily_reflections_student_id_ref_date_unique` (`student_id`,`ref_date`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `genetic_types`
--
ALTER TABLE `genetic_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `genetic_types_name_unique` (`name`);

--
-- Indexes for table `habits`
--
ALTER TABLE `habits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `habits_user_id_foreign` (`student_id`),
  ADD KEY `habits_category_id_foreign` (`category_id`),
  ADD KEY `habits_created_by_user_id_foreign` (`created_by_user_id`),
  ADD KEY `habits_updated_by_user_id_foreign` (`updated_by_user_id`);

--
-- Indexes for table `habit_categories`
--
ALTER TABLE `habit_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `habit_categories_created_by_user_id_foreign` (`created_by_user_id`),
  ADD KEY `habit_categories_updated_by_user_id_foreign` (`updated_by_user_id`),
  ADD KEY `habit_categories_student_id_foreign` (`student_id`);

--
-- Indexes for table `habit_logs`
--
ALTER TABLE `habit_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `habit_logs_habit_id_date_unique` (`habit_id`,`log_date`),
  ADD KEY `habit_logs_student_id_foreign` (`student_id`);

--
-- Indexes for table `habit_user`
--
ALTER TABLE `habit_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `habit_user_habit_id_student_id_unique` (`habit_id`,`student_id`),
  ADD KEY `habit_user_student_id_foreign` (`student_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mentor_feedbacks`
--
ALTER TABLE `mentor_feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mentor_feedbacks_class_id_foreign` (`class_id`),
  ADD KEY `mentor_feedbacks_mentor_id_foreign` (`mentor_id`),
  ADD KEY `mentor_feedbacks_student_id_foreign` (`student_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `student_guardians`
--
ALTER TABLE `student_guardians`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_guardians_student_id_guardian_id_unique` (`student_id`,`guardian_id`),
  ADD KEY `student_guardians_guardian_id_foreign` (`guardian_id`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_profiles_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_genetic_type_id_foreign` (`genetic_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classrooms`
--
ALTER TABLE `classrooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `classroom_students`
--
ALTER TABLE `classroom_students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `class_memberships`
--
ALTER TABLE `class_memberships`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `daily_reflections`
--
ALTER TABLE `daily_reflections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genetic_types`
--
ALTER TABLE `genetic_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `habits`
--
ALTER TABLE `habits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `habit_categories`
--
ALTER TABLE `habit_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `habit_logs`
--
ALTER TABLE `habit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `habit_user`
--
ALTER TABLE `habit_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mentor_feedbacks`
--
ALTER TABLE `mentor_feedbacks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_guardians`
--
ALTER TABLE `student_guardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_profiles`
--
ALTER TABLE `student_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD CONSTRAINT `classrooms_teacher_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `classroom_students`
--
ALTER TABLE `classroom_students`
  ADD CONSTRAINT `classroom_students_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classroom_students_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `class_memberships`
--
ALTER TABLE `class_memberships`
  ADD CONSTRAINT `class_memberships_assigned_by_admin_id_foreign` FOREIGN KEY (`assigned_by_admin_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `class_memberships_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_memberships_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `daily_reflections`
--
ALTER TABLE `daily_reflections`
  ADD CONSTRAINT `daily_reflections_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `habits`
--
ALTER TABLE `habits`
  ADD CONSTRAINT `habits_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `habit_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `habits_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `habits_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `habits_user_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `habit_categories`
--
ALTER TABLE `habit_categories`
  ADD CONSTRAINT `habit_categories_created_by_user_id_foreign` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `habit_categories_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `habit_categories_updated_by_user_id_foreign` FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `habit_logs`
--
ALTER TABLE `habit_logs`
  ADD CONSTRAINT `habit_logs_habit_id_foreign` FOREIGN KEY (`habit_id`) REFERENCES `habits` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `habit_logs_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `habit_user`
--
ALTER TABLE `habit_user`
  ADD CONSTRAINT `habit_user_habit_id_foreign` FOREIGN KEY (`habit_id`) REFERENCES `habits` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `habit_user_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mentor_feedbacks`
--
ALTER TABLE `mentor_feedbacks`
  ADD CONSTRAINT `mentor_feedbacks_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classrooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mentor_feedbacks_mentor_id_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mentor_feedbacks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_guardians`
--
ALTER TABLE `student_guardians`
  ADD CONSTRAINT `student_guardians_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_guardians_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `student_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_genetic_type_id_foreign` FOREIGN KEY (`genetic_type_id`) REFERENCES `genetic_types` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
