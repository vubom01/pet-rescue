-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: pet-rescue.chhw3ihaqbuw.ap-southeast-1.rds.amazonaws.com    Database: pet_rescue
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `donate_detail`
--

DROP TABLE IF EXISTS `donate_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donate_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sponsor_id` int NOT NULL,
  `created_at` date NOT NULL,
  `update_at` date NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `transaction_code` varchar(255) NOT NULL,
  `donations` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_donate_info_idx` (`sponsor_id`),
  CONSTRAINT `fk_donate_info` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donate_detail`
--

LOCK TABLES `donate_detail` WRITE;
/*!40000 ALTER TABLE `donate_detail` DISABLE KEYS */;
INSERT INTO `donate_detail` VALUES (12,11,'2021-08-10','2021-08-10','19034884488012','HQCS134567',10000000),(13,11,'2021-08-10','2021-08-10','123123','141234',12341234),(14,13,'2021-08-10','2021-08-10','50210000103590','QWER123465',1000000000);
/*!40000 ALTER TABLE `donate_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_report`
--

DROP TABLE IF EXISTS `health_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_id` int NOT NULL,
  `veterinary_clinic_id` int NOT NULL,
  `created_at` date NOT NULL,
  `update_at` varchar(45) NOT NULL,
  `weight` double NOT NULL,
  `health_condition` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_health_report_1_idx` (`pet_id`),
  KEY `fk_health_report_2_idx` (`veterinary_clinic_id`),
  CONSTRAINT `fk_health_report_1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_health_report_2` FOREIGN KEY (`veterinary_clinic_id`) REFERENCES `veterinary_clinic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_report`
--

LOCK TABLES `health_report` WRITE;
/*!40000 ALTER TABLE `health_report` DISABLE KEYS */;
INSERT INTO `health_report` VALUES (6,37,17,'2021-08-10','2021-08-10',30,'T??nh tr???ng s???c kho??? t???t','t??nh tr???ng s???c kho??? t???t , kh??ng b??? giun s??n, ham ??n, nhi???u n??ng l?????ng'),(7,34,19,'2021-08-10','2021-08-10',20,'t???t','s???c kho??? t???t, ??n u???ng ?????y ?????, kh??ng b??? giun s??n, nh??ng m?? h??i ng??o, hay s???a linh tinh'),(8,29,16,'2021-08-10','2021-08-10',2.5,'t???t','t???t');
/*!40000 ALTER TABLE `health_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_images`
--

DROP TABLE IF EXISTS `pet_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_images` (
  `pet_id` int NOT NULL,
  `url` varchar(255) NOT NULL,
  KEY `fk_image_pet_idx` (`pet_id`),
  CONSTRAINT `fk_image_pet` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_images`
--

LOCK TABLES `pet_images` WRITE;
/*!40000 ALTER TABLE `pet_images` DISABLE KEYS */;
INSERT INTO `pet_images` VALUES (19,'http://res.cloudinary.com/pet-rescue/image/upload/v1628346392/pet-rescue/19/flchsknonuwr0vsj86uw.jpg'),(29,'http://res.cloudinary.com/pet-rescue/image/upload/v1628385668/pet-rescue/29/hhrakpgo0sli1jxj5lex.jpg'),(32,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556101/pet-rescue/32/darnjmzy7pjmcqkr13u4.jpg'),(33,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556184/pet-rescue/33/rmxmb1ltqv9mh0od7tv2.jpg'),(34,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556374/pet-rescue/34/jjd3vbtuihuunpamtiga.jpg'),(35,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556485/pet-rescue/35/lwgdiyqvwcgho6goedjm.jpg'),(36,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556604/pet-rescue/36/tmj5dlvhq5zyszgxh0hi.jpg'),(37,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556890/pet-rescue/37/kvbtji0snn2lzfudlyej.jpg'),(37,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556891/pet-rescue/37/kq1xqtltdi28xhjm03rj.jpg'),(37,'http://res.cloudinary.com/pet-rescue/image/upload/v1628556892/pet-rescue/37/vtjayak39sybclipew4m.jpg');
/*!40000 ALTER TABLE `pet_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `health_condition` varchar(255) NOT NULL,
  `weight` double NOT NULL,
  `description` longtext NOT NULL,
  `species` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES (19,'ch??','young','male','v??ng','t???t',12,'ch?? corgi','dog'),(29,'putdo','mature','male','xanh x??m','t???t ',20.5,'l?? ch?? ch?? lang thang ???????c ng?????i c???u v??? trong t??nh tr???ng b??? th????ng ??? ch??n ph???i , sau khi ???????c s??? ch??m s??c c???a c??c t??nh nguy???n vi??n th?? ???? kho??? m???nh tr??? l???i v?? l???i h???i h??n x??a','dog'),(32,'Khoai t??y','mature','male','v??ng x??m','T???t',5,'B?? d??? th????ng ????ng y??u, bi???t ?????ng l???y khi ????i ??n hay b???','dog'),(33,'V???ng jinx','young','male','tr???ng','t???t',2,'V???ng (Jinx) ???????c c???u khi lang thang ngo??i ???????ng. B?? r???t tinh ngh???ch, ham ch??i ham vui.','cat'),(34,'john ng??o','mature','male','??en tr???ng','t???t',28,'Ch?? Husky c?? ngo???i h??nh ?????p, th??n thi???n nh??ng l???i kh?? ngh???ch ng???m, ????i m???t c???a ch?? Husky r???t trong, s??ng v?? tinh ranh.','dog'),(35,'Chewie','young','female','tr???ng','t???t',0.5,'B?? b??? ch??? c???t l??ng nham nh??? r???i th???ng tay v???t ??i, trong l??c mon men b?? ra ???????ng th?? g???p tai n???n xe. L??c tnv nh??m nh???n tin ?????n n??i th?? ng?????i d??n ??em b??? b?? ra l??m c??y, b?? ch???c h???n ???? r???t ho???ng s???, n???m cu???n tr??n im thin th??t trong c??i m?? b???o hi???m ???? v???. B?? th??? y???u, ng?????i l???nh, ni??m m???c nh???t nh???t, v?? n???m to??n th??n. May m?? k???p th???i c???u ???????c b?? ??i vi???n...','cat'),(36,'xi xi','young','male','tam th???','t???t',2,'Xi Xi ???????c c???u khi ??ang lang thang ??? ngo??i ???????ng l??c b???ng mang d??? ch???a. Nh??m ???? t??m ???????c m??i ???m cho t???t c??? c??c con c???a con, th??? nh??ng Xi Xi v???n ch??a c?? gia ????nh c???a ri??ng m??nh. Ban ?????u con s??? d?? ch???ng ch??t, nh??ng sau ???? s??? r???t t??nh th????ng m???n th????ng. Th??ch leo l??n l??ng n???m ????? ???????c ??m ???????c vu???t ve chi???u chu???ng. C??n th??ch ng??? ng??y gi???a ban ng??y ho???c n???m ng???a b???ng ph??i n???ng n???a c?? ^^','cat'),(37,'Bim Bim','old','male','v??ng x??m','t???t',14,'Bim Bim su??t b??? ch??? b??n th???t v?? b?? b??? gh??? v?? k?? sinh tr??ng m??u, may l?? b?? ???? v??? v???i nh??m k???p th???i v?? ???????c ch???a tr??? t??? t???. Bim Bim t??nh t??nh vui v???, ham ch??i, m???i g???n 1 t???i th??i n??n c??n h??i ng??o ng??o ng?? ng??, d??? tin ng?????i :))) Th??ch nh???t l?? ???????c tung t??ng ??i d???o v?? r???t ngoan khi d???t d??y. C?? ch??t nh??t nh??t khi th???y m??o v?? ch?? b??, nh??ng Bim Bim r???t th??ch l??m b???n v???i m???y b???n ch?? l???n. Foster c???a Bim Bim ?????m b???o b?? n?? si??u c???p hi???n l??nh, kh??ng l??m ??au c??? m???t con ru???i lun ?? n?? ? Bim Bim ???? ti??m ph??ng ?????y ?????, nh??ng ch??a tri???t s???n. Th??n h??nh hi???n t???i h??i \"m??nh d??y\" n??n c???n gia ????nh v??? v??? y??u th????ng, nh???t l?? v??? b??o :)))','dog');
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
INSERT INTO `sponsors` VALUES (10,'quynh','tr???n','123 tr???n h??ng ?????o','j@gmail.com','091239812'),(11,'Vuot','Nguyen','Ho??ng Cung','petcare@gmail.com','02466508126'),(12,'mingh','nguyen','123 h?? n???i','b@mi.com','09123979'),(13,'Vu','Le Huy','Thanh Hoa','vudeptrai@gmail.com','0123456789');
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'guest',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (15,'admin','$2b$12$FxEYx3gt8G8Vv.IxwX0BIOxHXb7htJTkKAlYZCvmFWh4IzFE9XM.e','Super','Admin','0123456789','admin@gmail.com','admin'),(16,'volunteer','$2b$12$OYf.i4.L4K5yg.UV/ksf5eIJpAgUBs/Jilon4sebiuaO6cskaUCa.','T??i l??','Volunteer','0987654321','volunteer@gmail.com','volunteer'),(17,'guest','$2b$12$EENCTdUa7YXshV1MKEyaGeDrtsxU6CQkXM/0EhBYSklzBpQ99Uz5i','T??i l??','Guest','0123456987','guest@gmail.com','guest');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinary_clinic`
--

DROP TABLE IF EXISTS `veterinary_clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinary_clinic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinary_clinic`
--

LOCK TABLES `veterinary_clinic` WRITE;
/*!40000 ALTER TABLE `veterinary_clinic` DISABLE KEYS */;
INSERT INTO `veterinary_clinic` VALUES (16,'B???nh vi???n th?? y nonae','240 ??u C??, T??y H???, H?? N???i','0908428882','pethealth@gmail.com'),(17,'B???nh vi???n th?? c??ng Pet Mart','242 Nguy???n Tr??i, Thanh Xu??n','02471069906','petmart@gmail.com'),(18,'B???nh vi???n th?? y H?? N???i H???i ????ng PetCare','S??? 14, Ng?? 102 Khu???t Duy Ti???n.','0964004115','petcare@gmail.com'),(19,'Ph??ng kh??m th?? y H?? N???i Dr.Hai','2F Ho??ng Hoa Th??m','02466508126','haido@yahoo.com');
/*!40000 ALTER TABLE `veterinary_clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_schedule`
--

DROP TABLE IF EXISTS `work_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_schedule` (
  `user_id` int NOT NULL,
  `working_day` date NOT NULL,
  `working_shift` int DEFAULT NULL,
  KEY `fk_user_time_idx` (`user_id`),
  CONSTRAINT `fk_user_time` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_schedule`
--

LOCK TABLES `work_schedule` WRITE;
/*!40000 ALTER TABLE `work_schedule` DISABLE KEYS */;
INSERT INTO `work_schedule` VALUES (16,'2021-08-18',1),(16,'2021-08-19',2),(16,'2021-08-20',2),(16,'2021-08-21',1),(16,'2021-08-22',NULL),(16,'2021-08-23',NULL);
/*!40000 ALTER TABLE `work_schedule` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-15 20:04:49
