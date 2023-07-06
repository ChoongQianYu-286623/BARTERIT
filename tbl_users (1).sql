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
(1, 'choongqianyu@gmail.com', 'Choong Qian Yu', '0123456789', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '2023-05-19 22:22:21.750411', 44498),
(2, 'waishan@gmail.com', 'Hoong Wai Shan', '0165982634', '3812d2d805f9ebc6fbface75ed417f80af3810d6', '2023-05-20 21:57:32.760083', 55553),
(4, 'choongyen@gmail.com', 'Ng Choong Yen', '01298409342', 'f3b38e0a838df821fd169a820e92eb7a96dbe882', '2023-05-21 00:10:37.666627', 68291),
(5, 'pankahheng@gmail.com', 'Pan Kah Heng', '017-6429715', '211a9d07a975e3466ec679fd16b6b070637ebc2e', '2023-07-03 16:56:48.256481', 22662),
(6, 'leeminho@gmail.com', 'Lee Min Ho', '0125678910', '832670c2a0766e1c46e718fe35aedd6a30aa394f', '2023-07-04 16:49:06.439035', 46823),
(7, 'ngenying@gmail.com', 'Ng En Ying', '0197268364', 'a75f0aec50b58b7c0d7ae4983cff786975437d51', '2023-07-04 21:34:21.758044', 39828);

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
