CREATE DATABASE  IF NOT EXISTS `final_project_databases` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `final_project_databases`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- ------------------------------------------------------
-- Server version	5.6.37-log

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
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Items` (
  `name` varchar(64) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES ('A group of about 8 tomatoes',7),('Balloons',10),('HDMI Cable',10),('Laptop',10),('Monitor',10),('Pencil',1),('Stapler',10),('Tablet',10);
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kit_Contents`
--

DROP TABLE IF EXISTS `Kit_Contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Kit_Contents` (
  `kit_name` varchar(64) NOT NULL,
  `item` varchar(64) NOT NULL,
  `quantity` int(11) NOT NULL,
  KEY `kit_contents_kit_fk_idx` (`kit_name`),
  KEY `kit_contents_items_fk_idx` (`item`),
  CONSTRAINT `kit_contents_items_fk` FOREIGN KEY (`item`) REFERENCES `Items` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kit_contents_kit_fk` FOREIGN KEY (`kit_name`) REFERENCES `Kits` (`kit_name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Kit_Contents`
--

LOCK TABLES `Kit_Contents` WRITE;
/*!40000 ALTER TABLE `Kit_Contents` DISABLE KEYS */;
INSERT INTO `Kit_Contents` VALUES ('Laptop Kit','Laptop',3),('Monitor Set','Monitor',2),('Monitor Set','HDMI Cable',2),('Computer Set','Laptop',1),('Computer Set','Tablet',1);
/*!40000 ALTER TABLE `Kit_Contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kits`
--

DROP TABLE IF EXISTS `Kits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Kits` (
  `kit_name` varchar(64) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`kit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Kits`
--

LOCK TABLES `Kits` WRITE;
/*!40000 ALTER TABLE `Kits` DISABLE KEYS */;
INSERT INTO `Kits` VALUES ('Computer Set',2),('Laptop Kit',2),('Monitor Set',4);
/*!40000 ALTER TABLE `Kits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Workshop_Contents`
--

DROP TABLE IF EXISTS `Workshop_Contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Workshop_Contents` (
  `workshop_id` int(11) NOT NULL,
  `kit_name` varchar(64) DEFAULT NULL,
  `item_name` varchar(64) DEFAULT NULL,
  `quantity` varchar(64) DEFAULT NULL,
  KEY `w_contents_items_fk_idx` (`item_name`),
  KEY `w_contents_kits_fk_idx` (`kit_name`),
  CONSTRAINT `w_contents_items_fk` FOREIGN KEY (`item_name`) REFERENCES `Items` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `w_contents_kits_fk` FOREIGN KEY (`kit_name`) REFERENCES `Kits` (`kit_name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Workshop_Contents`
--

LOCK TABLES `Workshop_Contents` WRITE;
/*!40000 ALTER TABLE `Workshop_Contents` DISABLE KEYS */;
INSERT INTO `Workshop_Contents` VALUES (1,'Laptop Kit',NULL,'1'),(1,NULL,'Tablet','5'),(1,NULL,'Laptop','1'),(2,'Laptop Kit',NULL,'1');
/*!40000 ALTER TABLE `Workshop_Contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `all_items_and_workshops`
--

DROP TABLE IF EXISTS `all_items_and_workshops`;
/*!50001 DROP VIEW IF EXISTS `all_items_and_workshops`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `all_items_and_workshops` AS SELECT 
 1 AS `Workshop_id`,
 1 AS `Item_Name`,
 1 AS `required_for_workshop`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `data_dump`
--

DROP TABLE IF EXISTS `data_dump`;
/*!50001 DROP VIEW IF EXISTS `data_dump`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `data_dump` AS SELECT 
 1 AS `workshop_id`,
 1 AS `name`,
 1 AS `total_available_of_item`,
 1 AS `kit_name`,
 1 AS `total_available_of_kit`,
 1 AS `used_in_workshop`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `items_in_kits_vs_individual`
--

DROP TABLE IF EXISTS `items_in_kits_vs_individual`;
/*!50001 DROP VIEW IF EXISTS `items_in_kits_vs_individual`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `items_in_kits_vs_individual` AS SELECT 
 1 AS `item`,
 1 AS `items_in_kits`,
 1 AS `available_as_individual`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `needed_items_for_kits`
--

DROP TABLE IF EXISTS `needed_items_for_kits`;
/*!50001 DROP VIEW IF EXISTS `needed_items_for_kits`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `needed_items_for_kits` AS SELECT 
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `total_items`
--

DROP TABLE IF EXISTS `total_items`;
/*!50001 DROP VIEW IF EXISTS `total_items`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `total_items` AS SELECT 
 1 AS `workshop_id`,
 1 AS `total_items`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `workshop_items_grouped`
--

DROP TABLE IF EXISTS `workshop_items_grouped`;
/*!50001 DROP VIEW IF EXISTS `workshop_items_grouped`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `workshop_items_grouped` AS SELECT 
 1 AS `workshop_id`,
 1 AS `item_name`,
 1 AS `quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `workshop_items_ungrouped`
--

DROP TABLE IF EXISTS `workshop_items_ungrouped`;
/*!50001 DROP VIEW IF EXISTS `workshop_items_ungrouped`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `workshop_items_ungrouped` AS SELECT 
 1 AS `workshop_id`,
 1 AS `item_Name`,
 1 AS `quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `workshops_kit_info`
--

DROP TABLE IF EXISTS `workshops_kit_info`;
/*!50001 DROP VIEW IF EXISTS `workshops_kit_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `workshops_kit_info` AS SELECT 
 1 AS `workshop_id`,
 1 AS `kit_name`,
 1 AS `quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `workshops_overusing_inventory`
--

DROP TABLE IF EXISTS `workshops_overusing_inventory`;
/*!50001 DROP VIEW IF EXISTS `workshops_overusing_inventory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `workshops_overusing_inventory` AS SELECT 
 1 AS `workshop_id`,
 1 AS `item_Name`,
 1 AS `workshop_Quantity`,
 1 AS `available`,
 1 AS `items_Short`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `workshops_underusing_inventory`
--

DROP TABLE IF EXISTS `workshops_underusing_inventory`;
/*!50001 DROP VIEW IF EXISTS `workshops_underusing_inventory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `workshops_underusing_inventory` AS SELECT 
 1 AS `workshop_id`,
 1 AS `item_Name`,
 1 AS `workshop_Quantity`,
 1 AS `available`,
 1 AS `items_left`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'final_project_databases'
--

--
-- Final view structure for view `all_items_and_workshops`
--

/*!50001 DROP VIEW IF EXISTS `all_items_and_workshops`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `all_items_and_workshops` AS select `w`.`workshop_id` AS `Workshop_id`,`w`.`item_name` AS `Item_Name`,`w`.`quantity` AS `required_for_workshop`,`i`.`name` AS `name` from (`workshop_items_grouped` `w` left join `Items` `i` on((`i`.`name` = `w`.`item_name`))) union select `w`.`workshop_id` AS `Workshop_id`,`w`.`item_name` AS `Item_Name`,`w`.`quantity` AS `Quantity`,`i`.`name` AS `name` from (`Items` `i` left join `workshop_items_grouped` `w` on((`i`.`name` = `w`.`item_name`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `data_dump`
--

/*!50001 DROP VIEW IF EXISTS `data_dump`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `data_dump` AS select `wc`.`workshop_id` AS `workshop_id`,`i`.`name` AS `name`,`i`.`quantity` AS `total_available_of_item`,`k`.`kit_name` AS `kit_name`,`k`.`quantity` AS `total_available_of_kit`,`wc`.`quantity` AS `used_in_workshop` from ((`Workshop_Contents` `wc` left join `Items` `i` on((`i`.`name` = `wc`.`item_name`))) left join `Kits` `k` on((`k`.`kit_name` = `wc`.`kit_name`))) union select `wc`.`workshop_id` AS `workshop_id`,`i`.`name` AS `name`,`i`.`quantity` AS `total_available_of_item`,`k`.`kit_name` AS `kit_name`,`k`.`quantity` AS `total_available_of_kit`,`wc`.`quantity` AS `used_in_workshop` from (`Kits` `k` left join (`Items` `i` left join `Workshop_Contents` `wc` on((`i`.`name` = `wc`.`item_name`))) on((`k`.`kit_name` = `wc`.`kit_name`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `items_in_kits_vs_individual`
--

/*!50001 DROP VIEW IF EXISTS `items_in_kits_vs_individual`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `items_in_kits_vs_individual` AS select `i`.`name` AS `item`,(sum(`ki`.`quantity`) * `k`.`quantity`) AS `items_in_kits`,(`i`.`quantity` - (sum(`ki`.`quantity`) * `k`.`quantity`)) AS `available_as_individual` from ((`Items` `i` join `Kit_Contents` `ki` on((`ki`.`item` = `i`.`name`))) join `Kits` `k` on((`k`.`kit_name` = `ki`.`kit_name`))) group by `i`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `needed_items_for_kits`
--

/*!50001 DROP VIEW IF EXISTS `needed_items_for_kits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `needed_items_for_kits` AS select `Items`.`name` AS `name` from `Items` where `Items`.`name` in (select `items_in_kits_vs_individual`.`item` from `items_in_kits_vs_individual` where (`items_in_kits_vs_individual`.`available_as_individual` < 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `total_items`
--

/*!50001 DROP VIEW IF EXISTS `total_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `total_items` AS select `workshop_items_grouped`.`workshop_id` AS `workshop_id`,sum(`workshop_items_grouped`.`quantity`) AS `total_items` from `workshop_items_grouped` group by `workshop_items_grouped`.`workshop_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `workshop_items_grouped`
--

/*!50001 DROP VIEW IF EXISTS `workshop_items_grouped`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `workshop_items_grouped` AS select `workshop_items_ungrouped`.`workshop_id` AS `workshop_id`,`workshop_items_ungrouped`.`item_Name` AS `item_name`,sum(`workshop_items_ungrouped`.`quantity`) AS `quantity` from `workshop_items_ungrouped` group by `workshop_items_ungrouped`.`workshop_id`,`workshop_items_ungrouped`.`item_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `workshop_items_ungrouped`
--

/*!50001 DROP VIEW IF EXISTS `workshop_items_ungrouped`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `workshop_items_ungrouped` AS select `Workshop_Contents`.`workshop_id` AS `workshop_id`,`Workshop_Contents`.`item_name` AS `item_Name`,`Workshop_Contents`.`quantity` AS `quantity` from `Workshop_Contents` where (`Workshop_Contents`.`item_name` is not null) union select `w`.`workshop_id` AS `Workshop_id`,`k`.`item` AS `item`,(`w`.`quantity` * `k`.`quantity`) AS `w.quantity * k.Quantity` from (`Workshop_Contents` `w` join `Kit_Contents` `k` on((`k`.`kit_name` = `w`.`kit_name`))) where (`w`.`kit_name` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `workshops_kit_info`
--

/*!50001 DROP VIEW IF EXISTS `workshops_kit_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `workshops_kit_info` AS select `Workshop_Contents`.`workshop_id` AS `workshop_id`,`Workshop_Contents`.`kit_name` AS `kit_name`,`Workshop_Contents`.`quantity` AS `quantity` from `Workshop_Contents` where `Workshop_Contents`.`kit_name` in (select `Kits`.`kit_name` from `Kits`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `workshops_overusing_inventory`
--

/*!50001 DROP VIEW IF EXISTS `workshops_overusing_inventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `workshops_overusing_inventory` AS select `w`.`workshop_id` AS `workshop_id`,`w`.`item_name` AS `item_Name`,`w`.`quantity` AS `workshop_Quantity`,`i`.`quantity` AS `available`,(`w`.`quantity` - `i`.`quantity`) AS `items_Short` from (`workshop_items_grouped` `w` join `Items` `i` on((`i`.`name` = `w`.`item_name`))) where ((`i`.`quantity` - `w`.`quantity`) < 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `workshops_underusing_inventory`
--

/*!50001 DROP VIEW IF EXISTS `workshops_underusing_inventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `workshops_underusing_inventory` AS select `w`.`workshop_id` AS `workshop_id`,`w`.`item_name` AS `item_Name`,`w`.`quantity` AS `workshop_Quantity`,`i`.`quantity` AS `available`,(`i`.`quantity` - `w`.`quantity`) AS `items_left` from (`workshop_items_grouped` `w` join `Items` `i` on((`i`.`name` = `w`.`item_name`))) where ((`i`.`quantity` - `w`.`quantity`) > 0) */;
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

-- Dump completed on 2017-11-28 19:48:38
