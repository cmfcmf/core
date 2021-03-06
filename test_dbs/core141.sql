-- MySQL dump 10.13  Distrib 5.5.42, for osx10.6 (i386)
--
-- Host: localhost    Database: upgrading14
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `admin_category`
--

DROP TABLE IF EXISTS `admin_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortorder` int(11) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_category`
--

LOCK TABLES `admin_category` WRITE;
/*!40000 ALTER TABLE `admin_category` DISABLE KEYS */;
INSERT INTO `admin_category` VALUES (1,'System','Core modules at the heart of operation of the site.',0),(2,'Layout','Layout modules for controlling the site\'s look and feel.',0),(3,'Users','Modules for controlling user membership, access rights and profiles.',0),(4,'Content','Modules for providing content to your users.',0),(5,'Uncategorised','Newly-installed or uncategorized modules.',0),(6,'Security','Modules for managing the site\'s security.',0);
/*!40000 ALTER TABLE `admin_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_module`
--

DROP TABLE IF EXISTS `admin_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_module` (
  `amid` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `sortorder` int(11) NOT NULL,
  PRIMARY KEY (`amid`),
  KEY `mid_cid` (`mid`,`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_module`
--

LOCK TABLES `admin_module` WRITE;
/*!40000 ALTER TABLE `admin_module` DISABLE KEYS */;
INSERT INTO `admin_module` VALUES (1,1,1,0),(2,12,1,1),(3,13,2,0),(4,2,1,2),(5,8,3,0),(6,5,3,1),(7,3,2,1),(8,14,3,2),(9,11,6,0),(10,4,4,0),(11,6,1,3),(12,10,4,1),(13,9,1,4);
/*!40000 ALTER TABLE `admin_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_placements`
--

DROP TABLE IF EXISTS `block_placements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_placements` (
  `pid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `sortorder` int(11) NOT NULL,
  PRIMARY KEY (`pid`,`bid`),
  KEY `bid_pid_idx` (`bid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_placements`
--

LOCK TABLES `block_placements` WRITE;
/*!40000 ALTER TABLE `block_placements` DISABLE KEYS */;
INSERT INTO `block_placements` VALUES (1,1,0),(2,4,0),(3,3,0),(4,2,0),(7,5,0);
/*!40000 ALTER TABLE `block_placements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_positions`
--

DROP TABLE IF EXISTS `block_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_positions` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_positions`
--

LOCK TABLES `block_positions` WRITE;
/*!40000 ALTER TABLE `block_positions` DISABLE KEYS */;
INSERT INTO `block_positions` VALUES (1,'left','Left blocks'),(2,'right','Right blocks'),(3,'center','Center blocks'),(4,'search','Search block'),(5,'header','Header block'),(6,'footer','Footer block'),(7,'topnav','Top navigation block'),(8,'bottomnav','Bottom navigation block');
/*!40000 ALTER TABLE `block_positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `bkey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8_unicode_ci NOT NULL,
  `mid` int(11) NOT NULL,
  `filter` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `active` int(11) NOT NULL,
  `collapsable` int(11) NOT NULL,
  `defaultstate` int(11) NOT NULL,
  `refresh` int(11) NOT NULL,
  `last_update` datetime NOT NULL,
  `language` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `active_idx` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (1,'Extmenu','Main menu','Main menu','a:5:{s:14:\"displaymodules\";s:1:\"0\";s:10:\"stylesheet\";s:11:\"extmenu.css\";s:8:\"template\";s:25:\"Block/Extmenu/extmenu.tpl\";s:11:\"blocktitles\";a:1:{s:2:\"en\";s:9:\"Main menu\";}s:5:\"links\";a:1:{s:2:\"en\";a:5:{i:0;a:7:{s:4:\"name\";s:4:\"Home\";s:3:\"url\";s:10:\"{homepage}\";s:5:\"title\";s:19:\"Go to the home page\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:1;a:7:{s:4:\"name\";s:14:\"Administration\";s:3:\"url\";s:24:\"{Admin:admin:adminpanel}\";s:5:\"title\";s:29:\"Go to the site administration\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:2;a:7:{s:4:\"name\";s:10:\"My Account\";s:3:\"url\";s:19:\"{ZikulaUsersModule}\";s:5:\"title\";s:24:\"Go to your account panel\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:3;a:7:{s:4:\"name\";s:7:\"Log out\";s:3:\"url\";s:31:\"{ZikulaUsersModule:user:logout}\";s:5:\"title\";s:20:\"Log out of this site\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:4;a:7:{s:4:\"name\";s:11:\"Site search\";s:3:\"url\";s:20:\"{ZikulaSearchModule}\";s:5:\"title\";s:16:\"Search this site\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}}}}','',3,'a:0:{}',1,1,1,3600,'2016-08-13 18:04:12',''),(2,'Search','Search box','Search block','a:2:{s:16:\"displaySearchBtn\";i:1;s:6:\"active\";a:1:{s:17:\"ZikulaUsersModule\";i:1;}}','',10,'a:0:{}',1,1,1,3600,'2016-08-13 18:04:12',''),(3,'Html','This site is powered by Zikula!','HTML block','<p><a href=\"http://zikula.org/\">Zikula</a> is a content management system (CMS) and application framework. It is secure and stable, and is a good choice for sites with a large volume of traffic.</p><p>With Zikula:</p><ul><li>you can customise all aspects of the site\'s appearance through themes, with support for CSS style sheets, JavaScript, Flash and all other modern web development technologies;</li><li>you can mark content as being suitable for either a single language or for all languages, and can control all aspects of localisation and internationalisation of your site;</li><li>you can be sure that your pages will display properly in all browsers, thanks to Zikula\'s full compliance with W3C HTML standards;</li><li>you get a standard application-programming interface (API) that lets you easily augment your site\'s functionality through modules, blocks and other extensions;</li><li>you can get help and support from the Zikula community of webmasters and developers at <a href=\"http://www.zikula.org\">zikula.org</a>.</li></ul><p>Enjoy using Zikula!</p><p><strong>The Zikula team</strong></p><p><em>Note: Zikula is Free Open Source Software (FOSS) licensed under the GNU General Public License.</em></p>','',3,'a:0:{}',1,1,1,3600,'2016-08-13 18:04:12',''),(4,'Login','User log-in','Login block','','',14,'a:0:{}',1,1,1,3600,'2016-08-13 18:04:12',''),(5,'Extmenu','Top navigation','Theme navigation','a:5:{s:14:\"displaymodules\";s:1:\"0\";s:10:\"stylesheet\";s:11:\"extmenu.css\";s:8:\"template\";s:24:\"Block/Extmenu/topnav.tpl\";s:11:\"blocktitles\";a:1:{s:2:\"en\";s:14:\"Top navigation\";}s:5:\"links\";a:1:{s:2:\"en\";a:3:{i:0;a:7:{s:4:\"name\";s:4:\"Home\";s:3:\"url\";s:10:\"{homepage}\";s:5:\"title\";s:26:\"Go to the site\'s home page\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:1;a:7:{s:4:\"name\";s:10:\"My Account\";s:3:\"url\";s:19:\"{ZikulaUsersModule}\";s:5:\"title\";s:24:\"Go to your account panel\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}i:2;a:7:{s:4:\"name\";s:11:\"Site search\";s:3:\"url\";s:20:\"{ZikulaSearchModule}\";s:5:\"title\";s:16:\"Search this site\";s:5:\"level\";i:0;s:8:\"parentid\";N;s:5:\"image\";s:0:\"\";s:6:\"active\";s:1:\"1\";}}}}','',3,'a:0:{}',1,1,1,3600,'2016-08-13 18:04:12','');
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bundles`
--

DROP TABLE IF EXISTS `bundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bundlename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `autoload` varchar(384) COLLATE utf8_unicode_ci NOT NULL,
  `bundleclass` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `bundletype` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `bundlestate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D8A73A9867B776D8` (`bundlename`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bundles`
--

LOCK TABLES `bundles` WRITE;
/*!40000 ALTER TABLE `bundles` DISABLE KEYS */;
INSERT INTO `bundles` VALUES (1,'zikula/legal-module','a:1:{s:5:\"psr-4\";a:1:{s:19:\"Zikula\\LegalModule\\\";s:27:\"modules/zikula/legal-module\";}}','Zikula\\LegalModule\\ZikulaLegalModule','M',3),(2,'zikula/profile-module','a:1:{s:5:\"psr-4\";a:1:{s:21:\"Zikula\\ProfileModule\\\";s:29:\"modules/zikula/profile-module\";}}','Zikula\\ProfileModule\\ZikulaProfileModule','M',3),(3,'zikula/andreas08-theme','a:1:{s:5:\"psr-4\";a:1:{s:22:\"Zikula\\Andreas08Theme\\\";s:21:\"themes/Andreas08Theme\";}}','Zikula\\Andreas08Theme\\ZikulaAndreas08Theme','T',3),(4,'zikula/atom-theme','a:1:{s:5:\"psr-4\";a:1:{s:17:\"Zikula\\AtomTheme\\\";s:16:\"themes/AtomTheme\";}}','Zikula\\AtomTheme\\ZikulaAtomTheme','T',3),(5,'zikula/bootstrap-theme','a:1:{s:5:\"psr-4\";a:1:{s:22:\"Zikula\\BootstrapTheme\\\";s:21:\"themes/BootstrapTheme\";}}','Zikula\\BootstrapTheme\\ZikulaBootstrapTheme','T',3),(6,'zikula/printer-theme','a:1:{s:5:\"psr-4\";a:1:{s:20:\"Zikula\\PrinterTheme\\\";s:19:\"themes/PrinterTheme\";}}','Zikula\\PrinterTheme\\ZikulaPrinterTheme','T',3),(7,'zikula/rss-theme','a:1:{s:5:\"psr-4\";a:1:{s:16:\"Zikula\\RssTheme\\\";s:15:\"themes/RssTheme\";}}','Zikula\\RssTheme\\ZikulaRssTheme','T',3),(8,'zikula/seabreeze-theme','a:1:{s:5:\"psr-4\";a:1:{s:22:\"Zikula\\SeaBreezeTheme\\\";s:21:\"themes/SeaBreezeTheme\";}}','Zikula\\SeaBreezeTheme\\ZikulaSeaBreezeTheme','T',3);
/*!40000 ALTER TABLE `bundles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_attributes`
--

DROP TABLE IF EXISTS `categories_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_attributes` (
  `category_id` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`,`name`),
  KEY `IDX_9015DE7812469DE2` (`category_id`),
  CONSTRAINT `FK_9015DE7812469DE2` FOREIGN KEY (`category_id`) REFERENCES `categories_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_attributes`
--

LOCK TABLES `categories_attributes` WRITE;
/*!40000 ALTER TABLE `categories_attributes` DISABLE KEYS */;
INSERT INTO `categories_attributes` VALUES (5,'Y','code'),(6,'N','code'),(11,'P','code'),(12,'C','code'),(13,'A','code'),(14,'O','code'),(15,'R','code'),(17,'M','code'),(18,'F','code'),(26,'A','code'),(27,'I','code'),(29,'P','code'),(30,'A','code');
/*!40000 ALTER TABLE `categories_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_category`
--

DROP TABLE IF EXISTS `categories_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL,
  `is_leaf` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_value` int(11) NOT NULL,
  `display_name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `display_desc` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `path` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ipath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_date` datetime NOT NULL,
  `lu_date` datetime NOT NULL,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_uid` int(11) DEFAULT NULL,
  `lu_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D0B2B0F8727ACA70` (`parent_id`),
  KEY `IDX_D0B2B0F88304AF18` (`cr_uid`),
  KEY `IDX_D0B2B0F8C072C1DD` (`lu_uid`),
  KEY `idx_categories_is_leaf` (`is_leaf`),
  KEY `idx_categories_name` (`name`),
  KEY `idx_categories_ipath` (`ipath`,`is_leaf`,`status`),
  KEY `idx_categories_status` (`status`),
  KEY `idx_categories_ipath_status` (`ipath`,`status`),
  CONSTRAINT `FK_D0B2B0F8727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `categories_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_category`
--

LOCK TABLES `categories_category` WRITE;
/*!40000 ALTER TABLE `categories_category` DISABLE KEYS */;
INSERT INTO `categories_category` VALUES (1,NULL,1,0,'__SYSTEM__','',1,'s:0:\"\";','s:0:\"\";','/__SYSTEM__','/1','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(2,1,0,0,'Modules','',2,'a:1:{s:2:\"en\";s:7:\"Modules\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules','/1/2','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(3,1,0,0,'General','',3,'a:1:{s:2:\"en\";s:7:\"General\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General','/1/3','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(4,3,0,0,'YesNo','',4,'a:1:{s:2:\"en\";s:6:\"Yes/No\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/YesNo','/1/3/4','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(5,4,0,1,'1 - Yes','Y',5,'s:0:\"\";','s:0:\"\";','/__SYSTEM__/General/YesNo/1 - Yes','/1/3/4/5','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(6,4,0,1,'2 - No','N',6,'s:0:\"\";','s:0:\"\";','/__SYSTEM__/General/YesNo/2 - No','/1/3/4/6','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(10,3,0,0,'Publication Status (extended)','',10,'a:1:{s:2:\"en\";s:29:\"Publication status (extended)\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended','/1/3/10','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(11,10,0,1,'Pending','P',11,'a:1:{s:2:\"en\";s:7:\"Pending\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended/Pending','/1/3/10/11','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(12,10,0,1,'Checked','C',12,'a:1:{s:2:\"en\";s:7:\"Checked\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended/Checked','/1/3/10/12','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(13,10,0,1,'Approved','A',13,'a:1:{s:2:\"en\";s:8:\"Approved\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended/Approved','/1/3/10/13','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(14,10,0,1,'On-line','O',14,'a:1:{s:2:\"en\";s:7:\"On-line\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended/Online','/1/3/10/14','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(15,10,0,1,'Rejected','R',15,'a:1:{s:2:\"en\";s:8:\"Rejected\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Extended/Rejected','/1/3/10/15','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(16,3,0,0,'Gender','',16,'a:1:{s:2:\"en\";s:6:\"Gender\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Gender','/1/3/16','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(17,16,0,1,'Male','M',17,'a:1:{s:2:\"en\";s:4:\"Male\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Gender/Male','/1/3/16/17','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(18,16,0,1,'Female','F',18,'a:1:{s:2:\"en\";s:6:\"Female\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Gender/Female','/1/3/16/18','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(19,3,0,0,'Title','',19,'a:1:{s:2:\"en\";s:5:\"Title\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title','/1/3/19','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(20,19,0,1,'Mr','Mr',20,'a:1:{s:2:\"en\";s:3:\"Mr.\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title/Mr','/1/3/19/20','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(21,19,0,1,'Mrs','Mrs',21,'a:1:{s:2:\"en\";s:4:\"Mrs.\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title/Mrs','/1/3/19/21','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(22,19,0,1,'Ms','Ms',22,'a:1:{s:2:\"en\";s:3:\"Ms.\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title/Ms','/1/3/19/22','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(23,19,0,1,'Miss','Miss',23,'a:1:{s:2:\"en\";s:4:\"Miss\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title/Miss','/1/3/19/23','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(24,19,0,1,'Dr','Dr',24,'a:1:{s:2:\"en\";s:3:\"Dr.\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Title/Dr','/1/3/19/24','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(25,3,0,0,'ActiveStatus','',25,'a:1:{s:2:\"en\";s:15:\"Activity status\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/ActiveStatus','/1/3/25','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(26,25,0,1,'Active','A',26,'a:1:{s:2:\"en\";s:6:\"Active\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/ActiveStatus/Active','/1/3/25/26','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(27,25,0,1,'Inactive','I',27,'a:1:{s:2:\"en\";s:8:\"Inactive\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/ActiveStatus/Inactive','/1/3/25/27','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(28,3,0,0,'Publication status (basic)','',28,'a:1:{s:2:\"en\";s:26:\"Publication status (basic)\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Basic','/1/3/28','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(29,28,0,1,'Pending','P',29,'a:1:{s:2:\"en\";s:7:\"Pending\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Basic/Pending','/1/3/28/29','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(30,28,0,1,'Approved','A',30,'a:1:{s:2:\"en\";s:8:\"Approved\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/General/Publication Status Basic/Approved','/1/3/28/30','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(31,1,0,0,'ZikulaUsersModule','',31,'a:1:{s:2:\"en\";s:5:\"Users\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Users','/1/31','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(32,2,0,0,'Global','',32,'a:1:{s:2:\"en\";s:6:\"Global\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global','/1/2/32','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(33,32,0,1,'Blogging','',33,'a:1:{s:2:\"en\";s:8:\"Blogging\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/Blogging','/1/2/32/33','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(34,32,0,1,'Music and audio','',34,'a:1:{s:2:\"en\";s:15:\"Music and audio\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/MusicAndAudio','/1/2/32/34','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(35,32,0,1,'Art and photography','',35,'a:1:{s:2:\"en\";s:19:\"Art and photography\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/ArtAndPhotography','/1/2/32/35','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(36,32,0,1,'Writing and thinking','',36,'a:1:{s:2:\"en\";s:20:\"Writing and thinking\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/WritingAndThinking','/1/2/32/36','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(37,32,0,1,'Communications and media','',37,'a:1:{s:2:\"en\";s:24:\"Communications and media\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/CommunicationsAndMedia','/1/2/32/37','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(38,32,0,1,'Travel and culture','',38,'a:1:{s:2:\"en\";s:18:\"Travel and culture\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/TravelAndCulture','/1/2/32/38','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(39,32,0,1,'Science and technology','',39,'a:1:{s:2:\"en\";s:22:\"Science and technology\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/ScienceAndTechnology','/1/2/32/39','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(40,32,0,1,'Sport and activities','',40,'a:1:{s:2:\"en\";s:20:\"Sport and activities\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/SportAndActivities','/1/2/32/40','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2),(41,32,0,1,'Business and work','',41,'a:1:{s:2:\"en\";s:17:\"Business and work\";}','a:1:{s:2:\"en\";s:0:\"\";}','/__SYSTEM__/Modules/Global/BusinessAndWork','/1/2/32/41','A','2016-08-13 18:04:03','2016-08-13 18:04:03','A',2,2);
/*!40000 ALTER TABLE `categories_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_mapobj`
--

DROP TABLE IF EXISTS `categories_mapobj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_mapobj` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `tablename` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `obj_id` int(11) NOT NULL,
  `obj_idcolumn` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `reg_id` int(11) NOT NULL,
  `reg_property` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_date` datetime NOT NULL,
  `cr_uid` int(11) NOT NULL,
  `lu_date` datetime NOT NULL,
  `lu_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_mapobj`
--

LOCK TABLES `categories_mapobj` WRITE;
/*!40000 ALTER TABLE `categories_mapobj` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_mapobj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_registry`
--

DROP TABLE IF EXISTS `categories_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `entityname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `property` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `cr_date` datetime NOT NULL,
  `lu_date` datetime NOT NULL,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_uid` int(11) DEFAULT NULL,
  `lu_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1B56B4338304AF18` (`cr_uid`),
  KEY `IDX_1B56B433C072C1DD` (`lu_uid`),
  KEY `idx_categories_registry` (`modname`,`entityname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_registry`
--

LOCK TABLES `categories_registry` WRITE;
/*!40000 ALTER TABLE `categories_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_applications`
--

DROP TABLE IF EXISTS `group_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_applications` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `application` longtext COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL,
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_applications`
--

LOCK TABLES `group_applications` WRITE;
/*!40000 ALTER TABLE `group_applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_membership`
--

DROP TABLE IF EXISTS `group_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_membership` (
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`gid`),
  KEY `IDX_5132B337539B0606` (`uid`),
  KEY `IDX_5132B3374C397118` (`gid`),
  CONSTRAINT `FK_5132B337539B0606` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_membership`
--

LOCK TABLES `group_membership` WRITE;
/*!40000 ALTER TABLE `group_membership` DISABLE KEYS */;
INSERT INTO `group_membership` VALUES (1,1),(2,1),(2,2);
/*!40000 ALTER TABLE `group_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_perms`
--

DROP TABLE IF EXISTS `group_perms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_perms` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `sequence` int(11) NOT NULL,
  `realm` int(11) NOT NULL,
  `component` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `instance` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  `bond` int(11) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_perms`
--

LOCK TABLES `group_perms` WRITE;
/*!40000 ALTER TABLE `group_perms` DISABLE KEYS */;
INSERT INTO `group_perms` VALUES (1,2,1,0,'.*','.*',800,0),(2,-1,2,0,'ExtendedMenublock::','1:1:',0,0),(3,1,3,0,'.*','.*',300,0),(4,0,4,0,'ExtendedMenublock::','1:(1|2|3):',0,0),(5,0,5,0,'.*','.*',200,0);
/*!40000 ALTER TABLE `group_perms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gtype` smallint(6) NOT NULL,
  `description` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `state` smallint(6) NOT NULL,
  `nbuser` int(11) NOT NULL,
  `nbumax` int(11) NOT NULL,
  `link` int(11) NOT NULL,
  `uidmaster` int(11) NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Users',0,'By default, all users are made members of this group.','usr',0,0,0,0,0),(2,'Administrators',0,'Group of administrators of this site.','adm',0,0,0,0,0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hook_area`
--

DROP TABLE IF EXISTS `hook_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hook_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `areatype` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `areaname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `areaidx` (`areaname`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hook_area`
--

LOCK TABLES `hook_area` WRITE;
/*!40000 ALTER TABLE `hook_area` DISABLE KEYS */;
INSERT INTO `hook_area` VALUES (1,'ZikulaUsersModule',NULL,'s','ui_hooks','subscriber.users.ui_hooks.user'),(2,'ZikulaUsersModule',NULL,'s','ui_hooks','subscriber.users.ui_hooks.registration'),(3,'ZikulaUsersModule',NULL,'s','ui_hooks','subscriber.users.ui_hooks.login_screen'),(4,'ZikulaUsersModule',NULL,'s','ui_hooks','subscriber.users.ui_hooks.login_block'),(5,'ZikulaBlocksModule',NULL,'s','ui_hooks','subscriber.blocks.ui_hooks.htmlblock.content'),(6,'ZikulaMailerModule',NULL,'s','ui_hooks','subscriber.mailer.ui_hooks.htmlmail'),(7,'ZikulaRoutesModule',NULL,'s','ui_hooks','subscriber.zikularoutesmodule.ui_hooks.routes'),(8,'ZikulaRoutesModule',NULL,'s','filter_hooks','subscriber.zikularoutesmodule.filter_hooks.routes');
/*!40000 ALTER TABLE `hook_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hook_binding`
--

DROP TABLE IF EXISTS `hook_binding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hook_binding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sowner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subsowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `powner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subpowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sareaid` int(11) NOT NULL,
  `pareaid` int(11) NOT NULL,
  `category` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `sortorder` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hook_binding`
--

LOCK TABLES `hook_binding` WRITE;
/*!40000 ALTER TABLE `hook_binding` DISABLE KEYS */;
/*!40000 ALTER TABLE `hook_binding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hook_provider`
--

DROP TABLE IF EXISTS `hook_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hook_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pareaid` int(11) NOT NULL,
  `hooktype` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `method` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `serviceid` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hook_provider`
--

LOCK TABLES `hook_provider` WRITE;
/*!40000 ALTER TABLE `hook_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `hook_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hook_runtime`
--

DROP TABLE IF EXISTS `hook_runtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hook_runtime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sowner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subsowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `powner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subpowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sareaid` int(11) NOT NULL,
  `pareaid` int(11) NOT NULL,
  `eventname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `method` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `serviceid` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hook_runtime`
--

LOCK TABLES `hook_runtime` WRITE;
/*!40000 ALTER TABLE `hook_runtime` DISABLE KEYS */;
/*!40000 ALTER TABLE `hook_runtime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hook_subscriber`
--

DROP TABLE IF EXISTS `hook_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hook_subscriber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `subowner` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sareaid` int(11) NOT NULL,
  `hooktype` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `eventname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hook_subscriber`
--

LOCK TABLES `hook_subscriber` WRITE;
/*!40000 ALTER TABLE `hook_subscriber` DISABLE KEYS */;
INSERT INTO `hook_subscriber` VALUES (1,'ZikulaUsersModule',NULL,1,'display_view','ui_hooks','users.ui_hooks.user.display_view'),(2,'ZikulaUsersModule',NULL,1,'form_edit','ui_hooks','users.ui_hooks.user.form_edit'),(3,'ZikulaUsersModule',NULL,1,'validate_edit','ui_hooks','users.ui_hooks.user.validate_edit'),(4,'ZikulaUsersModule',NULL,1,'process_edit','ui_hooks','users.ui_hooks.user.process_edit'),(5,'ZikulaUsersModule',NULL,1,'form_delete','ui_hooks','users.ui_hooks.user.form_delete'),(6,'ZikulaUsersModule',NULL,1,'validate_delete','ui_hooks','users.ui_hooks.user.validate_delete'),(7,'ZikulaUsersModule',NULL,1,'process_delete','ui_hooks','users.ui_hooks.user.process_delete'),(8,'ZikulaUsersModule',NULL,2,'display_view','ui_hooks','users.ui_hooks.registration.display_view'),(9,'ZikulaUsersModule',NULL,2,'form_edit','ui_hooks','users.ui_hooks.registration.form_edit'),(10,'ZikulaUsersModule',NULL,2,'validate_edit','ui_hooks','users.ui_hooks.registration.validate_edit'),(11,'ZikulaUsersModule',NULL,2,'process_edit','ui_hooks','users.ui_hooks.registration.process_edit'),(12,'ZikulaUsersModule',NULL,2,'form_delete','ui_hooks','users.ui_hooks.registration.form_delete'),(13,'ZikulaUsersModule',NULL,2,'validate_delete','ui_hooks','users.ui_hooks.registration.validate_delete'),(14,'ZikulaUsersModule',NULL,2,'process_delete','ui_hooks','users.ui_hooks.registration.process_delete'),(15,'ZikulaUsersModule',NULL,3,'form_edit','ui_hooks','users.ui_hooks.login_screen.form_edit'),(16,'ZikulaUsersModule',NULL,3,'validate_edit','ui_hooks','users.ui_hooks.login_screen.validate_edit'),(17,'ZikulaUsersModule',NULL,3,'process_edit','ui_hooks','users.ui_hooks.login_screen.process_edit'),(18,'ZikulaUsersModule',NULL,4,'form_edit','ui_hooks','users.ui_hooks.login_block.form_edit'),(19,'ZikulaUsersModule',NULL,4,'validate_edit','ui_hooks','users.ui_hooks.login_block.validate_edit'),(20,'ZikulaUsersModule',NULL,4,'process_edit','ui_hooks','users.ui_hooks.login_block.process_edit'),(21,'ZikulaBlocksModule',NULL,5,'form_edit','ui_hooks','blocks.ui_hooks.htmlblock.content.form_edit'),(22,'ZikulaMailerModule',NULL,6,'form_edit','ui_hooks','mailer.ui_hooks.htmlmail.form_edit'),(23,'ZikulaRoutesModule',NULL,7,'display_view','ui_hooks','zikularoutesmodule.ui_hooks.routes.display_view'),(24,'ZikulaRoutesModule',NULL,7,'form_edit','ui_hooks','zikularoutesmodule.ui_hooks.routes.form_edit'),(25,'ZikulaRoutesModule',NULL,7,'form_delete','ui_hooks','zikularoutesmodule.ui_hooks.routes.form_delete'),(26,'ZikulaRoutesModule',NULL,7,'validate_edit','ui_hooks','zikularoutesmodule.ui_hooks.routes.validate_edit'),(27,'ZikulaRoutesModule',NULL,7,'validate_delete','ui_hooks','zikularoutesmodule.ui_hooks.routes.validate_delete'),(28,'ZikulaRoutesModule',NULL,7,'process_edit','ui_hooks','zikularoutesmodule.ui_hooks.routes.process_edit'),(29,'ZikulaRoutesModule',NULL,7,'process_delete','ui_hooks','zikularoutesmodule.ui_hooks.routes.process_delete'),(30,'ZikulaRoutesModule',NULL,8,'filter','filter_hooks','zikularoutesmodule.filter_hooks.routes.filter');
/*!40000 ALTER TABLE `hook_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_deps`
--

DROP TABLE IF EXISTS `module_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_deps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modid` int(11) NOT NULL,
  `modname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `minversion` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `maxversion` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_deps`
--

LOCK TABLES `module_deps` WRITE;
/*!40000 ALTER TABLE `module_deps` DISABLE KEYS */;
INSERT INTO `module_deps` VALUES (1,3,'Scribite','5.0.0','',2);
/*!40000 ALTER TABLE `module_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_vars`
--

DROP TABLE IF EXISTS `module_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_vars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_vars`
--

LOCK TABLES `module_vars` WRITE;
/*!40000 ALTER TABLE `module_vars` DISABLE KEYS */;
INSERT INTO `module_vars` VALUES (1,'ZikulaExtensionsModule','itemsperpage','i:25;'),(2,'ZConfig','debug','s:1:\"0\";'),(3,'ZConfig','startdate','s:7:\"08/2016\";'),(4,'ZConfig','adminmail','s:17:\"admin@example.com\";'),(5,'ZConfig','Default_Theme','s:20:\"ZikulaAndreas08Theme\";'),(6,'ZConfig','timezone_offset','s:1:\"0\";'),(7,'ZConfig','timezone_server','s:1:\"0\";'),(8,'ZConfig','funtext','s:1:\"1\";'),(9,'ZConfig','reportlevel','s:1:\"0\";'),(10,'ZConfig','startpage','s:0:\"\";'),(11,'ZConfig','Version_Num','s:5:\"1.4.1\";'),(12,'ZConfig','Version_ID','s:6:\"Zikula\";'),(13,'ZConfig','Version_Sub','s:8:\"Overture\";'),(14,'ZConfig','debug_sql','s:1:\"0\";'),(15,'ZConfig','multilingual','s:1:\"1\";'),(16,'ZConfig','useflags','s:1:\"0\";'),(17,'ZConfig','theme_change','s:1:\"0\";'),(18,'ZConfig','UseCompression','s:1:\"0\";'),(19,'ZConfig','siteoff','i:0;'),(20,'ZConfig','siteoffreason','s:0:\"\";'),(21,'ZConfig','starttype','s:0:\"\";'),(22,'ZConfig','startfunc','s:0:\"\";'),(23,'ZConfig','startargs','s:0:\"\";'),(24,'ZConfig','entrypoint','s:9:\"index.php\";'),(25,'ZConfig','language_detect','i:0;'),(26,'ZConfig','shorturls','b:0;'),(27,'ZConfig','shorturlstype','s:1:\"0\";'),(28,'ZConfig','shorturlsseparator','s:1:\"-\";'),(29,'ZConfig','sitename_en','s:9:\"Site name\";'),(30,'ZConfig','slogan_en','s:16:\"Site description\";'),(31,'ZConfig','metakeywords_en','s:115:\"zikula, portal, open source, web site, website, weblog, blog, content management system, cms, application framework\";'),(32,'ZConfig','defaultpagetitle_en','s:9:\"Site name\";'),(33,'ZConfig','defaultmetadescription_en','s:16:\"Site description\";'),(34,'ZConfig','shorturlsstripentrypoint','b:1;'),(35,'ZConfig','shorturlsdefaultmodule','s:0:\"\";'),(36,'ZConfig','profilemodule','s:0:\"\";'),(37,'ZConfig','messagemodule','s:0:\"\";'),(38,'ZConfig','languageurl','i:0;'),(39,'ZConfig','ajaxtimeout','i:5000;'),(40,'ZConfig','permasearch','s:161:\"À,Á,Â,Ã,Å,à,á,â,ã,å,Ò,Ó,Ô,Õ,Ø,ò,ó,ô,õ,ø,È,É,Ê,Ë,è,é,ê,ë,Ç,ç,Ì,Í,Î,Ï,ì,í,î,ï,Ù,Ú,Û,ù,ú,û,ÿ,Ñ,ñ,ß,ä,Ä,ö,Ö,ü,Ü\";'),(41,'ZConfig','permareplace','s:114:\"A,A,A,A,A,a,a,a,a,a,O,O,O,O,O,o,o,o,o,o,E,E,E,E,e,e,e,e,C,c,I,I,I,I,i,i,i,i,U,U,U,u,u,u,y,N,n,ss,ae,Ae,oe,Oe,ue,Ue\";'),(42,'ZConfig','language','s:3:\"eng\";'),(43,'ZConfig','locale','s:2:\"en\";'),(44,'ZConfig','language_i18n','s:2:\"en\";'),(45,'ZConfig','idnnames','i:1;'),(46,'ZikulaThemeModule','modulesnocache','s:0:\"\";'),(47,'ZikulaThemeModule','enablecache','b:0;'),(48,'ZikulaThemeModule','compile_check','b:1;'),(49,'ZikulaThemeModule','cache_lifetime','i:1800;'),(50,'ZikulaThemeModule','cache_lifetime_mods','i:1800;'),(51,'ZikulaThemeModule','force_compile','b:0;'),(52,'ZikulaThemeModule','trimwhitespace','b:0;'),(53,'ZikulaThemeModule','maxsizeforlinks','i:30;'),(54,'ZikulaThemeModule','itemsperpage','i:25;'),(55,'ZikulaThemeModule','cssjscombine','b:0;'),(56,'ZikulaThemeModule','cssjscompress','b:0;'),(57,'ZikulaThemeModule','cssjsminify','b:0;'),(58,'ZikulaThemeModule','cssjscombine_lifetime','i:3600;'),(59,'ZikulaThemeModule','render_compile_check','b:1;'),(60,'ZikulaThemeModule','render_force_compile','b:0;'),(61,'ZikulaThemeModule','render_cache','b:0;'),(62,'ZikulaThemeModule','render_expose_template','b:0;'),(63,'ZikulaThemeModule','render_lifetime','i:3600;'),(64,'ZikulaAdminModule','modulesperrow','i:3;'),(65,'ZikulaAdminModule','itemsperpage','i:15;'),(66,'ZikulaAdminModule','defaultcategory','i:5;'),(67,'ZikulaAdminModule','admingraphic','i:1;'),(68,'ZikulaAdminModule','startcategory','i:1;'),(69,'ZikulaAdminModule','ignoreinstallercheck','i:0;'),(70,'ZikulaAdminModule','admintheme','s:0:\"\";'),(71,'ZikulaAdminModule','displaynametype','i:1;'),(72,'ZikulaPermissionsModule','filter','i:1;'),(73,'ZikulaPermissionsModule','warnbar','i:1;'),(74,'ZikulaPermissionsModule','rowview','i:20;'),(75,'ZikulaPermissionsModule','rowedit','i:20;'),(76,'ZikulaPermissionsModule','lockadmin','i:1;'),(77,'ZikulaPermissionsModule','adminid','i:1;'),(78,'ZikulaUsersModule','accountdisplaygraphics','b:1;'),(79,'ZikulaUsersModule','accountitemsperpage','i:25;'),(80,'ZikulaUsersModule','accountitemsperrow','i:5;'),(81,'ZikulaUsersModule','userimg','s:11:\"images/menu\";'),(82,'ZikulaUsersModule','anonymous','s:5:\"Guest\";'),(83,'ZikulaUsersModule','avatarpath','s:13:\"images/avatar\";'),(84,'ZikulaUsersModule','chgemail_expiredays','i:0;'),(85,'ZikulaUsersModule','chgpass_expiredays','i:0;'),(86,'ZikulaUsersModule','reg_expiredays','i:0;'),(87,'ZikulaUsersModule','allowgravatars','b:1;'),(88,'ZikulaUsersModule','gravatarimage','s:12:\"gravatar.jpg\";'),(89,'ZikulaUsersModule','hash_method','s:6:\"sha256\";'),(90,'ZikulaUsersModule','itemsperpage','i:25;'),(91,'ZikulaUsersModule','login_displayapproval','b:0;'),(92,'ZikulaUsersModule','login_displaydelete','b:0;'),(93,'ZikulaUsersModule','login_displayinactive','b:0;'),(94,'ZikulaUsersModule','login_displayverify','b:0;'),(95,'ZikulaUsersModule','loginviaoption','i:0;'),(96,'ZikulaUsersModule','login_redirect','b:1;'),(97,'ZikulaUsersModule','changeemail','b:1;'),(98,'ZikulaUsersModule','minpass','i:5;'),(99,'ZikulaUsersModule','use_password_strength_meter','b:0;'),(100,'ZikulaUsersModule','password_reminder_enabled','b:0;'),(101,'ZikulaUsersModule','password_reminder_mandatory','b:1;'),(102,'ZikulaUsersModule','reg_notifyemail','s:0:\"\";'),(103,'ZikulaUsersModule','reg_question','s:0:\"\";'),(104,'ZikulaUsersModule','reg_answer','s:0:\"\";'),(105,'ZikulaUsersModule','moderation','b:0;'),(106,'ZikulaUsersModule','moderation_order','i:0;'),(107,'ZikulaUsersModule','reg_autologin','b:0;'),(108,'ZikulaUsersModule','reg_noregreasons','s:51:\"Sorry! New user registration is currently disabled.\";'),(109,'ZikulaUsersModule','reg_allowreg','b:1;'),(110,'ZikulaUsersModule','reg_Illegaluseragents','s:0:\"\";'),(111,'ZikulaUsersModule','reg_Illegaldomains','s:0:\"\";'),(112,'ZikulaUsersModule','reg_Illegalusername','s:66:\"root, webmaster, admin, administrator, nobody, anonymous, username\";'),(113,'ZikulaUsersModule','reg_verifyemail','i:2;'),(114,'ZikulaUsersModule','reg_uniemail','b:1;'),(115,'ZikulaGroupsModule','itemsperpage','i:25;'),(116,'ZikulaGroupsModule','defaultgroup','i:1;'),(117,'ZikulaGroupsModule','mailwarning','i:0;'),(118,'ZikulaGroupsModule','hideclosed','i:0;'),(119,'ZikulaGroupsModule','primaryadmingroup','i:2;'),(120,'ZikulaBlocksModule','collapseable','i:0;'),(121,'ZikulaSecurityCenterModule','itemsperpage','i:10;'),(122,'ZConfig','updatecheck','i:1;'),(123,'ZConfig','updatefrequency','i:7;'),(124,'ZConfig','updatelastchecked','i:1471125892;'),(125,'ZConfig','updateversion','s:5:\"1.4.2\";'),(126,'ZConfig','keyexpiry','i:0;'),(127,'ZConfig','sessionauthkeyua','b:0;'),(128,'ZConfig','secure_domain','s:0:\"\";'),(129,'ZConfig','signcookies','i:1;'),(130,'ZConfig','signingkey','s:40:\"fbd96b4fd04b77309705e6e15062deec6862cd6b\";'),(131,'ZConfig','seclevel','s:6:\"Medium\";'),(132,'ZConfig','secmeddays','i:7;'),(133,'ZConfig','secinactivemins','i:20;'),(134,'ZConfig','sessionstoretofile','i:0;'),(135,'ZConfig','sessionsavepath','s:0:\"\";'),(136,'ZConfig','gc_probability','i:100;'),(137,'ZConfig','anonymoussessions','i:1;'),(138,'ZConfig','sessionrandregenerate','b:1;'),(139,'ZConfig','sessionregenerate','b:1;'),(140,'ZConfig','sessionregeneratefreq','i:10;'),(141,'ZConfig','sessionipcheck','i:0;'),(142,'ZConfig','sessionname','s:5:\"_zsid\";'),(143,'ZConfig','sessioncsrftokenonetime','i:1;'),(144,'ZConfig','filtergetvars','i:1;'),(145,'ZConfig','filterpostvars','i:1;'),(146,'ZConfig','filtercookievars','i:1;'),(147,'ZConfig','outputfilter','i:1;'),(148,'ZConfig','htmlpurifierlocation','s:78:\"/Applications/MAMP/htdocs/141/system/SecurityCenterModule/vendor/htmlpurifier/\";'),(149,'ZikulaSecurityCenterModule','htmlpurifierConfig','s:4303:\"a:10:{s:4:\"Attr\";a:15:{s:14:\"AllowedClasses\";N;s:19:\"AllowedFrameTargets\";a:0:{}s:10:\"AllowedRel\";a:3:{s:8:\"nofollow\";b:1;s:11:\"imageviewer\";b:1;s:8:\"lightbox\";b:1;}s:10:\"AllowedRev\";a:0:{}s:13:\"ClassUseCDATA\";N;s:15:\"DefaultImageAlt\";N;s:19:\"DefaultInvalidImage\";s:0:\"\";s:22:\"DefaultInvalidImageAlt\";s:13:\"Invalid image\";s:14:\"DefaultTextDir\";s:3:\"ltr\";s:8:\"EnableID\";b:0;s:16:\"ForbiddenClasses\";a:0:{}s:11:\"IDBlacklist\";a:0:{}s:17:\"IDBlacklistRegexp\";N;s:8:\"IDPrefix\";s:0:\"\";s:13:\"IDPrefixLocal\";s:0:\"\";}s:10:\"AutoFormat\";a:11:{s:13:\"AutoParagraph\";b:0;s:6:\"Custom\";a:0:{}s:14:\"DisplayLinkURI\";b:0;s:7:\"Linkify\";b:0;s:22:\"PurifierLinkify.DocURL\";s:3:\"#%s\";s:15:\"PurifierLinkify\";b:0;s:21:\"RemoveEmpty.Predicate\";a:4:{s:8:\"colgroup\";a:0:{}s:2:\"th\";a:0:{}s:2:\"td\";a:0:{}s:6:\"iframe\";a:1:{i:0;s:3:\"src\";}}s:33:\"RemoveEmpty.RemoveNbsp.Exceptions\";a:2:{s:2:\"td\";b:1;s:2:\"th\";b:1;}s:22:\"RemoveEmpty.RemoveNbsp\";b:0;s:11:\"RemoveEmpty\";b:0;s:28:\"RemoveSpansWithoutAttributes\";b:0;}s:3:\"CSS\";a:9:{s:14:\"AllowImportant\";b:0;s:11:\"AllowTricky\";b:0;s:12:\"AllowedFonts\";N;s:17:\"AllowedProperties\";N;s:13:\"DefinitionRev\";i:1;s:19:\"ForbiddenProperties\";a:0:{}s:12:\"MaxImgLength\";s:6:\"1200px\";s:11:\"Proprietary\";b:0;s:7:\"Trusted\";b:0;}s:5:\"Cache\";a:3:{s:14:\"DefinitionImpl\";s:10:\"Serializer\";s:14:\"SerializerPath\";N;s:21:\"SerializerPermissions\";i:493;}s:4:\"Core\";a:20:{s:17:\"AggressivelyFixLt\";b:1;s:23:\"AllowHostnameUnderscore\";b:0;s:13:\"CollectErrors\";b:0;s:13:\"ColorKeywords\";a:17:{s:6:\"maroon\";s:7:\"#800000\";s:3:\"red\";s:7:\"#FF0000\";s:6:\"orange\";s:7:\"#FFA500\";s:6:\"yellow\";s:7:\"#FFFF00\";s:5:\"olive\";s:7:\"#808000\";s:6:\"purple\";s:7:\"#800080\";s:7:\"fuchsia\";s:7:\"#FF00FF\";s:5:\"white\";s:7:\"#FFFFFF\";s:4:\"lime\";s:7:\"#00FF00\";s:5:\"green\";s:7:\"#008000\";s:4:\"navy\";s:7:\"#000080\";s:4:\"blue\";s:7:\"#0000FF\";s:4:\"aqua\";s:7:\"#00FFFF\";s:4:\"teal\";s:7:\"#008080\";s:5:\"black\";s:7:\"#000000\";s:6:\"silver\";s:7:\"#C0C0C0\";s:4:\"gray\";s:7:\"#808080\";}s:25:\"ConvertDocumentToFragment\";b:1;s:31:\"DirectLexLineNumberSyncInterval\";i:0;s:15:\"DisableExcludes\";b:0;s:10:\"EnableIDNA\";b:0;s:8:\"Encoding\";s:5:\"utf-8\";s:21:\"EscapeInvalidChildren\";b:0;s:17:\"EscapeInvalidTags\";b:0;s:24:\"EscapeNonASCIICharacters\";b:0;s:14:\"HiddenElements\";a:2:{s:6:\"script\";b:1;s:5:\"style\";b:1;}s:8:\"Language\";s:2:\"en\";s:9:\"LexerImpl\";N;s:19:\"MaintainLineNumbers\";N;s:17:\"NormalizeNewlines\";b:1;s:16:\"RemoveInvalidImg\";b:1;s:28:\"RemoveProcessingInstructions\";b:0;s:20:\"RemoveScriptContents\";N;}s:6:\"Filter\";a:6:{s:6:\"Custom\";a:0:{}s:27:\"ExtractStyleBlocks.Escaping\";b:1;s:24:\"ExtractStyleBlocks.Scope\";N;s:27:\"ExtractStyleBlocks.TidyImpl\";N;s:18:\"ExtractStyleBlocks\";b:0;s:7:\"YouTube\";b:0;}s:4:\"HTML\";a:31:{s:7:\"Allowed\";N;s:17:\"AllowedAttributes\";N;s:15:\"AllowedComments\";a:0:{}s:21:\"AllowedCommentsRegexp\";N;s:15:\"AllowedElements\";N;s:14:\"AllowedModules\";N;s:18:\"Attr.Name.UseCDATA\";b:0;s:12:\"BlockWrapper\";s:1:\"p\";s:11:\"CoreModules\";a:7:{s:9:\"Structure\";b:1;s:4:\"Text\";b:1;s:9:\"Hypertext\";b:1;s:4:\"List\";b:1;s:22:\"NonXMLCommonAttributes\";b:1;s:19:\"XMLCommonAttributes\";b:1;s:16:\"CommonAttributes\";b:1;}s:13:\"CustomDoctype\";N;s:12:\"DefinitionID\";N;s:13:\"DefinitionRev\";i:1;s:7:\"Doctype\";s:22:\"HTML 4.01 Transitional\";s:20:\"FlashAllowFullScreen\";b:0;s:19:\"ForbiddenAttributes\";a:0:{}s:17:\"ForbiddenElements\";a:0:{}s:12:\"MaxImgLength\";i:1200;s:8:\"Nofollow\";b:0;s:6:\"Parent\";s:3:\"div\";s:11:\"Proprietary\";b:0;s:9:\"SafeEmbed\";b:1;s:10:\"SafeIframe\";b:0;s:10:\"SafeObject\";b:1;s:13:\"SafeScripting\";a:0:{}s:6:\"Strict\";b:0;s:11:\"TargetBlank\";b:0;s:7:\"TidyAdd\";a:0:{}s:9:\"TidyLevel\";s:6:\"medium\";s:10:\"TidyRemove\";a:0:{}s:7:\"Trusted\";b:0;s:5:\"XHTML\";b:1;}s:6:\"Output\";a:6:{s:21:\"CommentScriptContents\";b:1;s:12:\"FixInnerHTML\";b:1;s:11:\"FlashCompat\";b:1;s:7:\"Newline\";N;s:8:\"SortAttr\";b:0;s:10:\"TidyFormat\";b:0;}s:4:\"Test\";a:1:{s:12:\"ForceNoIconv\";b:0;}s:3:\"URI\";a:17:{s:14:\"AllowedSchemes\";a:6:{s:4:\"http\";b:1;s:5:\"https\";b:1;s:6:\"mailto\";b:1;s:3:\"ftp\";b:1;s:4:\"nntp\";b:1;s:4:\"news\";b:1;}s:4:\"Base\";N;s:13:\"DefaultScheme\";s:4:\"http\";s:12:\"DefinitionID\";N;s:13:\"DefinitionRev\";i:1;s:7:\"Disable\";b:0;s:15:\"DisableExternal\";b:0;s:24:\"DisableExternalResources\";b:0;s:16:\"DisableResources\";b:0;s:4:\"Host\";N;s:13:\"HostBlacklist\";a:0:{}s:12:\"MakeAbsolute\";b:0;s:5:\"Munge\";N;s:14:\"MungeResources\";b:0;s:14:\"MungeSecretKey\";N;s:22:\"OverrideAllowedSchemes\";b:1;s:16:\"SafeIframeRegexp\";N;}}\";'),(150,'ZConfig','useids','i:0;'),(151,'ZConfig','idsmail','i:0;'),(152,'ZConfig','idsrulepath','s:100:\"/Applications/MAMP/htdocs/141/system/SecurityCenterModule/Resources/config/phpids_zikula_default.xml\";'),(153,'ZConfig','idssoftblock','i:1;'),(154,'ZConfig','idsfilter','s:3:\"xml\";'),(155,'ZConfig','idsimpactthresholdone','i:1;'),(156,'ZConfig','idsimpactthresholdtwo','i:10;'),(157,'ZConfig','idsimpactthresholdthree','i:25;'),(158,'ZConfig','idsimpactthresholdfour','i:75;'),(159,'ZConfig','idsimpactmode','i:1;'),(160,'ZConfig','idshtmlfields','a:1:{i:0;s:14:\"POST.__wysiwyg\";}'),(161,'ZConfig','idsjsonfields','a:1:{i:0;s:15:\"POST.__jsondata\";}'),(162,'ZConfig','idsexceptions','a:12:{i:0;s:10:\"GET.__utmz\";i:1;s:10:\"GET.__utmc\";i:2;s:18:\"REQUEST.linksorder\";i:3;s:15:\"POST.linksorder\";i:4;s:19:\"REQUEST.fullcontent\";i:5;s:16:\"POST.fullcontent\";i:6;s:22:\"REQUEST.summarycontent\";i:7;s:19:\"POST.summarycontent\";i:8;s:19:\"REQUEST.filter.page\";i:9;s:16:\"POST.filter.page\";i:10;s:20:\"REQUEST.filter.value\";i:11;s:17:\"POST.filter.value\";}'),(163,'ZConfig','htmlentities','s:1:\"1\";'),(164,'ZConfig','AllowableHTML','a:110:{s:3:\"!--\";i:2;s:1:\"a\";i:2;s:4:\"abbr\";i:1;s:7:\"acronym\";i:1;s:7:\"address\";i:1;s:6:\"applet\";i:0;s:4:\"area\";i:0;s:7:\"article\";i:1;s:5:\"aside\";i:1;s:5:\"audio\";i:0;s:1:\"b\";i:1;s:4:\"base\";i:0;s:8:\"basefont\";i:0;s:3:\"bdo\";i:0;s:3:\"big\";i:0;s:10:\"blockquote\";i:2;s:2:\"br\";i:2;s:6:\"button\";i:0;s:6:\"canvas\";i:0;s:7:\"caption\";i:1;s:6:\"center\";i:2;s:4:\"cite\";i:1;s:4:\"code\";i:0;s:3:\"col\";i:1;s:8:\"colgroup\";i:1;s:7:\"command\";i:0;s:8:\"datalist\";i:0;s:2:\"dd\";i:1;s:3:\"del\";i:0;s:7:\"details\";i:1;s:3:\"dfn\";i:0;s:3:\"dir\";i:0;s:3:\"div\";i:2;s:2:\"dl\";i:1;s:2:\"dt\";i:1;s:2:\"em\";i:2;s:5:\"embed\";i:0;s:8:\"fieldset\";i:1;s:10:\"figcaption\";i:0;s:6:\"figure\";i:0;s:6:\"footer\";i:0;s:4:\"font\";i:0;s:4:\"form\";i:0;s:2:\"h1\";i:1;s:2:\"h2\";i:1;s:2:\"h3\";i:1;s:2:\"h4\";i:1;s:2:\"h5\";i:1;s:2:\"h6\";i:1;s:6:\"header\";i:0;s:6:\"hgroup\";i:0;s:2:\"hr\";i:2;s:1:\"i\";i:1;s:6:\"iframe\";i:0;s:3:\"img\";i:2;s:5:\"input\";i:0;s:3:\"ins\";i:0;s:6:\"keygen\";i:0;s:3:\"kbd\";i:0;s:5:\"label\";i:1;s:6:\"legend\";i:1;s:2:\"li\";i:2;s:3:\"map\";i:0;s:4:\"mark\";i:0;s:4:\"menu\";i:0;s:7:\"marquee\";i:0;s:5:\"meter\";i:0;s:3:\"nav\";i:0;s:4:\"nobr\";i:0;s:6:\"object\";i:0;s:2:\"ol\";i:2;s:8:\"optgroup\";i:0;s:6:\"option\";i:0;s:6:\"output\";i:0;s:1:\"p\";i:2;s:5:\"param\";i:0;s:3:\"pre\";i:2;s:8:\"progress\";i:0;s:1:\"q\";i:0;s:2:\"rp\";i:0;s:2:\"rt\";i:0;s:4:\"ruby\";i:0;s:1:\"s\";i:0;s:4:\"samp\";i:0;s:6:\"script\";i:0;s:7:\"section\";i:0;s:6:\"select\";i:0;s:5:\"small\";i:0;s:6:\"source\";i:0;s:4:\"span\";i:2;s:6:\"strike\";i:0;s:6:\"strong\";i:2;s:3:\"sub\";i:1;s:7:\"summary\";i:1;s:3:\"sup\";i:0;s:5:\"table\";i:2;s:5:\"tbody\";i:1;s:2:\"td\";i:2;s:8:\"textarea\";i:0;s:5:\"tfoot\";i:1;s:2:\"th\";i:2;s:5:\"thead\";i:0;s:4:\"time\";i:0;s:2:\"tr\";i:2;s:2:\"tt\";i:2;s:1:\"u\";i:0;s:2:\"ul\";i:2;s:3:\"var\";i:0;s:5:\"video\";i:0;s:3:\"wbr\";i:0;}'),(165,'ZikulaCategoriesModule','userrootcat','s:17:\"/__SYSTEM__/Users\";'),(166,'ZikulaCategoriesModule','allowusercatedit','i:0;'),(167,'ZikulaCategoriesModule','autocreateusercat','i:0;'),(168,'ZikulaCategoriesModule','autocreateuserdefaultcat','i:0;'),(169,'ZikulaCategoriesModule','userdefaultcatname','s:7:\"Default\";'),(170,'ZikulaMailerModule','charset','s:5:\"utf-8\";'),(171,'ZikulaMailerModule','encoding','s:4:\"8bit\";'),(172,'ZikulaMailerModule','html','b:0;'),(173,'ZikulaMailerModule','wordwrap','i:50;'),(174,'ZikulaMailerModule','enableLogging','b:0;'),(175,'ZikulaSearchModule','itemsperpage','i:10;'),(176,'ZikulaSearchModule','limitsummary','i:255;'),(177,'ZikulaSearchModule','opensearch_enabled','b:1;'),(178,'ZikulaSearchModule','opensearch_adult_content','b:0;'),(179,'ZConfig','system_identifier','s:32:\"619372937657af995e90f71627589635\";'),(180,'systemplugin.imagine','version','s:5:\"0.6.2\";'),(181,'systemplugin.imagine','thumb_dir','s:20:\"systemplugin.imagine\";'),(182,'systemplugin.imagine','thumb_auto_cleanup','b:0;'),(183,'systemplugin.imagine','thumb_auto_cleanup_period','s:3:\"P1D\";'),(184,'systemplugin.imagine','presets','a:1:{s:7:\"default\";C:27:\"SystemPlugin_Imagine_Preset\":266:{x:i:2;a:8:{s:5:\"width\";i:100;s:6:\"height\";i:100;s:4:\"mode\";s:5:\"inset\";s:9:\"extension\";N;s:7:\"options\";a:2:{s:12:\"jpeg_quality\";i:75;s:21:\"png_compression_level\";i:7;}s:8:\"__module\";N;s:9:\"__imagine\";N;s:16:\"__transformation\";N;};m:a:1:{s:7:\"\0*\0name\";s:7:\"default\";}}}'),(185,'ZikulaAndreas08Theme','layout','s:9:\"container\";'),(186,'ZikulaAndreas08Theme','home','s:18:\"3col_w_centerblock\";'),(187,'ZikulaAndreas08Theme','master','s:4:\"2col\";'),(188,'ZikulaAndreas08Theme','admin','s:4:\"1col\";');
/*!40000 ALTER TABLE `module_vars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `displayname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `directory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `capabilities` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `state` int(11) NOT NULL,
  `securityschema` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `core_min` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `core_max` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'ZikulaExtensionsModule',3,'Extensions','extensions','Manage your modules and plugins.','ExtensionsModule','3.7.12','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:16:\"/141/extensions/\";}}',3,'a:1:{s:24:\"ZikulaExtensionsModule::\";s:2:\"::\";}','1.4.0',''),(2,'ZikulaAdminModule',3,'Administration panel','adminpanel','Backend administration interface.','AdminModule','1.9.1','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:16:\"/141/adminpanel/\";}}',3,'a:1:{s:19:\"ZikulaAdminModule::\";s:38:\"Admin Category name::Admin Category ID\";}','1.4.0',''),(3,'ZikulaBlocksModule',3,'Blocks','blocks','Block administration module.','BlocksModule','3.9.1','a:3:{s:15:\"hook_subscriber\";a:1:{s:7:\"enabled\";b:1;}s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/blocks/admin\";}s:4:\"user\";a:1:{s:3:\"url\";s:12:\"/141/blocks/\";}}',3,'a:11:{s:20:\"ZikulaBlocksModule::\";s:30:\"Block key:Block title:Block ID\";s:28:\"ZikulaBlocksModule::position\";s:26:\"Position name::Position ID\";s:23:\"Menutree:menutreeblock:\";s:26:\"Block ID:Link Name:Link ID\";s:19:\"ExtendedMenublock::\";s:17:\"Block ID:Link ID:\";s:15:\"fincludeblock::\";s:13:\"Block title::\";s:11:\"HTMLblock::\";s:13:\"Block title::\";s:15:\"Languageblock::\";s:13:\"Block title::\";s:11:\"Menublock::\";s:22:\"Block title:Link name:\";s:16:\"PendingContent::\";s:13:\"Block title::\";s:11:\"Textblock::\";s:13:\"Block title::\";s:11:\"xsltblock::\";s:13:\"Block title::\";}','1.4.0',''),(4,'ZikulaCategoriesModule',3,'Categories','categories','Category administration.','CategoriesModule','1.2.2','a:2:{s:5:\"admin\";a:1:{s:3:\"url\";s:21:\"/141/categories/admin\";}s:4:\"user\";a:1:{s:3:\"url\";s:16:\"/141/categories/\";}}',3,'a:2:{s:24:\"ZikulaCategoriesModule::\";s:2:\"::\";s:32:\"ZikulaCategoriesModule::Category\";s:40:\"Category ID:Category Path:Category IPath\";}','1.4.0',''),(5,'ZikulaGroupsModule',3,'Groups','groups','User group administration module.','GroupsModule','2.3.2','a:2:{s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/groups/admin\";}s:4:\"user\";a:1:{s:3:\"url\";s:12:\"/141/groups/\";}}',3,'a:1:{s:20:\"ZikulaGroupsModule::\";s:10:\"Group ID::\";}','1.4.0',''),(6,'ZikulaMailerModule',3,'Mailer Module','mailer','Mailer module, provides mail API and mail setting administration.','MailerModule','1.4.2','a:2:{s:15:\"hook_subscriber\";a:1:{s:7:\"enabled\";b:1;}s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/mailer/admin\";}}',3,'a:1:{s:20:\"ZikulaMailerModule::\";s:2:\"::\";}','1.4.0',''),(7,'ZikulaPageLockModule',3,'Page lock','pagelock','Provides the ability to lock pages when they are in use, for content and access control.','PageLockModule','1.1.1','a:0:{}',1,'a:1:{s:22:\"ZikulaPageLockModule::\";s:2:\"::\";}','1.4.0',''),(8,'ZikulaPermissionsModule',3,'Permissions','permissions','User permissions manager.','PermissionsModule','1.1.1','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/permissions/\";}}',3,'a:1:{s:25:\"ZikulaPermissionsModule::\";s:2:\"::\";}','1.4.0',''),(9,'ZikulaRoutesModule',3,'Routes','routes','Routes module generated by ModuleStudio 0.7.0.','RoutesModule','1.0.1','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/routes/admin\";}}',3,'a:3:{s:20:\"ZikulaRoutesModule::\";s:2:\"::\";s:24:\"ZikulaRoutesModule::Ajax\";s:2:\"::\";s:25:\"ZikulaRoutesModule:Route:\";s:10:\"Route ID::\";}','1.4.1','1.4.99'),(10,'ZikulaSearchModule',3,'Site search','search','Site search module.','SearchModule','1.5.4','a:2:{s:4:\"user\";a:1:{s:5:\"route\";s:28:\"zikulasearchmodule_user_form\";}s:5:\"admin\";a:1:{s:3:\"url\";s:17:\"/141/search/admin\";}}',3,'a:1:{s:20:\"ZikulaSearchModule::\";s:13:\"Module name::\";}','1.4.0',''),(11,'ZikulaSecurityCenterModule',3,'Security Center','securitycenter','Manage site security and settings.','SecurityCenterModule','1.4.4','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:25:\"/141/securitycenter/admin\";}}',3,'a:1:{s:28:\"ZikulaSecurityCenterModule::\";s:2:\"::\";}','1.4.0',''),(12,'ZikulaSettingsModule',3,'General settings','settings','General site configuration interface.','SettingsModule','2.9.10','a:1:{s:5:\"admin\";a:1:{s:3:\"url\";s:19:\"/141/settings/admin\";}}',3,'a:1:{s:22:\"ZikulaSettingsModule::\";s:2:\"::\";}','1.4.0',''),(13,'ZikulaThemeModule',3,'Themes','theme','Themes module to manage site layout, render and cache settings.','ThemeModule','3.4.3','a:2:{s:5:\"admin\";a:1:{s:3:\"url\";s:16:\"/141/theme/admin\";}s:4:\"user\";a:1:{s:3:\"url\";s:11:\"/141/theme/\";}}',3,'a:2:{s:19:\"ZikulaThemeModule::\";s:12:\"Theme name::\";s:30:\"ZikulaThemeModule::ThemeChange\";s:2:\"::\";}','1.4.0',''),(14,'ZikulaUsersModule',3,'Users','users','Provides an interface for configuring and administering registered user accounts. Incorporates all needed functionality, but can work in close unison with the third party profile module configured in the general settings of the site.','UsersModule','2.2.5','a:5:{s:14:\"authentication\";a:1:{s:7:\"version\";s:3:\"1.0\";}s:15:\"hook_subscriber\";a:1:{s:7:\"enabled\";b:1;}s:10:\"searchable\";a:1:{s:5:\"class\";s:38:\"Zikula\\UsersModule\\Helper\\SearchHelper\";}s:5:\"admin\";a:1:{s:3:\"url\";s:16:\"/141/users/admin\";}s:4:\"user\";a:1:{s:3:\"url\";s:16:\"/141/useraccount\";}}',3,'a:2:{s:19:\"ZikulaUsersModule::\";s:14:\"Uname::User ID\";s:28:\"ZikulaUsersModule::MailUsers\";s:2:\"::\";}','1.4.0','');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectdata_attributes`
--

DROP TABLE IF EXISTS `objectdata_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectdata_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `object_id` int(11) NOT NULL,
  `object_type` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_date` datetime NOT NULL,
  `cr_uid` int(11) NOT NULL,
  `lu_date` datetime NOT NULL,
  `lu_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_type` (`object_type`),
  KEY `object_id` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objectdata_attributes`
--

LOCK TABLES `objectdata_attributes` WRITE;
/*!40000 ALTER TABLE `objectdata_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `objectdata_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectdata_log`
--

DROP TABLE IF EXISTS `objectdata_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectdata_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_type` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `object_id` int(11) NOT NULL,
  `op` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `diff` longtext COLLATE utf8_unicode_ci,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_date` datetime NOT NULL,
  `cr_uid` int(11) NOT NULL,
  `lu_date` datetime NOT NULL,
  `lu_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objectdata_log`
--

LOCK TABLES `objectdata_log` WRITE;
/*!40000 ALTER TABLE `objectdata_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `objectdata_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objectdata_meta`
--

DROP TABLE IF EXISTS `objectdata_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objectdata_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `tablename` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `idcolumn` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `obj_id` int(11) NOT NULL,
  `permissions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_title` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_author` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_keywords` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_publisher` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_contributor` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_startdate` datetime DEFAULT NULL,
  `dc_enddate` datetime DEFAULT NULL,
  `dc_type` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_format` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_source` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_language` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_relation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_coverage` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_entity` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dc_extra` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `obj_status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `cr_date` datetime NOT NULL,
  `cr_uid` int(11) NOT NULL,
  `lu_date` datetime NOT NULL,
  `lu_uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objectdata_meta`
--

LOCK TABLES `objectdata_meta` WRITE;
/*!40000 ALTER TABLE `objectdata_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `objectdata_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sc_intrusion`
--

DROP TABLE IF EXISTS `sc_intrusion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sc_intrusion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `tag` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  `page` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `impact` int(11) NOT NULL,
  `filters` longtext COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8595CE46539B0606` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sc_intrusion`
--

LOCK TABLES `sc_intrusion` WRITE;
/*!40000 ALTER TABLE `sc_intrusion` DISABLE KEYS */;
/*!40000 ALTER TABLE `sc_intrusion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_result`
--

DROP TABLE IF EXISTS `search_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `text` longtext COLLATE utf8_unicode_ci,
  `module` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extra` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `found` datetime DEFAULT NULL,
  `sesid` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:object)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_result`
--

LOCK TABLES `search_result` WRITE;
/*!40000 ALTER TABLE `search_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_stat`
--

DROP TABLE IF EXISTS `search_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `scount` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_stat`
--

LOCK TABLES `search_stat` WRITE;
/*!40000 ALTER TABLE `search_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_info`
--

DROP TABLE IF EXISTS `session_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_info` (
  `sessid` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `ipaddr` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `lastused` datetime NOT NULL,
  `uid` int(11) NOT NULL,
  `remember` smallint(6) NOT NULL,
  `vars` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sessid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_info`
--

LOCK TABLES `session_info` WRITE;
/*!40000 ALTER TABLE `session_info` DISABLE KEYS */;
INSERT INTO `session_info` VALUES ('0267c5280cb3e662d9002de6ddd4fd97','localhost','2016-08-13 18:04:33',0,0,'_sf2_attributes|a:2:{s:7:\"_tokens\";a:1:{s:23:\"57af9971767c49.27292647\";a:2:{s:5:\"token\";s:92:\"NTdhZjk5NzE3NjdjNDkuMjcyOTI2NDc6MThkNDhhNzk1YTBjZTEwZmFmYmFhZDBiZjE2ZGJiYmI6MTQ3MTEyNTg3Mw==\";s:4:\"time\";i:1471125873;}}s:18:\"sessioncsrftokenid\";s:23:\"57af9971767c49.27292647\";}_sf2_flashes|a:1:{s:7:\"success\";a:1:{i:0;s:56:\"Congratulations! Zikula has been successfully installed.\";}}_sf2_meta|a:3:{s:1:\"u\";i:1471125874;s:1:\"c\";i:1471125871;s:1:\"l\";s:1:\"0\";}'),('286236246f657225843e43b54d5dd674','localhost','2016-08-13 18:04:57',2,1,'_sf2_attributes|a:5:{s:7:\"_tokens\";a:1:{s:23:\"57af9971767c49.27292647\";a:2:{s:5:\"token\";s:92:\"NTdhZjk5NzE3NjdjNDkuMjcyOTI2NDc6MThkNDhhNzk1YTBjZTEwZmFmYmFhZDBiZjE2ZGJiYmI6MTQ3MTEyNTg3Mw==\";s:4:\"time\";i:1471125873;}}s:18:\"sessioncsrftokenid\";s:23:\"57af9971767c49.27292647\";s:3:\"uid\";i:2;s:21:\"authentication_method\";a:2:{s:7:\"modname\";s:17:\"ZikulaUsersModule\";s:6:\"method\";s:5:\"uname\";}s:10:\"rememberme\";i:1;}_sf2_flashes|a:1:{s:7:\"success\";a:1:{i:0;s:56:\"Congratulations! Zikula has been successfully installed.\";}}_sf2_meta|a:3:{s:1:\"u\";i:1471125898;s:1:\"c\";i:1471125871;s:1:\"l\";s:1:\"0\";}'),('5b8c31febc8c9d60169d52ff52cd43b6','localhost','2016-08-13 18:04:54',0,0,'_sf2_attributes|a:0:{}_sf2_flashes|a:0:{}_sf2_meta|a:3:{s:1:\"u\";i:1471125899;s:1:\"c\";i:1471125875;s:1:\"l\";s:1:\"0\";}');
/*!40000 ALTER TABLE `session_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `themes`
--

DROP TABLE IF EXISTS `themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `displayname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `directory` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `contact` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `admin` smallint(6) NOT NULL,
  `user` smallint(6) NOT NULL,
  `system` smallint(6) NOT NULL,
  `state` smallint(6) NOT NULL,
  `xhtml` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `themes`
--

LOCK TABLES `themes` WRITE;
/*!40000 ALTER TABLE `themes` DISABLE KEYS */;
INSERT INTO `themes` VALUES (1,'ZikulaAndreas08Theme',3,'Andreas08','Based on the theme Andreas08 by Andreas Viklund','Andreas08Theme','2.0.0','3',1,1,0,1,1),(2,'ZikulaAtomTheme',3,'Atom','The Atom theme is an auxiliary theme specially designed for rendering pages in Atom mark-up.','AtomTheme','2.0.0','3',0,1,0,1,1),(3,'ZikulaBootstrapTheme',3,'Bootstrap','Bootstrap based theme','BootstrapTheme','1.0.0','3',1,1,0,1,1),(4,'ZikulaPrinterTheme',3,'Printer','The Printer theme is an auxiliary theme designed specially for outputting pages in a printer-friendly format.','PrinterTheme','3.0.0','3',0,1,0,1,1),(5,'ZikulaRssTheme',3,'Rss','The RSS theme is an auxiliary theme designed specially for outputting pages as an RSS feed.','RssTheme','2.0.0','3',0,1,0,1,1),(6,'ZikulaSeaBreezeTheme',3,'SeaBreeze','The SeaBreeze theme is a browser-oriented theme.','SeaBreezeTheme','4.0.0','3',1,1,0,1,1);
/*!40000 ALTER TABLE `themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userblocks`
--

DROP TABLE IF EXISTS `userblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userblocks` (
  `uid` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`uid`,`bid`),
  KEY `uid_bid_idx` (`uid`,`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userblocks`
--

LOCK TABLES `userblocks` WRITE;
/*!40000 ALTER TABLE `userblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `userblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(138) COLLATE utf8_unicode_ci NOT NULL,
  `passreminder` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `activated` smallint(6) NOT NULL,
  `approved_date` datetime NOT NULL,
  `approved_by` int(11) NOT NULL,
  `user_regdate` datetime NOT NULL,
  `lastlogin` datetime NOT NULL,
  `theme` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ublockon` smallint(6) NOT NULL,
  `ublock` longtext COLLATE utf8_unicode_ci NOT NULL,
  `tz` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `uname` (`uname`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'guest','','','',1,'1970-01-01 00:00:00',0,'1970-01-01 00:00:00','1970-01-01 00:00:00','',0,'','',''),(2,'admin','admin@example.com','8$w#9XD$abb959fc28434e3a084271108c00d87cb0ad82dd99398efb64a50209744483de','',1,'2016-08-13 22:03:59',2,'2016-08-13 22:04:13','2016-08-13 22:04:51','',0,'','','');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_attributes`
--

DROP TABLE IF EXISTS `users_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_attributes` (
  `user_id` int(11) NOT NULL,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`name`),
  KEY `IDX_E6F031E4A76ED395` (`user_id`),
  CONSTRAINT `FK_E6F031E4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_attributes`
--

LOCK TABLES `users_attributes` WRITE;
/*!40000 ALTER TABLE `users_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_verifychg`
--

DROP TABLE IF EXISTS `users_verifychg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_verifychg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `changetype` smallint(6) NOT NULL,
  `uid` int(11) NOT NULL,
  `newemail` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `verifycode` varchar(138) COLLATE utf8_unicode_ci NOT NULL,
  `created_dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_verifychg`
--

LOCK TABLES `users_verifychg` WRITE;
/*!40000 ALTER TABLE `users_verifychg` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_verifychg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `metaid` int(11) NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `schemaname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` smallint(6) NOT NULL,
  `obj_table` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `obj_idcolumn` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `obj_id` int(11) NOT NULL,
  `busy` int(11) NOT NULL,
  `debug` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflows`
--

LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zikula_routes_route`
--

DROP TABLE IF EXISTS `zikula_routes_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zikula_routes_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workflowState` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `routeType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `replacedRouteName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bundle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `controller` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `route_action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `route_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `schemes` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `methods` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prependBundlePrefix` tinyint(1) NOT NULL,
  `translatable` tinyint(1) NOT NULL,
  `translationPrefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `route_defaults` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `requirements` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `route_condition` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort` bigint(20) NOT NULL,
  `sort_group` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdUserId` int(11) NOT NULL,
  `updatedUserId` int(11) NOT NULL,
  `createdDate` datetime NOT NULL,
  `updatedDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_516F4628BF396750` (`id`),
  KEY `workflowstateindex` (`workflowState`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zikula_routes_route`
--

LOCK TABLES `zikula_routes_route` WRITE;
/*!40000 ALTER TABLE `zikula_routes_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `zikula_routes_route` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-13 18:06:16
