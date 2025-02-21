-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.11.8-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para faco-luz
CREATE DATABASE IF NOT EXISTS `faco-luz` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `faco-luz`;

-- Volcando estructura para tabla faco-luz.adulthistories
CREATE TABLE IF NOT EXISTS `adulthistories` (
  `id` varchar(64) NOT NULL,
  `patientId` varchar(64) NOT NULL,
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
  KEY `adultPatientId` (`patientId`),
  CONSTRAINT `adultPatientId` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.adulthistories: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.changelogs
CREATE TABLE IF NOT EXISTS `changelogs` (
  `id` varchar(64) NOT NULL,
  `changeType` int(11) NOT NULL,
  `dateTime` datetime NOT NULL,
  `userModificatorId` varchar(64) NOT NULL,
  `userModificatedId` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users` (`userModificatorId`),
  KEY `FK__users_2` (`userModificatedId`),
  CONSTRAINT `FK__users` FOREIGN KEY (`userModificatorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__users_2` FOREIGN KEY (`userModificatedId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.changelogs: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.childhistories
CREATE TABLE IF NOT EXISTS `childhistories` (
  `id` varchar(64) NOT NULL,
  `patientId` varchar(64) NOT NULL,
  `childPosition` int(11) NOT NULL DEFAULT 0,
  `currentStudying` int(11) NOT NULL DEFAULT 0,
  `representativename` varchar(25) NOT NULL DEFAULT '0',
  `representativeLastname` varchar(25) NOT NULL DEFAULT '0',
  `representativeIdentification` varchar(15) NOT NULL DEFAULT '0',
  `representativePhone` varchar(15) NOT NULL DEFAULT '0',
  `representative instructionGrade` enum('Prescolar','Primaria','Bachiller','Universitario','Ninguno') NOT NULL,
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
  KEY `childPatientId` (`patientId`),
  CONSTRAINT `childPatientId` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.childhistories: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.clases
CREATE TABLE IF NOT EXISTS `clases` (
  `section` varchar(5) NOT NULL,
  `asignature` varchar(5) NOT NULL,
  `userId` varchar(64) NOT NULL DEFAULT '',
  `role` tinyint(4) NOT NULL DEFAULT 0,
  KEY `FK_classes_users_2` (`userId`) USING BTREE,
  CONSTRAINT `FK_clases_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.clases: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.consultations
CREATE TABLE IF NOT EXISTS `consultations` (
  `id` varchar(64) NOT NULL,
  `patientId` varchar(64) NOT NULL,
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
  `generalForecast` varchar(50) NOT NULL DEFAULT '',
  `physicalTest` varchar(50) NOT NULL DEFAULT '',
  `oclusionExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`oclusionExamination`)),
  `complementaryTests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`complementaryTests`)),
  `generalObservations` varchar(100) NOT NULL DEFAULT '',
  `pulpVitality` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`pulpVitality`)),
  PRIMARY KEY (`id`),
  KEY `historyId` (`patientId`),
  CONSTRAINT `historyId` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.consultations: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.evaluations
CREATE TABLE IF NOT EXISTS `evaluations` (
  `id` varchar(64) NOT NULL,
  `notes` varchar(200) NOT NULL,
  `consultationId` varchar(64) NOT NULL,
  `studentId` varchar(64) NOT NULL,
  `teacherId` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__consultations` (`consultationId`),
  KEY `FK__users_studentId_evaluations` (`studentId`),
  KEY `FK__users_2_teacherId_evaluations` (`teacherId`),
  CONSTRAINT `FK__consultations` FOREIGN KEY (`consultationId`) REFERENCES `consultations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__users_2_teacherId_evaluations` FOREIGN KEY (`teacherId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__users_studentId_evaluations` FOREIGN KEY (`studentId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.evaluations: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.patients
CREATE TABLE IF NOT EXISTS `patients` (
  `id` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `patientIdentificacion` varchar(15) DEFAULT NULL,
  `patientCode` varchar(15) DEFAULT NULL,
  `birthDate` date NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `bloodType` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
  `address` varchar(100) NOT NULL DEFAULT '',
  `emergencyName` varchar(50) DEFAULT '',
  `emergencyPhone` varchar(15) DEFAULT '',
  `instructionGrade` enum('Prescolar','Primaria','Bachiller','Universitario','Ninguno') NOT NULL,
  `race` enum('Blanco','Negro','Moreno','indigena') NOT NULL,
  `proneToBleeding` enum('Si','No','No sabe') NOT NULL,
  `aliments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`aliments`)),
  `patientType` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.patients: ~0 rows (aproximadamente)

-- Volcando estructura para tabla faco-luz.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT 0,
  `identification` varchar(15) NOT NULL DEFAULT '0',
  `identificationType` int(10) NOT NULL DEFAULT 0,
  `active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla faco-luz.users: ~1 rows (aproximadamente)
INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identification`, `identificationType`, `active`) VALUES
	('1', 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 'admin', 0, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
