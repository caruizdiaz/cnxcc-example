-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: cnxcc
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `call`
--

DROP TABLE IF EXISTS `call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call` (
  `call_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `confirmed` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `max_amount` decimal(12,5) DEFAULT NULL,
  `consumed_amount` decimal(12,5) DEFAULT NULL,
  `start_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`call_id`),
  KEY `FK_call_credit_data` (`client_id`),
  CONSTRAINT `FK_call_credit_data` FOREIGN KEY (`client_id`) REFERENCES `credit_data` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call`
--

LOCK TABLES `call` WRITE;
/*!40000 ALTER TABLE `call` DISABLE KEYS */;
/*!40000 ALTER TABLE `call` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cdr`
--

LOCK TABLES `cdr` WRITE;
/*!40000 ALTER TABLE `cdr` DISABLE KEYS */;
INSERT INTO `cdr` VALUES (1,'1100','0981146623',19,'2014-03-27 06:10:47','0.02470','cyopsvvnmbmzxvx@caru-laptop','jfepb','1','outbound'),(2,'1100','0991123456',3,'2014-03-27 06:11:18','3.00000','eomhhpecgxlbilc@caru-laptop','jmzwn','2','outbound'),(3,'1100','0981146623',10,'2014-03-27 06:21:43','0.01300','vvnvgyzycxxpevb@caru-laptop','reykk','4','outbound'),(4,'1100','0991123456',4,'2014-03-27 06:21:56','4.00000','kfnabkhdiyrfuvv@caru-laptop','dwfyr','5','outbound'),(5,'1100','0991123456',3,'2014-03-27 06:27:04','3.00000','gbkaeclwxkilfhd@caru-laptop','qwzps','7','outbound'),(6,'1100','0981146623',88,'2014-03-27 06:46:16','0.11440','iwngbjlvbpdimtc@caru-laptop','nteru','10','outbound'),(7,'1100','0981146623',292,'2014-03-27 06:52:27','0.37960','oecvufaqqxrthld@caru-laptop','amhpg','11','outbound'),(8,'1100','0981146623',12,'2014-03-27 07:22:53','0.01560','hnogrddhnidobza@caru-laptop','jocks','13','outbound'),(9,'1100','0971123456',54,'2014-03-27 07:23:42','0.07020','mfgmxybprttzmhc@caru-laptop','gadlv','14','outbound'),(10,'1100','0971123456',18,'2014-03-27 07:23:52','0.02340','iydavwxevpqohxo@caru-laptop','zdwvu','15','outbound'),(11,'1100','0981146623',94,'2014-03-27 08:04:44','0.12220','lonuqaoqvdakrtr@caru-laptop','kgtot','11','<null>'),(12,'1100','0981146623',4,'2014-03-27 08:07:20','0.00520','blqtehawvzxcgld@caru-laptop','pgean','12','<null>'),(13,'1100','0981146623',4,'2014-03-27 08:11:46','0.00520','naxjayyekoeqeeb@caru-laptop','zpplg','13','<null>'),(14,'1100','0981146623',4,'2014-03-27 08:12:54','0.00520','ebshvyvncjlqmqv@caru-laptop','vzdfx','14','<null>'),(15,'1000','0991236457',34,'2014-03-27 08:13:59','0.04420','kmlTmxMv8cdfN.8NmEOLrh2HcOknxbI2','daB9tIJ6gyfskrgSTuK49BT3Uo31DPei','15','<null>'),(16,'1000','0991123456',10,'2014-03-27 08:15:09','5.00000','62dhKFYTCU9uke3Wgzfy1g5AG2rZtfSt','sTtQeWt-DynPkAMsNjiduwuDF36-diU0','16','outbound'),(17,'1100','0981111111',0,'2014-03-27 08:22:08','0.00000','cunnhuxdekdvdfg@caru-laptop','ewmhz','21','outbound'),(18,'1100','0981111111',0,'2014-03-27 08:24:54','0.00000','agoutcnscemavwm@caru-laptop','uaxxh','22','outbound'),(19,'1100','0981111111',0,'2014-03-27 08:25:44','0.00000','rlzyvmajeovsyyb@caru-laptop','lxhhy','24','outbound'),(20,'1000','0981123456',49,'2014-03-27 08:26:11','0.06370','aNRq7TfeR61cHl2rgfcVATZe--30ddXt','.ETTD1j8X3IeR83UpbEsjMtxri0aakiX','23','outbound'),(21,'1100','0981111111',0,'2014-03-27 08:28:05','0.00000','rjojpghjwwbkohw@caru-laptop','pvipu','25','outbound'),(22,'1100','0981111111',0,'2014-03-27 08:36:27','0.00000','fccwomwyuzsqmnd@caru-laptop','sngwx','26','outbound'),(23,'1100','0981111111',0,'2014-03-27 08:36:57','0.00000','dujqfvxcwivlzlw@caru-laptop','sbftg','27','outbound'),(24,'1100','0981111111',0,'2014-03-27 08:37:40','0.00000','vyvhqdqrnkrnixi@caru-laptop','ncycj','28','<null>'),(25,'1000','0981146623',27,'2014-03-27 08:44:31','0.03510','SjpJ.vmNDvCC2ZwivFD0FBTRpcGaboA.','46CFxhifEJmfVVt9JvogX43qA-BQ4-dd','30','outbound'),(26,'1000','0981123456',18,'2014-03-27 08:48:05','0.02340','p16H6hxCsbOUQ0OUo3fbKHR7OpIY8WNn','8zh5TrxU5wxnqN4HmGODmlUdcGKyu3Rm','31','outbound'),(27,'1100','0981111111',0,'2014-03-27 08:50:15','0.00000','xxswuxsbfagldtm@caru-laptop','rxomb','32','outbound');
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
INSERT INTO `credit` VALUES ('1000','9.92200','0000-00-00 00:00:00'),('1100','0.24730','2014-03-27 05:49:23');
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_data`
--

DROP TABLE IF EXISTS `credit_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_data` (
  `credit_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `max_amount` decimal(12,5) DEFAULT '0.00000',
  `consumed_amount` decimal(12,5) DEFAULT '0.00000',
  `number_of_calls` int(11) DEFAULT '0',
  `concurrent_calls` int(11) DEFAULT '0',
  `credit_type_id` int(11) DEFAULT NULL,
  `client_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`credit_data_id`),
  UNIQUE KEY `client_id_unique` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_data`
--

LOCK TABLES `credit_data` WRITE;
/*!40000 ALTER TABLE `credit_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_data` ENABLE KEYS */;
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
  `country` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_subscriber` (`subscriber`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (3,'1100','Carlos','Ruiz Diaz','PY','2014-03-27 05:48:22');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (9,'uloc-5333d0f4-512b-1','1000',NULL,'sip:1000@201.141.236.38:49411;ob','sip:201.141.236.38:49411',NULL,'2014-03-27 04:53:54',-1.00,'U-MChsoNhNAL8ANraL2RC58FCgZcUYv-',28420,'2014-03-27 04:38:54',0,64,'CSipSimple_GT-I9100-16/r2330','udp:107.170.102.188:5070',8159,NULL,0),(5,'uloc-533360a4-eb9-3','1100',NULL,'sip:1100@192.168.3.102:5062','sip:201.141.236.38:43634',NULL,'2014-03-27 05:40:11',-1.00,'hjlzohhrdfdbkwl@caru-laptop',462,'2014-03-27 04:40:11',0,64,'Twinkle/1.4.2','udp:107.170.102.188:5070',6111,NULL,0);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `money_based_call`
--

DROP TABLE IF EXISTS `money_based_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money_based_call` (
  `call_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `cost_per_second` decimal(10,6) NOT NULL,
  `initial_pulse` int(11) NOT NULL,
  `final_pulse` int(11) NOT NULL,
  PRIMARY KEY (`call_id`),
  CONSTRAINT `FK_money_based_call_callid` FOREIGN KEY (`call_id`) REFERENCES `call` (`call_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money_based_call`
--

LOCK TABLES `money_based_call` WRITE;
/*!40000 ALTER TABLE `money_based_call` DISABLE KEYS */;
/*!40000 ALTER TABLE `money_based_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'Admin'),(2,'Basic'),(3,'Basic + Can Drop Calls');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
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
  `initial_cost` int(11) NOT NULL,
  `final_cost` int(11) NOT NULL,
  `outbound_call_cps` decimal(10,5) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`subscriber`,`prefix`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES ('*','09',1,1,'0.00130','0000-00-00 00:00:00'),('*','099',1,1,'0.50000','0000-00-00 00:00:00'),('1100','098111111',0,0,'0.00000','0000-00-00 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
INSERT INTO `subscriber` VALUES (1,'1000','cnxcc.caruizdiaz.com','1234','','afd9023714188c1e268732a0421d6793','a78ee501f52a42c346b914694af47c3f',NULL),(2,'1100','cnxcc.caruizdiaz.com','1234','','b523ae07cc2871d6b9ef802123bc132e','2bf994fed362ec43ac5dd18aedab7910',NULL);
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `version` VALUES ('acc',4),('missed_calls',3),('lcr_gw',2),('lcr_rule_target',1),('lcr_rule',2),('domain',2),('domain_attrs',1),('grp',2),('re_grp',1),('trusted',5),('address',5),('aliases',5),('location',6),('silo',7),('dbaliases',1),('uri',1),('speed_dial',2),('usr_preferences',2),('subscriber',6),('pdt',1),('dialog',7),('dialog_vars',1),('dispatcher',4),('dialplan',1),('presentity',3),('active_watchers',11),('watchers',3),('xcap',4),('pua',7),('rls_presentity',1),('rls_watchers',3),('imc_rooms',1),('imc_members',1),('cpl',1),('sip_trace',3),('domainpolicy',2),('carrierroute',3),('carrierfailureroute',2),('carrier_name',1),('domain_name',1),('userblacklist',1),('globalblacklist',1),('htable',2),('purplemap',1),('uacreg',1),('pl_pipes',1),('mtree',1),('mtrees',2);
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-27  4:51:05
