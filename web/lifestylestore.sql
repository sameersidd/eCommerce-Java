-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2019 at 11:21 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lifestylestore`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(6) NOT NULL,
  `itemname` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `itemname`, `price`, `image`, `stock`) VALUES
(1, 'Canon EOS', 36000, '5.jpg', 10),
(2, 'Nikon DSLR', 40000, '1.jpg', 10),
(3, 'Sony DSLR', 45000, '3.jpg', 6),
(4, 'Olympus DSLR', 50000, '4.jpg', 8),
(5, 'Titan Model #301', 13000, '18.jpg', 2),
(6, 'Titan Model #201', 3000, '19.jpg', 10),
(7, 'HMT Milan', 8000, '20.jpg', 4),
(8, 'Faber Luba #111', 18000, '21.jpg', 6),
(9, 'H&W', 800, '22.jpg', 100),
(10, 'Luis Phil', 1000, '23.jpg', 4),
(11, 'John Zok', 1500, '24.jpg', 2),
(12, 'Jhalsani', 1300, '25.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `items_merch`
--

CREATE TABLE `items_merch` (
  `id` int(6) NOT NULL,
  `item_id` int(6) DEFAULT NULL,
  `merch_id` int(6) DEFAULT NULL,
  `merch_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items_merch`
--

INSERT INTO `items_merch` (`id`, `item_id`, `merch_id`, `merch_name`) VALUES
(1, 1, 1, 'lifestylestore'),
(2, 2, 1, 'lifestylestore'),
(3, 3, 1, 'lifestylestore'),
(4, 4, 1, 'lifestylestore'),
(5, 5, 1, 'lifestylestore'),
(6, 6, 1, 'lifestylestore'),
(7, 7, 1, 'lifestylestore'),
(8, 8, 1, 'lifestylestore'),
(9, 9, 1, 'lifestylestore'),
(10, 10, 1, 'lifestylestore'),
(11, 11, 1, 'lifestylestore'),
(12, 12, 1, 'lifestylestore');

-- --------------------------------------------------------

--
-- Table structure for table `item_description`
--

CREATE TABLE `item_description` (
  `id` int(6) NOT NULL,
  `item_id` int(6) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_description`
--

INSERT INTO `item_description` (`id`, `item_id`, `description`) VALUES
(1, 1, 'The EOS 1300D packs in all the fun of photography'),
(2, 2, 'Image quality, connectivity and creative control come together in this lightweight, full-featured DX-format DSLR. The new EXPEED 4 is our fastest image processor to date and complements the 24.2-megapixel CMOS. With its 39-point autofocus, improved white balance and wide sensitivity range, the D5300 lets you shoot stunning photos and Full HD movies. It’s our first DSLR to feature a built-in Wi-Fi, so you can instantly transfer your photos. Its GPS function saves location information to your images. A crystal-clear 3.2-inch LCD vari-angle monitor lets you shoot at any angle. With so many innovative features, the D5300 adds new dimensions to photography. '),
(3, 3, 'With a 50x optical zoom (100x Clear Image Zoom) and 20.4MP Exmor R CMOS sensor and BIONZ X image processor for peerless performance'),
(4, 4, 'Sporting a classic design and sleek form factor'),
(5, 5, 'This analog watch for men has patterned silver dial enclosed within a round'),
(6, 6, 'This analog watch for men has patterned silver dial enclosed within a round'),
(7, 7, 'Japanese quartz movement with analog-digital display'),
(8, 8, 'A classy Plain Casual shirt with structured cuts and regular fitting'),
(9, 9, 'The size is China size, it is smaller then USA size, pleae choose 2 sizes up! Any question please don\'t hesitate to contact us, will help you to solve problem.\r\n\r\nPackage:Other accessories not include\r\n\r\nMaterial:Polyester\r\nSize details:\r\nUS Small=China Medium:Length:26.38\"(67cm),Bust:37.80\"(96cm),Shoulder:16.14\"(41cm),Sleeve Length:23.62\"(60cm);\r\nUS Medium=China Large:Length:26.77\"(68cm),Bust:39.37\"(100cm),Shoulder:16.54\"(42cm),Sleeve Length:24.02\"(61cm);\r\nUS Large=China X-Large:Length:27.17\"(69cm),Bust:40.94\"(104cm),Shoulder:16.93\"(43cm),Sleeve Length:24.41\"(62cm);\r\nUS X-Large=China 2X-Large:Length:27.56\"(70cm),Bust:42.52\"(108cm),Shoulder:17.32\"(44cm),Sleeve Length:24.80\"(63cm);\r\nUS 2X-Large=China 3X-Large:Length:27.95\"(71cm),Bust:44.09\"(112cm),Shoulder:17.72\"(45cm),Sleeve Length:25.20\"(64cm);'),
(10, 10, 'A classy Plain Casual shirt with structured cuts and regular fitting'),
(11, 11, 'A classy Plain Casual shirt with structured cuts and regular fitting'),
(12, 12, 'A classy Plain Casual shirt with structured cuts and regular fitting');

-- --------------------------------------------------------

--
-- Table structure for table `merchants`
--

CREATE TABLE `merchants` (
  `id` int(3) NOT NULL,
  `m_name` varchar(100) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `contact` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `merchants`
--

INSERT INTO `merchants` (`id`, `m_name`, `password`, `email`, `contact`) VALUES
(1, 'Lifestylestore', '1234', 'estore@store.com', '923876827');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(6) NOT NULL,
  `user_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `quantity` int(2) NOT NULL DEFAULT '0',
  `order_status` enum('Added To Cart','Confirmed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `contact` varchar(12) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `contact`, `city`, `address`) VALUES
(1, 'Sameer Siddiqui', '1234', 'r@r.com', '9786587667', 'BlehCity', 'Blah at Blah Blah'),
(2, 'Test 1', '1234', 'Test1@Test.com', '388274702', 'BlahCity', 'Bleh at Bleh'),
(3, 'Test 2', '12345', 'Test2@Test.com', '388274702', 'Blah', 'Bleh at Bleh');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items_merch`
--
ALTER TABLE `items_merch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_key` (`item_id`),
  ADD KEY `merch_key` (`merch_id`),
  ADD KEY `mname_key` (`merch_name`);

--
-- Indexes for table `item_description`
--
ALTER TABLE `item_description`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_description_item_id_uindex` (`item_id`);

--
-- Indexes for table `merchants`
--
ALTER TABLE `merchants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `merchants_m_name_uindex` (`m_name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `Item_ID` (`item_id`),
  ADD KEY `User_ID` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `items_merch`
--
ALTER TABLE `items_merch`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `item_description`
--
ALTER TABLE `item_description`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `items_merch`
--
ALTER TABLE `items_merch`
  ADD CONSTRAINT `item_key` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `merch_key` FOREIGN KEY (`merch_id`) REFERENCES `merchants` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mname_key` FOREIGN KEY (`merch_name`) REFERENCES `merchants` (`m_name`) ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `Item_ID` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `User_ID` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
