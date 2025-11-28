/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: faco_luz
-- ------------------------------------------------------
-- Server version	11.8.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `adulthistories`
--

DROP TABLE IF EXISTS `adulthistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `adulthistories` (
  `patientId` uuid NOT NULL,
  `currentWorking` enum('Si','No') NOT NULL,
  `workType` varchar(30) DEFAULT NULL,
  `familyBurden` int(11) unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  KEY `patientToAdultHistories` (`patientId`),
  CONSTRAINT `patientToAdultHistory` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adulthistories`
--

LOCK TABLES `adulthistories` WRITE;
/*!40000 ALTER TABLE `adulthistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `adulthistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changelogs`
--

DROP TABLE IF EXISTS `changelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelogs` (
  `id` uuid NOT NULL,
  `changeType` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `userModificatorId` int(15) unsigned NOT NULL,
  `userModificatedId` int(15) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `modificatorToLogs` (`userModificatorId`),
  KEY `modificatedtoLogs` (`userModificatedId`),
  CONSTRAINT `modificatedtoLogs` FOREIGN KEY (`userModificatedId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `modificatorToLogs` FOREIGN KEY (`userModificatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelogs`
--

LOCK TABLES `changelogs` WRITE;
/*!40000 ALTER TABLE `changelogs` DISABLE KEYS */;
INSERT INTO `changelogs` VALUES
('95caac2d-2f0b-4cc1-a0f0-08a1014bf1c5',0,'2025-10-25 13:59:45',1,444466),
('44df124e-519f-4019-a7ae-2a0af586093b',0,'2025-10-25 13:56:56',1,8877),
('e85beb67-57a7-4f0a-96aa-2dfc57490e82',0,'2025-07-08 14:29:19',1,4),
('4a855e0e-93b4-4191-b90c-4625e139a00a',0,'2025-10-25 15:16:46',1,7744456),
('a5e05f34-6a78-43cb-bb2f-73e53d7a7a25',0,'2025-07-08 14:29:09',1,3),
('57fb848e-b31f-495f-a585-7859a10c9160',1,'2025-10-25 15:37:15',1,444466),
('6eac2379-2326-4a28-87b5-7a6dc7d64140',0,'2025-10-25 13:59:24',1,7788),
('7cd4a499-f17c-453e-a951-7f6dfaf81dad',0,'2025-10-25 15:16:31',1,7736559),
('f9df193b-80d6-4e1f-980a-85117882414a',0,'2025-10-25 15:15:22',1,7667655),
('87a098b6-40a2-41ce-9f33-8c6052940e60',0,'2025-07-08 14:29:27',1,5),
('8f6d56b7-a957-4edd-a585-8fca31947915',0,'2025-10-25 13:57:14',1,282882),
('82f77958-313a-4cd6-8d0c-9f8eb43fb83e',0,'2025-07-08 14:29:00',1,2),
('686925bc-08e2-4016-9708-b9992601bffd',1,'2025-10-25 15:37:18',1,282882),
('090fd24c-1ae8-403a-a450-fb5c04f41259',0,'2025-10-25 13:56:38',1,88266);
/*!40000 ALTER TABLE `changelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `childhistories`
--

DROP TABLE IF EXISTS `childhistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `childhistories` (
  `patientId` uuid NOT NULL,
  `currentStudying` enum('Si','No') NOT NULL,
  `representativeName` varchar(25) NOT NULL,
  `representativeIdentification` varchar(15) NOT NULL,
  `representativePhone` varchar(15) NOT NULL,
  `representativeInstructionGrade` enum('Ninguno','Prescolar','Primaria','Bachillerato','Universitario','Postgrado') NOT NULL,
  `representativeWorking` enum('Si','No') NOT NULL,
  `representativeWorkType` varchar(50) DEFAULT NULL,
  `representativeFamilyBurden` int(11) unsigned NOT NULL DEFAULT 0,
  `familyDentalHistory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `dietaryHabits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `height` decimal(2,2) unsigned DEFAULT NULL,
  `weight` decimal(2,2) unsigned DEFAULT NULL,
  KEY `patientToChildHistories` (`patientId`),
  CONSTRAINT `FK_childhistories_patients` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `childhistories`
--

LOCK TABLES `childhistories` WRITE;
/*!40000 ALTER TABLE `childhistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `childhistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clases`
--

DROP TABLE IF EXISTS `clases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clases` (
  `section` varchar(5) NOT NULL,
  `asignature` varchar(5) NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `role` tinyint(4) NOT NULL,
  `year` int(4) NOT NULL,
  KEY `FK_classes_users_2` (`userId`) USING BTREE,
  CONSTRAINT `userToClases` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clases`
--

LOCK TABLES `clases` WRITE;
/*!40000 ALTER TABLE `clases` DISABLE KEYS */;
INSERT INTO `clases` VALUES
('001','PP3',3,2,2026),
('001','PP3',88266,1,2026);
/*!40000 ALTER TABLE `clases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultations`
--

DROP TABLE IF EXISTS `consultations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultations` (
  `id` uuid NOT NULL,
  `patientId` uuid NOT NULL,
  `consultationReason` varchar(100) NOT NULL,
  `currentDisease` varchar(50) NOT NULL,
  `dateTime` datetime NOT NULL,
  `treatment` varchar(200) NOT NULL,
  `systolicPresure` int(11) NOT NULL,
  `diastolicPresure` int(11) NOT NULL,
  `BPM` int(11) NOT NULL,
  `physicalExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `intraoralExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `gumEvaluation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `childrenDentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `forecast` varchar(50) NOT NULL,
  `complementaryTests` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `observations` varchar(100) NOT NULL,
  `temp` decimal(2,2) NOT NULL DEFAULT 0.00,
  `pregnacy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`pregnacy`)),
  `reactionToAnesthesia` enum('Si','No','No Sabe') NOT NULL,
  `reactionToAnesthesiaDesc` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `patientToConsultations` (`patientId`),
  CONSTRAINT `patientToConsultations` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultations`
--

LOCK TABLES `consultations` WRITE;
/*!40000 ALTER TABLE `consultations` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dates`
--

DROP TABLE IF EXISTS `dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dates` (
  `id` uuid NOT NULL,
  `patientId` uuid DEFAULT NULL,
  `doctorId` int(10) unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` enum('Pendiente','Atendida','Cancelada') NOT NULL DEFAULT 'Pendiente',
  `invoiceId` uuid NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patientOnDate` (`patientId`),
  KEY `doctorOnDate` (`doctorId`),
  KEY `dates_invoices_FK` (`invoiceId`),
  CONSTRAINT `dates_invoices_FK` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`),
  CONSTRAINT `doctorOnDate` FOREIGN KEY (`doctorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patientOnDate` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dates`
--

LOCK TABLES `dates` WRITE;
/*!40000 ALTER TABLE `dates` DISABLE KEYS */;
/*!40000 ALTER TABLE `dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluations`
--

DROP TABLE IF EXISTS `evaluations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluations` (
  `id` uuid NOT NULL,
  `notes` varchar(200) NOT NULL,
  `consultationId` uuid NOT NULL,
  `studentId` int(10) unsigned NOT NULL,
  `teacherId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `consultationToEvaluation` (`consultationId`),
  KEY `studentIdToEvaluations` (`studentId`),
  KEY `teacherIdToEvaluations` (`teacherId`),
  CONSTRAINT `consultationToEvaluation` FOREIGN KEY (`consultationId`) REFERENCES `consultations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `studentIdToEvaluations` FOREIGN KEY (`studentId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `teacherIdToEvaluations` FOREIGN KEY (`teacherId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluations`
--

LOCK TABLES `evaluations` WRITE;
/*!40000 ALTER TABLE `evaluations` DISABLE KEYS */;
/*!40000 ALTER TABLE `evaluations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `billableitem` enum('Cirugia','Endodoncia','Ortodoncia') NOT NULL,
  `currency` enum('Dolares','Bolivares') NOT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `payerId` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `invoices_payer_FK` (`payerId`),
  CONSTRAINT `invoices_payer_FK` FOREIGN KEY (`payerId`) REFERENCES `payer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` uuid NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `patientIdentificacion` int(10) unsigned DEFAULT NULL,
  `patientCode` int(10) unsigned DEFAULT NULL,
  `birthDate` date NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `bloodType` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `emergencyName` varchar(50) NOT NULL,
  `emergencyPhone` varchar(15) NOT NULL,
  `instructionGrade` enum('Ninguno','Prescolar','Primaria','Bachiller','Universitario','Postgrado') NOT NULL,
  `race` enum('Blanco','Negro','Moreno','indigena') NOT NULL,
  `proneToBleeding` enum('Si','No','No sabe') DEFAULT NULL,
  `ailments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createPatient` datetime NOT NULL,
  `identificationType` enum('V','E','Cod.') NOT NULL,
  `birthPlace` varchar(50) NOT NULL,
  `addressMunicipality` varchar(25) NOT NULL,
  `addressCity` varchar(25) NOT NULL,
  `emergencyRelationship` enum('Madre','Padre','Abuelo/a','Hermano/a','Nieto/a','Hijo/a','Esposo/a','Tio/a','Sobrino/a','Otro') NOT NULL,
  `companionName` varchar(30) DEFAULT NULL,
  `companionPhone` varchar(15) DEFAULT NULL,
  `companionRelationship` enum('Madre','Padre','Abuelo/a','Hermano/a','Nieto/a','Hijo/a','Esposo/a','Tio/a','Sobrino/a','Otro') NOT NULL,
  `idStudent` int(10) unsigned NOT NULL,
  `idTeacher` int(10) unsigned NOT NULL,
  `habits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`habits`)),
  `ethnicity` enum('Wayuu','Añu','Bari','Yukpa','Japreria') DEFAULT NULL,
  `addressState` varchar(25) NOT NULL,
  `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `patientIdentificacion_patientCode` (`patientIdentificacion`,`patientCode`),
  KEY `historyIdStudent` (`idStudent`),
  KEY `historyIdTeacher` (`idTeacher`),
  CONSTRAINT `historyIdStudent` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `historyIdTeacher` FOREIGN KEY (`idTeacher`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payer`
--

DROP TABLE IF EXISTS `payer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payer`
--

LOCK TABLES `payer` WRITE;
/*!40000 ALTER TABLE `payer` DISABLE KEYS */;
/*!40000 ALTER TABLE `payer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `label` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`label`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
('currencyRate',244),
('datePrice',5),
('historyPrice',5),
('startedPeriod',0);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',0,0,1),
(2,'2','2','d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',1,1,1),
(3,'3','3','4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',2,1,1),
(4,'4','4','4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',3,1,1),
(5,'5','5','ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d',4,1,1),
(7788,'Cesar','Moreno','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',3,1,1),
(8877,'David','Garcia','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',1,2,0),
(88266,'Jose','Garcia','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',1,1,1),
(282882,'Jesus','Lozano','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',5,2,1),
(444466,'Samuel','Chourio','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,1,1),
(7667655,'Maria','V','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,1,1),
(7736559,'Juan','M','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',4,1,1),
(7744456,'Luis','U','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',0,1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'faco_luz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-11-27 21:57:47
