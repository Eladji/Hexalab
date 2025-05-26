-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: May 26, 2025 at 09:32 AM
-- Server version: 8.0.42
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `HexalabDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `User_Id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`User_Id`) VALUES
(2);

-- --------------------------------------------------------

--
-- Table structure for table `Comment`
--

CREATE TABLE `Comment` (
  `id` int NOT NULL,
  `Content` mediumtext NOT NULL,
  `Author_Id` int NOT NULL,
  `Replied_To_Comment_Id` int DEFAULT NULL,
  `Post_Id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Comment`
--

INSERT INTO `Comment` (`id`, `Content`, `Author_Id`, `Replied_To_Comment_Id`, `Post_Id`) VALUES
(1, 'Great tutorial, very helpful for beginners!', 3, NULL, 1),
(2, 'Thanks, Charlie! Glad you found it useful.', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Content`
--

CREATE TABLE `Content` (
  `id` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` longtext,
  `Creation_Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Path` varchar(255) NOT NULL,
  `Author_Id` int NOT NULL,
  `Type_Id` int DEFAULT NULL,
  `Contributor_Id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Content`
--

INSERT INTO `Content` (`id`, `Name`, `Description`, `Creation_Date`, `Path`, `Author_Id`, `Type_Id`, `Contributor_Id`) VALUES
(1, 'Introduction to SQL', 'A beginner-friendly guide to SQL basics.', '2025-05-19 09:38:30', '/content/sql-intro.pdf', 1, 1, NULL),
(2, 'Advanced Woodworking Techniques', 'Exploring joinery and finishing.', '2025-05-19 09:38:30', '/content/woodworking-advanced.html', 2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Notification`
--

CREATE TABLE `Notification` (
  `id` int NOT NULL,
  `Receiver_Id` int NOT NULL,
  `Content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Notification`
--

INSERT INTO `Notification` (`id`, `Receiver_Id`, `Content`) VALUES
(1, 3, 'Your request for \"Introduction to SQL\" has been approved!');

-- --------------------------------------------------------

--
-- Table structure for table `Peripheric`
--

CREATE TABLE `Peripheric` (
  `id` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Peripheric`
--

INSERT INTO `Peripheric` (`id`, `Name`, `Type`, `Description`) VALUES
(1, 'Microscope Model X', 'Optical', 'High-resolution lab microscope'),
(2, '3D Printer Pro', 'Fabrication', 'Desktop FDM 3D printer');

-- --------------------------------------------------------

--
-- Table structure for table `Request`
--

CREATE TABLE `Request` (
  `id` int NOT NULL,
  `Requester_Id` int NOT NULL,
  `State` tinyint NOT NULL,
  `Admin_Id` int DEFAULT NULL,
  `Content_Id` int NOT NULL,
  `Peripheric_Id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Request`
--

INSERT INTO `Request` (`id`, `Requester_Id`, `State`, `Admin_Id`, `Content_Id`, `Peripheric_Id`) VALUES
(1, 3, 1, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Type_Content`
--

CREATE TABLE `Type_Content` (
  `id` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Type_Content`
--

INSERT INTO `Type_Content` (`id`, `Name`) VALUES
(1, 'Tutorial'),
(2, 'Blog Post'),
(3, 'Research Paper');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `id` int NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Certified` tinyint(1) NOT NULL DEFAULT '0',
  `Pfp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`id`, `First_Name`, `Last_Name`, `Certified`, `Pfp`) VALUES
(1, 'Alice', 'Wonderland', 1, ''),
(2, 'Bob', 'The Builder', 0, ''),
(3, 'Charlie', 'Brown', 0, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`User_Id`);

--
-- Indexes for table `Comment`
--
ALTER TABLE `Comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Author_Id` (`Author_Id`),
  ADD KEY `Replied_To_Comment_Id` (`Replied_To_Comment_Id`),
  ADD KEY `Post_Id` (`Post_Id`);

--
-- Indexes for table `Content`
--
ALTER TABLE `Content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Author_Id` (`Author_Id`),
  ADD KEY `Type_Id` (`Type_Id`),
  ADD KEY `Contributor_Id` (`Contributor_Id`);

--
-- Indexes for table `Notification`
--
ALTER TABLE `Notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Receiver_Id` (`Receiver_Id`);

--
-- Indexes for table `Peripheric`
--
ALTER TABLE `Peripheric`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Request`
--
ALTER TABLE `Request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Requester_Id` (`Requester_Id`),
  ADD KEY `Admin_Id` (`Admin_Id`),
  ADD KEY `Content_Id` (`Content_Id`),
  ADD KEY `Peripheric_Id` (`Peripheric_Id`);

--
-- Indexes for table `Type_Content`
--
ALTER TABLE `Type_Content`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Comment`
--
ALTER TABLE `Comment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Content`
--
ALTER TABLE `Content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Notification`
--
ALTER TABLE `Notification`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Peripheric`
--
ALTER TABLE `Peripheric`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Request`
--
ALTER TABLE `Request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Type_Content`
--
ALTER TABLE `Type_Content`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Admin`
--
ALTER TABLE `Admin`
  ADD CONSTRAINT `Admin_ibfk_1` FOREIGN KEY (`User_Id`) REFERENCES `User` (`id`);

--
-- Constraints for table `Comment`
--
ALTER TABLE `Comment`
  ADD CONSTRAINT `Comment_ibfk_1` FOREIGN KEY (`Author_Id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `Comment_ibfk_2` FOREIGN KEY (`Replied_To_Comment_Id`) REFERENCES `Comment` (`id`),
  ADD CONSTRAINT `Comment_ibfk_3` FOREIGN KEY (`Post_Id`) REFERENCES `Content` (`id`);

--
-- Constraints for table `Content`
--
ALTER TABLE `Content`
  ADD CONSTRAINT `Content_ibfk_1` FOREIGN KEY (`Author_Id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `Content_ibfk_2` FOREIGN KEY (`Type_Id`) REFERENCES `Type_Content` (`id`),
  ADD CONSTRAINT `Content_ibfk_3` FOREIGN KEY (`Contributor_Id`) REFERENCES `User` (`id`);

--
-- Constraints for table `Notification`
--
ALTER TABLE `Notification`
  ADD CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`Receiver_Id`) REFERENCES `User` (`id`);

--
-- Constraints for table `Request`
--
ALTER TABLE `Request`
  ADD CONSTRAINT `Request_ibfk_1` FOREIGN KEY (`Requester_Id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `Request_ibfk_2` FOREIGN KEY (`Admin_Id`) REFERENCES `Admin` (`User_Id`),
  ADD CONSTRAINT `Request_ibfk_3` FOREIGN KEY (`Content_Id`) REFERENCES `Content` (`id`),
  ADD CONSTRAINT `Request_ibfk_4` FOREIGN KEY (`Peripheric_Id`) REFERENCES `Peripheric` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
