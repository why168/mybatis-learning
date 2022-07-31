-- MySQL dump 10.13  Distrib 5.7.37, for osx10.17 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	5.7.37-log

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
-- Table structure for table `product_plus`
--

DROP TABLE IF EXISTS `product_plus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_plus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `NAME` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `price` int(11) DEFAULT '0' COMMENT '价格',
  `VERSION` int(11) DEFAULT '0' COMMENT '乐观锁版本号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_plus`
--

LOCK TABLES `product_plus` WRITE;
/*!40000 ALTER TABLE `product_plus` DISABLE KEYS */;
INSERT INTO `product_plus` VALUES (1,'外星人笔记本',220,13);
/*!40000 ALTER TABLE `product_plus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dept`
--

DROP TABLE IF EXISTS `t_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dept` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dept`
--

LOCK TABLES `t_dept` WRITE;
/*!40000 ALTER TABLE `t_dept` DISABLE KEYS */;
INSERT INTO `t_dept` VALUES (1,'A'),(2,'B'),(3,'C');
/*!40000 ALTER TABLE `t_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_emp`
--

DROP TABLE IF EXISTS `t_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_emp` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(16) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `did` int(11) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_emp`
--

LOCK TABLES `t_emp` WRITE;
/*!40000 ALTER TABLE `t_emp` DISABLE KEYS */;
INSERT INTO `t_emp` VALUES (1,'张1',24,'女','123@qq.com',1),(2,'张2',22,'男','123@qq.com',1),(3,'张3',20,'男','123@qq.com',2),(4,'张4',30,'男','123@qq.com',3),(5,'a1',23,'男','123@qq.com',1),(6,'a2',23,'男','123@qq.com',2),(7,'a3',23,'男','123@qq.com',1),(8,'a1',23,'男','123@qq.com',NULL),(9,'a2',23,'男','123@qq.com',NULL),(10,'a3',23,'男','123@qq.com',NULL),(11,'a1',23,'男','123@qq.com',NULL),(12,'a2',23,'男','123@qq.com',NULL),(13,'a3',23,'男','123@qq.com',NULL),(14,'a1',23,'男','123@qq.com',NULL),(15,'a2',23,'男','123@qq.com',NULL),(16,'a3',23,'男','123@qq.com',NULL),(17,'a1',23,'男','123@qq.com',NULL),(18,'a2',23,'男','123@qq.com',NULL),(19,'a3',23,'男','123@qq.com',NULL),(20,'abc',23,'男','123@qq.com',NULL);
/*!40000 ALTER TABLE `t_emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (7,'??','www123',20,'?','222222@qq.com'),(8,'??','www123',20,'?','222222@qq.com'),(16,'??','www123',20,'?','222222@qq.com'),(17,'??','www123',20,'?','222222@qq.com'),(34,'奶狗','www123',20,'男','3333@qq.com'),(35,'奶狗','www123',20,'男','3333@qq.com'),(36,'奶狗','www123',20,'男','3333@qq.com'),(37,'奶狗','www123',20,'男','3333@qq.com'),(38,'奶狗','www123',20,'男','3333@qq.com'),(39,'奶狗','www123',20,'男','3333@qq.com'),(40,'奶狗','www123',20,'男','3333@qq.com'),(46,'奶狗','www123',20,'男','3333@qq.com'),(47,'奶狗','www123',20,'男','3333@qq.com'),(48,'奶狗','www123',20,'男','3333@qq.com'),(49,'奶狗1657128071734','www123',20,'男','3333@qq.com'),(55,'admin','123456',23,'男','12345@qq.com'),(56,'admin','123456',23,'男','12345@qq.com'),(57,'李四','123',23,'男','123@qq.com'),(58,'admin','123456',23,'男','12345@qq.com'),(59,'admin','123456',23,'男','12345@qq.com'),(60,'admin','123456',23,'男','12345@qq.com'),(61,'admin','123456',23,'男','12345@qq.com'),(62,'admin','123456',23,'男','12345@qq.com'),(63,'admin','123456',23,'男','12345@qq.com'),(64,'admin','123456',23,'男','12345@qq.com'),(65,'admin','123456',23,'男','12345@qq.com'),(66,'admin','123456',23,'男','12345@qq.com');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `age` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'张三',19),(4,'张三',19),(5,'张三',19),(6,'张三',19),(7,'张三',19),(8,'王麻子',19),(9,'李四',19),(10,'王四',28),(11,'王四四2',30);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_plus`
--

DROP TABLE IF EXISTS `user_plus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_plus` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `is_deleted` int(11) DEFAULT '0' COMMENT '0:未删除',
  `sex` int(11) DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=1551272047715901458 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_plus`
--

LOCK TABLES `user_plus` WRITE;
/*!40000 ALTER TABLE `user_plus` DISABLE KEYS */;
INSERT INTO `user_plus` VALUES (1,'李四',21,'lisi@atguigu.com',0,0),(2,'李四',21,'lisi@atguigu.com',1,0),(3,'李四',21,'lisi@atguigu.com',1,0),(4,'李四',21,'lisi@atguigu.com',0,0),(5,'Billie',24,'test5@baomidou.com',0,0),(7,'李四',21,'lisi@atguigu.com',0,0),(8,'张三',23,'zhangsan@atguigu.com',0,0),(1551271997275111426,'张三',23,'zhangsan@atguigu.com',0,0),(1551272047715901441,'张三',23,'zhangsan@atguigu.com',0,0),(1551272047715901442,'张三',23,'zhangsan@atguigu.com',0,0),(1551272047715901443,'admin',33,NULL,1,1),(1551272047715901444,'admin',33,NULL,1,1),(1551272047715901445,'admin',33,NULL,1,1),(1551272047715901446,'admin',33,NULL,1,1),(1551272047715901447,'ybc1',21,NULL,1,0),(1551272047715901448,'ybc2',22,NULL,1,0),(1551272047715901449,'ybc3',23,NULL,1,0),(1551272047715901450,'ybc4',24,NULL,1,0),(1551272047715901451,'ybc5',25,NULL,1,0),(1551272047715901452,'ybc6',26,NULL,1,0),(1551272047715901453,'ybc7',27,NULL,1,0),(1551272047715901454,'ybc8',28,NULL,1,0),(1551272047715901455,'ybc9',29,NULL,1,0),(1551272047715901456,'ybc10',30,NULL,1,0),(1551272047715901457,'张三',23,'zhangsan@atguigu.com',0,0);
/*!40000 ALTER TABLE `user_plus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-31 21:48:39
