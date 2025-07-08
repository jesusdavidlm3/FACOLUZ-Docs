-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.11.11-MariaDB-0+deb12u1 - Debian 12
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para faco_luz
CREATE DATABASE IF NOT EXISTS `faco_luz` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `faco_luz`;

-- Volcando estructura para tabla faco_luz.adulthistories
CREATE TABLE IF NOT EXISTS `adulthistories` (
  `patientId` uuid NOT NULL,
  `currentWorking` enum('Si','No') NOT NULL,
  `workType` varchar(30) DEFAULT NULL,
  `familyBurden` int(11) unsigned NOT NULL,
  `phone` varchar(15) NOT NULL,
  `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
  KEY `patientToAdultHistories` (`patientId`),
  CONSTRAINT `patientToAdultHistory` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.adulthistories: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.changelogs
CREATE TABLE IF NOT EXISTS `changelogs` (
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

-- Volcando datos para la tabla faco_luz.changelogs: ~0 rows (aproximadamente)
INSERT INTO `changelogs` (`id`, `changeType`, `dateTime`, `userModificatorId`, `userModificatedId`) VALUES
	('e85beb67-57a7-4f0a-96aa-2dfc57490e82', 0, '2025-07-08 14:29:19', 1, 4),
	('a5e05f34-6a78-43cb-bb2f-73e53d7a7a25', 0, '2025-07-08 14:29:09', 1, 3),
	('87a098b6-40a2-41ce-9f33-8c6052940e60', 0, '2025-07-08 14:29:27', 1, 5),
	('82f77958-313a-4cd6-8d0c-9f8eb43fb83e', 0, '2025-07-08 14:29:00', 1, 2);

-- Volcando estructura para tabla faco_luz.childhistories
CREATE TABLE IF NOT EXISTS `childhistories` (
  `patientId` uuid NOT NULL,
  `currentStudying` enum('Si','No') NOT NULL,
  `representativeName` varchar(25) NOT NULL,
  `representativeIdentification` varchar(15) NOT NULL,
  `representativePhone` varchar(15) NOT NULL,
  `representativeInstructionGrade` enum('Ninguno','Prescolar','Primaria','Bachillerato','Universitario','Postgrado') NOT NULL,
  `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
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

-- Volcando datos para la tabla faco_luz.childhistories: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.clases
CREATE TABLE IF NOT EXISTS `clases` (
  `section` varchar(5) NOT NULL,
  `asignature` varchar(5) NOT NULL,
  `userId` int(10) unsigned NOT NULL,
  `role` tinyint(4) NOT NULL,
  KEY `FK_classes_users_2` (`userId`) USING BTREE,
  CONSTRAINT `userToClases` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.clases: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.consultations
CREATE TABLE IF NOT EXISTS `consultations` (
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

-- Volcando datos para la tabla faco_luz.consultations: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.dates
CREATE TABLE IF NOT EXISTS `dates` (
  `id` uuid NOT NULL,
  `patientId` uuid DEFAULT NULL,
  `doctorId` int(10) unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patientOnDate` (`patientId`),
  KEY `doctorOnDate` (`doctorId`),
  CONSTRAINT `doctorOnDate` FOREIGN KEY (`doctorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patientOnDate` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.dates: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.evaluations
CREATE TABLE IF NOT EXISTS `evaluations` (
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

-- Volcando datos para la tabla faco_luz.evaluations: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.patients
CREATE TABLE IF NOT EXISTS `patients` (
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `patientIdentificacion_patientCode` (`patientIdentificacion`,`patientCode`),
  KEY `historyIdStudent` (`idStudent`),
  KEY `historyIdTeacher` (`idTeacher`),
  CONSTRAINT `historyIdStudent` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `historyIdTeacher` FOREIGN KEY (`idTeacher`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.patients: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `label` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`label`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.settings: ~0 rows (aproximadamente)
INSERT INTO `settings` (`label`, `value`) VALUES
	('startedPeriod', 0);

-- Volcando estructura para tabla faco_luz.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.users: ~1 rows (aproximadamente)
INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
	(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1),
	(2, '2', '2', 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', 1, 1, 1),
	(3, '3', '3', '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 2, 1, 1),
	(4, '4', '4', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', 3, 1, 1),
	(5, '5', '5', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', 4, 1, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
