-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB
-- Host: localhost         Database: FCDB

SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `Jobs`
--

DROP TABLE IF EXISTS Jobs;
CREATE TABLE `Jobs` (
  `job_id` int(10) NOT NULL AUTO_INCREMENT UNIQUE,
  `customer_id` int(10) NOT NULL,
  `category_id` int(10),
  `job_code` varchar(255) NOT NULL,
  `job_start_date` date NOT NULL,
  `job_end_date` date,
  `job_description` varchar(255),
  `job_status` varchar(255) NOT NULL,
  PRIMARY KEY (`job_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`),
  FOREIGN KEY (`category_id`) REFERENCES  `Categories`(`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Jobs`
--

LOCK TABLES `Jobs` WRITE;
INSERT INTO `Jobs` (`job_id`, `customer_id`, `category_id`, `job_code`, `job_start_date`, `job_end_date`,
                    `job_description`, `job_status`)
VALUES
(1,5,1,'SFR01', '2020-01-18','2020-03-18', 'Single Family Home Repair 2 Windows double pane', 'Complete'),
(2,1,1,'SFR02','2020-01-24','2020-03-24', 'Single Family Home Repair 3 burst Pipes', 'Complete'),
(3,16,1, 'SF03', '2020-01-27', '2020-04-04','Modular Single Family Home Build on Lot - 3 bed/2ba', 'Complete'),
(4,10,2,'CN01', '2020-02-01','2020-06-30', 'Condo Building - 2 units', 'Complete'),
(5,2,2,'CN02','2020-04-13','2020-10-10', 'Condo Building - 10 units', 'Complete'),
(6,1,2, 'CN03', '2020-04-26', '2020-11-12','Condo Build - 20 units', 'Complete'),
(7,2,3,'TH01', '2020-05-03','2020-07-02', 'Townhome Build - 1 unit', 'Complete'),
(8,8,3,'TH02','2020-05-20','2020-07-19', 'Townhome Build - 4 units', 'Complete'),
(9,24,3,'TH03', '2020-07-05', '2020-09-03','Townhome Build - 4 units', 'Complete'),
(10,17,3,'TH04', '2020-07-06','2020-09-04', 'Townhome Build -Complex', 'Complete'),
(11,11,3,'TH05','2020-07-16','2020-09-14', 'Townhome Build -Complex', 'Complete'),
(12,23,4,'MF01', '2020-07-17', '2020-08-26','Multi-family Build - Duplex 1000 sq ft', 'Complete'),
(13,6,4,'MF02', '2020-07-25','2020-09-03', 'Multi-family Build - Duplex 2000 sq ft', 'Complete'),
(14,24,4,'MF03','2020-07-26','2020-09-04', 'Multi-family Build - Duplex 2000 sq ft', 'Complete'),
(15,15,5,'HWR01','2020-08-05', '2020-10-04','Highway Repair - 4 Potholes', 'Complete'),
(16,11,5,'HWR02','2020-08-05','2020-10-04', 'Highway Repair - Shoulder repair - 1500 feet', 'Complete'),
(17,21,5,'HWR03', '2020-08-12', '2020-10-11','Highway Repair - Repaving 1/2 mile', 'Complete'),
(18,22,5,'HWR04', '2020-08-29','2020-10-28', 'Highway Repair - Repaving 1/4 mile', 'Complete'),
(19,17,6,'PL01','2020-08-29','2021-02-25', 'Pipeline Build - 2.5 miles', 'Complete'),
(20,14,6,'PL02', '2020-09-07', '2021-03-06','Pipeline Build - 4 miles', 'Complete'),
(21,8,6,'PL03','2020-09-23','2021-03-22', 'Pipeline Build - 1.5 miles', 'Complete'),
(22,17,8,'RRR01', '2020-10-14', '2021-04-12','Railway Maintenance - 10 miles', 'Complete'),
(23,8,8,'RR01', '2020-10-26','2021-04-24', 'Railway Build - Station', 'Complete'),
(24,21,8,'RR02','2020-11-27','2021-05-26', 'Railway Build - 2 mile rail', 'Complete'),
(25,15,8,'RR03', '2020-12-01', '2021-05-30','Railway Build - 5 mile rail', 'Complete'),
(26,19,7,'RD01','2020-12-07','2021-01-06', 'Road Build - street 100 feet - 2 lane', 'Complete'),
(27,6,7,'RD02', '2020-12-30', '2021-02-08','Road Build - street 500 feet - 2 lane', 'Complete'),
(28,3,7,'RD03', '2021-01-05','2021-02-24', 'Road Build - street 560 feet - 1 lane','Complete'),
(29,7,7,'RD04','2021-01-28','2021-03-19', 'Road Build - street 100 feet - 2 lane','Complete'),
(30,9,7,'RD05', '2021-02-15', '2021-04-06','Road Build - street 250 feet - 2 lane', 'Complete'),
(31,6,7,'RD06','2021-03-09','2021-04-28', 'Road Build - street 750 feet - 2 lane', 'Complete'),
(32,15,7,'RD07', '2021-03-16', '2021-05-05','Road Build - street 250 feet - 2 lane', 'Complete'),
(33,9,1,'SF04', '2021-03-28','2021-06-16', 'Modular Single Family Home Build - 4 bed/2ba','Complete'),
(34,16,1,'SF05','2021-04-01','2021-07-05', ' Modular Single Family Home Build - 4 bed/2ba','Complete'),
(35,21,1,'SF06', '2021-04-11', '2021-06-30','Modular Single Family Home Build - 3 bed/2ba', 'Complete'),
(36,5,1,'SF07','2021-06-27','2021-09-30', 'Modular Single Family Home Build - 3 bed/2ba', 'Complete'),
(37,2,1,'SF08', '2021-07-13', '2021-10-01','Modular Single Family Home Build - 2 bed/2ba', 'Complete'),
(38,12,5,'HW01', '2021-07-22','2022-01-18', 'Highway Build - 2 miles-4 lane','Complete'),
(39,23,8,'RR05','2021-07-22','2022-01-18', 'Railway Build - 2 miles','Complete'),
(40,11,6,'PL04', '2021-07-31', '2022-01-27','Pipeline Build - 10 miles', 'Complete'),
(41,6,11,'SP01','2021-08-22','2022-02-18', 'Sports Facility Repair - Bathrooms x2', 'Complete'),
(42,3,11,'SP02', '2021-08-29', '2022-02-25','Sports Facility Repair - Tennis court repair', 'Complete'),
(43,13,2,'CN04', '2021-09-08','2021-10-18', 'Condo Build - 1 room/1 ba','Complete'),
(44,25,7,'RD08','2021-09-12','2021-11-06', 'Road Build - 50 feet - 1 lane','Complete'),
(45,21,7,'RD09', '2021-10-19', '2021-12-13','Road Build - 50 feet - 1 lane', 'Complete'),
(46,19,7,'RD10','2021-11-04','2022-12-29', 'Road Build - 10 feet - 2 lane', 'Complete'),
(47,2,9,'RES01', '2021-11-19', NULL, 'Restaurant Repair - Full Wall repair', 'In Progress'),
(48,4,9,'RES02', '2021-11-30', NULL, 'Restaurant Repair - Restoration of kitchen - 500 square feet', 'In Progress'),
(49,2,10,'MED01','2022-01-04', NULL, 'Medical Facility Repair - Roof repair 2500 sq feet','In Progress'),
(50,5,10,'MED02', '2022-01-15', NULL, 'Medical Facility Repair - Parking lot repair -  70,000 sq ft', 'In Progress')
ON DUPLICATE KEY UPDATE `category_id` = `category_id`;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT UNIQUE,
  `customer_first_name` varchar(255) NOT NULL,
  `customer_last_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_phone` varchar(255) NOT NULL,
  `customer_company` varchar(255) NOT NULL,
  `customer_address1` varchar(255) NOT NULL,
  `customer_address2` varchar(255),
  `customer_city` varchar(255) NOT NULL,
  `customer_state` varchar(2) NOT NULL,
  `customer_zipcode` int(5) NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `full_name` (`customer_first_name`,`customer_last_name`)
  )ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
INSERT INTO `Customers` (`customer_id`, `customer_first_name`,`customer_last_name`,  `customer_email`, `customer_phone`,
                         `customer_address1`, `customer_city`, `customer_state`,`customer_zipcode`, `customer_company`)
VALUES
(1,'Laila','Robertson', 'lailarobertson@gmail.com','(581) 982-7934', '11 Brook St.', 'Hope Mills', 'NC', 23348,'Green-Lowe'),
(2,'Cristina','Murray', 'cristinamurray@gmail.com','(995) 323-768', '148 Ridge Avenue', 'Dickson', 'TN', 37055,'Bradtke Group'),
(3,'Hamza','Richards', 'hamzarichards@gmail.com','(276) 978-1218', '158 Corona Street', 'Millville', 'NJ', 83321,'Wisoky LLC'),
(4,'Mia','Shannon', 'miashannon@gmail.com','(522) 894-6880', '2 Marlborough Rd.', 'Sarasota', 'FL', 34231,'Bartoletti and Sons'),
(5,'Ishaan','Perkins', 'ishaanperkins@gmail.com','(817) 437-7014', '21 Rock Creek Street', 'El Dorado', 'AR', 41730,'Lind LLC'),
(6,'Lorena','Roy', 'lroy@gmail.com','(318) 442-6235', '3 Rockwell Ave.', 'Royal Oak', 'MI', 48067,'Turcotte, Murray and Hayes'),
(7,'Brett','Barrera', 'bbarrera@gmail.com','(542) 259-0411', '36 Mayfield Court', 'Fishers', 'IN', 46037,'Morar, Bashirian and Nader'),
(8,'Carsen','Lowe', 'clowe@gmail.com','(432) 613-7627', '36 N. Deerfield Ave.', 'Bethel Park', 'PA', 15102,'Kohler, Goldner and Schaden'),
(9,'Eliza','Moon', 'emoon@gmail.com','(809) 760-5081', '430 Old 8th Drive', 'Sidney', 'OH', 45365,'Wisozk - Kassulke'),
(10,'McKayla','Walker', 'mwalker@gmail.com','(311) 515-1073', '460 Roosevelt Ave.', 'Boca Raton', 'FL', 33428,'Ferry, Jakubowski and Hessel'),
(11,'Camron','Rivera', 'crivera@gmail.com','(316) 251-2083', '52 W. North Court', 'Owensboro', 'KY', 42301,'Conn and Sons'),
(12,'Addisyn','Flynn', 'aflynn@gmail.com','(453) 400-0361', '548 North Cedar Swamp Ave.', 'South Windsor', 'CT', 60745,'Veum, Dietrich and Erdman'),
(13,'Ivan','Scott', 'iscott@gmail.com','(204) 397-3707', '692 Constitution Lane', 'Bonita Springs', 'FL', 34135,'Jenkins - Reynolds'),
(14,'Hector','Mack', 'hmack@gmail.com','(769) 723-4219', '7008 South Harrison St.', 'Elkridge', 'MD', 21075,'Legros - Schimmel'),
(15,'Greta','Holden', 'gholden@gmail.com','(956) 967-8736', '742 Spring Lane', 'Downers Grove', 'IL', 60515,'Austin Creative Solutions'),
(16,'Amaris','Hoffman', 'amhof@gmail.com','(381) 283-9459', '7613 Pulaski Street', 'Coraopolis', 'PA', 15108,'Smitham LLC'),
(17,'Bella','Huffman', 'behuf@gmail.com','(973) 682-0297', '7866 E. Ashley Ave.', 'Lake Mary', 'FL', 32746,'Greenfelder, Hudson and Kohler'),
(18,'Selena','Finley', 'sefin@gmail.com','(502) 454-7075', '856 Randall Mill Road', 'North Haven', 'CT', 64734,'Harris Inc'),
(19,'Cash','Lynn', 'calyn@gmail.com','(527) 509-8838', '8577 College Ave.', 'Pensacola', 'MA', 32503,'Bogan, Reilly and Runolfsdottir'),
(20,'Keagan','Butler', 'kebut@gmail.com','(355) 959-2763', '886 West St.', 'Fitchburg', 'MD', 14205,'Krajcik LLC'),
(21,'Slade','Conrad', 'slcon@gmail.com','(936) 219-4685', '89 Monroe St.', 'Dundalk', 'MD', 21222,'Medhurst LLC'),
(22,'Kali','Hendricks', 'kalihendricks@gmail.com','(789) 756-7755', '90 Catherine Street', 'Oakland Gardens', 'NY', 11364,'VonRueden - Kiehn'),
(23,'Jordan','Pennington', 'jpennington@gmail.com','(525) 524-2074', '9113 Essex St.', 'Jackson', 'NJ', 85274,'Murphy, Lind and Jaskolski'),
(24,'Mareli','Fuller', 'mfuller@gmail.com','(484) 334-6413', '9502 E. Paris Hill Ave.', 'Grayslake', 'IL', 60030,'Johnston, Watsica and Hettinger'),
(25,'Francis','Ortiz', 'fortiz@gmail.com','(893) 524-1644', '964 Wilson Lane', 'Holly Spring', 'NC', 27540,'Hegmann, Hickle and Effertz');
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY (`category_id`)
  )ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
INSERT INTO `Categories` (`category_id`, `category_name`)
VALUES
(1,'Single Family Home'),
(2,'Condominium'),
(3,'Townhome'),
(4,'Multifamily'),
(5,'Highway'),
(6,'Pipeline'),
(7,'Road'),
(8,'Railroad'),
(9,'Restaurant'),
(10,'Medical Facility'),
(11,'Sports Facility');
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `employee_id` int(10) NOT NULL AUTO_INCREMENT UNIQUE,
  `employee_code` varchar(255) NOT NULL UNIQUE,
  `employee_first_name` varchar(255) NOT NULL,
  `employee_last_name` varchar(255) NOT NULL,
  `employee_email` varchar(255) NOT NULL,
  `employee_job_title` varchar(255) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `full_name` (`employee_first_name`,`employee_last_name`)
  ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Employees`
--
LOCK TABLES `Employees` WRITE;
INSERT INTO `Employees` (`employee_id`, `employee_code`,`employee_first_name`, `employee_last_name`, `employee_email`,
                         `employee_job_title`)
VALUES 
(1,'SUSW','Susan','Werner','swerner@falconstruction.com','Foreman'),
(2,'JESH','Jessica','Henry','jhenry@falconstruction.com','Foreman'),
(3,'DAVH','David','Hunt','dhunt@falconstruction.com','Foreman'),
(4,'CHES','Cheryl','Smith','csmith@falconstruction.com','Foreman'),
(5,'DONG','Donald','Gates','dgates@falconstruction.com','Foreman'),
(6,'JONS','Jonathan','Sanchez','jsanchez@falconstruction.com','Foreman'),
(7,'JOHB','John','Brown','jbrown@falconstruction.com','Foreman'),
(8,'NICR','Nicholas','Rivera','nrivera@falconstruction.com','Foreman'),
(9,'DAKB','Dakota','Barry','dbarry@falconstruction.com','Foreman'),
(10,'BARL','Barbara','Larry','blamb@falconstruction.com','Foreman'),
(11,'JOAR','Joan','Rogers','jrogers@falconstruction.com','Foreman'),
(12,'DANH','Danny','Hamilton','dhamilton@falconstruction.com','Foreman'),
(13,'STEA','Stephen','Avery','savery@falconstruction.com','Foreman'),
(14,'MELF','Melissa','Francis','mfrancis@falconstruction.com','Foreman'),
(15,'AMYJ','Amy','Jones','ajones@falconstruction.com','Foreman'),
(16,'KEVM','Kevin','Mason','kmason@falconstruction.com','Foreman'),
(17,'JASH','Jason','Hernandez','khernandez@falconstruction.com','Foreman'),
(18,'MARH','Mark','Holder','mholder@falconstruction.com','Foreman'),
(19,'SHEK','Shelly','Kennedy','skennedy@falconstruction.com','Foreman'),
(20,'JAMR','James','Rodriguez','jrodriguez@falconstruction.com','Foreman'),
(21,'BRIH','Brianna','Schneider','bhernandez@falconstruction.com','Foreman'),
(22,'JENR','Jennifer','Roberts','jroberts@falconstruction.com','Foreman'),
(23,'TARH','Tara','Hannah','thanna@falconstruction.com','Foreman'),
(24,'MARH','Mariah','Hines','mhines@falconstruction.com','Foreman'),
(25,'KARJ','Karen','Jones','kjones@falconstruction.com','Foreman'),
(26,'ROBS','Robin','Schneider','rschneider@falconstruction.com','Foreman'),
(27,'KEIB','Keith','Boyer', '7kboyer@falconstruction.com','Foreman'),
(28,'TYRW','Tyrone','Wright','twright@falconstruction.com','Foreman'),
(29,'PAUB','Paul','Bauer','pbaur@falconstruction.com','Foreman'),
(30,'VICC','Vicki','Carter','vcarter@falconstruction.com','Foreman');
UNLOCK TABLES;

--
-- Table structure for table `Job_Employees`
--

DROP TABLE IF EXISTS `Job_Employees`;
CREATE TABLE `Job_Employees` (
  `job_employee_id` int(10) NOT NULL AUTO_INCREMENT UNIQUE,
  `employee_id` int(10) UNIQUE,
  `job_id` int(10) UNIQUE,
  PRIMARY KEY (`job_employee_id`),
  FOREIGN KEY (`employee_id`) REFERENCES Employees (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`job_id`) REFERENCES Jobs (`job_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Job_Employees`
--

LOCK TABLES `Job_Employees` WRITE;
INSERT INTO `Job_Employees` (`job_employee_id`,`job_id`,`employee_id`)
VALUES 
(1,22,1),
(2,23,2),
(3,27,2),
(4,24,3),
(5,28,3),
(6,4,4),
(7,10,4),
(8,34,4),
(9,25,5),
(10,29,5),
(11,38,6),
(12,45,6),
(13,5,7),
(14,35,7),
(15,30,8),
(16,39,8),
(17,6,9),
(18,36,9),
(19,37,10),
(20,43,10),
(21,1,11),
(22,12,11),
(23,2,12),
(24,11,12),
(25,13,12),
(26,26,13),
(27,15,14),
(28,46,14),
(29,49,15),
(30,50,16),
(31,16,17),
(32,7,18),
(33,14,18),
(34,17,19),
(35,31,19),
(36,47,20),
(37,18,21),
(38,32,21),
(39,19,22),
(40,44,22),
(41,48,23),
(42,20,24),
(43,3,25),
(44,8,25),
(45,21,26),
(46,41,27),
(47,9,28),
(48,33,28),
(49,40,29),
(50,42,30);
UNLOCK TABLES;
