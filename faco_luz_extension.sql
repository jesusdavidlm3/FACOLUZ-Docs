-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2026 a las 00:21:48
-- Versión del servidor: 11.8.3-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `faco_luz_extension`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificates`
--

CREATE TABLE `certificates` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `courseId` uuid NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Volcado de datos para la tabla `certificates`
--

INSERT INTO `certificates` (`id`, `studentId`, `courseId`, `date`) VALUES
('2a5095b5-1045-11f1-9f8d-106530499799', '49c8680e-0f9a-11f1-9f8d-106530499799', '0c346a18-09d0-11f1-a6b1-106530499799', '2026-02-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `changelogs`
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
-- Estructura de tabla para la tabla `courses`
--

CREATE TABLE `courses` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
  `create_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `courses`
--

INSERT INTO `courses` (`id`, `description`, `state`, `create_at`) VALUES
('0c346a18-09d0-11f1-a6b1-106530499799', 'Asistente de Higienista Dental', 'Activo', '2026-02-14 18:05:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enrollments`
--

CREATE TABLE `enrollments` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `studentId` uuid NOT NULL,
  `dateEnrollment` datetime NOT NULL DEFAULT current_timestamp(),
  `periodId` uuid NOT NULL,
  `state` enum('Pagada','Deuda') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enrollments_sections`
--

CREATE TABLE `enrollments_sections` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `enrollmentId` uuid NOT NULL,
  `sectionId` uuid NOT NULL,
  `score` int(3) DEFAULT NULL,
  `dateScore` datetime DEFAULT NULL,
  `status` enum('Inscrito','Aprobado','Reprobado','Retirado') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoices`
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

--
-- Volcado de datos para la tabla `invoices`
--

INSERT INTO `invoices` (`id`, `billableitem`, `chargedAmount`, `date`, `comments`, `status`, `StudentIdentification`) VALUES
('a7dba523-0f9e-11f1-9f8d-106530499799', 'Inscripcion', 10, '2026-02-21 23:29:11', NULL, 'Pendiente', 1111);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules`
--

CREATE TABLE `modules` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `description` text NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modules`
--

INSERT INTO `modules` (`id`, `description`, `create_at`, `state`) VALUES
('0c3dae7c-09d0-11f1-a6b1-106530499799', 'Nociones basicas de la Anatomia Dental y Oclusion', '2026-02-14 18:05:36', 'Activo'),
('0c3db180-09d0-11f1-a6b1-106530499799', 'Realaciones Humanas', '2026-02-14 18:05:36', 'Activo'),
('0c3db276-09d0-11f1-a6b1-106530499799', 'Sistema de Atencion Odontologica', '2026-02-14 18:05:36', 'Activo'),
('0c3db2bc-09d0-11f1-a6b1-106530499799', 'Semiologia e Historia Clinica', '2026-02-14 18:05:36', 'Activo'),
('0c3db2fa-09d0-11f1-a6b1-106530499799', 'Bioetica y Odontologia Legal', '2026-02-14 18:05:36', 'Activo'),
('0c3db334-09d0-11f1-a6b1-106530499799', 'Bioseguridad y Esterilizacion en Odontologia', '2026-02-14 18:05:36', 'Activo'),
('0c3db36b-09d0-11f1-a6b1-106530499799', 'Practica Profesional I', '2026-02-14 18:05:36', 'Activo'),
('0c3db3ab-09d0-11f1-a6b1-106530499799', 'Asistencia de Procedimientos Clincos Odontologicos', '2026-02-14 18:05:36', 'Activo'),
('0c3db3e8-09d0-11f1-a6b1-106530499799', 'Biomateriales Odontologicos', '2026-02-14 18:05:36', 'Activo'),
('0c3db427-09d0-11f1-a6b1-106530499799', 'Nociones Basicas en Radiologia e Imagenologia Odontologica', '2026-02-14 18:05:36', 'Activo'),
('0c3db45f-09d0-11f1-a6b1-106530499799', 'Epidemiologia y Sistema de informacion', '2026-02-14 18:05:36', 'Activo'),
('0c3db495-09d0-11f1-a6b1-106530499799', 'Ingles Intrumental', '2026-02-14 18:05:36', 'Activo'),
('0c3db4d1-09d0-11f1-a6b1-106530499799', 'Educacion y Promocion de la Salud Bucal', '2026-02-14 18:05:36', 'Activo'),
('0c3db508-09d0-11f1-a6b1-106530499799', 'Fotografia Clinica y Marketing en Odontologia', '2026-02-14 18:05:36', 'Activo'),
('0c3db53f-09d0-11f1-a6b1-106530499799', 'Practica Profesional II', '2026-02-14 18:05:36', 'Activo'),
('0c3db578-09d0-11f1-a6b1-106530499799', 'Servicios Comunitario', '2026-02-14 18:05:36', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modules_courses`
--

CREATE TABLE `modules_courses` (
  `moduleid` uuid NOT NULL,
  `courseid` uuid NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
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
-- Estructura de tabla para la tabla `periods`
--

CREATE TABLE `periods` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `year` int(4) NOT NULL,
  `period` int(2) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `state` enum('En curso','Finalizado') NOT NULL DEFAULT 'En curso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sections`
--

CREATE TABLE `sections` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `periodId` uuid NOT NULL,
  `moduleId` uuid NOT NULL,
  `teacherId` uuid NOT NULL,
  `code` varchar(1) NOT NULL,
  `modality` enum('Intensivo','Sabatino','','') NOT NULL,
  `quota` int(2) NOT NULL,
  `status` enum('Activa','Cerrada','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `students`
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
  `state` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `students`
--

INSERT INTO `students` (`id`, `name`, `lastname`, `photo`, `parentalPermission`, `studentsIdentification`, `birthDate`, `email`, `phone`, `address`, `instructionGrade`, `created_at`, `state`) VALUES
('382f4b8f-0f9a-11f1-9f8d-106530499799', 'Juan', 'perez', NULL, NULL, 1111, '2026-01-12', 'jjd@o.c', 4127859999, 'kkk', 'Universitario', '2026-02-21 22:57:26', 'Activo'),
('49c8680e-0f9a-11f1-9f8d-106530499799', 'jesus', 'Lozano', NULL, NULL, 890, '2026-01-05', 'jjd@o.c', 414223, 'kkk', 'Postgrado', '2026-02-21 22:57:56', 'Activo'),
('55af3fe9-0f9a-11f1-9f8d-106530499799', 'David', 'Garcia', NULL, NULL, 3353, '2026-01-06', 'jjd@o.c', 41409876, 'kkk', 'Bachillerato', '2026-02-21 22:58:16', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teachers`
--

CREATE TABLE `teachers` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `identification` int(11) UNSIGNED NOT NULL,
  `status` enum('Activo','Inactivo') NOT NULL DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
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
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `passwordSHA256`, `type`, `identificationType`, `active`) VALUES
(1, 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 0, 0, 1),
(2, '2', '2', 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', 1, 1, 1),
(3, '3', '3', '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', 2, 1, 1),
(4, '4', '4', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', 3, 1, 1),
(5, '5', '5', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', 4, 1, 1),
(6, '6', '6', 'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683', 5, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificates_students_FK` (`studentId`),
  ADD KEY `certificates_courses_FK` (`courseId`);

--
-- Indices de la tabla `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`userId`);

--
-- Indices de la tabla `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_student_enrollment` (`studentId`),
  ADD KEY `fk_period_enrollment` (`periodId`);

--
-- Indices de la tabla `enrollments_sections`
--
ALTER TABLE `enrollments_sections`
  ADD KEY `fk_enrollment` (`enrollmentId`),
  ADD KEY `fk_section` (`sectionId`);

--
-- Indices de la tabla `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modules_courses`
--
ALTER TABLE `modules_courses`
  ADD KEY `modules_courses_courses_FK` (`courseid`),
  ADD KEY `modules_courses_modules_FK` (`moduleid`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_invoices_FK` (`invoiceId`);

--
-- Indices de la tabla `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_period_section` (`periodId`),
  ADD KEY `fk_teacher_section` (`teacherId`),
  ADD KEY `fk_module_section` (`moduleId`);

--
-- Indices de la tabla `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `studentsId` (`studentsIdentification`);

--
-- Indices de la tabla `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `certificates_courses_FK` FOREIGN KEY (`courseId`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `certificates_students_FK` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);

--
-- Filtros para la tabla `changelogs`
--
ALTER TABLE `changelogs`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_period_enrollment` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`studentId`) REFERENCES `students` (`id`);

--
-- Filtros para la tabla `enrollments_sections`
--
ALTER TABLE `enrollments_sections`
  ADD CONSTRAINT `fk_enrollment` FOREIGN KEY (`enrollmentId`) REFERENCES `enrollments` (`id`),
  ADD CONSTRAINT `fk_section` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`);

--
-- Filtros para la tabla `modules_courses`
--
ALTER TABLE `modules_courses`
  ADD CONSTRAINT `modules_courses_courses_FK` FOREIGN KEY (`courseid`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `modules_courses_modules_FK` FOREIGN KEY (`moduleid`) REFERENCES `modules` (`id`);

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_invoices_FK` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`);

--
-- Filtros para la tabla `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `fk_module_section` FOREIGN KEY (`moduleId`) REFERENCES `modules` (`id`),
  ADD CONSTRAINT `fk_period_section` FOREIGN KEY (`periodId`) REFERENCES `periods` (`id`),
  ADD CONSTRAINT `fk_teacher_section` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
