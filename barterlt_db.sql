-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2023 at 07:25 PM
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
-- Table structure for table `tbl_cards`
--

CREATE TABLE `tbl_cards` (
  `card_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `card_name` varchar(50) NOT NULL,
  `card_number` varchar(50) NOT NULL,
  `card_month` int(5) NOT NULL,
  `card_year` int(5) NOT NULL,
  `card_cvv` int(5) NOT NULL,
  `card_type` varchar(50) NOT NULL,
  `card_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_cards`
--

INSERT INTO `tbl_cards` (`card_id`, `user_id`, `card_name`, `card_number`, `card_month`, `card_year`, `card_cvv`, `card_type`, `card_datereg`) VALUES
(1, 5, 'Pan Kah Heng', '1234  5678  9999  0203', 2, 26, 888, 'Visa', '2023-07-20 02:23:05.189706'),
(2, 1, 'Choong Qian Yu', '1234  6678  3378  0025', 8, 24, 499, 'Visa', '2023-07-20 13:53:49.976241');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `cart_id` int(5) NOT NULL,
  `item_id` int(5) NOT NULL,
  `cart_qty` int(5) NOT NULL,
  `cart_price` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `seller_id` int(5) NOT NULL,
  `cart_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_carts`
--

INSERT INTO `tbl_carts` (`cart_id`, `item_id`, `cart_qty`, `cart_price`, `user_id`, `seller_id`, `cart_date`) VALUES
(4, 9, 1, 10, 5, 6, '2023-07-18 15:08:11.022860'),
(5, 1, 2, 30, 5, 1, '2023-07-19 21:47:49.717898');

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
(4, 5, 'Hanger', 'Home & Living', 'Brown colour', 5, 19, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-03 17:05:15.916662'),
(5, 5, 'Men T-shirt', 'Clothing', 'Size M, condition 99% only wear once', 10, 3, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 12:22:08.845857'),
(6, 5, 'Foldable Chair', 'Home & Living', 'Black and White colour', 15, 2, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 16:17:35.101712'),
(7, 5, 'Keyboard', 'Computer', 'Still new not open yet', 400, 2, '6.4406317', '100.19837', 'Perlis', 'Kangar', '2023-07-04 16:45:57.759272'),
(8, 6, 'Bowl', 'Home & Living', 'Made with wood', 20, 3, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 16:52:36.598497'),
(9, 6, 'Tote Bag', 'Accessories', 'Various pattern', 10, 9, '5.43803', '100.3881917', 'Pulau Pinang', 'Butterworth', '2023-07-04 16:54:59.488174'),
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

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orderdetails`
--

CREATE TABLE `tbl_orderdetails` (
  `orderdetails_id` int(5) NOT NULL,
  `item_id` varchar(5) NOT NULL,
  `order_bill` int(6) NOT NULL,
  `orderdetails_qty` int(5) NOT NULL,
  `orderdetails_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `orderdetails_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_orderdetails`
--

INSERT INTO `tbl_orderdetails` (`orderdetails_id`, `item_id`, `order_bill`, `orderdetails_qty`, `orderdetails_paid`, `buyer_id`, `seller_id`, `orderdetails_date`) VALUES
(1, '4', 854306, 1, 5, '1', '5', '2023-07-20 23:35:14.299148'),
(2, '9', 163348, 1, 10, '1', '6', '2023-07-21 00:24:46.975682'),
(3, '8', 439992, 1, 20, '1', '6', '2023-07-21 00:42:51.892501');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(5) NOT NULL,
  `order_bill` int(6) NOT NULL,
  `order_paid` float NOT NULL,
  `user_id` int(5) NOT NULL,
  `seller_id` int(5) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_id`, `order_bill`, `order_paid`, `user_id`, `seller_id`, `order_date`) VALUES
(1, 854306, 5, 1, 5, '2023-07-20 23:35:14.296889'),
(2, 163348, 10, 1, 6, '2023-07-21 00:24:46.973641'),
(3, 439992, 20, 1, 6, '2023-07-21 00:42:51.885206');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_phone` varchar(15) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `user_otp` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_datereg`, `user_otp`) VALUES
(1, 'choongqianyu@gmail.com', 'Choong Qian Yu', '0198765431', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '2023-05-19 22:22:21.750411', 44498),
(2, 'waishan@gmail.com', 'Hoong Wai Shan', '0165982634', '3812d2d805f9ebc6fbface75ed417f80af3810d6', '2023-05-20 21:57:32.760083', 55553),
(4, 'choongyen@gmail.com', 'Ng Choong Yen', '01298409342', 'f3b38e0a838df821fd169a820e92eb7a96dbe882', '2023-05-21 00:10:37.666627', 68291),
(5, 'pankahheng@gmail.com', 'Pan Kah Heng', '017-6429716', '211a9d07a975e3466ec679fd16b6b070637ebc2e', '2023-07-03 16:56:48.256481', 22662),
(6, 'leeminho@gmail.com', 'Lee Min Ho', '0125678910', '832670c2a0766e1c46e718fe35aedd6a30aa394f', '2023-07-04 16:49:06.439035', 46823),
(7, 'ngenying@gmail.com', 'Ng En Ying', '0197268364', 'a75f0aec50b58b7c0d7ae4983cff786975437d51', '2023-07-04 21:34:21.758044', 39828);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_cards`
--
ALTER TABLE `tbl_cards`
  ADD PRIMARY KEY (`card_id`);

--
-- Indexes for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_orderdetails`
--
ALTER TABLE `tbl_orderdetails`
  ADD PRIMARY KEY (`orderdetails_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `order_bill` (`order_bill`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_cards`
--
ALTER TABLE `tbl_cards`
  MODIFY `card_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  MODIFY `cart_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tbl_orderdetails`
--
ALTER TABLE `tbl_orderdetails`
  MODIFY `orderdetails_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
