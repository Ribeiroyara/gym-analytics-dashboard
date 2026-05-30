-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2026 at 06:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gym`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `trainer_id` int(100) NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_booking`
--

CREATE TABLE `class_booking` (
  `id` int(11) NOT NULL,
  `classes_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('weights','machines','conditioning','cardio') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE `exercises` (
  `id` int(11) NOT NULL,
  `workout_id` int(11) NOT NULL,
  `name` varchar(11) NOT NULL,
  `sets` int(11) NOT NULL,
  `rep` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `id` int(11) NOT NULL,
  `user_id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('active','inactive','suspended') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `user_id`, `name`, `status`) VALUES
(1, 2, 'Yara', 'active'),
(2, 4, 'Josh', 'active'),
(3, 6, 'George', 'suspended'),
(4, 8, 'Mattew', 'inactive'),
(5, 9, 'Amanda', 'active'),
(6, 10, 'John', 'suspended'),
(7, 11, 'Alice', 'suspended'),
(8, 12, 'Gustavo', 'active'),
(9, 13, 'Jack', 'inactive'),
(10, 14, 'Juan', 'active'),
(11, 15, 'Anne', 'active'),
(12, 16, 'Suzi', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `members_workouts`
--

CREATE TABLE `members_workouts` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `workout_id` int(11) NOT NULL,
  `assigned by` enum('trainer','admin','','') NOT NULL,
  `Status` enum('çomplete','peding','in progress') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members_workouts`
--

INSERT INTO `members_workouts` (`id`, `member_id`, `workout_id`, `assigned by`, `Status`) VALUES
(1, 1, 3, 'admin', 'çomplete'),
(2, 2, 5, 'admin', 'in progress'),
(3, 3, 2, 'trainer', 'peding'),
(4, 11, 4, 'admin', 'çomplete'),
(5, 7, 1, 'trainer', 'çomplete'),
(6, 8, 2, 'trainer', 'in progress'),
(7, 4, 3, 'admin', 'çomplete'),
(8, 12, 4, 'admin', 'peding'),
(9, 10, 1, 'trainer', 'çomplete'),
(10, 9, 2, 'trainer', 'in progress'),
(11, 7, 1, 'trainer', 'çomplete'),
(12, 6, 1, 'trainer', 'peding');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `status` enum('paid','peding','overdue') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trainers`
--

CREATE TABLE `trainers` (
  `id` int(11) NOT NULL,
  `user_id` int(100) NOT NULL,
  `phone` int(11) DEFAULT NULL,
  `specialty` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trainers`
--

INSERT INTO `trainers` (`id`, `user_id`, `phone`, `specialty`) VALUES
(1, 3, 412369258, 'Strength Training, Yoga'),
(2, 5, 410589563, 'Pilates, Yoga'),
(3, 7, 410569321, 'Strength Training');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('admin','trainer','member','') NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`, `created_at`) VALUES
(1, 'admin', '1234', 'admin', 'admin@gym.com', '2020-05-13 14:28:35.000000'),
(2, 'yara', '1234', 'member', 'yara@gmail.com', '2025-05-01 14:28:57.000000'),
(3, 'Chanell', '1234', 'trainer', 'chanell@gym.com', '2022-02-14 14:28:57.000000'),
(4, 'Josh', '1234', 'member', 'josh@yahoo.com', '2022-12-20 14:29:50.000000'),
(5, 'Emma', 'ema2026', 'trainer', 'emma@gym.com', '2026-05-19 14:30:14.000000'),
(6, 'george', 'george', 'member', 'george@gmail.com', '2026-03-09 14:31:56.000000'),
(7, 'athon', 'athon', 'trainer', 'athon@gym.com', '2022-12-20 14:29:50.000000'),
(8, 'mattew', 'mattew12', 'member', 'mattew12@gmail.com', '2024-09-17 14:33:51.000000'),
(9, 'amanda', 'amanda', 'member', 'amanda@gmail.com', '2026-03-09 14:31:56.000000'),
(10, 'john', 'john', 'member', 'john@gmail.com', '2020-05-13 14:28:35.000000'),
(11, 'alice', 'allie23', 'member', 'allie@gmail.com', '2023-02-13 14:36:11.000000'),
(12, 'gustavo', 'gus123', 'member', 'gus123@gmail.com', '2020-05-13 14:28:35.000000'),
(13, 'jack', 'jack2024', 'member', 'jack@jack.com', '2024-09-05 14:37:01.000000'),
(14, 'juan', 'juan', 'member', 'littlejuan@gmail.com', '2024-07-22 14:38:32.000000'),
(15, 'anne', 'anne15', 'member', 'anne.cherry@gmail.com', '2025-04-15 14:38:32.000000'),
(16, 'suzi', 'suziyoga', 'member', 'suziyoga@yahoo.com', '2026-05-10 14:38:32.000000');

-- --------------------------------------------------------

--
-- Table structure for table `workouts`
--

CREATE TABLE `workouts` (
  `id` int(11) NOT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `level` text NOT NULL,
  `description` text NOT NULL,
  `create_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workouts`
--

INSERT INTO `workouts` (`id`, `trainer_id`, `title`, `level`, `description`, `create_at`) VALUES
(1, 3, 'Full Body Strength', 'Beginner', 'Beginner strength training focused on full body resistance exercises.', '2026-04-06 16:48:40.000000'),
(2, 1, 'Upper Body Power', 'Intermediate', 'Strength workout focused on chest, shoulders, back and arms', '2026-03-02 16:48:40.000000'),
(3, 2, 'Pilates Core Flow', 'Beginner', 'Pilates session focused on core strength, posture and flexibility', '2026-05-04 16:50:37.000000'),
(4, 2, 'Morning Yoga', 'Beginner', 'Relaxing yoga practice focused on flexibility and breathing', '2026-04-06 16:50:37.000000'),
(5, 1, 'Advanced Yoga', 'Advanced', 'Advanced yoga session focused on balance, mobility and endurance', '2026-05-04 16:50:37.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainer_id` (`trainer_id`);

--
-- Indexes for table `class_booking`
--
ALTER TABLE `class_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classes_id` (`classes_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD KEY `workout_id` (`workout_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `members_workouts`
--
ALTER TABLE `members_workouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`member_id`),
  ADD KEY `workout_id` (`workout_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `trainers`
--
ALTER TABLE `trainers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainers_ibfk_1` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workouts`
--
ALTER TABLE `workouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workouts_ibfk_1` (`trainer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_booking`
--
ALTER TABLE `class_booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `members_workouts`
--
ALTER TABLE `members_workouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trainers`
--
ALTER TABLE `trainers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `workouts`
--
ALTER TABLE `workouts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`trainer_id`) REFERENCES `trainers` (`id`);

--
-- Constraints for table `class_booking`
--
ALTER TABLE `class_booking`
  ADD CONSTRAINT `class_booking_ibfk_1` FOREIGN KEY (`classes_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `class_booking_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `exercises`
--
ALTER TABLE `exercises`
  ADD CONSTRAINT `exercises_ibfk_1` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `members_workouts`
--
ALTER TABLE `members_workouts`
  ADD CONSTRAINT `members_workouts_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  ADD CONSTRAINT `members_workouts_ibfk_2` FOREIGN KEY (`workout_id`) REFERENCES `workouts` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trainers`
--
ALTER TABLE `trainers`
  ADD CONSTRAINT `trainers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `workouts`
--
ALTER TABLE `workouts`
  ADD CONSTRAINT `workouts_ibfk_1` FOREIGN KEY (`trainer_id`) REFERENCES `trainers` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
