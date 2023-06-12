-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2023 at 12:30 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barterlt_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `item_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_type` varchar(15) NOT NULL,
  `item_desc` varchar(200) NOT NULL,
  `item_price` float NOT NULL,
  `item_qty` int(5) NOT NULL,
  `user_lat` varchar(15) NOT NULL,
  `user_long` varchar(15) NOT NULL,
  `user_state` varchar(30) NOT NULL,
  `user_locality` varchar(50) NOT NULL,
  `insert_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`item_id`, `user_id`, `item_name`, `item_type`, `item_desc`, `item_price`, `item_qty`, `user_lat`, `user_long`, `user_state`, `user_locality`, `insert_date`) VALUES
(1, 1, 'Pen', 'Stationary', 'Blue', 0, 0, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 05:17:22.773927'),
(2, 1, 'Pen', 'Stationary', 'Hello', 0, 0, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 05:22:43.691557'),
(3, 1, 'Pen 3', 'Stationary', 'Black', 10, 20, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 05:27:31.396792'),
(4, 1, 'Pen', 'Stationary', 'Black colour', 2, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 06:10:09.869070'),
(5, 1, 'iPhone 14 ', 'Smart gadgets', 'brand new', 4500, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 06:27:28.271690'),
(6, 1, 'iPhone 13', 'Smart gadgets', 'second hand condition 97%', 3000, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-06-13 06:28:15.648266');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
