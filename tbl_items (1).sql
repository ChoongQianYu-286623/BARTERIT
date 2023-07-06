-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2023 at 01:22 PM
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
(1, 1, 'Broom', 'Home & Living', 'New never use', 15, 5, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-03 14:25:30.862734'),
(2, 1, 'Iphone 14 pro max', 'Smart gadgets', 'condition 99% new', 4300, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-03 14:35:59.859955'),
(3, 1, 'Pen', 'Stationary', 'Brand : Pilot', 3.5, 15, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-03 14:40:13.239954'),
(4, 5, 'Hanger', 'Home & Living', 'Brown colour', 5, 20, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-03 17:05:15.916662'),
(5, 5, 'Men T-shirt', 'Clothing', 'Size M, condition 99% only wear once', 10, 3, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 12:22:08.845857'),
(6, 5, 'Foldable Chair', 'Home & Living', 'Black and White colour', 15, 2, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 16:17:35.101712'),
(7, 5, 'Keyboard', 'Computer', 'Still new not open yet', 400, 2, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 16:45:57.759272'),
(8, 6, 'Bowl', 'Home & Living', 'Made with wood', 20, 5, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 16:52:36.598497'),
(9, 6, 'Tote Bag', 'Accessories', 'Various pattern', 10, 10, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 16:54:59.488174'),
(10, 6, 'Slippers', 'Shoe', 'Color:Blue', 7, 3, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 16:57:09.684421'),
(11, 6, 'Necklace', 'Accessories', 'New with condition 98%', 99, 3, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 17:02:01.239907'),
(12, 7, 'Necklace', 'Accessories', 'wore twice only', 88, 3, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-04 21:42:24.829507'),
(13, 7, 'Harry Potter Book', 'Book', 'Full Set Collection', 60, 1, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-04 21:45:23.812832'),
(14, 5, 'Denim jeans pants', 'Clothing', 'Wore for once, skinny', 25, 2, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-05 11:36:20.696727'),
(15, 6, 'Nike air Force 1', 'Shoe', 'UK Size 7 men', 420, 1, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-05 11:38:37.648621'),
(16, 1, 'Long dress', 'Clothing', 'White color, v neck collar, material: satin, wear only once', 20, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-06 16:07:59.380225'),
(18, 1, 'Cushion', 'Cosmestic', 'Brand:YSL, Shade:15,Reason to sell: Brought wrong shade', 260, 1, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-06 16:21:37.190057'),
(19, 1, 'T-shirt', 'Clothing', 'Plain white, size M', 5, 2, '6.4318283', '100.4299967', 'Kedah', 'Changlun', '2023-07-06 16:37:18.391127'),
(20, 7, 'Basketball', 'Sports', 'Condition 80%,brought for 1 year', 35, 1, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-06 16:41:47.319504'),
(21, 5, 'Calculator', 'Stationary', 'Brand New Brand:Casio,Model:fx-570ex', 99, 1, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-06 17:27:51.722183');

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
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
