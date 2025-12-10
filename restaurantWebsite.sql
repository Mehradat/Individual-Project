-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 10, 2025 at 05:40 PM
-- Server version: 8.0.40
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurantWebsite`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `message`) VALUES
(1, 'Mehrad Ata', 'mehrad.ata@gmail.com', 'thanks'),
(4, 'puja', 'pujaaa@gmail.com', 'thankyouuuu'),
(5, 'eli ela', 'eli@yahoo.com', 'hiii'),
(6, 'Mehrad Ata', 'mehrad.ata@gmail.com', 'dffdfd'),
(7, 'Mehrad Ata', 'mehrad.ata@gmail.com', 'thank you for your delicious food!!');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `username`, `message`) VALUES
(1, 5, 'mehrad', 'thanks for your food '),
(2, NULL, NULL, 'hiii'),
(3, NULL, NULL, 'hiii'),
(4, NULL, NULL, 'perfect'),
(5, 4, 'admin', 'thank you'),
(6, NULL, NULL, 'I leave a messege here');

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `fid` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`fid`, `name`, `price`, `description`, `image`) VALUES
(9, 'American Pizza', 15.00, 'A classic cheesy pizza with a rich, savory American-style flavor', 'dish--1.png'),
(10, 'Beef Wrap', 12.00, 'A warm tortilla filled with seasoned beef and fresh ingredients.', 'dish--2.png'),
(11, 'Lasagna', 14.00, 'Layers of pasta, rich meat sauce, and melted cheese baked to perfection.', 'dish--4.png'),
(12, 'Grilled Salmon', 18.00, 'Fresh salmon grilled until tender with a light, buttery flavor.', 'dish--3.png'),
(13, 'Spaghetti', 11.00, 'A hearty pasta dish tossed in a rich, flavorful tomato sauce.', 'dish--7.png'),
(14, 'French Fries', 5.00, 'Crispy golden fries seasoned lightly for a perfect snack.', 'dish--5.png'),
(15, 'Chicken Wings', 14.00, 'Tender, flavorful wings cooked to a crisp and served hot.', 'dish--12.png'),
(16, 'Fresh Salad', 7.00, 'A mix of crisp greens and veggies served with a light dressing.', 'dish--13.png'),
(17, 'Vegetable Dish', 8.00, 'A colorful mix of fresh sautéed vegetables with light seasoning.', 'dish--9.png');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `image`, `title`) VALUES
(8, 'dish--2.png', 'Beef Wrap'),
(9, 'dish--1.png', 'American Pizza'),
(10, 'dish--4.png', 'Lasagna'),
(11, 'dish--3.png', 'Grilled Salmon'),
(12, 'dish--7.png', 'Spaghetti'),
(13, 'dish--5.png', 'French Fries	'),
(14, 'dish--12.png', 'Chicken Wings'),
(15, 'dish--13.png', 'Fresh Salad'),
(16, 'dish--9.png', 'Vegetable Dish'),
(17, 'dish--8.png', 'Pasta'),
(18, 'dish--6.png', 'Chicken with Salad');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text,
  `role` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `phone`, `address`, `role`) VALUES
(2, 'Mehradata', 'mehradata', 'mehrad.ata@gmail.com', '+16479926422', '1432 White Oaks Blvd\r\n0\r\noaks blvd', 1),
(4, 'admin', 'admin', 'admin@gmail.com', '+16479926422', 'admin', 2),
(5, 'mehrad', 'mehrad', 'mehrad@gmail.com', '16479926422', 'mehrad', 1),
(6, 'sara', 'sara', 'sara@gmail.com', '11111111', 'sara', 1),
(7, 'ali', 'ali', 'ali@gmail.com', 'ali', 'ali', 1),
(9, 'mahsa', 'mahsa', 'mahsa@gmail.com', 'mahsa', 'mahsa', 1),
(10, 'alii', 'alii', 'alii@gmail.com', 'alii', 'alii', 1),
(11, 'mehrshad', 'mehrshad', 'mehrshad@gmail.com', 'mehrshad', 'mehrshad', 1),
(12, 'hasan', 'hasan', 'hasan@gmail.com', 'hasan', 'hasan\r\n', 1),
(13, 'al', 'al', 'al@gmail.com', 'al', 'al', 1),
(14, 'sa', 'sa', 'sa@sss.com', 'sa', 'sa', 1),
(15, 'ma', 'ma', 'ma@g', 'ma', 'ma', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `fid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
