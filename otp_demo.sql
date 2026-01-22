-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2025 at 05:35 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `otp_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'admin',
  `is_super_admin` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive','suspended') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`, `name`, `contact`, `role`, `is_super_admin`, `created_at`, `last_login`, `status`) VALUES
(2, 'veliganio_roden@plpasig.edu.ph', '$2y$10$NEjyFI4TODm3yWw9UWyE5.YIprXzIL1mzHvF.ADlnCE3mxf6FCmzm', '', '', '', 0, '2025-05-27 13:12:19', '2025-05-27 14:15:42', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_proof` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `reference_id` varchar(23) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `otp` varchar(10) NOT NULL,
  `otp_expires` datetime NOT NULL,
  `account_type` enum('user','admin') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pending`
--

CREATE TABLE `pending` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `size` varchar(10) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_info`
--

CREATE TABLE `personal_info` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `personal_info`
--

INSERT INTO `personal_info` (`id`, `first_name`, `middle_name`, `last_name`, `address`, `profile_pic`, `profile_image`) VALUES
(9, 'Xader', 'Jarabelo', 'Laggui', 'San Joaquin Pasig City', NULL, NULL),
(10, 'Xader', 'Jarabelo', 'Laggui', 'Villa Bernardo San Joaquin Pasig City', NULL, NULL),
(16, 'Zane Allyson', 'Velasco', 'Capalaran', '65B Villa Monique Esgueera St.', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pet_info`
--

CREATE TABLE `pet_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `pet_name` varchar(100) DEFAULT NULL,
  `species` varchar(50) DEFAULT NULL,
  `breed` varchar(100) DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `pet_photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pet_info`
--

INSERT INTO `pet_info` (`id`, `user_id`, `pet_name`, `species`, `breed`, `gender`, `birthday`, `age`, `pet_photo`) VALUES
(1, 9, 'Jacob', 'Dogasdas', 'Mix Breedasdasd', 'Male', '2000-02-12', 2, '1'),
(2, 10, 'Jacob', 'Dog', 'Mix Breed', 'Male', '2023-12-12', 1, '2'),
(6, 16, 'Tiger Commando', 'cat', 'siopai', 'Male', '2025-05-22', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `otp` varchar(6) DEFAULT NULL,
  `otp_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `main_category` enum('Grooming','Full Services','Clinical Services') NOT NULL DEFAULT 'Clinical Services'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `price`, `duration`, `main_category`) VALUES
(1, 'General Check-up', 'Health assessment, weight check, and physical examination.', 300.00, '1 - 1.5 hr', 'Clinical Services'),
(2, 'Deworming', 'Treatment for internal parasites to maintain digestive health.', 200.00, '30 mins', 'Clinical Services'),
(3, 'Dental Cleaning', 'Teeth cleaning, oral exams, and dental treatments.', 1000.00, '30-45 mins', 'Full Services'),
(4, 'Ear Cleaning', 'Removal of wax and debris from ear canals to prevent infections.', 500.00, '20-30 mins', 'Full Services'),
(5, 'Vaccination', 'Administering vaccines for common diseases in large breeds.', 1500.00, '1 hr', 'Clinical Services'),
(6, 'Full Grooming', 'Includes bath, hair trimming, nail cutting, and blow drying.', 2000.00, '2 hrs', 'Grooming'),
(7, 'Basic Grooming', 'Bath, brush, and basic trim', 500.00, '1 hour', 'Grooming'),
(8, 'Full Grooming', 'Bath, brush, full trim, nail clipping, ear cleaning', 800.00, '2 hours', 'Grooming'),
(9, 'Spa Package', 'Premium bath, massage, aromatherapy', 1000.00, '1.5 hours', 'Grooming'),
(10, 'General Checkup', 'Basic health assessment and examination', 600.00, '30 mins', 'Clinical Services'),
(11, 'Vaccination', 'Essential vaccines and health record update', 1200.00, '30 mins', 'Clinical Services'),
(12, 'Dental Cleaning', 'Professional teeth cleaning and oral exam', 1500.00, '1 hour', 'Clinical Services'),
(13, 'Complete Care Package', 'Full grooming + health checkup + vaccination', 2500.00, '3 hours', 'Full Services'),
(14, 'Premium Package', 'Spa treatment + dental cleaning + health assessment', 3000.00, '4 hours', 'Full Services');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `contact`, `created_at`) VALUES
(9, 'xader.jarabelo.laggui@gmail.com', '$2y$10$szCCcXEDE/ITUZZpAnzKNu9bsIN3EpUrI82bUhK.gFGa0woULQ1l.', '09388286776', '2025-05-21 16:15:55'),
(10, 'laggui_xader@plpasig.edu.ph', '$2y$10$N9TkTRgedZz9/o6VasVya.6nuk7nbQx0l0bI65h1KLDCdo3JHVjZO', '09388286776', '2025-05-21 17:10:28'),
(16, 'veliganioroden0404@gmail.com', '$2y$10$.lNocMalZPPPJpAy.BYfve.VPBu3rYNqsKhWzsSjRKiBEofzcCWmS', '09266623264', '2025-05-26 18:48:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pending`
--
ALTER TABLE `pending`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `personal_info`
--
ALTER TABLE `personal_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pet_info`
--
ALTER TABLE `pet_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `pending`
--
ALTER TABLE `pending`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pet_info`
--
ALTER TABLE `pet_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `pending`
--
ALTER TABLE `pending`
  ADD CONSTRAINT `pending_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pending_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `personal_info`
--
ALTER TABLE `personal_info`
  ADD CONSTRAINT `personal_info_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pet_info`
--
ALTER TABLE `pet_info`
  ADD CONSTRAINT `pet_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
