-- MySQL dump 10.13  Distrib 5.5.33, for Linux (x86_64)
--
-- Host: localhost    Database: cnxcc
-- ------------------------------------------------------
-- Server version	5.5.33-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS cnxcc;
USE cnxcc;
--
-- Table structure for table `acc`
--

DROP TABLE IF EXISTS `acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(16) NOT NULL DEFAULT '',
  `from_tag` varchar(64) NOT NULL DEFAULT '',
  `to_tag` varchar(64) NOT NULL DEFAULT '',
  `callid` varchar(128) NOT NULL DEFAULT '',
  `sip_code` char(3) NOT NULL DEFAULT '',
  `sip_reason` varchar(32) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `src_ip` varchar(64) NOT NULL DEFAULT '',
  `dst_ouser` varchar(64) NOT NULL DEFAULT '',
  `dst_user` varchar(64) NOT NULL DEFAULT '',
  `dst_domain` varchar(128) NOT NULL DEFAULT '',
  `src_user` varchar(64) NOT NULL DEFAULT '',
  `src_domain` varchar(128) NOT NULL DEFAULT '',
  `cdr_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acc_callid` (`callid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc`
--

LOCK TABLES `acc` WRITE;
/*!40000 ALTER TABLE `acc` DISABLE KEYS */;
/*!40000 ALTER TABLE `acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aliases`
--

DROP TABLE IF EXISTS `aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aliases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ruid` varchar(64) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `domain` varchar(64) DEFAULT NULL,
  `contact` varchar(255) NOT NULL DEFAULT '',
  `received` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `expires` datetime NOT NULL DEFAULT '2020-05-28 21:32:15',
  `q` float(10,2) NOT NULL DEFAULT '1.00',
  `callid` varchar(255) NOT NULL DEFAULT 'Default-Call-ID',
  `cseq` int(11) NOT NULL DEFAULT '1',
  `last_modified` datetime NOT NULL DEFAULT '1900-01-01 00:00:01',
  `flags` int(11) NOT NULL DEFAULT '0',
  `cflags` int(11) NOT NULL DEFAULT '0',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `socket` varchar(64) DEFAULT NULL,
  `methods` int(11) DEFAULT NULL,
  `instance` varchar(255) DEFAULT NULL,
  `reg_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `alias_idx` (`username`,`domain`,`contact`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aliases`
--

LOCK TABLES `aliases` WRITE;
/*!40000 ALTER TABLE `aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdr`
--

DROP TABLE IF EXISTS `cdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr` (
  `cdr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subscriber` varchar(64) NOT NULL,
  `destination` varchar(30) NOT NULL,
  `duration` int(11) NOT NULL,
  `call_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cost` decimal(10,5) NOT NULL,
  `callid` varchar(255) NOT NULL,
  `from_tag` varchar(64) NOT NULL,
  `to_tag` varchar(64) NOT NULL,
  `direction` varchar(8) NOT NULL,
  PRIMARY KEY (`cdr_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr`
--

LOCK TABLES `cdr` WRITE;
/*!40000 ALTER TABLE `cdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cdrs`
--

DROP TABLE IF EXISTS `cdrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdrs` (
  `cdr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `src_username` varchar(64) NOT NULL DEFAULT '',
  `src_domain` varchar(128) NOT NULL DEFAULT '',
  `dst_username` varchar(64) NOT NULL DEFAULT '',
  `dst_domain` varchar(128) NOT NULL DEFAULT '',
  `dst_ousername` varchar(64) NOT NULL DEFAULT '',
  `call_start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `sip_call_id` varchar(128) NOT NULL DEFAULT '',
  `sip_from_tag` varchar(128) NOT NULL DEFAULT '',
  `sip_to_tag` varchar(128) NOT NULL DEFAULT '',
  `src_ip` varchar(64) NOT NULL DEFAULT '',
  `cost` int(11) NOT NULL DEFAULT '0',
  `rated` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  PRIMARY KEY (`cdr_id`),
  UNIQUE KEY `uk_cft` (`sip_call_id`,`sip_from_tag`,`sip_to_tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdrs`
--

LOCK TABLES `cdrs` WRITE;
/*!40000 ALTER TABLE `cdrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cdrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit`
--

DROP TABLE IF EXISTS `credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit` (
  `subscriber` varchar(64) NOT NULL,
  `credit` decimal(10,5) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`subscriber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit`
--

LOCK TABLES `credit` WRITE;
/*!40000 ALTER TABLE `credit` DISABLE KEYS */;
INSERT INTO `credit` VALUES ('5951000',4.70924,'2013-03-26 13:17:19'),('5951001',0.00000,'2013-03-23 18:53:32'),('5951002',4.81822,'2013-03-29 15:43:06'),('5951003',9.59087,'2013-03-27 21:06:32'),('5951004',66.00000,'2013-04-11 00:28:51'),('5951006',9.79070,'2013-03-25 14:04:40'),('5951007',3.65580,'2013-03-25 14:50:27'),('5951008',7.89530,'2013-03-25 04:04:35'),('5951010',5.00000,'2013-03-25 04:04:29'),('5951017',4.40460,'2013-03-25 14:03:31'),('5951018',4.79980,'2013-03-26 20:12:08'),('5951026',3.54890,'2013-04-05 15:00:52'),('5951027',4.97270,'2013-03-26 14:01:00'),('5951029',4.98636,'2013-04-03 20:04:37'),('5951030',0.39000,'2013-04-03 05:38:08'),('5951031',0.39000,'2013-04-12 13:54:20'),('5951032',0.39000,'2013-04-12 14:04:16'),('5951033',0.39000,'2013-04-12 14:11:10');
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `subscriber` varchar(64) DEFAULT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL DEFAULT '123456',
  `email` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `activate` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `country` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `unique_subscriber` (`subscriber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tri_get_subscriber_number` BEFORE INSERT ON `customers` 
    FOR EACH ROW BEGIN
    
	declare v_subscriber varchar(7);

	SELECT MAX(subscriber) + 1 into v_subscriber FROM customers;
		
	
	if v_subscriber is null then
		SELECT MAX(username) + 1 INTO v_subscriber FROM subscriber WHERE username <> 'frompstn';
	end if;
	
	set new.subscriber = v_subscriber;
	
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tri_create_subscriber_on_activation` AFTER UPDATE ON `customers` 
    FOR EACH ROW BEGIN
	if old.status <> 0 and new.status = 0 then
		insert into subscriber values(NULL, new.subscriber, 'sip.sigapy.com', 
								new.password, new.email, 
								md5(concat(new.subscriber, ':sip.sigapy.com:', new.password)),
								md5(CONCAT(new.subscriber, '@sip.sigapy.com:sip.sigapy.com:', new.password)), NULL);
	end if;
	
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dialog`
--

DROP TABLE IF EXISTS `dialog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dialog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash_entry` int(10) unsigned NOT NULL,
  `hash_id` int(10) unsigned NOT NULL,
  `callid` varchar(255) NOT NULL,
  `from_uri` varchar(128) NOT NULL,
  `from_tag` varchar(64) NOT NULL,
  `to_uri` varchar(128) NOT NULL,
  `to_tag` varchar(64) NOT NULL,
  `caller_cseq` varchar(20) NOT NULL,
  `callee_cseq` varchar(20) NOT NULL,
  `caller_route_set` varchar(512) DEFAULT NULL,
  `callee_route_set` varchar(512) DEFAULT NULL,
  `caller_contact` varchar(128) NOT NULL,
  `callee_contact` varchar(128) NOT NULL,
  `caller_sock` varchar(64) NOT NULL,
  `callee_sock` varchar(64) NOT NULL,
  `state` int(10) unsigned NOT NULL,
  `start_time` int(10) unsigned NOT NULL,
  `timeout` int(10) unsigned NOT NULL DEFAULT '0',
  `sflags` int(10) unsigned NOT NULL DEFAULT '0',
  `iflags` int(10) unsigned NOT NULL DEFAULT '0',
  `toroute_name` varchar(32) DEFAULT NULL,
  `req_uri` varchar(128) NOT NULL,
  `xdata` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hash_idx` (`hash_entry`,`hash_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dialog`
--

LOCK TABLES `dialog` WRITE;
/*!40000 ALTER TABLE `dialog` DISABLE KEYS */;
/*!40000 ALTER TABLE `dialog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dialog_vars`
--

DROP TABLE IF EXISTS `dialog_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dialog_vars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash_entry` int(10) unsigned NOT NULL,
  `hash_id` int(10) unsigned NOT NULL,
  `dialog_key` varchar(128) NOT NULL,
  `dialog_value` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hash_idx` (`hash_entry`,`hash_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dialog_vars`
--

LOCK TABLES `dialog_vars` WRITE;
/*!40000 ALTER TABLE `dialog_vars` DISABLE KEYS */;
/*!40000 ALTER TABLE `dialog_vars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `htable`
--

DROP TABLE IF EXISTS `htable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `htable` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key_name` varchar(64) NOT NULL DEFAULT '',
  `key_type` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `key_value` varchar(128) NOT NULL DEFAULT '',
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `htable`
--

LOCK TABLES `htable` WRITE;
/*!40000 ALTER TABLE `htable` DISABLE KEYS */;
/*!40000 ALTER TABLE `htable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ruid` varchar(64) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `domain` varchar(64) DEFAULT NULL,
  `contact` varchar(255) NOT NULL DEFAULT '',
  `received` varchar(128) DEFAULT NULL,
  `path` varchar(128) DEFAULT NULL,
  `expires` datetime NOT NULL DEFAULT '2020-05-28 21:32:15',
  `q` float(10,2) NOT NULL DEFAULT '1.00',
  `callid` varchar(255) NOT NULL DEFAULT 'Default-Call-ID',
  `cseq` int(11) NOT NULL DEFAULT '1',
  `last_modified` datetime NOT NULL DEFAULT '1900-01-01 00:00:01',
  `flags` int(11) NOT NULL DEFAULT '0',
  `cflags` int(11) NOT NULL DEFAULT '0',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `socket` varchar(64) DEFAULT NULL,
  `methods` int(11) DEFAULT NULL,
  `instance` varchar(255) DEFAULT NULL,
  `reg_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `account_contact_idx` (`username`,`domain`,`contact`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price` (
  `subscriber` varchar(64) NOT NULL,
  `prefix` varchar(30) NOT NULL,
  `initial_pulse` int(11) NOT NULL,
  `final_pulse` int(11) NOT NULL,
  `inbound_call_cps` decimal(10,5) NOT NULL,
  `outbound_call_cps` decimal(10,5) NOT NULL,
  `inbound_sms_cpu` decimal(10,5) NOT NULL,
  `outbound_sms_cpu` decimal(10,5) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`subscriber`,`prefix`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES ('*','09',1,1,0.00065,0.00130,0.00000,0.11678,'0000-00-00 00:00:00'),('5951000','0',30,6,0.00065,0.00130,0.00000,0.11678,'0000-00-00 00:00:00'),('5951000','098',30,6,0.00065,0.00130,0.00000,0.11678,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reason`
--

DROP TABLE IF EXISTS `reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reason` (
  `reason` varchar(20) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`reason`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reason`
--

LOCK TABLES `reason` WRITE;
/*!40000 ALTER TABLE `reason` DISABLE KEYS */;
INSERT INTO `reason` VALUES ('nocredit','No Credit'),('notfound','Customer Not Found'),('congestion','Channel Congestion'),('noanswer','Callee\'s No Answer'),('invalidnumber','Invalid Dialed Number'),('wrongcodec','Invalid Codec Configuration');
/*!40000 ALTER TABLE `reason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `route_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'186.2.196.140','Parla'),(2,'192.168.2.104','Home');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriber`
--

DROP TABLE IF EXISTS `subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `domain` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(25) NOT NULL DEFAULT '',
  `email_address` varchar(64) NOT NULL DEFAULT '',
  `ha1` varchar(64) NOT NULL DEFAULT '',
  `ha1b` varchar(64) NOT NULL DEFAULT '',
  `rpid` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_idx` (`username`,`domain`),
  KEY `username_idx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
INSERT INTO `subscriber` VALUES (1,'5951003','sip.sigapy.com','1234','','e20a62e8d44e0280c85c110505034c68','1ae6e8a547562d86d4e240d1d7e942b1',NULL),(2,'5951000','sip.sigapy.com','123456','','d075344ab81ba6d080e8631e6e5792bf','f2c47654842fdee245150187abb63429',NULL),(3,'5951001','sip.sigapy.com','1234','','6e5cef1fb956cd7c1e7c8fe52c177a08','383830229620e4a6017c8018e861ab18',NULL),(4,'5951004','sip.sigapy.com','1234','','50165882cd0f2bd38deb4d82f741d014','9880ba3523ee52da40a707cea09813b7',NULL),(5,'5951005','sip.sigapy.com','1234','','57acd3255011aecb1021451194f9ad9e','58bcfec34d35cc7b1bd26f733c808be5',NULL),(6,'5951006','sip.sigapy.com','1234','','6227bb23ca895c58dac6bc0b2aa54592','315bc8049dc2d445f41ba5e1cee2102d',NULL),(7,'5951007','sip.sigapy.com','1234','','27fb5fb2d1a585dd0e9ecf37cc5dc1b2','109ba5d0cb27356fa11dd1f414ab0025',NULL),(8,'5951008','sip.sigapy.com','1234','','7eefcbb41ff8df48d58cbff0e867b2ef','b71a9dec1f1d4e2fd2e270917b161a3e',NULL),(9,'5951009','sip.sigapy.com','1234','','6a37ad9993e1afc7fed75b4d97dcefb3','181fa57150d5adde5f2d77e891b2bb90',NULL),(10,'5951010','sip.sigapy.com','1234','','08d5990ad9d6f8dd6e4c5d79f1f307ec','2be8c9e780206cd2c7b84cba287bf6f2',NULL),(11,'5951011','sip.sigapy.com','1234','','70f083ffa41079410f2b586801dfe5cb','062bd8cfc0aa37270c3e7c6f8c611601',NULL),(12,'5951012','sip.sigapy.com','1234','','ff85da5e9b5eb9db1f5f8beb5fc9a5af','5af314e6ef3f46b37b4927c2fbe8be38',NULL),(13,'5951013','sip.sigapy.com','1234','','306d891ca2241e37908682317038cea5','080584bf9800118737b44039e5b864c6',NULL),(14,'5951014','sip.sigapy.com','1234','','3176442194571b34725c35028f2a8b5c','27db1af0b3074aaef8a785ba7f459824',NULL),(15,'5951015','sip.sigapy.com','1234','','3e8da0efb86fd5069c1bcb9c675a4e44','efe2111e2edba576099e7cf86d026807',NULL),(16,'frompstn','sip.sigapy.com','dualstagepapa','','db1441fc16eb126d664c909a0b0cdfcb','8860b8296399cffecca15e7740001ebb',NULL),(17,'5951016','sip.sigapy.com','ivanpassword','','a32b3f33fb7ff5e2b45ef6e6729e5834','be1ba4202ad77fd12c48d1dd68eb3fa6',NULL),(18,'5951017','sip.sigapy.com','1234','','dea7779333b0026ca6772fa91a6fa900','ac25e32386804b697e4391054dc0105b',NULL),(19,'5951018','sip.sigapy.com','1234','','b1122fad41f83043104a40ab0ccc0f4c','ff9c17dbb6ad2d362c016702ab4fdc5e',NULL),(20,'5951019','sip.sigapy.com','1234','','42b84533002450d1a54a3ab630e3c5a0','7d91f3ffde5855cf375ce10d7e88e497',NULL),(21,'5951020','sip.sigapy.com','1234','','1b97c5bdf12a94b752dfb3578af4ef0a','993b9911a075e6833aef29ea4043077d',NULL),(22,'5951021','sip.sigapy.com','1234','','58597d29a853c8b535ac1af38ec78da3','f8ed314a44cea9f5daf7e6f3afc2a32c',NULL),(23,'5951022','sip.sigapy.com','1234','','667fd0d3316da50b2c39d2aed46a6a4b','357df54120f2396a2e0269761f7f0afd',NULL),(24,'5951023','sip.sigapy.com','1234','','c608386337afc3390120394b2964f1e7','26e02700c5d7a42484b032064c65a554',NULL),(25,'5951024','sip.sigapy.com','1234','','e295667246d5c49c97cf66b7a3197fb6','7fce214149652a7e1fbcb7ec1cf4a7cc',NULL),(26,'5951025','sip.sigapy.com','1234','','89d200a0791ff139ee25df3c419e00dd','bf87b908e91dc869f29e47e5d806c1f9',NULL),(27,'5951026','sip.sigapy.com','1234','','7ad256260d4c886669710e4e1e825acc','dd3beedbbd9644b82e12daeebe71d102',NULL),(28,'5951027','sip.sigapy.com','1234','','e253b01b3c9fc3dc315f533d520b5e23','674a05b7395a378789e68cba504046a7',NULL),(29,'5951028','sip.sigapy.com','1234','','98e579230e5dcb2ba69e2eaf54fb9ef0','35a51f6c8085bbf54d4453fa3f8a3e51',NULL),(30,'5951002','sip.sigapy.com','1234','','b7e46d5350a1559337ac46d6af5022f7','b3203624cb44a4dda3360f6c825c90ac',NULL),(38,'5951029','sip.sigapy.com','123456','carlos.ruizdiaz@gmail.com','6b08922450ce2fbad1f517fcc4aaddf1','a370b83b2610143f4eddc773a09afd78',NULL),(40,'5951030','sip.sigapy.com','123','griart@gmail.com','6ea8fd6d3c3018bc0d42f54ba2ff5361','f92bee96f0e202e334727683832a8f4e',NULL),(42,'5951031','sip.sigapy.com','123','griart@gmail.com','81699d9c21543fff2860407982ed3331','c74806dda7f4260dac186784017a6fe4',NULL),(44,'5951032','sip.sigapy.com','123','griart@gmail.com','37d95e43939cf71d8015b355d61ea7bc','2f8300c8ebeba771efebb8c4f359623a',NULL),(45,'5951033','sip.sigapy.com','123','griart@gmail.com','de4acf3df4e9bc545b68d0ba9170ed98','8e5914933aa50bfbe182c9bdfb213b49',NULL);
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `tri_setup_new_subscriber` AFTER INSERT ON `subscriber` 
    FOR EACH ROW BEGIN
	DECLARE v_message VARCHAR(300) DEFAULT 'Hola ';
	DECLARE v_credit DECIMAL(10, 5);
		
        SET v_message = CONCAT(v_message, (SELECT firstname FROM customers WHERE subscriber = new.username), '! Te damos la bienvenida a sigapy. Si tienes alguna duda, no dudes en escribirnos un email a service@sigapy.com. Que disfrutes del servicio :)');	
		
	INSERT INTO smsqueue(to_subs, sms, from_number) VALUES (new.username, v_message, 'service');	
	
	
	SELECT (outbound_call_cps * 60 * 5) INTO v_credit FROM price WHERE subscriber = '*' ORDER BY last_update DESC LIMIT 1;	
	
	INSERT INTO credit VALUES(new.username, 0, CURRENT_TIMESTAMP);
	insert into accreditation values(NULL, new.username, v_credit, current_timestamp, null);
	
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `table_name` varchar(32) NOT NULL,
  `table_version` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('acc',4),('missed_calls',3),('lcr_gw',2),('lcr_rule_target',1),('lcr_rule',2),('domain',2),('domain_attrs',1),('grp',2),('re_grp',1),('trusted',5),('address',5),('aliases',5),('location',5),('silo',7),('dbaliases',1),('uri',1),('speed_dial',2),('usr_preferences',2),('subscriber',6),('pdt',1),('dialog',7),('dialog_vars',1),('dispatcher',4),('dialplan',1),('presentity',3),('active_watchers',11),('watchers',3),('xcap',4),('pua',7),('rls_presentity',1),('rls_watchers',3),('imc_rooms',1),('imc_members',1),('cpl',1),('sip_trace',3),('domainpolicy',2),('carrierroute',3),('carrierfailureroute',2),('carrier_name',1),('domain_name',1),('userblacklist',1),('globalblacklist',1),('htable',2),('purplemap',1),('uacreg',1),('pl_pipes',1),('mtree',1),('mtrees',2);
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_acc_cdrs`
--

DROP TABLE IF EXISTS `vw_acc_cdrs`;
/*!50001 DROP VIEW IF EXISTS `vw_acc_cdrs`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_acc_cdrs` (
  `idi` tinyint NOT NULL,
  `idb` tinyint NOT NULL,
  `subscriber` tinyint NOT NULL,
  `destination` tinyint NOT NULL,
  `start_datetime` tinyint NOT NULL,
  `duration` tinyint NOT NULL,
  `completed` tinyint NOT NULL,
  `reason` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_calls_per_server`
--

DROP TABLE IF EXISTS `vw_calls_per_server`;
/*!50001 DROP VIEW IF EXISTS `vw_calls_per_server`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_calls_per_server` (
  `server` tinyint NOT NULL,
  `number_of_calls` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_credits`
--

DROP TABLE IF EXISTS `vw_credits`;
/*!50001 DROP VIEW IF EXISTS `vw_credits`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_credits` (
  `subscriber` tinyint NOT NULL,
  `credit` tinyint NOT NULL,
  `last_update` tinyint NOT NULL,
  `outbound_mins` tinyint NOT NULL,
  `inbound_mins` tinyint NOT NULL,
  `sms` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_acc_cdrs`
--

/*!50001 DROP TABLE IF EXISTS `vw_acc_cdrs`*/;
/*!50001 DROP VIEW IF EXISTS `vw_acc_cdrs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_acc_cdrs` AS select `a`.`id` AS `idi`,`b`.`id` AS `idb`,`a`.`src_user` AS `subscriber`,if((`b`.`src_user` = `a`.`src_user`),`b`.`dst_ouser`,`b`.`src_user`) AS `destination`,`a`.`time` AS `start_datetime`,sec_to_time((`b`.`time` - `a`.`time`)) AS `duration`,if(((length(`a`.`dst_user`) >= 6) and (length(`a`.`dst_ouser`) >= 6) and (substr(`a`.`dst_user`,-(6)) = substr(`a`.`dst_ouser`,-(6)))),'yes','no') AS `completed`,`r`.`description` AS `reason` from ((`acc` `a` left join `acc` `b` on((`a`.`callid` = `b`.`callid`))) left join `reason` `r` on((`a`.`dst_user` = `r`.`reason`))) where ((`a`.`method` = 'INVITE') and (`b`.`method` = 'BYE') and (`a`.`sip_code` = 200) and (`b`.`sip_code` = 200) and (`a`.`src_domain` = 'cnxcc.caruizdiaz.com')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_calls_per_server`
--

/*!50001 DROP TABLE IF EXISTS `vw_calls_per_server`*/;
/*!50001 DROP VIEW IF EXISTS `vw_calls_per_server`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_calls_per_server` AS select `acc`.`dst_domain` AS `server`,count(0) AS `number_of_calls` from `acc` where ((`acc`.`method` = 'INVITE') and `acc`.`dst_domain` in (select `route`.`ip` from `route`)) group by `acc`.`dst_domain` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_credits`
--

/*!50001 DROP TABLE IF EXISTS `vw_credits`*/;
/*!50001 DROP VIEW IF EXISTS `vw_credits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_credits` AS select `credit`.`subscriber` AS `subscriber`,`credit`.`credit` AS `credit`,`credit`.`last_update` AS `last_update`,sec_to_time((`credit`.`credit` / (select `price`.`outbound_call_cps` from `price` where (`price`.`subscriber` = '*')))) AS `outbound_mins`,sec_to_time((`credit`.`credit` / (select `price`.`inbound_call_cps` from `price` where (`price`.`subscriber` = '*')))) AS `inbound_mins`,floor((`credit`.`credit` / (select `price`.`outbound_sms_cpu` from `price` where (`price`.`subscriber` = '*')))) AS `sms` from `credit` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-26 13:41:33
