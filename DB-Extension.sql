-- ============================================================================
--  FACOLUZ Extension - esquema y semilla de la base de datos
--  Crea la base `faco_luz_extension` COMPLETA desde cero.
--
--  Como importarlo (XAMPP / MariaDB local, sin Docker):
--      C:\xampp\mysql\bin\mysql.exe -u root -p < DB-Extension.sql
--    o desde phpMyAdmin: Importar -> este archivo.
--    Ojo: el archivo empieza con CREATE DATABASE, asi que no hace falta crear la
--    base a mano. Si ya existe, la reusa y cada DROP TABLE reemplaza la tabla.
--
--  ADVERTENCIA: borra y recrea invoices, payments y el resto de las tablas. Para
--  una base que YA tiene datos, no usar este archivo: usar en su lugar
--  Back/FACOLUZ-Back-Extension/migrations/001_p0_auditoria.sql, que solo agrega
--  columnas e indices y no toca los datos.
--
--  Cambios de este script respecto al dump del 2026-09-25 (P0, tarea T2):
--    invoices
--      + issuedBy, cancelledAt, cancelledBy, cancelledReason  -> quien emitio y
--        quien anulo. Con dos personas facturando, sin esto no hay auditoria.
--      + indices de date, (StudentIdentification, date) y status
--      + CHECK: el total y la cantidad tienen que ser mayores a 0
--    payments
--      + indice de date
--      + CHECK: montos no negativos, y la devolucion no puede superar lo pagado
--      ~ la exoneracion se justifica en `comments` (un solo campo de observacion,
--        con el justificativo y quien lo autorizo). No se agregan columnas.
--
--  Lo que este script todavia NO trae, a proposito (ver PLAN-P0-FACTURACION.md):
--    - Correlativo de factura (`invoices.number` + tabla `invoice_counters`).
--    - CHECK de exoneracion justificada: se habilita en la tarea T8, cuando el
--      backend ya exija la observacion. Aplicarlo antes seria un 500 crudo.
--    - UNIQUE en students.studentsIdentification: hoy solo tiene un indice normal,
--      asi que se pueden registrar dos estudiantes con la misma cedula.
-- ============================================================================

-- MariaDB dump 10.20-13.0.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: faco_luz_extension
-- ------------------------------------------------------
-- Server version	13.0.2-MariaDB-ubu2604

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- Current Database: `faco_luz_extension`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `faco_luz_extension` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `faco_luz_extension`;

--
-- Table structure for table `billables`
--

DROP TABLE IF EXISTS `billables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `billables` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` text NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billables`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `billables` WRITE;
/*!40000 ALTER TABLE `billables` DISABLE KEYS */;
INSERT INTO `billables` VALUES
('5b37f444-b8fd-11f1-b397-a6356dd53d29','Inscripcion',5),
('5b37f5c4-b8fd-11f1-b397-a6356dd53d29','Materia',5),
('5b37f727-b8fd-11f1-b397-a6356dd53d29','Actividad especial',5),
('5b37f740-b8fd-11f1-b397-a6356dd53d29','Reimpresion de certificado',5);
/*!40000 ALTER TABLE `billables` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
INSERT INTO `certificates` VALUES
('2a5095b5-1045-11f1-9f8d-106530499799','49c8680e-0f9a-11f1-9f8d-106530499799','0c346a18-09d0-11f1-a6b1-106530499799','2026-02-22');
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `changelogs`
--

DROP TABLE IF EXISTS `changelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelogs` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `userId` int(11) unsigned NOT NULL,
  `changeType` int(11) NOT NULL,
  `description` text NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_user` (`userId`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelogs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `changelogs` WRITE;
/*!40000 ALTER TABLE `changelogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `changelogs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
('0c346a18-09d0-11f1-a6b1-106530499799','Asistente de Higienista Dental','Activo','2026-02-14 18:05:36');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `docType` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `documents_students_FK` (`studentId`),
  CONSTRAINT `documents_students_FK` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `enrollment_partial_scores`
--

DROP TABLE IF EXISTS `enrollment_partial_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment_partial_scores` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentGradeId` uuid NOT NULL,
  `evaluationOrder` int(2) unsigned NOT NULL DEFAULT 1 COMMENT '1 = primera nota, 2 = segunda nota',
  `score` int(3) NOT NULL,
  `weight` decimal(5,2) unsigned NOT NULL DEFAULT 50.00 COMMENT 'Peso en %',
  `dateScore` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_partial_enrollment_grade` (`enrollmentGradeId`),
  CONSTRAINT `fk_partial_enrollment_grade` FOREIGN KEY (`enrollmentGradeId`) REFERENCES `enrollments_grade` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_partial_scores`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `enrollment_partial_scores` WRITE;
/*!40000 ALTER TABLE `enrollment_partial_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollment_partial_scores` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `sectionId` uuid NOT NULL,
  `cohortId` uuid NOT NULL,
  `enrollmentType` enum('Regular','Repitiente') NOT NULL DEFAULT 'Regular',
  `parentEnrollmentId` uuid DEFAULT NULL COMMENT 'Si es repitiente, ID de la inscripcion original que reprobo',
  `dateEnrollment` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pagada','Deuda') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_enrollment` (`studentId`),
  KEY `fk_section_enrollment` (`sectionId`),
  KEY `fk_enrollment_cohort` (`cohortId`),
  KEY `fk_enrollment_parent` (`parentEnrollmentId`),
  CONSTRAINT `fk_enrollment_cohort` FOREIGN KEY (`cohortId`) REFERENCES `student_cohorts` (`id`),
  CONSTRAINT `fk_enrollment_parent` FOREIGN KEY (`parentEnrollmentId`) REFERENCES `enrollments` (`id`),
  CONSTRAINT `fk_section_enrollment` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`),
  CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `enrollments_grade`
--

DROP TABLE IF EXISTS `enrollments_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments_grade` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentId` uuid NOT NULL,
  `score` int(3) DEFAULT NULL,
  `dateScore` datetime DEFAULT NULL,
  `status` enum('Inscrito','Aprobado','Reprobado','Retirado') NOT NULL DEFAULT 'Inscrito',
  PRIMARY KEY (`id`),
  KEY `fk_enrollment` (`enrollmentId`),
  CONSTRAINT `fk_enrollment` FOREIGN KEY (`enrollmentId`) REFERENCES `enrollments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments_grade`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `enrollments_grade` WRITE;
/*!40000 ALTER TABLE `enrollments_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments_grade` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `billableid` uuid NOT NULL,
  `chargedAmount` float NOT NULL,
  `exchangeRate` float NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `comments` text DEFAULT NULL,
  `status` enum('Pendiente','Pagado','Anulada') NOT NULL DEFAULT 'Pendiente',
  `StudentIdentification` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `issuedBy` int(11) unsigned DEFAULT NULL COMMENT 'users.id de quien emitio la factura. Sin esto, con dos personas facturando, no hay forma de saber quien emitio una factura equivocada',
  `cancelledAt` datetime DEFAULT NULL COMMENT 'Momento de la anulacion. Anular dos veces la misma factura queda bloqueado por status',
  `cancelledBy` int(11) unsigned DEFAULT NULL COMMENT 'users.id de quien anulo',
  `cancelledReason` text DEFAULT NULL COMMENT 'Motivo de la anulacion. El backend lo exige: una anulacion sin motivo no se puede devolver',
  PRIMARY KEY (`id`),
  KEY `fk_invoices_billable` (`billableid`),
  KEY `idx_invoices_date` (`date`),
  KEY `idx_invoices_student` (`StudentIdentification`, `date`),
  KEY `idx_invoices_status` (`status`),
  KEY `fk_invoices_issued_by` (`issuedBy`),
  KEY `fk_invoices_cancelled_by` (`cancelledBy`),
  CONSTRAINT `fk_invoices_billable` FOREIGN KEY (`billableid`) REFERENCES `billables` (`id`),
  CONSTRAINT `fk_invoices_issued_by` FOREIGN KEY (`issuedBy`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_invoices_cancelled_by` FOREIGN KEY (`cancelledBy`) REFERENCES `users` (`id`),
  CONSTRAINT `chk_invoices_charged_positive` CHECK (`chargedAmount` > 0),
  CONSTRAINT `chk_invoices_quantity_positive` CHECK (`quantity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `modify_scores`
--

DROP TABLE IF EXISTS `modify_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modify_scores` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentGradeId` uuid NOT NULL,
  `partialScoreId` uuid DEFAULT NULL COMMENT 'NULL = cambio a nota final. Con valor = cambio a nota parcial especifica',
  `lastscore` int(3) NOT NULL,
  `newscore` int(3) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `reason` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modify_scores_enrollments_FK` (`enrollmentGradeId`),
  KEY `fk_modify_partial` (`partialScoreId`),
  CONSTRAINT `fk_modify_partial` FOREIGN KEY (`partialScoreId`) REFERENCES `enrollment_partial_scores` (`id`),
  CONSTRAINT `modify_scores_enrollments_FK` FOREIGN KEY (`enrollmentGradeId`) REFERENCES `enrollments_grade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modify_scores`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modify_scores` WRITE;
/*!40000 ALTER TABLE `modify_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `modify_scores` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `evaluationMode` enum('Simple','Promedio') NOT NULL DEFAULT 'Simple' COMMENT 'Simple: 1 nota unica. Promedio: promedio ponderado de N notas parciales',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES
('0c3dae7c-09d0-11f1-a6b1-106530499799','Nociones basicas de la Anatomia Dental y Oclusion','Simple','2026-02-14 18:05:36','Activo'),
('0c3db180-09d0-11f1-a6b1-106530499799','Realaciones Humanas','Simple','2026-02-14 18:05:36','Activo'),
('0c3db276-09d0-11f1-a6b1-106530499799','Sistema de Atencion Odontologica','Simple','2026-02-14 18:05:36','Activo'),
('0c3db2bc-09d0-11f1-a6b1-106530499799','Semiologia e Historia Clinica','Simple','2026-02-14 18:05:36','Activo'),
('0c3db2fa-09d0-11f1-a6b1-106530499799','Bioetica y Odontologia Legal','Simple','2026-02-14 18:05:36','Activo'),
('0c3db334-09d0-11f1-a6b1-106530499799','Bioseguridad y Esterilizacion en Odontologia','Simple','2026-02-14 18:05:36','Activo'),
('0c3db36b-09d0-11f1-a6b1-106530499799','Practica Profesional I','Simple','2026-02-14 18:05:36','Activo'),
('0c3db3ab-09d0-11f1-a6b1-106530499799','Asistencia de Procedimientos Clincos Odontologicos','Simple','2026-02-14 18:05:36','Activo'),
('0c3db3e8-09d0-11f1-a6b1-106530499799','Biomateriales Odontologicos','Simple','2026-02-14 18:05:36','Activo'),
('0c3db427-09d0-11f1-a6b1-106530499799','Nociones Basicas en Radiologia e Imagenologia Odontologica','Simple','2026-02-14 18:05:36','Activo'),
('0c3db45f-09d0-11f1-a6b1-106530499799','Epidemiologia y Sistema de informacion','Simple','2026-02-14 18:05:36','Activo'),
('0c3db495-09d0-11f1-a6b1-106530499799','Ingles Intrumental','Simple','2026-02-14 18:05:36','Activo'),
('0c3db4d1-09d0-11f1-a6b1-106530499799','Educacion y Promocion de la Salud Bucal','Simple','2026-02-14 18:05:36','Activo'),
('0c3db508-09d0-11f1-a6b1-106530499799','Fotografia Clinica y Marketing en Odontologia','Simple','2026-02-14 18:05:36','Activo'),
('0c3db53f-09d0-11f1-a6b1-106530499799','Practica Profesional II','Simple','2026-02-14 18:05:36','Activo'),
('0c3db578-09d0-11f1-a6b1-106530499799','Servicios Comunitario','Simple','2026-02-14 18:05:36','Activo');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `modules_courses`
--

DROP TABLE IF EXISTS `modules_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules_courses` (
  `moduleid` uuid NOT NULL,
  `courseid` uuid NOT NULL,
  `order` int(2) unsigned NOT NULL,
  KEY `modules_courses_courses_FK` (`courseid`),
  KEY `modules_courses_modules_FK` (`moduleid`),
  CONSTRAINT `modules_courses_courses_FK` FOREIGN KEY (`courseid`) REFERENCES `courses` (`id`),
  CONSTRAINT `modules_courses_modules_FK` FOREIGN KEY (`moduleid`) REFERENCES `modules` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules_courses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `modules_courses` WRITE;
/*!40000 ALTER TABLE `modules_courses` DISABLE KEYS */;
INSERT INTO `modules_courses` VALUES
('0c3dae7c-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db180-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db276-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db2bc-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db2fa-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db334-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db36b-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db3ab-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db3e8-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db427-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db45f-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db495-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db4d1-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db508-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db53f-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1),
('0c3db578-09d0-11f1-a6b1-106530499799','0c346a18-09d0-11f1-a6b1-106530499799',1);
/*!40000 ALTER TABLE `modules_courses` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `invoiceId` uuid NOT NULL,
  `receivedPaymentMethod` enum('Efectivo','Transferencia','Dolares','Exoneracion') DEFAULT NULL,
  `returnedPaymentMethod` enum('Efectivo','Transferencia','Dolares','Exoneracion') DEFAULT NULL,
  `paidAmount` float NOT NULL,
  `returnedAmount` float DEFAULT 0,
  `reference` varchar(20) DEFAULT NULL,
  `returnReference` varchar(20) DEFAULT NULL,
  `comments` text DEFAULT NULL COMMENT 'Observaciones del pago. En una EXONERACION es obligatorio y debe dejar tanto el justificativo como quien lo autorizo, en un solo texto (decision D4)',
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `exchangeRate` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_invoices_FK` (`invoiceId`),
  KEY `idx_payments_date` (`date`),
  CONSTRAINT `payments_invoices_FK` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`),
  CONSTRAINT `chk_payments_paid_nonneg` CHECK (`paidAmount` >= 0),
  CONSTRAINT `chk_payments_returned_nonneg` CHECK (`returnedAmount` >= 0),

  -- El techo de "no devuelvas mas de lo que pagaste" vale DENTRO de un
  -- movimiento: pagan $20 y se devuelven $5, bien; se devuelven $25, mal.
  --
  -- Pero la anulacion escribe un movimiento que no es un pago: es una salida de
  -- dinero, `paidAmount = 0` y `returnedAmount = <lo que se devuelve>`. Contra
  -- un `returnedAmount <= paidAmount` a secas eso es `10 <= 0` y la fila no
  -- entra: anular una factura cobrada fallaba con ERROR 4025. La migracion 001
  -- metio este CHECK asi y nadie lo probo con una factura pagada.
  --
  -- Con `paidAmount = 0` no hay entrada contra la que comparar, asi que el
  -- movimiento es una devolucion pura y el CHECK no dice nada. El techo real
  -- (no devolver mas de lo cobrado en toda la factura) no lo puede hacer un
  -- CHECK por fila porque abarca varias: lo impone `makePayment` sumando con la
  -- factura en FOR UPDATE. Este solo cuida la coherencia de cada fila aislada.
  CONSTRAINT `chk_payments_returned_le_paid` CHECK (
    `paidAmount` = 0 OR `returnedAmount` IS NULL OR `returnedAmount` <= `paidAmount`
  ),

  -- Una exoneracion sin justificacion no es una decision: es una deuda que
  -- alguien decidio perdonar sin dejar escrito por que ni quien lo autorizo.
  -- El backend lo rechaza (POST /api/payments, min 10 caracteres) y el modal de
  -- cobro lo pide antes de enviar; esto es la ultima linea, para lo que llegue
  -- por SQL. Se activo en la migracion 002 (T8).
  --
  -- Las filas de devolucion por anulacion tienen `receivedPaymentMethod` NULL.
  -- `NULL <> 'Exoneracion'` da NULL y un CHECK que da NULL se considera
  -- cumplido, asi que la devolucion no choca con esto.
  CONSTRAINT `chk_payments_exoneracion_observada` CHECK (
    `receivedPaymentMethod` <> 'Exoneracion' OR `comments` IS NOT NULL
  )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
  `modality` enum('Intensivo','Sabatino') NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('En curso','Finalizado') NOT NULL DEFAULT 'En curso',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periods`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `periods` WRITE;
/*!40000 ALTER TABLE `periods` DISABLE KEYS */;
/*!40000 ALTER TABLE `periods` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `periodId` uuid NOT NULL,
  `moduleId` uuid NOT NULL,
  `code` varchar(1) NOT NULL,
  `quota` int(2) NOT NULL,
  `status` enum('Activa','Por cargar','Cerrada') NOT NULL DEFAULT 'Activa',
  PRIMARY KEY (`id`),
  KEY `fk_module_section` (`moduleId`),
  KEY `fk_period_section` (`periodId`),
  CONSTRAINT `fk_module_section` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  CONSTRAINT `fk_period_section` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sections_teachers`
--

DROP TABLE IF EXISTS `sections_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_teachers` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `sectionId` uuid NOT NULL,
  `teacherId` uuid NOT NULL,
  `evaluationOrder` int(2) unsigned NOT NULL DEFAULT 1 COMMENT '1 = primer evaluador, 2 = segundo evaluador, etc.',
  PRIMARY KEY (`id`),
  KEY `fk_st_section` (`sectionId`),
  KEY `fk_st_teacher` (`teacherId`),
  CONSTRAINT `fk_st_section` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_st_teacher` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_teachers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sections_teachers` WRITE;
/*!40000 ALTER TABLE `sections_teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections_teachers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `student_cohorts`
--

DROP TABLE IF EXISTS `student_cohorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_cohorts` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `periodId` uuid NOT NULL,
  `sectionCode` varchar(1) NOT NULL COMMENT 'Seccion de origen (A/B). Historico.',
  `courseId` uuid NOT NULL,
  `enrollmentDate` datetime NOT NULL DEFAULT current_timestamp(),
  `completionDate` datetime DEFAULT NULL,
  `status` enum('En curso','Finalizado','Abandonado') NOT NULL DEFAULT 'En curso',
  PRIMARY KEY (`id`),
  KEY `fk_sc_course` (`courseId`),
  KEY `fk_sc_period` (`periodId`),
  KEY `fk_sc_student` (`studentId`),
  CONSTRAINT `fk_sc_course` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`),
  CONSTRAINT `fk_sc_period` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  CONSTRAINT `fk_sc_student` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_cohorts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `student_cohorts` WRITE;
/*!40000 ALTER TABLE `student_cohorts` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_cohorts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
  `phone` int(10) unsigned NOT NULL,
  `address` text NOT NULL,
  `instructionGrade` enum('Ninguno','Bachillerato','Universitario','Postgrado') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `section` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `studentsId` (`studentsIdentification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES
('382f4b8f-0f9a-11f1-9f8d-106530499799','Juan','perez',NULL,NULL,1111,'2026-01-12','jjd@o.c',4127859999,'kkk','Universitario','2026-02-21 22:57:26','Activo',NULL),
('49c8680e-0f9a-11f1-9f8d-106530499799','jesus','Lozano',NULL,NULL,890,'2026-01-05','jjd@o.c',414223,'kkk','Postgrado','2026-02-21 22:57:56','Activo',NULL),
('55af3fe9-0f9a-11f1-9f8d-106530499799','David','Garcia',NULL,NULL,3353,'2026-01-06','jjd@o.c',41409876,'kkk','Bachillerato','2026-02-21 22:58:16','Activo',NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
  `email` varchar(100) NOT NULL,
  `phone` int(10) unsigned NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

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
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin','admin','66908395b9edc2fbbedd85dbda476785736a14ac7313f06a362f779b643734e5',0,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping events for database 'faco_luz_extension'
--

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

-- Dump completed on 2026-09-25 16:23:22
