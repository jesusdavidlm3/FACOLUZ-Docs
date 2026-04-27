-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2026 at 12:28 AM
-- Server version: 11.8.3-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `faco_luz_extension_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `courseId` uuid NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `changelogs`
--

CREATE TABLE `changelogs` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `userId` int(11) UNSIGNED NOT NULL,
  `changeType` int(11) NOT NULL,
  `description` text NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `docType` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `sectionId` uuid NOT NULL,
  `cohortId` uuid NOT NULL,
  `enrollmentType` enum('Regular','Repitiente') NOT NULL DEFAULT 'Regular',
  `parentEnrollmentId` uuid DEFAULT NULL COMMENT 'Si es repitiente, ID de la inscripcion original que reprobo',
  `dateEnrollment` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pagada','Deuda') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments_grade`
--

CREATE TABLE `enrollments_grade` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentId` uuid NOT NULL,
  `score` int(3) DEFAULT NULL,
  `dateScore` datetime DEFAULT NULL,
  `status` enum('Inscrito','Aprobado','Reprobado','Retirado') NOT NULL DEFAULT 'Inscrito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enrollment_partial_scores`
--

CREATE TABLE `enrollment_partial_scores` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentGradeId` uuid NOT NULL,
  `evaluationOrder` int(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 = primera nota, 2 = segunda nota',
  `score` int(3) NOT NULL,
  `weight` decimal(5,2) UNSIGNED NOT NULL DEFAULT 50.00 COMMENT 'Peso en %',
  `dateScore` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `billableitem` enum('Inscripcion','Materia','Actividad especial','Reimpresion de certificado') NOT NULL,
  `chargedAmount` float NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `comments` text DEFAULT NULL,
  `status` enum('Pendiente','Pagado') NOT NULL DEFAULT 'Pendiente',
  `StudentIdentification` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `modify_scores`
--

CREATE TABLE `modify_scores` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentGradeId` uuid NOT NULL,
  `partialScoreId` uuid DEFAULT NULL COMMENT 'NULL = cambio a nota final. Con valor = cambio a nota parcial especifica',
  `lastscore` int(3) NOT NULL,
  `newscore` int(3) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE `modules` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `evaluationMode` enum('Simple','Promedio') NOT NULL DEFAULT 'Simple' COMMENT 'Simple: 1 nota unica. Promedio: promedio ponderado de N notas parciales',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `modules_courses`
--

CREATE TABLE `modules_courses` (
  `moduleid` uuid NOT NULL,
  `courseid` uuid NOT NULL,
  `order` int(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `invoiceId` uuid NOT NULL,
  `receivedPaymentMethod` enum('efectivo','Exoneracion') NOT NULL,
  `returnedPaymentMethod` enum('efectivo','Exoneracion') NOT NULL,
  `paidAmount` float NOT NULL,
  `returnedAmount` float NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `changeRate` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `periods`
--

CREATE TABLE `periods` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `year` int(4) NOT NULL,
  `period` int(2) NOT NULL,
  `modality` enum('Intensivo','Sabatino') NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('En curso','Finalizado') NOT NULL DEFAULT 'En curso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `periodId` uuid NOT NULL,
  `moduleId` uuid NOT NULL,
  `code` varchar(1) NOT NULL,
  `quota` int(2) NOT NULL,
  `status` enum('Activa','Por cargar','Cerrada') NOT NULL DEFAULT 'Activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections_teachers`
--

CREATE TABLE `sections_teachers` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `sectionId` uuid NOT NULL,
  `teacherId` uuid NOT NULL,
  `evaluationOrder` int(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 = primer evaluador, 2 = segundo evaluador, etc.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `photo` text DEFAULT NULL,
  `parentalPermission` text DEFAULT NULL,
  `studentsIdentification` int(10) NOT NULL,
  `birthDate` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(10) UNSIGNED NOT NULL,
  `address` text NOT NULL,
  `instructionGrade` enum('Ninguno','Bachillerato','Universitario','Postgrado') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_cohorts`
--

CREATE TABLE `student_cohorts` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `periodId` uuid NOT NULL,
  `sectionCode` varchar(1) NOT NULL COMMENT 'Seccion de origen (A/B). Historico.',
  `courseId` uuid NOT NULL,
  `enrollmentDate` datetime NOT NULL DEFAULT current_timestamp(),
  `completionDate` datetime DEFAULT NULL,
  `status` enum('En curso','Finalizado','Abandonado') NOT NULL DEFAULT 'En curso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `identification` int(11) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` int(10) UNSIGNED NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `passwordSHA256` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `identificationType` int(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_students_FK` (`studentId`),
  ADD KEY `certificates_courses_FK` (`courseId`);

--
-- Indexes for table `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`userId`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_students_FK` (`studentId`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_enrollment` (`studentId`),
  ADD KEY `fk_section_enrollment` (`sectionId`),
  ADD KEY `fk_enrollment_cohort` (`cohortId`),
  ADD KEY `fk_enrollment_parent` (`parentEnrollmentId`);

--
-- Indexes for table `enrollments_grade`
--
ALTER TABLE `enrollments_grade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_enrollment` (`enrollmentId`);

--
-- Indexes for table `enrollment_partial_scores`
--
ALTER TABLE `enrollment_partial_scores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_partial` (`enrollmentGradeId`,`evaluationOrder`),
  ADD KEY `fk_partial_enrollment_grade` (`enrollmentGradeId`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modify_scores`
--
ALTER TABLE `modify_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modify_scores_enrollments_FK` (`enrollmentGradeId`),
  ADD KEY `fk_modify_partial` (`partialScoreId`);

--
-- Indexes for table `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modules_courses`
--
ALTER TABLE `modules_courses`
  ADD KEY `modules_courses_courses_FK` (`courseid`),
  ADD KEY `modules_courses_modules_FK` (`moduleid`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_invoices_FK` (`invoiceId`);

--
-- Indexes for table `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_period_section` (`periodId`),
  ADD KEY `fk_module_section` (`moduleId`);

--
-- Indexes for table `sections_teachers`
--
ALTER TABLE `sections_teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_section_teacher` (`sectionId`,`teacherId`),
  ADD UNIQUE KEY `unique_section_order` (`sectionId`,`evaluationOrder`),
  ADD KEY `fk_st_section` (`sectionId`),
  ADD KEY `fk_st_teacher` (`teacherId`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `studentsId` (`studentsIdentification`);

--
-- Indexes for table `student_cohorts`
--
ALTER TABLE `student_cohorts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sc_student` (`studentId`),
  ADD KEY `fk_sc_period` (`periodId`),
  ADD KEY `fk_sc_course` (`courseId`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_courses_FK` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `certificates_students_FK` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);

--
-- Constraints for table `changelogs`
--
ALTER TABLE `changelogs`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_students_FK` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enrollment_cohort` FOREIGN KEY (`cohortId`) REFERENCES `student_cohorts` (`id`),
  ADD CONSTRAINT `fk_enrollment_parent` FOREIGN KEY (`parentEnrollmentId`) REFERENCES `enrollments` (`id`),
  ADD CONSTRAINT `fk_section_enrollment` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`),
  ADD CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);

--
-- Constraints for table `enrollments_grade`
--
ALTER TABLE `enrollments_grade`
  ADD CONSTRAINT `fk_enrollment` FOREIGN KEY (`enrollmentId`) REFERENCES `enrollments` (`id`);

--
-- Constraints for table `enrollment_partial_scores`
--
ALTER TABLE `enrollment_partial_scores`
  ADD CONSTRAINT `fk_partial_enrollment_grade` FOREIGN KEY (`enrollmentGradeId`) REFERENCES `enrollments_grade` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `modify_scores`
--
ALTER TABLE `modify_scores`
  ADD CONSTRAINT `fk_modify_partial` FOREIGN KEY (`partialScoreId`) REFERENCES `enrollment_partial_scores` (`id`),
  ADD CONSTRAINT `modify_scores_enrollments_FK` FOREIGN KEY (`enrollmentGradeId`) REFERENCES `enrollments_grade` (`id`);

--
-- Constraints for table `modules_courses`
--
ALTER TABLE `modules_courses`
  ADD CONSTRAINT `modules_courses_courses_FK` FOREIGN KEY (`courseid`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `modules_courses_modules_FK` FOREIGN KEY (`moduleid`) REFERENCES `modules` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_invoices_FK` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`);

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `fk_module_section` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `fk_period_section` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`);

--
-- Constraints for table `sections_teachers`
--
ALTER TABLE `sections_teachers`
  ADD CONSTRAINT `fk_st_section` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_st_teacher` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `student_cohorts`
--
ALTER TABLE `student_cohorts`
  ADD CONSTRAINT `fk_sc_course` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_sc_period` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `fk_sc_student` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);


INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1),
(2, '2', '2', 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', 1, 1, 1),
(3, '3', '3', '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 2, 1, 1),
(4, '4', '4', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', 3, 1, 1),
(5, '5', '5', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', 4, 1, 1),
(6, '6', '6', 'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683', 5, 1, 1);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
