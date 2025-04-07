CREATE DATABASE IF NOT EXISTS `faco_luz` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `faco_luz`;

/* Volcando estructura para tabla faco_luz.users*/
CREATE TABLE IF NOT EXISTS `users` (
    `id` int(10) unsigned NOT NULL,
    `name` varchar(20) NOT NULL,
    `lastname` varchar(20) NOT NULL,
    `passwordSHA256` varchar(64) NOT NULL,
    `type` int(11) NOT NULL,
    `identificationType` int(10) NOT NULL,
    `active` tinyint(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/* Volcando datos para la tabla faco_luz.users: ~1 rows (aproximadamente)*/
INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
	(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1);

CREATE TABLE IF NOT EXISTS `changelogs` (
    `id` binary(16) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `patients` (
    `id` binary(16) NOT NULL,
    `patientType` int(11) NOT NULL,
    `createPatient` datetime DEFAULT CURRENT_TIMESTAMP(),

    /*Datos personales*/
    `name` varchar(50) NOT NULL,
    `lastname` varchar(50) NOT NULL,
    `patientIdentificacion` int(10) unsigned DEFAULT NULL,
    `patientCode` int(10) unsigned DEFAULT NULL,
    `phone` varchar(15) NOT NULL DEFAULT '0',
    `sex` enum('M','F') NOT NULL,
    `bloodType` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
    `birthDate` date NOT NULL,
    `birthPlace` varchar(100) NOT NULL,
    `religion` varchar(50) DEFAULT NULL,
    `race` enum('Criollo','Afrodescendiente','indigena','Otro') NOT NULL,
    `address` varchar(100) NOT NULL,
    `addressMunicipality` varchar(100) NOT NULL,
    `addressCity` varchar(100) NOT NULL,

    /*Datos en caso de emergencia*/
    `emergencyName` varchar(50) DEFAULT NULL,
    `emergencyPhone` varchar(15) DEFAULT NULL,
    `emergencyRelationship` varchar(50) DEFAULT NULL,

    /*Datos de acompañante( en casos que aplique)*/
    `companionName` varchar(50) DEFAULT NULL,
    `companionPhone` varchar(15) DEFAULT NULL,
    `companionyRelationship` varchar(50) DEFAULT NULL,


    `instructionGrade` enum('Sin Instruccion','Primaria incompleta','Primaria completa','Secundaria incompleta','Secundaria completa','TSU incompleta','TSU completa','Superior universitaria incompleta','Superior universitaria completa') NOT NULL,

    /*Antecedentes*/
    `ailments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ailments`)),

    /* Examenes */
    `physicalExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `intraoralExamination` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,

    
    /*Diagramas Dentarios*/
    `dentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `childrenDentalDiagram` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    
    /* Pronostico */
    `forecast` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,

    /* informacion del estudiante y docente */
    `idStudent` int(10) unsigned NOT NULL,
    `idTeacher` int(10) unsigned NOT NULL,

    PRIMARY KEY (`id`),
    KEY `studentToPacients` (`idStudent`),
    KEY `teacherToPacients` (`idTeacher`),

    CONSTRAINT `studentToPacients` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `teacherToPacients` FOREIGN KEY (`idTeacher`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `adulthistories` (
    `id` binary(16) NOT NULL,
    `patientId` binary(16) NOT NULL,
    /*Datos socieconomios*/
    `currentWorking` int(1) NOT NULL DEFAULT 0,
    `workType` varchar(30) NOT NULL DEFAULT '0',
    `workAddress` varchar(100) NOT NULL DEFAULT '0',
    `workPhone` varchar(15) NOT NULL DEFAULT '0',
    `workEntry` varchar(10) NOT NULL DEFAULT '0',
    `workLeaving` varchar(10) NOT NULL DEFAULT '0',
    `familyBurden` int(11) NOT NULL DEFAULT 0,
    `income` enum('-1','1-2','3-4','5+','SM+D') NOT NULL,
    PRIMARY KEY (`id`),
    KEY `patientToAdultHistories` (`patientId`),
    CONSTRAINT `patientToAdultHistories` FOREIGN KEY (`patientId`) REFERENCES `adulthistories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


CREATE TABLE IF NOT EXISTS `childhistories`(
    `id` binary(16) NOT NULL,
    `patientId` binary(16) NOT NULL,
    `childPosition` int(11) NOT NULL,
    `currentStudying` int(11) NOT NULL,
    `representativename` varchar(25) NOT NULL,
    `representativeLastname` varchar(25) NOT NULL,
    `representativeIdentification` varchar(15) NOT NULL,
    `representativePhone` varchar(15) NOT NULL,
    `representativeInstructionGrade` enum('Sin Instruccion','Primaria incompleta','Primaria completa','Secundaria incompleta','Secundaria completa','TSU incompleta','TSU completa','Superior universitaria incompleta','Superior universitaria completa') NOT NULL,
    `homeOwnership` enum('Familiar','Propia','Alquilada') NOT NULL,
    `numberOfRooms` int(11) NOT NULL,
    `representativeWorking` int(11) NOT NULL,
    `representativeWorkType` varchar(50) NOT NULL DEFAULT '',
    `representativeWorkAddress` varchar(100) NOT NULL DEFAULT '',
    `representativeWorkPhone` varchar(15) NOT NULL DEFAULT '',
    `representativeWorkEntry` varchar(10) NOT NULL DEFAULT '',
    `representativeWorkLeaving` varchar(10) NOT NULL DEFAULT '',
    `representativeFamilyBurden` int(11) NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`),
    KEY `patientToChildHistories` (`patientId`),
    CONSTRAINT `patientToChildHistories` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `consultations` (
    `id` binary(16) NOT NULL,
    `patientId` binary(16) NOT NULL,
    `dateTime` datetime DEFAULT CURRENT_TIMESTAMP(),
    
    /*Motivo de la consulta*/
    `consultationReason` varchar(100) NOT NULL,
    `currentDisease` varchar(100) DEFAULT NULL,
    `currentTreatment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    
    `treatment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,

    /*Periodo gestacion*/
    `gestationPeriod` int(3) DEFAULT NULL,
    `gestationControl` int(1) DEFAULT NULL,

    /*Signos Vitales*/
    `systolicPresure` int(3) NOT NULL,
    `diastolicPresure` int(3) NOT NULL,
    `bpm` int(3) NOT NULL,
    `temperature` int(3) NOT NULL,
    `weight` int(3) NOT NULL,
    
    `laboratoryStudies` text DEFAULT NULL,

    /* informacion del estudiante y docente */
    `idStudent` int(10) unsigned NOT NULL,
    `idTeacher` int(10) unsigned NOT NULL,

    

    /* Indices */
    PRIMARY KEY (`id`),
    KEY `patientToConsultations` (`patientId`),
    KEY `studentToConsultations` (`idStudent`),
    KEY `teacherToConsultations` (`idTeacher`),

    CONSTRAINT `patientToConsultations` FOREIGN KEY (`patientId`) REFERENCES `patients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `studentToConsultations` FOREIGN KEY (`idStudent`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `teacherToConsultations` FOREIGN KEY (`idTeacher`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `evaluations` (
    `id` binary(16) NOT NULL,
    `notes` varchar(200) NOT NULL,
    `consultationId` binary(16) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `clases` (
    `section` varchar(5) NOT NULL,
    `asignature` varchar(5) NOT NULL,
    `userId` int(10) unsigned NOT NULL,
    `role` tinyint(4) NOT NULL,
    KEY `FK_classes_users_2` (`userId`),
    CONSTRAINT `userToClases` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
(10100100, 'Jorge', 'diaz', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 2, 1),
(12345678, 'Manuel', 'Chourio', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 3, 1, 1),
(20202020, 'Jesus', 'Torres', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 1, 1),
(29929976, 'Samuel', 'Chourio', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 3, 1, 1),
(87654321, 'Pedro', 'Diaz', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 1, 2, 1);

INSERT INTO `changelogs` (`id`, `changeType`, `dateTime`, `userModificatorId`, `userModificatedId`) VALUES
(0x0556312d322247c3ac944adde6e68f80, 1, '2025-03-06 15:09:54', 1, 10100100),
(0x094b569fb4894de7b230ddc653d506bf, 2, '2025-03-17 10:36:47', 1, 29929976),
(0x09ac66687e7744b4924419c4714464d2, 3, '2025-03-07 10:57:43', 1, 12345678),
(0x0a58d8a905d049009aad4203824ed463, 2, '2025-03-17 10:37:15', 1, 20202020),
(0x0c476838cd7a4765b5cde6090fda64e5, 0, '2025-03-05 10:07:42', 1, 12345678),
(0x1017bc9596954ef2b42b2e17980e3060, 1, '2025-03-07 15:55:19', 1, 29929976),
(0x101f7966709542edb3b2aa83c17b22b4, 4, '2025-03-05 10:09:50', 1, 12345678),
(0x2d43c70ddf344770ac845a02ae93964f, 4, '2025-03-05 10:12:23', 1, 12345678),
(0x2e2e8c6b5add46adb928ac93e503d809, 3, '2025-03-06 14:51:54', 1, 10100100),
(0x310c8e0c3e0740e496f63eb9fa6fc1ac, 3, '2025-03-05 10:09:22', 1, 29929976),
(0x34444d4a1fb647bfa6e826a417d5089e, 4, '2025-03-05 10:10:28', 1, 12345678),
(0x37ab2263885044afa7496a05e5c7145f, 0, '2025-03-05 10:19:32', 1, 10100100),
(0x4475953363634b3eb4f5cf1733efb886, 0, '2025-03-07 10:51:58', 1, 20202020),
(0x447b1afd30b1452783dbbd7f88188f89, 0, '2025-03-05 10:03:07', 1, 29929976),
(0x58142e35de6740a6967db2fc1c62ef6e, 4, '2025-03-05 10:12:19', 1, 12345678),
(0x73b297105b414963a617be14ae2b8265, 2, '2025-03-17 10:38:34', 1, 10100100),
(0x7dedcbd07f9e432ab2397023dc249377, 4, '2025-03-05 10:10:58', 1, 12345678),
(0x8922de8e864440fba1c091565da84481, 1, '2025-03-05 10:14:14', 1, 12345678),
(0x95ad4a00697348b581f6f6fd8a421f92, 4, '2025-03-17 10:49:08', 1, 12345678),
(0xa9d3365a97994f258f5a100be42dfd36, 4, '2025-03-05 10:12:27', 1, 12345678),
(0xac5efb1d2cf74da7b52af2e7031516f0, 4, '2025-03-05 10:12:42', 1, 12345678),
(0xcad23c105e854d22b3f8ff76710b4d08, 2, '2025-03-06 14:51:29', 1, 10100100),
(0xd12d41fc89cc40f1b6ff121aa623f166, 0, '2025-03-07 10:43:10', 1, 87654321),
(0xdd7d37a14b4941fe858c3e9972f67090, 4, '2025-03-05 10:11:34', 1, 12345678),
(0xe07a6c5faf9f4cd4b9d4701342bbd840, 4, '2025-03-05 10:11:53', 1, 12345678),
(0xe1f63e87605a448db53e959dd53a2229, 4, '2025-03-05 10:19:39', 1, 29929976),
(0xecd61b277e734ae1835e8ae1630e24e4, 1, '2025-03-07 10:55:55', 1, 20202020),
(0xedcbd0d137034bd1889d50143e7cc9ee, 4, '2025-03-05 10:10:42', 1, 12345678),
(0xeef498658608481b91c62f6d569ed6c1, 4, '2025-03-05 10:12:06', 1, 12345678),
(0xf942f44720d142baa303f80a4aecdbdd, 4, '2025-03-05 10:10:11', 1, 12345678),
(0xfe566b95d7534872a2bd209131b2776d, 4, '2025-03-05 10:12:55', 1, 12345678),
(0xfe74e5d548a9480aa3f8e4e4ad2d68de, 2, '2025-03-05 10:14:51', 1, 12345678),
(0xfeb2f94c96244709bed540f57072ed8f, 1, '2025-03-06 12:32:13', 1, 10100100);