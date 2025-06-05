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
  `id` uuid NOT NULL,
  `patientId` uuid NOT NULL,
  `addressCity` varchar(25) NOT NULL,
  `addressState` varchar(25) NOT NULL,
  `addressMunicipality` varchar(25) NOT NULL,
  `currentWorking` int(11) NOT NULL DEFAULT 0,
  `workType` varchar(30) NOT NULL DEFAULT '0',
  `workAddress` varchar(100) NOT NULL DEFAULT '0',
  `workPhone` varchar(15) NOT NULL DEFAULT '0',
  `workEntry` varchar(10) NOT NULL DEFAULT '0',
  `workLeaving` varchar(10) NOT NULL DEFAULT '0',
  `familyBurden` int(11) NOT NULL DEFAULT 0,
  `phone` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `patientToAdultHistories` (`patientId`),
  CONSTRAINT `patientToAdultHistories` FOREIGN KEY (`patientId`) REFERENCES `adulthistories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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

-- Volcando datos para la tabla faco_luz.changelogs: ~4 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.childhistories
CREATE TABLE IF NOT EXISTS `childhistories` (
  `id` uuid NOT NULL,
  `patientId` uuid NOT NULL,
  `childPosition` int(11) NOT NULL,
  `currentStudying` int(11) NOT NULL,
  `representativename` varchar(25) NOT NULL,
  `representativeLastname` varchar(25) NOT NULL,
  `representativeIdentification` varchar(15) NOT NULL,
  `representativePhone` varchar(15) NOT NULL,
  `representativeInstructionGrade` enum('Prescolar','Primaria','Bachiller','Universitario','Ninguno') NOT NULL,
  `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
  `numberOfRooms` int(11) NOT NULL,
  `representativeWorking` int(11) NOT NULL,
  `representativeWorkType` varchar(50) NOT NULL DEFAULT '',
  `representativeWorkAddress` varchar(100) NOT NULL DEFAULT '',
  `representativeWorkPhone` varchar(15) NOT NULL DEFAULT '',
  `representativeWorkEntry` varchar(10) NOT NULL DEFAULT '',
  `representativeWorkLeaving` varchar(10) NOT NULL DEFAULT '',
  `representativeFamilyBurden` int(11) NOT NULL DEFAULT 0,
  `familyDentalHistory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`familyDentalHistory`)),
  `dietaryHabits` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`dietaryHabits`)),
  `height` decimal(2,2) NOT NULL DEFAULT 0.00,
  `weight` decimal(2,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patientToChildHistories` (`patientId`),
  CONSTRAINT `patientToChildHistories` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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

-- Volcando datos para la tabla faco_luz.clases: ~2 rows (aproximadamente)

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
  `fisicConsistency` varchar(20) NOT NULL,
  `physicalExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `intraoralExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `gumEvaluation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `childrenDentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `individualForecast` varchar(50) NOT NULL,
  `generalForecast` varchar(50) NOT NULL,
  `physicalTest` varchar(50) NOT NULL,
  `oclusionExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`oclusionExamination`)),
  `complementaryTests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`complementaryTests`)),
  `generalObservations` varchar(100) NOT NULL,
  `pulpVitality` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`pulpVitality`)),
  PRIMARY KEY (`id`),
  KEY `patientToConsultations` (`patientId`),
  CONSTRAINT `patientToConsultations` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.consultations: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.dates
CREATE TABLE IF NOT EXISTS `dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `bloodType` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `address` varchar(100) NOT NULL,
  `emergencyName` varchar(50) NOT NULL,
  `emergencyPhone` varchar(15) NOT NULL,
  `instructionGrade` enum('Prescolar','Primaria','Bachiller','Universitario','Ninguno') NOT NULL,
  `race` enum('Blanco','Negro','Moreno','indigena') NOT NULL,
  `proneToBleeding` enum('Si','No','No sabe') NOT NULL,
  `ailments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createPatient` datetime NOT NULL,
  `identificationType` int(11) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `birthPlace` varchar(50) NOT NULL,
  `religion` varchar(25) DEFAULT NULL,
  `addressMunicipality` varchar(25) NOT NULL,
  `addressCity` varchar(25) NOT NULL DEFAULT '',
  `emergencyRelationship` int(10) unsigned NOT NULL,
  `companionName` varchar(30) DEFAULT NULL,
  `companionPhone` varchar(15) DEFAULT NULL,
  `companionRelationship` int(10) unsigned DEFAULT NULL,
  `idStudent` int(10) unsigned NOT NULL DEFAULT 0,
  `idTeacher` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `historyIdStudent` (`idStudent`),
  CONSTRAINT `historyIdStudent` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.patients: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco_luz.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `label` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`label`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco_luz.settings: ~1 rows (aproximadamente)
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

-- Volcando datos para la tabla faco_luz.users: ~5 rows (aproximadamente)
INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
	(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
