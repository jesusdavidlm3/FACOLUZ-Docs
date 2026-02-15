/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: faco_luz_extension
-- ------------------------------------------------------
-- Server version	12.1.2-MariaDB

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
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificates` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `courseId` uuid NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `certificates_students_FK` (`studentId`),
  KEY `certificates_courses_FK` (`courseId`),
  CONSTRAINT `certificates_courses_FK` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`),
  CONSTRAINT `certificates_students_FK` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
('0c346a18-09d0-11f1-a6b1-106530499799','Asistente de Higienista Dental','Activo','2026-02-14 18:05:36');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `periodId` uuid NOT NULL,
  `dateEnrollments` datetime NOT NULL DEFAULT current_timestamp(),
  `section` int(11) NOT NULL,
  `state` enum('Pagada','Deuda') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_enrollment` (`studentId`),
  KEY `fk_period_enrollment` (`periodId`),
  CONSTRAINT `fk_period_enrollment` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments_modules`
--

DROP TABLE IF EXISTS `enrollments_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments_modules` (
  `enrollmentId` uuid NOT NULL,
  `moduleId` uuid NOT NULL,
  KEY `fk_enrollment` (`enrollmentId`),
  KEY `fk_module` (`moduleId`),
  CONSTRAINT `fk_enrollment` FOREIGN KEY (`enrollmentId`) REFERENCES `enrollments` (`id`),
  CONSTRAINT `fk_module` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments_modules`
--

LOCK TABLES `enrollments_modules` WRITE;
/*!40000 ALTER TABLE `enrollments_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `billableitem` enum('Inscripcion','Materia','Actividad especial','Reimpresion de certificado') NOT NULL,
  `chargedAmount` float NOT NULL,
  `currencyReceived` enum('Bolivares en efectivo','Bolivares en transferencia','Dolares en efectivo','Exoneracion') NOT NULL,
  `amountReceived` float NOT NULL,
  `currencyReturned` enum('Bolivares en efectivo','Bolivares en transferencia','Dolares en efectivo','Exoneracion') DEFAULT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `changeRate` float NOT NULL,
  `comments` text DEFAULT NULL,
  `status` enum('Pendiente','Recibida','Rechazada') NOT NULL DEFAULT 'Pendiente',
  `StudentIdentification` int(11) NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES
('0c3dae7c-09d0-11f1-a6b1-106530499799','Nociones basicas de la Anatomia Dental y Oclusion','2026-02-14 18:05:36','Activo'),
('0c3db180-09d0-11f1-a6b1-106530499799','Realaciones Humanas','2026-02-14 18:05:36','Activo'),
('0c3db276-09d0-11f1-a6b1-106530499799','Sistema de Atencion Odontologica','2026-02-14 18:05:36','Activo'),
('0c3db2bc-09d0-11f1-a6b1-106530499799','Semiologia e Historia Clinica','2026-02-14 18:05:36','Activo'),
('0c3db2fa-09d0-11f1-a6b1-106530499799','Bioetica y Odontologia Legal','2026-02-14 18:05:36','Activo'),
('0c3db334-09d0-11f1-a6b1-106530499799','Bioseguridad y Esterilizacion en Odontologia','2026-02-14 18:05:36','Activo'),
('0c3db36b-09d0-11f1-a6b1-106530499799','Practica Profesional I','2026-02-14 18:05:36','Activo'),
('0c3db3ab-09d0-11f1-a6b1-106530499799','Asistencia de Procedimientos Clincos Odontologicos','2026-02-14 18:05:36','Activo'),
('0c3db3e8-09d0-11f1-a6b1-106530499799','Biomateriales Odontologicos','2026-02-14 18:05:36','Activo'),
('0c3db427-09d0-11f1-a6b1-106530499799','Nociones Basicas en Radiologia e Imagenologia Odontologica','2026-02-14 18:05:36','Activo'),
('0c3db45f-09d0-11f1-a6b1-106530499799','Epidemiologia y Sistema de informacion','2026-02-14 18:05:36','Activo'),
('0c3db495-09d0-11f1-a6b1-106530499799','Ingles Intrumental','2026-02-14 18:05:36','Activo'),
('0c3db4d1-09d0-11f1-a6b1-106530499799','Educacion y Promocion de la Salud Bucal','2026-02-14 18:05:36','Activo'),
('0c3db508-09d0-11f1-a6b1-106530499799','Fotografia Clinica y Marketing en Odontologia','2026-02-14 18:05:36','Activo'),
('0c3db53f-09d0-11f1-a6b1-106530499799','Practica Profesional II','2026-02-14 18:05:36','Activo'),
('0c3db578-09d0-11f1-a6b1-106530499799','Servicios Comunitario','2026-02-14 18:05:36','Activo');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules_courses`
--

DROP TABLE IF EXISTS `modules_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules_courses` (
  `moduleid` uuid NOT NULL,
  `courseid` uuid NOT NULL,
  KEY `modules_courses_courses_FK` (`courseid`),
  KEY `modules_courses_modules_FK` (`moduleid`),
  CONSTRAINT `modules_courses_courses_FK` FOREIGN KEY (`courseid`) REFERENCES `courses` (`id`),
  CONSTRAINT `modules_courses_modules_FK` FOREIGN KEY (`moduleid`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules_courses`
--

LOCK TABLES `modules_courses` WRITE;
/*!40000 ALTER TABLE `modules_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periods`
--

DROP TABLE IF EXISTS `periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `periods` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `year` int(4) NOT NULL,
  `period` int(2) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('En curso','Finalizado') NOT NULL DEFAULT 'En curso',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periods`
--

LOCK TABLES `periods` WRITE;
/*!40000 ALTER TABLE `periods` DISABLE KEYS */;
/*!40000 ALTER TABLE `periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scores` (
  `studentsId` uuid DEFAULT NULL,
  `moduleId` uuid DEFAULT NULL,
  `score` int(2) DEFAULT NULL,
  KEY `fk_student_scores` (`studentsId`),
  KEY `fk_module_scores` (`moduleId`),
  CONSTRAINT `fk_module_scores` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  CONSTRAINT `fk_student_scores` FOREIGN KEY (`studentsId`) REFERENCES `students` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `photo` text DEFAULT NULL,
  `parentalPermission` text DEFAULT NULL,
  `studentsIdentification` int(10) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(11) NOT NULL,
  `address` text NOT NULL,
  `instructionGrade` enum('Ninguno','Bachillerato','Universitario','Postgrado') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `section` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `studentsId` (`studentsIdentification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `identification` int(11) unsigned NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers_modules`
--

DROP TABLE IF EXISTS `teachers_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers_modules` (
  `teacherId` uuid NOT NULL,
  `moduleId` uuid NOT NULL,
  `section` int(11) NOT NULL,
  KEY `teachers_modules_modules_FK` (`moduleId`),
  KEY `teachers_modules_teachers_FK` (`teacherId`),
  CONSTRAINT `teachers_modules_modules_FK` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  CONSTRAINT `teachers_modules_teachers_FK` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers_modules`
--

LOCK TABLES `teachers_modules` WRITE;
/*!40000 ALTER TABLE `teachers_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',0,0,1),
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'faco_luz_extension'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-02-14 20:39:45
